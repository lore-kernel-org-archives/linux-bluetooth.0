Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 1/2] Bluetooth: Clear RFCOMM session timer when disconnecting last channel
Date: Tue,  6 Dec 2011 16:23:26 -0800
Message-Id: <1323217407-2490-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>
References: <1323217407-2490-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the last RFCOMM data channel is closed, a timer is normally set
up to disconnect the control channel at a later time.  If the control
channel disconnect command is sent with the timer pending, the timer
needs to be cancelled.

If the timer is not cancelled in this situation, the reference
counting logic for the RFCOMM session does not work correctly when the
remote device closes the L2CAP connection.  The session is freed at
the wrong time, leading to a kernel panic.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/rfcomm/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 4e32e18..2d28dfe 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1146,6 +1146,7 @@ static int rfcomm_recv_ua(struct rfcomm_session *s, u8 dlci)
 			if (list_empty(&s->dlcs)) {
 				s->state = BT_DISCONN;
 				rfcomm_send_disc(s, 0);
+				rfcomm_session_clear_timer(s);
 			}
 
 			break;
-- 
1.7.8

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
