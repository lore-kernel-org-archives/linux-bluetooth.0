Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/1] Bluetooth: Fix regression into L2CAP when using Basic Mode
Date: Sat, 17 Oct 2009 21:41:01 -0300
Message-Id: <1255826461-7741-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Basic Mode is the default mode of operation of a L2CAP entity, so we don't
need to send a RFC (Retransmission and Flow Control) Configuration Option.
This patch makes L2CAP do not send RFC when Basic Mode is selected.
The regression was introduced by the ERTM (Enhanced Retransmission Mode)
patches.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 243aac7..bafac04 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2408,6 +2408,10 @@ done:
 			rfc.monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
 
 			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+					sizeof(rfc), (unsigned long) &rfc);
+
 			break;
 
 		case L2CAP_MODE_STREAMING:
@@ -2415,6 +2419,10 @@ done:
 			pi->max_pdu_size = rfc.max_pdu_size;
 
 			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+					sizeof(rfc), (unsigned long) &rfc);
+
 			break;
 
 		default:
@@ -2424,9 +2432,6 @@ done:
 			rfc.mode = pi->mode;
 		}
 
-		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
-					sizeof(rfc), (unsigned long) &rfc);
-
 		if (result == L2CAP_CONF_SUCCESS)
 			pi->conf_state |= L2CAP_CONF_OUTPUT_DONE;
 	}
-- 
1.6.4.4
