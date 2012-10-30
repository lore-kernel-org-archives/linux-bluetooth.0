Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 2/6] doc: Update settings-storage.txt
Date: Tue, 30 Oct 2012 18:05:24 +0100
Message-Id: <1351616728-10075-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Device name should be saved in device info file.
---
 doc/settings-storage.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 93184d1..1174d44 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -132,6 +132,8 @@ Long term key) related to a remote device.
 
 [General] group contains:
 
+  Name			String		Remote device friendly name
+
   Alias			String		Alias name
 
   Class			String		Device class in hexadecimal,
-- 
1.7.9.5

