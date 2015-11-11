Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Move check for ongoing connect earlier in hci_connect_le()
Date: Wed, 11 Nov 2015 14:44:58 +0200
Message-Id: <1447245899-30783-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
References: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This helps simplify the logic in further patches (less cleanups to do
in this failure branch).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 673c2254935b..08a291dd0f3a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -798,6 +798,12 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	/* Since the controller supports only one LE connection attempt at a
+	 * time, we return -EBUSY if there is any connection attempt running.
+	 */
+	if (hci_lookup_le_connect(hdev))
+		return ERR_PTR(-EBUSY);
+
 	/* Some devices send ATT messages as soon as the physical link is
 	 * established. To be able to handle these ATT messages, the user-
 	 * space first establishes the connection and then starts the pairing
@@ -821,12 +827,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		}
 	}
 
-	/* Since the controller supports only one LE connection attempt at a
-	 * time, we return -EBUSY if there is any connection attempt running.
-	 */
-	if (hci_lookup_le_connect(hdev))
-		return ERR_PTR(-EBUSY);
-
 	/* When given an identity address with existing identity
 	 * resolving key, the connection needs to be established
 	 * to a resolvable random address.
-- 
2.5.0

