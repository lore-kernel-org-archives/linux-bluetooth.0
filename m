Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/8] Bluetooth: Add a custom type for Short Term Keys
Date: Thu, 10 Nov 2011 22:03:50 -0300
Message-Id: <1320973436-13399-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These keys are just used to encrypt the link, during SMP phase 2, they should
not be stored nor reused. We use the same list as the LTKs to temporarily store
them, but as soon as they are used they are removed from the list.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 139ce2a..069768c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -260,6 +260,7 @@ enum {
 #define HCI_LK_AUTH_COMBINATION		0x05
 #define HCI_LK_CHANGED_COMBINATION	0x06
 /* The spec doesn't define types for SMP keys */
+#define HCI_LK_SMP_STK			0x80
 #define HCI_LK_SMP_LTK			0x81
 #define HCI_LK_SMP_IRK			0x82
 #define HCI_LK_SMP_CSRK			0x83
-- 
1.7.7

