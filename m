Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v2 bluez 2/2] Add A2MP definitions
Date: Thu, 27 Oct 2011 17:28:39 -0700
Message-Id: <1319761719-16363-3-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1319761719-16363-1-git-send-email-pkrystad@codeaurora.org>
References: <1319761719-16363-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/a2mp.h |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 133 insertions(+), 0 deletions(-)
 create mode 100644 lib/a2mp.h

diff --git a/lib/a2mp.h b/lib/a2mp.h
new file mode 100644
index 0000000..bac55c9
--- /dev/null
+++ b/lib/a2mp.h
@@ -0,0 +1,133 @@
+/*
+ *
+ *	BlueZ - Bluetooth protocol stack for Linux
+ *
+ *	Copyright (C) 2010-2011 Code Aurora Forum.  All rights reserved.
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License version 2 and
+ *	only version 2 as published by the Free Software Foundation.
+ *
+ *	This program is distributed in the hope that it will be useful,
+ *	but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *	GNU General Public License for more details.
+ *
+ */
+
+#ifndef __A2MP_H
+#define __A2MP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* A2MP Protocol */
+
+/* A2MP command codes */
+
+#define A2MP_COMMAND_REJ	0x01
+#define A2MP_DISCOVER_REQ	0x02
+#define A2MP_DISCOVER_RSP	0x03
+#define A2MP_CHANGE_NOTIFY	0x04
+#define A2MP_CHANGE_RSP		0x05
+#define A2MP_INFO_REQ		0x06
+#define A2MP_INFO_RSP		0x07
+#define A2MP_ASSOC_REQ		0x08
+#define A2MP_ASSOC_RSP		0x09
+#define A2MP_CREATE_REQ		0x0a
+#define A2MP_CREATE_RSP		0x0b
+#define A2MP_DISCONN_REQ	0x0c
+#define A2MP_DISCONN_RSP	0x0d
+
+typedef struct {
+	uint8_t		code;
+	uint8_t		ident;
+	uint16_t	len;
+} __attribute__ ((packed)) a2mp_hdr;
+#define A2MP_HDR_SIZE 4
+
+typedef struct {
+	uint8_t		type_id;
+	uint16_t	len;
+	uint8_t		data[0];
+} __attribute__ ((packed)) a2mp_assoc_tlv;
+
+typedef struct {
+	uint16_t	reason;
+} __attribute__ ((packed)) a2mp_cmd_rej_parms;
+
+typedef struct {
+	uint16_t	mtu;
+	uint16_t	mask;
+} __attribute__ ((packed)) a2mp_discover_req_parms;
+
+typedef struct {
+	uint16_t	mtu;
+	uint16_t	mask;
+	uint8_t		controller_list[0];
+} __attribute__ ((packed)) a2mp_discover_rsp_parms;
+
+typedef struct {
+	uint8_t		id;
+} __attribute__ ((packed)) a2mp_info_req_parms;
+
+typedef struct {
+	uint8_t		id;
+	uint8_t		status;
+	uint32_t	total_bandwidth;
+	uint32_t	max_bandwidth;
+	uint32_t	min_latency;
+	uint16_t	pal_caps;
+	uint16_t	assoc_size;
+} __attribute__ ((packed)) a2mp_info_rsp_parms;
+
+typedef struct {
+	uint8_t		id;
+	uint8_t		status;
+	a2mp_assoc_tlv	assoc;
+} __attribute__ ((packed)) a2mp_assoc_rsp_parms;
+
+typedef struct {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+	a2mp_assoc_tlv	assoc;
+} __attribute__ ((packed)) a2mp_create_req_parms;
+
+typedef struct {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+	uint8_t		status;
+} __attribute__ ((packed)) a2mp_create_rsp_parms;
+
+typedef struct {
+	uint8_t		local_id;
+	uint8_t		remote_id;
+} __attribute__ ((packed)) a2mp_disconn_req_parms;
+
+#define A2MP_COMMAND_NOT_RECOGNIZED 0x0000
+
+/* AMP controller status */
+#define AMP_CTRL_POWERED_DOWN		0x00
+#define AMP_CTRL_BLUETOOTH_ONLY		0x01
+#define AMP_CTRL_NO_CAPACITY		0x02
+#define AMP_CTRL_LOW_CAPACITY		0x03
+#define AMP_CTRL_MEDIUM_CAPACITY	0x04
+#define AMP_CTRL_HIGH_CAPACITY		0x05
+#define AMP_CTRL_FULL_CAPACITY		0x06
+
+/* A2MP response status */
+#define A2MP_STATUS_SUCCESS				0x00
+#define A2MP_STATUS_INVALID_CTRL_ID			0x01
+#define A2MP_STATUS_UNABLE_START_LINK_CREATION		0x02
+#define A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS		0x02
+#define A2MP_STATUS_COLLISION_OCCURED			0x03
+#define A2MP_STATUS_DISCONN_REQ_RECVD			0x04
+#define A2MP_STATUS_PHYS_LINK_EXISTS			0x05
+#define A2MP_STATUS_SECURITY_VIOLATION			0x06
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __A2MP_H */
-- 
1.7.7

-- 
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
