Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 2/4] Bluetooth: Track discovery type
Date: Fri, 17 Feb 2012 20:39:36 -0300
Message-Id: <1329521978-8537-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
References: <1329521978-8537-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to struct discovery_state the field 'type' so that
we can track the discovery type the device is performing.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    2 ++
 net/bluetooth/mgmt.c             |    4 +++-
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index be8da5d..d7c79b5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -57,6 +57,7 @@ struct inquiry_entry {
 };
 
 struct discovery_state {
+	int type;
 	enum {
 		DISCOVERY_STOPPED,
 		DISCOVERY_STARTING,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dc31e7d..29a9b01 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -380,6 +380,8 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
+		hdev->discovery.type = 0;
+
 		if (hdev->discovery.state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 196215c..9d98382 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2192,7 +2192,9 @@ static int start_discovery(struct sock *sk, u16 index,
 		goto failed;
 	}
 
-	switch (cp->type) {
+	hdev->discovery.type = cp->type;
+
+	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
 	case DISCOV_TYPE_INTERLEAVED:
 		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
-- 
1.7.9.1

