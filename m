Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/5] opp: Update record to support version 1.2 with GoepL2capPsm attribute
Date: Mon, 13 Feb 2012 13:37:49 +0200
Message-Id: <1329133070-30003-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
References: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/opp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/plugins/opp.c b/plugins/opp.c
index 2375a21..d9b68b2 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -72,7 +72,7 @@
     <sequence>							\
       <sequence>						\
         <uuid value=\"0x1105\"/>				\
-        <uint16 value=\"0x0100\" name=\"version\"/>		\
+        <uint16 value=\"0x0102\" name=\"version\"/>		\
       </sequence>						\
     </sequence>							\
   </attribute>							\
@@ -92,6 +92,9 @@
       <uint8 value=\"0xff\"/>					\
     </sequence>							\
   </attribute>							\
+  <attribute id=\"0x0200\">					\
+    <uint16 value=\"%u\" name=\"psm\"/>				\
+  </attribute>							\
 </record>"
 
 static void *opp_connect(struct obex_session *os, int *err)
@@ -214,6 +217,7 @@ static struct obex_service_driver driver = {
 	.name = "Object Push server",
 	.service = OBEX_OPP,
 	.channel = OPP_CHANNEL,
+	.port = OBEX_PORT_RANDOM,
 	.record = OPP_RECORD,
 	.connect = opp_connect,
 	.progress = opp_progress,
-- 
1.7.7.6

