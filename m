Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 30 Nov 2009 16:21:24 +0100
Message-ID: <a0d5085b0911300721y49e6b87fs262f750e8b97d383@mail.gmail.com>
Subject: [PATCH 2/2] A couple of bugs in bluetooth
From: Luiz Pena <carlos.luiz.pena@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The second one is a few instances of copying data from the skb->data without
verifying the it has the data (there is an if statement a few lines above which
only check till the length field).


Signed-off-by: Carlos Luiz Pena <carlos.luiz.pena@gmail.com>
---
diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index 97f8d68..f060b4f 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -250,11 +250,10 @@ static void cmtp_recv_interopmsg(struct
cmtp_session *session, struct sk_buff *s
 			if (skb->len < CAPI_MSG_BASELEN + 15)
 				break;

-			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 10);
-
 			if (!info && ctrl) {
 				int len = min_t(uint, CAPI_MANUFACTURER_LEN,
 						skb->data[CAPI_MSG_BASELEN + 14]);
+				len = min_t(uint, len, skb->len - 14 - CAPI_MSG_BASELEN);

 				memset(ctrl->manu, 0, CAPI_MANUFACTURER_LEN);
 				strncpy(ctrl->manu,
@@ -267,8 +266,6 @@ static void cmtp_recv_interopmsg(struct
cmtp_session *session, struct sk_buff *s
 			if (skb->len < CAPI_MSG_BASELEN + 32)
 				break;

-			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
-
 			if (!info && ctrl) {
 				ctrl->version.majorversion = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 16);
 				ctrl->version.minorversion = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 20);
@@ -282,11 +279,10 @@ static void cmtp_recv_interopmsg(struct
cmtp_session *session, struct sk_buff *s
 			if (skb->len < CAPI_MSG_BASELEN + 17)
 				break;

-			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
-
 			if (!info && ctrl) {
 				int len = min_t(uint, CAPI_SERIAL_LEN,
 						skb->data[CAPI_MSG_BASELEN + 16]);
+				len = min_t(uint, len, skb->len - 16 - CAPI_MSG_BASELEN);

 				memset(ctrl->serial, 0, CAPI_SERIAL_LEN);
 				strncpy(ctrl->serial,
