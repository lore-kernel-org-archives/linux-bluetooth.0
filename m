Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 8/8] Bluetooth: Add support for notifying userspace of new LTK's
Date: Fri, 13 Jan 2012 16:39:40 -0300
Message-Id: <1326483580-11243-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326483580-11243-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326483580-11243-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we want to have proper pairing support over LE we need to
inform userspace that a new LTK is available, so userspace
can store that key permanently.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5f41e74..ffb66a1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1343,6 +1343,9 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	if (!new_key)
 		return 0;
 
+	if (type & HCI_SMP_LTK)
+		mgmt_new_ltk(hdev, key, 1);
+
 	return 0;
 }
 
-- 
1.7.8.1

