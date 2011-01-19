Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: ville.tervo@nokia.com
Subject: [PATCH 2/5] Bluetooth: Fix MITM protection requirement preservation
Date: Wed, 19 Jan 2011 12:06:49 +0530
Message-Id: <1295419012-25717-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
References: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

If an existing connection has a MITM protection requirement (the first
bit of the auth_type) then that requirement should not be cleared by new
sockets that reuse the ACL but don't have that requirement.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_conn.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 65a3fb5..fe712a8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -442,6 +442,9 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 	else if (conn->link_mode & HCI_LM_AUTH)
 		return 1;
 
+	/* Make sure we preserve an existing MITM requirement*/
+	auth_type |= (conn->auth_type & 0x01);
+
 	conn->auth_type = auth_type;
 
 	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
-- 
1.7.2.3

