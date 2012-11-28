Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/5] Bluetooth: AMP: Mark controller radio powered down after HCIDEVDOWN
Date: Wed, 28 Nov 2012 17:59:42 +0200
Message-Id: <1354118382-25571-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1354118382-25571-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1354118382-25571-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

After getting HCIDEVDOWN controller did not mark itself as 0x00 which
means: "The Controller radio is available but is currently physically
powered down". The result was even if the hdev was down we return
in controller list value 0x01 "status 0x01 (Bluetooth only)".

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 69eb644..ec7d3a7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -861,6 +861,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	/* Clear flags */
 	hdev->flags = 0;
 
+	/* Controller radio is available but is currently powered down */
+	hdev->amp_status = 0;
+
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 
-- 
1.7.10.4

