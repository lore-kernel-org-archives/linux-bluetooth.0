Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] Bluetooth: Remove dead code
Date: Mon, 05 Jan 2015 19:32:55 +0530
Message-id: <1420466575-14615-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variable 'controller' is assigned a value that is never used.
Identified by cppcheck tool.

Signed-off-by: Gowtham Anandha Babu <gowtham.ab@samsung.com>
---
 net/bluetooth/cmtp/capi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
index 1ca8a87..75bd2c4 100644
--- a/net/bluetooth/cmtp/capi.c
+++ b/net/bluetooth/cmtp/capi.c
@@ -253,8 +253,6 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			if (skb->len < CAPI_MSG_BASELEN + 15)
 				break;
 
-			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 10);
-
 			if (!info && ctrl) {
 				int len = min_t(uint, CAPI_MANUFACTURER_LEN,
 						skb->data[CAPI_MSG_BASELEN + 14]);
@@ -270,8 +268,6 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			if (skb->len < CAPI_MSG_BASELEN + 32)
 				break;
 
-			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
-
 			if (!info && ctrl) {
 				ctrl->version.majorversion = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 16);
 				ctrl->version.minorversion = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 20);
@@ -285,8 +281,6 @@ static void cmtp_recv_interopmsg(struct cmtp_session *session, struct sk_buff *s
 			if (skb->len < CAPI_MSG_BASELEN + 17)
 				break;
 
-			controller = CAPIMSG_U32(skb->data, CAPI_MSG_BASELEN + 12);
-
 			if (!info && ctrl) {
 				int len = min_t(uint, CAPI_SERIAL_LEN,
 						skb->data[CAPI_MSG_BASELEN + 16]);
-- 
1.9.1

