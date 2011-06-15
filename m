Return-Path: <cyrus@holtmann.org>
From: Ilia Kolomisnky <ilia.kolominsky@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH bluetooth-2.6] Fix L2CAP connection establishment
Date: Wed, 15 Jun 2011 06:52:26 +0300
Message-Id: <1308109946-20835-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In hci_conn_security ( which is used during L2CAP connection
establishment ) test for HCI_CONN_ENCRYPT_PEND state also
sets this state, which is bogus and leads to connection time-out
on L2CAP sockets in certain situations (especially when
using non-ssp devices )
---
 net/bluetooth/hci_conn.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9aa986..d3a05b9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -608,7 +608,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 		goto encrypt;
 
 auth:
-	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
 		return 0;
 
 	if (!hci_conn_auth(conn, sec_level, auth_type))
-- 
1.7.1

