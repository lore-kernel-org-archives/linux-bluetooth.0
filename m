Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Paulo=20S=C3=A9rgio?= <paulo.sergio@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Paulo=20S=C3=A9rgio?= <paulo.sergio@openbossa.org>
Subject: [PATCH] Bluetooth: Fix error status when pairing fails
Date: Thu, 25 Oct 2012 16:55:51 -0300
Message-Id: <1351194951-7534-1-git-send-email-paulo.sergio@openbossa.org>
In-Reply-To: <1351192136-6925-1-git-send-email-paulo.sergio@openbossa.org>
References: <1351192136-6925-1-git-send-email-paulo.sergio@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When pairing fails due to wrong confirm value, the management layer
doesn't report a proper error status. It sends
MGMT_STATUS_CONNECT_FAILED instead of MGMT_STATUS_AUTH_FAILED.

Most of management functions that receive a status as a parameter
expects for it to be encoded as a HCI status. But when a SMP pairing
fails, the SMP layer sends the SMP reason as the error status to the
management layer.

This commit maps all SMP reasons to HCI_ERROR_AUTH_FAILURE, which will
be converted to MGMT_STATUS_AUTH_FAILED in the management layer.

Reported-by: Claudio Takahasi <claudio.takahasi@openbossa.org>
Reviewed-by: João Paulo Rechi Vita <jprvita@openbossa.org>
Signed-off-by: Paulo Sérgio <paulo.sergio@openbossa.org>
---

Please, disconsider the previous patch. It had a wrong commit message.

PS: This is my first patch.

 net/bluetooth/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b542c5d..b3b7cc0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -266,7 +266,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason, u8 send)
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->hcon->flags);
 	mgmt_auth_failed(conn->hcon->hdev, conn->dst, hcon->type,
-			 hcon->dst_type, reason);
+			 hcon->dst_type, HCI_ERROR_AUTH_FAILURE);
 
 	cancel_delayed_work_sync(&conn->security_timer);
 
-- 
1.7.9.5

