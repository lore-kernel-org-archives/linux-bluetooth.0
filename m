Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 12/23] client-api: Rename FileTransfer interface to org.bluez.obex.FileTransfer
Date: Tue,  5 Jun 2012 13:57:10 +0300
Message-Id: <1338893841-14234-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/ftp.c       |    2 +-
 doc/client-api.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 58aa17f..0b12d12 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -42,7 +42,7 @@
 	"\xF9\xEC\x7B\xC4\x95\x3C\x11\xD2\x98\x4E\x52\x54\x00\xDC\x9E\x09"
 #define OBEX_FTP_UUID_LEN 16
 
-#define FTP_INTERFACE "org.openobex.FileTransfer"
+#define FTP_INTERFACE "org.bluez.obex.FileTransfer"
 #define FTP_UUID "00001106-0000-1000-8000-00805f9b34fb"
 #define PCSUITE_UUID "00005005-0000-1000-8000-0002ee000001"
 
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 09aab87..fc58ee9 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -111,7 +111,7 @@ File Transfer hierarchy
 =======================
 
 Service		org.bluez.obex.client
-Interface	org.openobex.FileTransfer
+Interface	org.bluez.obex.FileTransfer
 Object path	[variable prefix]/{session0,session1,...}
 
 Methods		void ChangeFolder(string folder)
-- 
1.7.10.2

