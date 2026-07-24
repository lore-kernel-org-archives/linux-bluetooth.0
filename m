Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D344C65F
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920361; cv=none; b=ECWdOw+FMm/plOcDwOhY7JCKeMeMdTku/btFpH7np8NtZ8ma5cvKM6DMypwIarAwxwGI55TCqZVTQ3wj3pgLSbvLFPpjwL0H1xPmjDBs6Z45rFS4GZUqomzHkVuE9O78N7VLQ3WNhZTmCG1tH5gjDWhRFXv60VOOe6Lu8coe3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920361; c=relaxed/simple;
	bh=ytA+ZiYq5ltE3R+uXulLHKYcnl2EI1p8mqXCpWWdWUk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oODy5Dg8dXAtyZflwQm8RWqW1YzRIXUQThGz8tIeOHR/NL8BSshAHrcz+OyVdzTaJ0hdzqWnss7tbDUgrd3q4bzEiiXRIJ9WeUHivQB2A79iiKBfXgjok38PRaE2gltDLMLkSYuhoc0ZlVVNymiigG4TXKcPN5wD57FYmetXHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceoNT8TL; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceoNT8TL"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so478523e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920359; x=1785525159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+SPsEiIGqUBLuxNcyV5ClSeYJePE2hPXdSOngCHkYjU=;
        b=ceoNT8TLDSo5eR7hj/eEocpVTb+czEDUNdE3/ESOQJw7Hu9GOd6ytiWpuQM71007fc
         ufWaBNGZSKgF+49gzBSVEPVkzTXrf4JVT0KM8LhxnleHD3mZ3cJ55SF7V4I31D1lIB0B
         sSNlnL0hX4KkQ4ALgI6zuF+MRojvoCRqgkc/WzdrDUEXxt/z9M9N62a4paCCvQFDX6oh
         sUNie2uvx2C6Hx1ujpued4pDFubaDY6v+Fdgh0jK5wUlL85ycyooS8gy/Ojeu1l78FWo
         bY5LHVz2Rn+IeKdMSX9OEObZxdwd7pw3tHD5QucddgQG1JmadOgcg59qFlu8S9scwVVI
         doAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920359; x=1785525159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+SPsEiIGqUBLuxNcyV5ClSeYJePE2hPXdSOngCHkYjU=;
        b=b2p++38qEvwRGQNgO22L471PTb5zwJ/nPLYWggMDMJy3yz263J1LQMclJZyWfZRWvF
         Z+SqT/feP5Ff7VFsP2JFrl8jV3ayY2Ka6fydVxebn4G6Uk+4/6YL5zO0wcxBMMu5w/5p
         p2Awsd58oOGmFhnwYoDZ5p+/9XSr989HChzCQ9z6bPS22jF9HnKbeoXtWUeUBv5RsF9z
         SfREG6rY1s4hz6b3m8FsnzU8d/PHAHCOBQc9y/rkituXzTrrQUD8+sjmBiyVWAh8uP0R
         LrLOenOsqis+nSEJ6Rd2PL1UqZ1lVipYZMBzogpeagIbQSYmATwficVCvTvIf9IZVg/S
         9URQ==
X-Gm-Message-State: AOJu0YxTVHUubKs8JtBdJuNnyHkmJozAs/ZfFkpbHveW8VkT55HB0Yog
	+He9ahFjU67ggGT8Doi+VZQl7vWLupGZHTDGvqKm3fhFlEiDhrP+gBBk6MKENdf5
X-Gm-Gg: AR+sD128qUc1eGoDQEHfU3DkjrCdKNsXswKh/XKEC3C57pwjBvnhXUzYNOqVXfXlInJ
	E/jQJbu2I78Fx4is8oYp9wTrBYYnkb2ByU1GGnN/sI575E9PM3WsDJOtYlmAIoyJX88dKBHSFI/
	E4IM18J2xA5SqDHMbG7Ty0HBqFPa4vxBJWhGCMriUg+Pw1nseJBAewCb4lI4y7ujYDA4uQrIGED
	rFs6FlL/K6fu2GfFC8Xaiz1iJ2FDrHzDoYtS+zqD0usY52PA6ZQf0IBvQgkUIkMRNl9XeJZJFAL
	hzpe+mVPXhCI7bYtXP/CxquxLNgrPF1GXRN5yoLvkQRBwnAxW3bOZ7KxHPU/ptlR/5mHshFS/iU
	KYfOyJZyyx8QuCK4738L9Ezpg4BzwfKqBiwdlU45DA7B+Kg5yQzhXcV9oIZClX7PRLvG0rN7Bte
	huBEcqWUh1uhHKGCoUvSttpeXZ7/JTsApA3HAGNT5iNMQJztzlRO/ZGciLDBou4j2e/8CO3RCS
X-Received: by 2002:a05:6122:2895:b0:5bb:eebe:7ffd with SMTP id 71dfb90a1353d-5c2da07b556mr5069741e0c.8.1784920358574;
        Fri, 24 Jul 2026 12:12:38 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/12] mgmt: Add Shorter Connection Interval setting and Load Connection Subrate
Date: Fri, 24 Jul 2026 15:12:16 -0400
Message-ID: <20260724191225.1815634-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add the Shorter Connection Interval setting bit (25) to indicate
controller support for SCI feature.

Add the Load Connection Subrate command (0x005C) which allows
loading connection subrate parameters for devices that support
shorter connection intervals as defined in Bluetooth 6.2.
---
 doc/mgmt-protocol.rst | 125 ++++++++++++++++++++++++++++++++++++++++++
 lib/bluetooth/mgmt.h  |  31 +++++++++++
 2 files changed, 156 insertions(+)

diff --git a/doc/mgmt-protocol.rst b/doc/mgmt-protocol.rst
index 35446dd974ac..f0564075f92f 100644
--- a/doc/mgmt-protocol.rst
+++ b/doc/mgmt-protocol.rst
@@ -321,6 +321,7 @@ following available bits:
     22, LL Privacy
     23, PAST Sender
     24, PAST Receiver
+    25, Shorter Connection Interval
 
 This command generates a Command Complete event on success or a Command Status
 event on failure.
@@ -4170,6 +4171,86 @@ Possible errors:
 :Failed:
 :Invalid Parameters:
 
+Load Connection Subrate
+```````````````````````
+
+:Command Code:		0x005C
+:Controller Index:	<controller id>
+:Command Parameters:	Param_Count (2 Octets)
+:...:			Address[] (6 Octets)
+:...:			Address_Type[] (1 Octet)
+:...:			Min_Connection_Interval[] (2 Octets)
+:...:			Max_Connection_Interval[] (2 Octets)
+:...:			Subrate_Min[] (2 Octets)
+:...:			Subrate_Max[] (2 Octets)
+:...:			Max_Latency[] (2 Octets)
+:...:			Continuation_Number[] (2 Octets)
+:...:			Supervision_Timeout[] (2 Octets)
+:...:			...[]
+:Return Parameters:
+
+This command is used to load connection subrate parameters from several devices
+into the kernel. This is only supported on controllers with Low Energy support
+and the Shorter Connection Interval (SCI) feature.
+
+This command operates on the same device entries as Load Connection Parameters
+(0x0035). If an entry for the given device already exists, the subrate-specific
+fields are updated on that entry. If no entry exists, a new one is created. The
+device must have been previously added via Load Connection Parameters or this
+command.
+
+Note that the Min_Connection_Interval and Max_Connection_Interval parameters in
+this command refer to the connection rate interval used with the LE Connection
+Rate Request procedure, which has different valid ranges than the connection
+interval in Load Connection Parameters. The Load Connection Parameters interval
+is specified in units of 1.25 ms (range: 6 to 3200), while the connection rate
+interval here is specified in units of 0.125 ms (range: 8 to 3200).
+
+Loading with multiple entries overwrites the subrate parameters for all listed
+devices. Loading with a single entry attempts to update the parameters if an
+entry for the given device already exists, or adds a new entry otherwise.
+
+Possible values for the Address_Type parameter:
+
+.. csv-table::
+	:header: "Value", "Description"
+	:widths: auto
+
+	0x00, BR/EDR
+	0x01, LE Public
+	0x02, LE Random
+
+The provided Address and Address_Type are the identity of a device. So either
+its public address or static random address.
+
+The Min_Connection_Interval and Max_Connection_Interval parameters specify the
+connection rate interval range in units of 0.125 ms (range: 0x0008 to 0x0C80,
+corresponding to 1.0 ms to 400.0 ms). These are distinct from the connection
+parameters interval in Load Connection Parameters which uses units of 1.25 ms.
+
+The Subrate_Min and Subrate_Max parameters specify the acceptable subrate factor
+range.
+
+The Max_Latency parameter specifies the maximum peripheral latency in units of
+subrated connection events.
+
+The Continuation_Number parameter specifies the number of continuation events
+the peripheral will be listened to.
+
+The Supervision_Timeout parameter specifies the link supervision timeout in
+units of 10 ms.
+
+This command can be used when the controller is not powered.
+
+This command generates a Command Complete event on success or a Command Status
+event on failure.
+
+Possible errors:
+
+:Invalid Parameters:
+:Invalid Index:
+:Not Supported:
+
 Events
 ------
 
@@ -5396,3 +5477,47 @@ This event indicates that a requested outbound Mesh packet has completed and no
 longer occupies a transmit slot.
 
 This event will be sent to all management sockets.
+
+Connection Subrate
+``````````````````
+
+:Event Code:		0x0033
+:Controller Index:	<controller id>
+:Event Parameters:	Address (6 Octets)
+:...:			Address_Type (1 Octet)
+:...:			Status (1 Octet)
+:...:			Interval (2 Octets)
+:...:			Subrate (2 Octets)
+:...:			Latency (2 Octets)
+:...:			Continuation_Number (2 Octets)
+:...:			Supervision_Timeout (2 Octets)
+
+This event indicates that the connection rate has changed for a device. This
+can be a result of a successful LE Connection Rate Request or a change
+initiated by the remote device.
+
+Possible values for the Address_Type parameter:
+
+.. csv-table::
+	:header: "Value", "Description"
+	:widths: auto
+
+	0x01, LE Public
+	0x02, LE Random
+
+The Status indicates whether the connection rate change was successful.
+
+The Interval parameter specifies the new connection interval in units of
+0.125 ms.
+
+The Subrate parameter specifies the subrate factor.
+
+The Latency parameter specifies the peripheral latency.
+
+The Continuation_Number parameter specifies the number of continuation
+events.
+
+The Supervision_Timeout parameter specifies the supervision timeout in units
+of 10 ms.
+
+This event will be sent to all management sockets.
diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 7fab3d7a0bba..9df0c1ba2fbf 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -107,6 +107,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
 #define MGMT_SETTING_PAST_SENDER	BIT(23)
 #define MGMT_SETTING_PAST_RECEIVER	BIT(24)
+#define MGMT_SETTING_SCI		BIT(25)
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -814,6 +815,23 @@ struct mgmt_cp_hci_cmd_sync {
 	uint8_t  params[];
 } __packed;
 
+struct mgmt_conn_subrate {
+	struct mgmt_addr_info addr;
+	uint16_t min_interval;
+	uint16_t max_interval;
+	uint16_t subrate_min;
+	uint16_t subrate_max;
+	uint16_t max_latency;
+	uint16_t cont_num;
+	uint16_t supv_timeout;
+} __packed;
+
+#define MGMT_OP_LOAD_CONN_SUBRATE	0x005C
+struct mgmt_cp_load_conn_subrate {
+	uint16_t param_count;
+	struct mgmt_conn_subrate params[];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -1107,6 +1125,17 @@ struct mgmt_ev_mesh_pkt_cmplt {
 	uint8_t	handle;
 } __packed;
 
+#define MGMT_EV_CONN_SUBRATE			0x0033
+struct mgmt_ev_conn_subrate {
+	struct mgmt_addr_info addr;
+	uint8_t  status;
+	uint16_t interval;
+	uint16_t subrate;
+	uint16_t latency;
+	uint16_t cont_num;
+	uint16_t supv_timeout;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1200,6 +1229,7 @@ static const char *mgmt_op[] = {
 	"Mesh Send",
 	"Mesh Send Cancel",
 	"HCI Cmd Sync",
+	"Load Connection Subrate",
 };
 
 static const char *mgmt_ev[] = {
@@ -1254,6 +1284,7 @@ static const char *mgmt_ev[] = {
 	"Advertisement Monitor Device Lost",
 	"Mesh Packet Found",
 	"Mesh Packet Complete",
+	"Connection Subrate",
 };
 
 static const char *mgmt_status[] = {
-- 
2.54.0

