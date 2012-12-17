Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/13] doc: Add device appearance in settings-storage doc
Date: Mon, 17 Dec 2012 16:09:44 +0100
Message-Id: <1355756994-18953-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355756994-18953-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/settings-storage.txt |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 037e14f..bc60709 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -165,6 +165,9 @@ Long term key) related to a remote device.
   Class			String		Device class in hexadecimal,
 					i.e. 0x000000
 
+  Appearance		String		Device appearance in hexadecimal,
+					i.e. 0x0000
+
   SupportedTechnologies	List of		List of technologies supported by
 			strings		device, separated by ";"
 					Technologies can be BR/EDR or LE
-- 
1.7.9.5

