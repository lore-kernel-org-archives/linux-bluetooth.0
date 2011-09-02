Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/3] Bluetooth: Require authentication if MITM protection is requested
Date: Fri,  2 Sep 2011 14:51:20 -0300
Message-Id: <1314985882-24059-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1314985882-24059-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1314985882-24059-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HIGH security level requires a 16 digit pin code for non-SSP
bondings. Sometimes this requirement is not acceptable and we still
want protection againts MITM attacks (which is something that the
MEDIUM security level doesn't provide), for that we should allow
another way to request authentication without using the HIGH security
level.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_event.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8483cab..8404cd9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1104,9 +1104,10 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 		return 0;
 
 	/* Only request authentication for SSP connections or non-SSP
-	 * devices with sec_level HIGH */
+	 * devices with sec_level HIGH or if MITM protection is requested */
 	if (!(hdev->ssp_mode > 0 && conn->ssp_mode > 0) &&
-				conn->pending_sec_level != BT_SECURITY_HIGH)
+				conn->pending_sec_level != BT_SECURITY_HIGH &&
+				!(conn->auth_type & 0x01))
 		return 0;
 
 	return 1;
-- 
1.7.6.1

