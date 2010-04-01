Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 25/34] Bluetooth: Send Ack after clear the SREJ list
Date: Thu,  1 Apr 2010 17:23:43 -0300
Message-Id: <1270153432-6477-26-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-25-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-24-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-25-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

As specified by Bluetooth 3.0 spec we shall send an acknowledgment using
the Send-Ack() after clear the SREJ list.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 6196f2c..4580fcf 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3497,6 +3497,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 			if (list_empty(SREJ_LIST(sk))) {
 				pi->buffer_seq = pi->buffer_seq_srej;
 				pi->conn_state &= ~L2CAP_CONN_SREJ_SENT;
+				l2cap_send_ack(pi);
 			}
 		} else {
 			struct srej_list *l;
-- 
1.6.4.4
