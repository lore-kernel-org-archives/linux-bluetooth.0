Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/2] Bluetooth: mgmt: Fix sending events with uninitialized data
Date: Wed, 22 Aug 2012 16:33:29 -0300
Message-Id: <1345664010-30471-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In response to the Read Index List command, it is possible that
uninitialized data is sent to userspace because the way the number
of adapters is counted. This way we only count adapters that will
be included in the response.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 05d4b83..6219a39 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -333,6 +333,9 @@ static int read_index_list(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	count = 0;
 	list_for_each_entry(d, &hci_dev_list, list) {
+		if (test_bit(HCI_SETUP, &d->dev_flags))
+			continue;
+
 		if (!mgmt_valid_hdev(d))
 			continue;
 
-- 
1.7.11.4

