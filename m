Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add definition of a new addresses file
Date: Sun, 30 Oct 2016 17:45:28 +0200
Message-Id: <1477842328-20312-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Currently bluetoothd doesn't support single-mode adapters without a
public address. This patch defines a new 'addresses' file that will be
used for managing generated static random addresses.
---
 doc/settings-storage.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 6a708b45fee8..160bbb2460a1 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -24,8 +24,16 @@ All files are in ini-file format.
 Storage directory structure
 ===========================
 
-There is one directory per adapter, named by its Bluetooth address, which
-contains:
+The storage root directory contains an optional addresses file that's
+used for managing adapters that come without a pre-allocated address.
+The format of the addresses file is:
+
+	[Static]
+	<manufacturer id> = <array of addresses>
+
+Each adapter with an assigned address has its own subdirectory under the
+root, named based on the address, which contains:
+
  - a settings file for the local adapter
  - an attributes file containing attributes of supported LE services
  - a cache directory containing:
-- 
2.7.4

