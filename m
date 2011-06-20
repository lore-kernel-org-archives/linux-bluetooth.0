Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <yongli@qca.qualcomm.com>,
	Nami <nami.li@atheros.com>
Subject: [PATCH obexd 01/14] Update OPP service record for GOEP v2.0.
Date: Mon, 20 Jun 2011 17:44:47 +0800
Message-ID: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,all
 These patches support opp and ftp over l2cap. Currently I just modified OPP and FTP.
 Please help review these patches.
 Thanks.

---
 plugins/opp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/plugins/opp.c b/plugins/opp.c
index 17c4356..7ea7e18 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -71,7 +71,7 @@
     <sequence>							\
       <sequence>						\
         <uuid value=\"0x1105\"/>				\
-        <uint16 value=\"0x0100\" name=\"version\"/>		\
+        <uint16 value=\"0x0102\" name=\"version\"/>		\
       </sequence>						\
     </sequence>							\
   </attribute>							\
@@ -91,6 +91,10 @@
       <uint8 value=\"0xff\"/>					\
     </sequence>							\
   </attribute>							\
+    	  	  	  	  	  	  	  	  	 \
+  <attribute id=\"0x0200\">						\
+ 	<uint16 value=\"%u\" name=\"psm\"/>         		\
+  </attribute>							\
 </record>"

 static void *opp_connect(struct obex_session *os, int *err)
--
1.7.1

