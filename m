Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v2 10/10] build: Update bootstrap-configure with new build options
Date: Thu, 17 Nov 2016 14:20:01 +0200
Message-Id: <1479385201-10559-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
References: <1479385201-10559-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 bootstrap-configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bootstrap-configure b/bootstrap-configure
index 87766b1..ffc16ac 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -14,6 +14,9 @@ fi
 		--enable-manpages \
 		--enable-backtrace \
 		--enable-experimental \
+		--enable-nfc \
+		--enable-sap \
+		--enable-health \
 		--enable-android \
 		--enable-sixaxis \
 		--disable-datafiles $*
-- 
2.7.4

