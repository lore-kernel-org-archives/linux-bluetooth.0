Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH 1/3] Bluetooth: Add Bluetooth Management interface definitions
Date: Wed,  8 Dec 2010 00:21:05 +0200
Message-Id: <1291760467-1569-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1291760467-1569-1-git-send-email-johan.hedberg@gmail.com>
References: <1291760467-1569-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

Add initial definitions for the new Bluetooth Management interface to
the bluetooth headers.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |    4 +++
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/mgmt.h     |   46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 include/net/bluetooth/mgmt.h

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index f3c5ed6..29a7a8c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -934,9 +934,13 @@ static inline struct hci_sco_hdr *hci_sco_hdr(const struct sk_buff *skb)
 struct sockaddr_hci {
 	sa_family_t    hci_family;
 	unsigned short hci_dev;
+	unsigned short hci_channel;
 };
 #define HCI_DEV_NONE	0xffff
 
+#define HCI_CHANNEL_RAW		0
+#define HCI_CHANNEL_CONTROL	1
+
 struct hci_filter {
 	unsigned long type_mask;
 	unsigned long event_mask[2];
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9c08625..3e34359 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -668,6 +668,7 @@ struct hci_pinfo {
 	struct hci_dev    *hdev;
 	struct hci_filter filter;
 	__u32             cmsg_mask;
+	unsigned short   channel;
 };
 
 /* HCI security filter */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
new file mode 100644
index 0000000..95974da
--- /dev/null
+++ b/include/net/bluetooth/mgmt.h
@@ -0,0 +1,46 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+
+   Copyright (C) 2010  Nokia Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+struct mgmt_hdr {
+	__le16 opcode;
+	__le16 len;
+} __packed;
+#define MGMT_HDR_SIZE			4
+
+#define MGMT_EV_CMD_COMPLETE		0x0001
+struct mgmt_ev_cmd_complete {
+	__le16 opcode;
+	__u8 data[0];
+} __packed;
+
+#define MGMT_EV_CMD_STATUS		0x0002
+struct mgmt_ev_cmd_status {
+	__u8 status;
+	__le16 opcode;
+} __packed;
+
+#define MGMT_EV_CONTROLLER_ERROR	0x0003
+struct mgmt_ev_controller_error {
+	__le16 index;
+	__u8 error_code;
+} __packed;
-- 
1.7.2.3

