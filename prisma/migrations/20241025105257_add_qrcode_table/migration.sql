/*
  Warnings:

  - You are about to drop the column `accountOwner` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `collaborator` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `emailVerified` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `firstName` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `lastName` on the `Session` table. All the data in the column will be lost.
  - You are about to drop the column `locale` on the `Session` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "QRCode" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "shop" TEXT NOT NULL,
    "productId" TEXT NOT NULL,
    "productHandle" TEXT NOT NULL,
    "productVariantId" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "scans" INTEGER NOT NULL DEFAULT 0,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "shop" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL DEFAULT false,
    "scope" TEXT,
    "expires" DATETIME,
    "accessToken" TEXT NOT NULL,
    "userId" BIGINT
);
INSERT INTO "new_Session" ("accessToken", "expires", "id", "isOnline", "scope", "shop", "state", "userId") SELECT "accessToken", "expires", "id", "isOnline", "scope", "shop", "state", "userId" FROM "Session";
DROP TABLE "Session";
ALTER TABLE "new_Session" RENAME TO "Session";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
