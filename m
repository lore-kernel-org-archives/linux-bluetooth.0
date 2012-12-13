Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/15] doc: Update Settings-storage for SDP records
Date: Thu, 13 Dec 2012 21:39:22 +0100
Message-Id: <1355431170-12897-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355431170-12897-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SDP records shouls be saved in device file located in cache
directory, as we cannot guarantee that this info is available
always and profiles should work even if the info is not there.
---
 doc/settings-storage.txt |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index a43b7af..792c899 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -115,13 +115,23 @@ Sample:
 Cache directory file format
 ============================
 
-Each file, named by remote device address, contains one [General] group.
-This general group contains:
+Each file, named by remote device address, may includes multiple groups
+(General and ServiceRecords).
+
+In ServiceRecords, SDP records are stored using their handle as key
+(hexadecimal format).
+
+[General] group contains:
 
   Name		String		Remote device friendly name
 
   ShortName	String		Remote device shortened name
 
+[ServiceRecords] group contains
+
+  <0x...>	String		SDP record as hexadecimal encoded
+				string
+
 Info file format
 ================
 
-- 
1.7.9.5

