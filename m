Return-Path: <cyrus@holtmann.org>
From: Ville Tervo <ville.tervo@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@nokia.com, Ville Tervo <ville.tervo@nokia.com>
Subject: [PATCH] Bluetooth: Fix refcount balance for hci connection
Date: Thu,  7 Apr 2011 14:59:50 +0300
Message-Id: <1302177590-4107-1-git-send-email-ville.tervo@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_io_capa_reply_evt() holds reference for hciconnection. It's useless since
hci_io_capa_request_evt()/hci_simple_pair_complete_evt() already protects the
connection. In addition it leaves connection open after failed SSP pairing.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 net/bluetooth/hci_event.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7a3398d..6b878c8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2419,8 +2419,6 @@ static inline void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *s
 	if (!conn)
 		goto unlock;
 
-	hci_conn_hold(conn);
-
 	conn->remote_cap = ev->capability;
 	conn->remote_oob = ev->oob_data;
 	conn->remote_auth = ev->authentication;
-- 
1.7.2.3

