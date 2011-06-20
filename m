Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Nami <nami.li@atheros.com>
Subject: [PATCH obexd 02/14] Update FTP service record for GOEP v2.0.
Date: Mon, 20 Jun 2011 17:56:34 +0800
Message-ID: <1308563794-18964-4-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308563794-18964-1-git-send-email-nami.li@atheros.com>
References: <1308563794-18964-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/ftp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index 79223bf..d8e5356 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -83,7 +83,7 @@
     <sequence>								\
       <sequence>							\
         <uuid value=\"0x1106\"/>					\
-        <uint16 value=\"0x0100\" name=\"version\"/>			\
+        <uint16 value=\"0x0102\" name=\"version\"/>			\
       </sequence>							\
     </sequence>								\
   </attribute>								\
@@ -91,6 +91,10 @@
   <attribute id=\"0x0100\">						\
     <text value=\"%s\" name=\"name\"/>					\
   </attribute>								\
+  	  	  	  	  	  	  	  	  	 \
+  <attribute id=\"0x0200\">						\
+ 	<uint16 value=\"%u\" name=\"psm\"/>         		\
+  </attribute>     							\
 </record>"

 #define PCSUITE_CHANNEL 24
--
1.7.1

