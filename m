Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/4] Bluetooth: Track discovery type
Date: Thu, 16 Feb 2012 18:50:39 -0300
Message-Id: <1329429041-30715-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to struct discovery_state the field 'type' so that
we can track the discovery type the device is performing.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |    2 ++
 net/bluetooth/mgmt.c             |    4 +++-
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9982179..3a62f93 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -61,6 +61,7 @@ struct inquiry_entry {
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
index 410392e..e71564e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2072,7 +2072,9 @@ static int start_discovery(struct sock *sk, u16 index,
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

