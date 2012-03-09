Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Correct type for hdev lmp_subver
Date: Fri,  9 Mar 2012 11:46:49 +0200
Message-Id: <1331286409-26774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Keep lmp_subver in host byte order. We have following conversion
in hci_cc_read_local_version:
hdev->lmp_subver = __le16_to_cpu(rp->lmp_subver);

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5a90317..4af976c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -177,7 +177,7 @@ struct hci_dev {
 	__u16		hci_rev;
 	__u8		lmp_ver;
 	__u16		manufacturer;
-	__le16		lmp_subver;
+	__u16		lmp_subver;
 	__u16		voice_setting;
 	__u8		io_capability;
 
-- 
1.7.9

