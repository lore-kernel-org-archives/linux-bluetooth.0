Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 05/23] Bluetooth: A2MP: Definitions for A2MP commands
Date: Fri, 20 Apr 2012 14:09:33 +0300
Message-Id: <1334920191-29308-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define A2MP command IDs and packet structures.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |   73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 995f1c0..39160f5 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -31,6 +31,79 @@ struct a2mp_cmd {
 	__u8	data[0];
 } __packed;
 
+/* A2MP command codes */
+#define A2MP_COMMAND_REJ         0x01
+struct a2mp_cmd_rej {
+	__le16	reason;
+	__u8	data[0];
+} __packed;
+
+#define A2MP_DISCOVER_REQ        0x02
+struct a2mp_discov_req {
+	__le16	mtu;
+	__le16	ext_feat;
+} __packed;
+
+struct a2mp_cl {
+	__u8	id;
+	__u8	type;
+	__u8	status;
+} __packed;
+
+#define A2MP_DISCOVER_RSP        0x03
+struct a2mp_discov_rsp {
+	__le16     mtu;
+	__le16     ext_feat;
+	struct a2mp_cl cl[0];
+} __packed;
+
+#define A2MP_CHANGE_NOTIFY       0x04
+#define A2MP_CHANGE_RSP          0x05
+
+#define A2MP_GETINFO_REQ         0x06
+struct a2mp_info_req {
+	__u8       id;
+} __packed;
+
+#define A2MP_GETINFO_RSP         0x07
+struct a2mp_info_rsp {
+	__u8	id;
+	__u8	status;
+	__le32	total_bw;
+	__le32	max_bw;
+	__le32	min_latency;
+	__le16	pal_cap;
+	__le16	assoc_size;
+} __packed;
+
+#define A2MP_GETAMPASSOC_REQ     0x08
+struct a2mp_amp_assoc_req {
+	__u8	id;
+} __packed;
+
+#define A2MP_GETAMPASSOC_RSP     0x09
+struct a2mp_amp_assoc_rsp {
+	__u8	id;
+	__u8	status;
+	__u8	amp_assoc[0];
+} __packed;
+
+#define A2MP_CREATEPHYSLINK_REQ  0x0A
+#define A2MP_DISCONNPHYSLINK_REQ 0x0C
+struct a2mp_physlink_req {
+	__u8	local_id;
+	__u8	remote_id;
+	__u8	amp_assoc[0];
+} __packed;
+
+#define A2MP_CREATEPHYSLINK_RSP  0x0B
+#define A2MP_DISCONNPHYSLINK_RSP 0x0D
+struct a2mp_physlink_rsp {
+	__u8	local_id;
+	__u8	remote_id;
+	__u8	status;
+} __packed;
+
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 
-- 
1.7.9.5

