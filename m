Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 7/7] Bluetooth: Add support for notifying userspace of new LTK's
Date: Thu,  2 Feb 2012 21:08:05 -0300
Message-Id: <1328227685-27245-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we want to have proper pairing support over LE we need to
inform userspace that a new LTK is available, so userspace
can store that key permanently.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff519b5..aa5e571 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1338,6 +1338,9 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
 	if (!new_key)
 		return 0;
 
+	if (type & HCI_SMP_LTK)
+		mgmt_new_ltk(hdev, key, 1);
+
 	return 0;
 }
 
-- 
1.7.8.1

