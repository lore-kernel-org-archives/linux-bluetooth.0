Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Dec 2009 12:07:48 +0530
From: Kandukuri Vikram <vkandukuri@atheros.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] According to BNEP test spec proper response should be sent
	for a setup connection request message after the BNEP connection
	setup has been completed
Message-ID: <20091204063748.GA3774@atheros-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>


 Signed-off-by: Vikram Kandukuri <vikram.kandukuri@atheros.com>
---
 net/bluetooth/bnep/core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index cafe9f5..29b1b22 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -230,7 +230,6 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 
 	switch (cmd) {
 	case BNEP_CMD_NOT_UNDERSTOOD:
-	case BNEP_SETUP_CONN_REQ:
 	case BNEP_SETUP_CONN_RSP:
 	case BNEP_FILTER_NET_TYPE_RSP:
 	case BNEP_FILTER_MULTI_ADDR_RSP:
@@ -245,6 +244,10 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 		err = bnep_ctrl_set_mcfilter(s, data, len);
 		break;
 
+	case BNEP_SETUP_CONN_REQ:
+		err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
+		break;
+
 	default: {
 			u8 pkt[3];
 			pkt[0] = BNEP_CONTROL;
-- 
1.6.0.4
