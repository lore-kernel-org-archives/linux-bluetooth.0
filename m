Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769659;
	b=UX4zH2aAbCVZI/z61hQNXudZRDti4a9ZPDtvqIEzt/JmSw8GH5R0aHgO3FtmGHsi8DWD
	 yDBWO5AATfH3mAP2TCHoJifVpIxPLv/hJJ1Z8Lh26bhIFOMJ2tgtnL7xKLafk5wRmaYT5
	 hT8yD17nDe+KIJUtp2xoa0yuAs7xp3XE2lP8ymnR8IfAKBIygp7o/yU62NvwFBjX79kqI
	 PLnZznabvsL51kqx4iKrE4FTgvW+zcpMWOzYn059SHbpwpbyAIO/5zQ2MAGYvGtrJtXzf
	 fg220kX0uaJy3Av4QuRuCdiFPiva/xrpXRGZvMKJFDFMmrQ/L7FBdJ00U6z3eI30guw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tsSPL51FeALmAR/qfsWQKAbY9gJVU1A5IbpKy4+QT3M=;
	b=PjbYVxER/mU6ZvANPKfDMeaB04EpnMdPT8xpwA0f5aPJQNB900N6ssPNCE9gtOHjPp9w
	 wYtTI4JVFhfpp4SZYihlDErSxe0QuFO3IlB2cvy/GiUwd7gDRLAn8FIuhYKcnkKCDn1LU
	 qIbaxtOQRLwRRsz5I6SOJkhnTEbR5nveyLKevdXDMKZ6LfKt2pbZS33wd5nRTI2H7va2X
	 abtRoEbKmRyDNC44kFvQUBkYftMRcE90/O/3jya7RSorfinGOiPG5adFYLmsfaA8NeUPx
	 ty/X+4kPSY6PrCfndF+G6W8jv1+FeBWj0jkbjuMNNkpvIaOZqTbML9hWptEgjpvBcYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9Rp0HVo;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0002606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 08:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0002606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z9Rp0HVo
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c5187b42a2dso62331066b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 00:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769657; x=1796374457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsSPL51FeALmAR/qfsWQKAbY9gJVU1A5IbpKy4+QT3M=;
        b=Z9Rp0HVoEbjKX7732gt3ukPvqsNPph59kJEeHCtFNhVqTT/Oz7D5VsTJ1kihHxvf7g
         xlYZJ2Dr8EP5+y6m3HY2y9jftZqIU9EZTSnbrFPTYtJMwIvgExj3bcmXfMzyLqg7vXrI
         Nftmvt/QKkgWlDmBsZlEg2FwndqrwS6nJ/skpSZ4kCBDdV7/6lNvV4qEw7CTE2kZOB5I
         veV/DZToTmWaUuw+eIGAJG4uiy1E1J+IDYAy8sj//qF1T8vKnGMj+Lxc+ranFXaC/u42
         q3q0qrxiTa2lRnNZP9DaUWm1Bh3FWry91DA3sp/iKb61YXcTds98NAjWBQHR62qFqrEo
         7lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769657; x=1796374457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsSPL51FeALmAR/qfsWQKAbY9gJVU1A5IbpKy4+QT3M=;
        b=Hoetva0U+uSQx+zW3dnBYVXfwhpaL6VUQXL0ll9b9WqYA9jLE1tkV1mkGMg1ZogQ1k
         lRf3s9MFdIf0eoJ5plriq7AwaqHBR/SjChY0gC0sXlR6E4S8dDBr68oB0HpzgWMhlms3
         NsXTRDE36kd06iJOCCGmUYgVs6puF109Q8pVR//HK76jlrnSN4b2OgkPPMdMd/nIrVfB
         dC0w3d0KVeA0arTQYzf2cVzrZ04IVQaxSw5wDgjXK3JHVDr0ZICxKJ7Tq32HYtvaxhVy
         Xj0EwA0uVZvUjD5wmGjH6Wc5ApDhMvQ6N48SBA3rFTGk/GEmZ/8cDgycR603u4USkPKz
         zFOg==
X-Gm-Message-State: APuU4Z8qQCPIyWGhRm45GDXcpErihpQdRuZQdcUJ7Ye/GbFDe8eHB3Df
	S7chPe/PfTqcXUHA/DgutYJgYn5L3VxloS7zd34AbifoJdfkhfWSuo2xW42DQ0m1
X-Gm-Gg: AZFdTZed1mpA93Qq+ltnFLC/qeYD+tUH14cog5h+EBxUqcZsdaoN+tagBYz+unxV2Vf
	U/dYSuITK/MZUCa60ytKjyXNMVf4jBNNl+0lxUF1TOk6+LNJg8Zo9ccqrbo86aEHb8TkuZau2+6
	AE8tO2lSFbJD0TzYguMRxBRalaTJl31Gjv6rblTha5W3fSR0Yx6ztDwArG1IWbL3kkcEZsp0L/q
	qO57B8vYzuke6r3GoMSjG5TI3KxLMmY8OhoqcSuhx0Rsx9T0PKmpQjT3Qq03iYdsRktDczG5W+l
	RaX+FOV6jNbeXpDHBAVqJIS7ipcQczfKFpSAMugouA0OJncWKsimIGZ6xCGDKl4bDHpe/k6bC1v
	8d/Vwj2VT7Capgz4X+CeCthHWMERo18zkTkDLgE+OfjbTkaWmGXK8E8T1rE/e7FcOTNB7ptZ17q
	rkK4RMHTRcI3QSul1/wdWiOUK7LDgTaXQH4jGRiLp3dR+/mi6b7lDR7BqeaZb2R5dvOrKurwJJ4
	nA8oVfULIr8kze2E2YNrsU4a6lg/FqjC5vT6UUJn2I11MT5A5XsNCzjR3NmcFxG/eF/LaGongTM
	USQQ/HjE8QqQmFIeefkOyCPDhQoMNeZKCho=
X-Received: by 2002:a17:906:68d5:b0:c51:4fd:1aef with SMTP id a640c23a62f3a-c513a50ab80mr1922559366b.2.1795769657087;
        Fri, 27 Nov 2026 00:54:17 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm870688166b.33.2026.11.27.00.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:54:16 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [RFC PATCH 1/5] Bluetooth: hci: Add Periodic Advertising with Responses definitions
Date: Fri, 27 Nov 2026 09:53:56 +0100
Message-ID: <20261127085401.263615-2-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127085401.263615-1-rolandschober1968@gmail.com>
References: <20261127085401.263615-1-rolandschober1968@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the HCI definitions of the advertiser side of Periodic Advertising
with Responses (PAwR), from the Bluetooth Core Specification 5.4:

 - the LE feature bits of the PAwR advertiser and scanner;
 - LE Set Periodic Advertising Parameters [v2], which adds the subevent
   and response slot timing to the periodic advertising parameters;
 - LE Set Periodic Advertising Subevent Data, by which the host hands
   the controller the data of the next subevents;
 - LE Periodic Advertising Subevent Data Request, by which the
   controller asks for that data;
 - LE Periodic Advertising Response Report, which carries the responses
   received in the response slots of a subevent.

Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Roland Schober <rolandschober1968@gmail.com>
---
 include/net/bluetooth/hci.h      | 59 ++++++++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |  6 ++++
 2 files changed, 65 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index ac64780274a5..81ff64dc82ac 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -659,6 +659,8 @@ enum {
 #define HCI_LE_ISO_BROADCASTER		0x40
 #define HCI_LE_ISO_SYNC_RECEIVER	0x80
 #define HCI_LE_LL_EXT_FEATURE		0x80
+#define HCI_LE_PAWR_ADVERTISER		0x08	/* byte 5 */
+#define HCI_LE_PAWR_SCANNER		0x10	/* byte 5 */
 #define HCI_LE_CS			0x40
 #define HCI_LE_CS_HOST			0x80
 #define HCI_LE_SCI			0x01	/* byte 9 - Shorter Connection Intervals */
@@ -2294,6 +2296,37 @@ struct hci_cp_le_set_host_feature {
 	__u8     bit_value;
 } __packed;
 
+struct hci_le_per_adv_subevent_data {
+	__u8    subevent;
+	__u8    response_slot_start;
+	__u8    response_slot_count;
+	__u8    data_len;
+	__u8    data[] __counted_by(data_len);
+} __packed;
+
+/* What fits one command next to handle and num_subevents */
+#define HCI_MAX_PER_ADV_SUBEVENT_DATA_LEN	253
+
+#define HCI_OP_LE_SET_PER_ADV_SUBEVENT_DATA	0x2082
+struct hci_cp_le_set_per_adv_subevent_data {
+	__u8    handle;
+	__u8    num_subevents;
+	__u8    subevents[];
+} __packed;
+
+#define HCI_OP_LE_SET_PER_ADV_PARAMS_V2		0x2086
+struct hci_cp_le_set_per_adv_params_v2 {
+	__u8    handle;
+	__le16  min_interval;
+	__le16  max_interval;
+	__le16  periodic_properties;
+	__u8    num_subevents;
+	__u8    subevent_interval;
+	__u8    response_slot_delay;
+	__u8    response_slot_spacing;
+	__u8    num_response_slots;
+} __packed;
+
 #define HCI_OP_LE_READ_ALL_LOCAL_FEATURES	0x2087
 struct hci_rp_le_read_all_local_features {
 	__u8    status;
@@ -3380,6 +3413,32 @@ struct hci_evt_le_big_info_adv_report {
 	__u8    encryption;
 } __packed;
 
+#define HCI_EV_LE_PER_ADV_SUBEVENT_DATA_REQ	0x27
+struct hci_ev_le_per_adv_subevent_data_req {
+	__u8    handle;
+	__u8    subevent_start;
+	__u8    subevent_data_count;
+} __packed;
+
+struct hci_le_per_adv_response {
+	__s8    tx_power;
+	__s8    rssi;
+	__u8    cte_type;
+	__u8    response_slot;
+	__u8    data_status;
+	__u8    data_len;
+	__u8    data[] __counted_by(data_len);
+} __packed;
+
+#define HCI_EV_LE_PER_ADV_RESPONSE_REPORT	0x28
+struct hci_ev_le_per_adv_response_report {
+	__u8    handle;
+	__u8    subevent;
+	__u8    tx_status;
+	__u8    num_responses;
+	__u8    responses[];
+} __packed;
+
 #define HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE 0x2b
 struct hci_evt_le_read_all_remote_features_complete {
 	__u8    status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4aa0b49ae104..250245186702 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2140,6 +2140,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Periodic advertising support */
 #define per_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_PERIODIC_ADV))
 
+/* Periodic Advertising with Responses support */
+#define pawr_adv_capable(dev) \
+	((dev)->le_features[5] & HCI_LE_PAWR_ADVERTISER)
+#define pawr_scan_capable(dev) \
+	((dev)->le_features[5] & HCI_LE_PAWR_SCANNER)
+
 /* CIS Master/Slave and BIS support */
 #define iso_capable(dev) (cis_capable(dev) || bis_capable(dev))
 #define iso_enabled(dev) (le_enabled(dev) && iso_capable(dev))
-- 
2.47.3

