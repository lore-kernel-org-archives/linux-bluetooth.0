Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix potential buffer overflow with Add Advertising
Date: Fri, 11 Mar 2016 09:56:33 +0200
Message-Id: <1457682993-18470-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1457682993-18470-1-git-send-email-johan.hedberg@gmail.com>
References: <1457682993-18470-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Add Advertising command handler does the appropriate checks for
the AD and Scan Response data, however fails to take into account the
general length of the mgmt command itself, which could lead to
potential buffer overflows. This patch adds the necessary check that
the mgmt command length is consistent with the given ad and scan_rsp
lengths.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c856fb65812c..9e4b931588cf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5995,6 +5995,10 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
 
+	if (data_len != sizeof(*cp) + cp->adv_data_len + cp->scan_rsp_len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	flags = __le32_to_cpu(cp->flags);
 	timeout = __le16_to_cpu(cp->timeout);
 	duration = __le16_to_cpu(cp->duration);
-- 
2.5.0

