Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add missing confirm_name field to mgmt_ev_device_found
Date: Mon, 19 Dec 2011 14:29:06 +0200
Message-Id: <1324297748-8546-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a missing confirm_name field to mgmt_ev_device_found.
Support for setting the correct value for this field is not implemented
yet, but having it part of the struct definition ensures that user-space
gets correct sized device_found events and is thereby able to do at
least rudimentary parsing of them.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 2b1059d..9f7a956 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -357,6 +357,7 @@ struct mgmt_ev_device_found {
 	struct mgmt_addr_info addr;
 	__u8 dev_class[3];
 	__s8 rssi;
+	__u8 confirm_name;
 	__u8 eir[HCI_MAX_EIR_LENGTH];
 } __packed;
 
-- 
1.7.7.3

