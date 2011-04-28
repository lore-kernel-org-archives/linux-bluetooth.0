Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/12] Bluetooth: Fix old_key_type logic for non-persistent keys
Date: Thu, 28 Apr 2011 11:29:00 -0700
Message-Id: <1304015344-12238-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
References: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

Even if there's no previous key stored the connection might still be
secured with a non-persistent key and in that case the key type in the
hci_conn struct should be checked.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 85fae57..88ed4ff 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1069,7 +1069,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		old_key_type = old_key->type;
 		key = old_key;
 	} else {
-		old_key_type = 0xff;
+		old_key_type = conn ? conn->key_type : 0xff;
 		key = kzalloc(sizeof(*key), GFP_ATOMIC);
 		if (!key)
 			return -ENOMEM;
-- 
1.7.4.4

