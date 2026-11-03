Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744394;
	b=gfDlIcE9GWSxHAaBgaIC0aiP3Byh9ebv1XGkZm07bjsDfEP/nsJwztWCMSNtUeXRr8nt
	 vcVYAGXXnyougHgRLAhh9TZ4YNm/dyuX/z7lrtX17FxIRmd2beOC+xZea2kT2RZBVk7SN
	 xFBe2ma3Sez2dkDxd0WfesqsSCfCnHe5/vNTW1rfFJ49bSxTIP3Di/xpH8lAeYMMf+W6z
	 fTvcGipsbxO5ImU+a3vItCCQDkdEAIAIXUmNJdKZ0vGEgyT766g8c5f+EqpaFnqThIeRc
	 cnUfmYg/RuIBx66P4wzr0XigRoM1dBDKfneicNtqO2xsugv/3/mMBeGljZy3a+xmDSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4SzJ8RlYTNfbw3uGQAM0DBxrn8IAE/7UVTHyN9HioJU=;
	b=UzizjAlsB3w+Y4XYZsVkV8JDhY9Q2nfOxwWwMKM24aO7+gbIV8x+rBkwneloicYmVfEM
	 B4yVn/Pmh8LIqB5HyxLTExXrhEfcTYK/WkCiz3BLIFBrdhg2LPeXc2mypyGn7zZeTUBkM
	 rre3PDQyla6TTNgpQ2PbaKaNPIGAeKBS7osIqXA6P5IAkOJhcSkR/KRRqITZRGyfOBlrk
	 hE2sQR2y9M3YYD+nlqtJzJ5TSqYASv/hfzgbtjeRQX8B7vfzpujwVZVGQ/tX4/J6nCsH1
	 wcO0tAf0Cr89vKhbTWrgk1qfRgDvyRYn1L85VEB/qjVguRDd0np+8J9vx7SZTGQsNnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHO1y7Zy;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B33606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2B33606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iHO1y7Zy
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-992f6d8cb51so22401241.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744392; x=1794349192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4SzJ8RlYTNfbw3uGQAM0DBxrn8IAE/7UVTHyN9HioJU=;
        b=iHO1y7ZytSjekHDKj75al3CMEGYB1smnTDkvrPlXGPGzCbQXvTacZMKJBO2mwpWIvC
         M/oXtoL9oT34bXl4UgIynxHWhBmrO+QoB/6vvOd0tvDYO3zIog4HGqyJwYpSTZif8s4B
         yEft9iyFWE2hoA+cA3AmADxj92ntDRqUvwslGnkP36AfXFSHSdrRKZUEeGZ+7NXPnERA
         4R2SxnLrnW2pNwv2n9etxtXzMBMxgUwe7b7vhoI8IfKei5lAI08GntXwXvJ806CM8TI5
         1ptzlkfg90lW2vLavL7bj8x47Dyt1LkJMUNSjkAXXNNoIqbDAHmmyd74s0KfdDQTDFTQ
         uAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744392; x=1794349192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4SzJ8RlYTNfbw3uGQAM0DBxrn8IAE/7UVTHyN9HioJU=;
        b=0n7831uEPJJaC9OCY2UPlc/Cg8Q2aYseH3Ftyc0U8V/KOUzeXVwohYfcfj9v2/tkWv
         6P+RhteJRaDD709VkWSkXIiSwP0j+JHctnWTcUeni8qmH6Ic37D5BL53AMoChWh6bY35
         O1YfKyzzBx8aU5pRcMkw/ubm2kZTDQPC5sLrtKLSolFy2ebApW9O1kTR63d5VpHmTjyt
         XHPJEuJpv3viGZ2OqZHP/QEa+Q/iZVfFF7uJByYog00bh3imD8YXUFFoHn/Dk3OaxZ8A
         hwE7yWI5H+68jjrF/l8JdzKeJWWIRlqWyBiTNkkOAI0PGt+eLkjQXtt4fmT+66VRYm/l
         gKyw==
X-Gm-Message-State: APuU4Z/CHM9WgdF0qc8aAmF7I4WgZyJGCERQ8Uc/8Xm+CKNPYDyPAJoj
	a7bBZ5n7Q7MHqGSCXt6IF048pYcKnq/V4n4Dwk3P3se2Ow8pw6vGrI2LHlw+jg==
X-Gm-Gg: AYBFou2m/PUV87WaOh+9SkJszpixtzwSC2YWfCA10xc7trVf/UM4vbNEOEQePh+HKpm
	FNN7faKaqmg3oBHfZc9ZURTIQpiJhplRZJn9Pb6OesKZKbdWCHOW1ej+1II4ZJBFMgH9cXMVh6J
	P1P9cU5O7KXfivMOdeJJ4nrot9VzccDf7YMWDkc3lq0Jr7rGvyK73OUF5YB8Gyoqs9Ig6Yc+3jh
	k3ipeNKlydfvcZpNDNMjFzayPx2TmgPZhrguiH1JPAJx3Ee63in168tk7mXSNN/MvFIxfxXX/pF
	Pvsaszm3UEUJfkDIJm+hFG6HyF0AksuNgzvY9kJHWMjfJpb/nVd7j6tUWoj6ef4qFt7C/sFGQcC
	NGvTp6Rlg/2vcGPZCCjkOPAG++9Gpcp+Sh+E0Pw49nz4MDZMtpJrn6TikYit9qxIUf7RlX2Ho6D
	NNVNpFmtdlsapxiHsWG34JU5xI+Mim4b2FtPaw3AX7PvVNBctS2+F+eZnIi4GxjObcdzQ3GVDn/
	dyBwpjsMO+ufnsSOuI0xnjNqNCDY1oEhxCz4FPdQupySljrlNR4TdUuGbiLnzh6yr/+yfM4DtqY
	sFjRmibc2eSIGR2csLcANtFDjVLi0ZFSD/vJxKcn/51gYxpuag/i6oGqdVmI4LyrXjf2vOKSnJk
	haOpUdy1+qqkh461MJXkdUUiIo0EfFP7Vr6etWp19PTEdxspXhHSuokO3dmsC2VpfG6a2HzxJ+p
	QxrkAcHymm9cxUGlu5n5KlR9hD
X-Received: by 2002:a05:6102:a4f:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7d072d4634amr4711541137.36.1793744390903;
        Tue, 03 Nov 2026 14:19:50 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d8afc268sm356591241.4.2026.11.03.14.19.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/9] monitor: Add HCI decoding for HDT
Date: Tue,  3 Nov 2026 17:19:36 -0500
Message-ID: <20261103221944.4072041-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221944.4072041-1-luiz.dentz@gmail.com>
References: <20261103221944.4072041-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Decode the HCI commands, events, feature bits and supported commands
bits introduced by High Data Throughput (HDT) and Encryption Key Schedule
(EKS) in Bluetooth 7.0, along with the MIC Length Too Short error codes
of L2CAP and ATT, the HDT MGMT setting and the HDT default parameters
and EKS Opportunistic Encryption system configuration TLVs.

Assisted-by: OpenCode:claude-opus-5
---
 monitor/att.c    |    3 +
 monitor/bt.h     |  414 +++++++++++++++
 monitor/l2cap.c  |    6 +
 monitor/packet.c | 1308 +++++++++++++++++++++++++++++++++++++---------
 4 files changed, 1497 insertions(+), 234 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index a35198949e3d..7ddc155838df 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -364,6 +364,9 @@ static void att_error_response(const struct l2cap_frame *frame)
 	case 0x13:
 		str = "Value Not Allowed";
 		break;
+	case 0xdf:
+		str = "MIC Length Too Short";
+		break;
 	case 0xfd:
 		str = "CCC Improperly Configured";
 		break;
diff --git a/monitor/bt.h b/monitor/bt.h
index 2ddf37ccc22f..ae2333b39cbf 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -253,6 +253,104 @@ struct bt_ll_feature_ext_rsp {
 	uint8_t  features[24];
 } __attribute__ ((packed));
 
+#define BT_LL_REFRESH_ENC_IND	0xe4
+struct bt_ll_refresh_enc_ind {
+	uint8_t  mic_len;
+	uint16_t instant;
+} __attribute__ ((packed));
+
+#define BT_LL_REFRESH_ENC_RSP	0xe5
+struct bt_ll_refresh_enc_rsp {
+	uint8_t  flags;
+} __attribute__ ((packed));
+
+#define BT_LL_REFRESH_ENC_REQ	0xe6
+struct bt_ll_refresh_enc_req {
+	uint8_t  flags;
+} __attribute__ ((packed));
+
+#define BT_LL_ENC_ECDH_RSP	0x41
+struct bt_ll_enc_ecdh_rsp {
+	uint8_t flags;
+	uint8_t rand[16];
+	uint8_t key_type;
+	uint8_t pubkey[64];
+} __attribute__ ((packed));
+
+#define BT_LL_ENC_ECDH_REQ	0x40
+struct bt_ll_enc_ecdh_req {
+	uint8_t flags;
+	uint8_t rand[16];
+	uint8_t key_type;
+	uint8_t pubkey[64];
+} __attribute__ ((packed));
+
+#define BT_LL_CIS_IND_V2	0xe9
+struct bt_ll_cis_ind_v2 {
+	uint32_t addr;
+	uint8_t  cis_offset[3];
+	uint8_t  cig_sync_delay[3];
+	uint8_t  cis_sync_delay[3];
+	uint16_t conn_event_count;
+	uint8_t  pca_h;
+} __attribute__ ((packed));
+
+#define BT_LL_PHY_UPDATE_IND_V2	0xf6
+struct bt_ll_phy_update_ind_v2 {
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint16_t instant;
+	uint8_t  address[5];
+} __attribute__ ((packed));
+
+#define BT_LL_HDT_CONFIG_RSP	0x43
+struct bt_ll_hdt_config_rsp {
+	uint8_t  wincfg;
+	uint16_t acl_rx_rates;
+	uint16_t acl_rx_mtu;
+} __attribute__ ((packed));
+
+#define BT_LL_HDT_CONFIG_REQ	0x42
+struct bt_ll_hdt_config_req {
+	uint8_t  wincfg;
+	uint16_t acl_rx_rates;
+	uint16_t acl_rx_mtu;
+} __attribute__ ((packed));
+
+#define BT_LL_HDT_LQF_REPORTING_IND 0x44
+struct bt_ll_hdt_lqf_ind {
+	uint8_t  transport;
+} __attribute__ ((packed));
+
+#define BT_LL_CIS_REQ_V3	0xfa
+struct bt_ll_cis_req_v3 {
+	uint8_t  cig;
+	uint8_t  cis;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
+	uint8_t  c_pdu;
+	uint8_t  p_pdu;
+	uint8_t  nse;
+	uint8_t  sub_interval[3];
+	uint8_t  bn;
+	uint8_t  c_ft;
+	uint8_t  p_ft;
+	uint16_t iso_interval;
+	uint8_t  offset_min[3];
+	uint8_t  offset_max[3];
+	uint16_t conn_event_count;
+	uint16_t c_rates;
+	uint16_t p_rates;
+	uint8_t  config_id;
+	uint8_t  tl_group_id;
+	uint8_t  wincfg;
+} __attribute__ ((packed));
+
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
@@ -3247,6 +3345,234 @@ struct bt_hci_rsp_le_read_conn_interval {
 	struct bt_hci_le_conn_interval_group grps[0];
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_WRITE_DEF_DATA_LEN_V2	0x20b2
+#define BT_HCI_BIT_LE_WRITE_DEF_DATA_LEN_V2	BT_HCI_CMD_BIT(50, 7)
+struct bt_hci_cmd_le_write_def_data_len_v2 {
+	uint16_t tx_len;
+	uint16_t tx_time;
+	uint8_t  phys;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_DEF_DATA_LEN_V2	0x20b1
+#define BT_HCI_BIT_LE_READ_DEF_DATA_LEN_V2	BT_HCI_CMD_BIT(50, 6)
+struct bt_hci_cmd_le_read_def_data_len_v2 {
+	uint8_t  phys;
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_read_def_data_len_v2 {
+	uint8_t  status;
+	uint16_t tx_len;
+	uint16_t tx_time;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2		0x20af
+#define BT_HCI_BIT_LE_ENABLE_ENCRYPT_V2		BT_HCI_CMD_BIT(50, 4)
+struct bt_hci_cmd_le_enable_encrypt_v2 {
+	uint16_t handle;
+	uint64_t rand;
+	uint16_t ediv;
+	uint8_t  ltk[16];
+	uint8_t  mic_len;
+	uint8_t  encryption;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_MAX_DATA_LEN_V2	0x20b0
+#define BT_HCI_BIT_LE_READ_MAX_DATA_LEN_V2	BT_HCI_CMD_BIT(50, 5)
+struct bt_hci_cmd_le_read_data_len_v2 {
+	uint8_t  phy;
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_read_data_len_v2 {
+	uint8_t  status;
+	uint16_t max_tx_len;
+	uint16_t max_tx_time;
+	uint16_t max_rx_len;
+	uint16_t max_rx_time;
+	uint8_t  max_tx_win;
+	uint8_t  max_rx_win;
+	uint16_t max_rx_packet;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_MAX_DATA_LEN_V2	0x20aa
+#define BT_HCI_BIT_LE_SET_MAX_DATA_LEN_V2	BT_HCI_CMD_BIT(52, 3)
+struct bt_hci_cmd_le_set_data_len_v2 {
+	uint16_t handle;
+	uint16_t tx_len;
+	uint16_t tx_time;
+	uint8_t  phys;
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_set_data_len_v2 {
+	uint8_t  status;
+	uint16_t handle;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_CIG_PARAMS_V2		0x20b3
+#define BT_HCI_BIT_LE_SET_CIG_PARAMS_V2		BT_HCI_CMD_BIT(51, 0)
+struct bt_hci_cis_params_v2 {
+	uint8_t  cis_id;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint8_t  c_rtn;
+	uint8_t  p_rtn;
+	uint8_t  c_coded_rates;
+	uint8_t  p_coded_rates;
+	uint16_t c_hdt_rates;
+	uint16_t p_hdt_rates;
+	uint8_t  mic_len;
+	uint8_t  format;
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_set_cig_params_v2 {
+	uint8_t  cig_id;
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
+	uint8_t  sca;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint16_t c_latency;
+	uint16_t p_latency;
+	uint8_t  num_cis;
+	struct bt_hci_cis_params_v2 cis[0];
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_set_cig_params_v2 {
+	uint8_t  status;
+	uint8_t  cig_id;
+	uint8_t  num_handles;
+	uint16_t handle[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST_V2	0x20b4
+#define BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST_V2	BT_HCI_CMD_BIT(51, 1)
+struct bt_hci_cis_params_test_v2 {
+	uint8_t  cis_id;
+	uint8_t  nse;
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint16_t c_pdu;
+	uint16_t p_pdu;
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint8_t  c_bn;
+	uint8_t  p_bn;
+	uint8_t  c_coded_rates;
+	uint8_t  p_coded_rates;
+	uint16_t c_hdt_rates;
+	uint16_t p_hdt_rates;
+	uint8_t  mic_len;
+	uint8_t  format;
+	uint8_t  c_win;
+	uint8_t  p_win;
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_set_cig_params_test_v2 {
+	uint8_t  cig_id;
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
+	uint8_t  c_ft;
+	uint8_t  p_ft;
+	uint16_t iso_interval;
+	uint8_t  sca;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  num_cis;
+	struct bt_hci_cis_params_test_v2 cis[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_CREATE_BIG_V2		0x20b6
+#define BT_HCI_BIT_LE_CREATE_BIG_V2		BT_HCI_CMD_BIT(51, 3)
+struct bt_hci_bis_v2 {
+	uint8_t  sdu_interval[3];
+	uint16_t sdu;
+	uint16_t latency;
+	uint8_t  rtn;
+	uint8_t  phy;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+	uint8_t  coded_rates;
+	uint16_t hdt_rates;
+	uint8_t  mic_len;
+	uint8_t  format;
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_create_big_v2 {
+	uint8_t  handle;
+	uint8_t  adv_handle;
+	uint8_t  num_bis;
+	struct bt_hci_bis_v2 bis;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_CREATE_BIG_TEST_V2	0x20b7
+#define BT_HCI_BIT_LE_CREATE_BIG_TEST_V2	BT_HCI_CMD_BIT(51, 4)
+struct bt_hci_bis_test_v2 {
+	uint8_t  sdu_interval[3];
+	uint16_t iso_interval;
+	uint8_t  nse;
+	uint16_t sdu;
+	uint16_t pdu;
+	uint8_t  phy;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  bn;
+	uint8_t  irc;
+	uint8_t  pto;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+	uint8_t  coded_rates;
+	uint16_t hdt_rates;
+	uint8_t  mic_len;
+	uint8_t  format;
+	uint8_t  blocks;
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_create_big_test_v2 {
+	uint8_t  big_handle;
+	uint8_t  adv_handle;
+	uint8_t  num_bis;
+	struct bt_hci_bis_test bis[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_HDT_DEFAULT_PARAMS	0x20bc
+#define BT_HCI_BIT_LE_SET_HDT_DEFAULT_PARAMS	BT_HCI_CMD_BIT(52, 1)
+struct bt_hci_cmd_le_hdt_set_default_params {
+	uint8_t  mic_len;
+	uint8_t  format;
+	uint16_t rates;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_HDT_PARAMS_TEST	0x20bd
+#define BT_HCI_BIT_LE_SET_HDT_PARAMS_TEST	BT_HCI_CMD_BIT(52, 2)
+struct bt_hci_cmd_le_hdt_set_params_test {
+	uint16_t handle;
+	uint8_t  mic_len;
+	uint8_t  format;
+	uint8_t  blocks;
+	uint16_t tx_rates;
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_hdt_set_params_test {
+	uint8_t  status;
+	uint16_t handle;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_EKS_DEBUG_MODE	0x20b8
+#define BT_HCI_BIT_LE_READ_EKS_DEBUG_MODE	BT_HCI_CMD_BIT(51, 5)
+struct bt_hci_rsp_le_read_eks_debug_mode {
+	uint8_t  status;
+	uint8_t  mode;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_WRITE_EKS_DEBUG_MODE	0x20b9
+#define BT_HCI_BIT_LE_WRITE_EKS_DEBUG_MODE	BT_HCI_CMD_BIT(51, 6)
+struct bt_hci_cmd_le_write_eks_debug_mode {
+	uint8_t  mode;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
@@ -4224,6 +4550,93 @@ struct bt_hci_evt_le_conn_rate_change {
 	uint16_t supv_timeout;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_ENCRYPT_CHANGE_V3		0x5a
+#define BT_HCI_BIT_ENCRYPT_CHANGE_V3		26
+struct bt_hci_evt_encrypt_change_v3 {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  mode;
+	uint8_t  key_size;
+	uint8_t  mic_len;
+	uint8_t  eks_mode;
+	uint8_t  eks_debug;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2 0x5b
+#define BT_HCI_BIT_ENCRYPT_KEY_REFRESH_COMPLETE_V2 27
+struct bt_hci_evt_encrypt_key_refresh_complete_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  mic_len;
+	uint8_t  eks_mode;
+	uint8_t  eks_debug;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_DATA_LENGTH_CHANGE_V2	0x39
+#define BT_HCI_BIT_LE_DATA_LENGTH_CHANGE_V2	56
+struct bt_hci_evt_le_data_length_change_v2 {
+	uint16_t handle;
+	uint16_t max_tx_len;
+	uint16_t max_tx_time;
+	uint16_t max_rx_len;
+	uint16_t max_rx_time;
+	uint8_t  phys;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_CIS_ESTABLISHED_V3	0x3a
+#define BT_HCI_BIT_LE_CIS_ESTABLISHED_V3	57
+struct bt_hci_evt_le_cis_established_v3 {
+	uint8_t  status;
+	uint16_t conn_handle;
+	uint8_t  cig_sync_delay[3];
+	uint8_t  cis_sync_delay[3];
+	uint8_t  c_latency[3];
+	uint8_t  p_latency[3];
+	uint8_t  c_phy;
+	uint8_t  p_phy;
+	uint8_t  nse;
+	uint8_t  c_bn;
+	uint8_t  p_bn;
+	uint8_t  c_ft;
+	uint8_t  p_ft;
+	uint16_t c_mtu;
+	uint16_t p_mtu;
+	uint16_t interval;
+	uint8_t  sub_interval[3];
+	uint16_t c_sdu;
+	uint16_t p_sdu;
+	uint8_t  c_sdu_interval[3];
+	uint8_t  p_sdu_interval[3];
+	uint8_t  framing;
+	uint16_t c_rates;
+	uint16_t p_rates;
+	uint8_t  config_id;
+	uint8_t  group_id;
+	uint8_t  encryption;
+	uint8_t  mic_len;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_BIG_COMPLETE_V2		0x3b
+#define BT_HCI_BIT_LE_BIG_COMPLETE_V2		58
+struct bt_hci_evt_le_big_complete_v2 {
+	uint8_t  status;
+	uint8_t  handle;
+	uint8_t  sync_delay[3];
+	uint8_t  latency[3];
+	uint8_t  phy;
+	uint8_t  nse;
+	uint8_t  bn;
+	uint8_t  pto;
+	uint8_t  irc;
+	uint16_t max_pdu;
+	uint16_t interval;
+	uint16_t rates;
+	uint8_t  encryption;
+	uint8_t  mic_len;
+	uint8_t  num_bis;
+	uint16_t bis_handle[0];
+} __attribute__ ((packed));
+
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
@@ -4243,6 +4656,7 @@ struct bt_hci_evt_le_conn_rate_change {
 #define BT_HCI_ERR_UNKNOWN_ADVERTISING_ID	0x42
 #define BT_HCI_ERR_CANCELLED			0x44
 #define BT_HCI_ERR_ENC_MODE_NOT_ACCEPTABLE	0x25
+#define BT_HCI_ERR_MIC_LEN_TOO_SHORT		0xfe
 
 struct bt_l2cap_hdr {
 	uint16_t len;
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index d94d996010ff..9dd4f4b5e042 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -633,6 +633,9 @@ static void print_le_conn_result(uint16_t result)
 	case 0x000b:
 		str = "Connection refused - unacceptable parameters";
 		break;
+	case 0x000d:
+		str = "Connection refused - MIC length too short";
+		break;
 	default:
 		str = "Reserved";
 		break;
@@ -1440,6 +1443,9 @@ static void print_ecred_conn_result(uint16_t result)
 	case 0x000b:
 		str = "All Connections refused - unacceptable parameters";
 		break;
+	case 0x000d:
+		str = "All Connections refused - MIC length too short";
+		break;
 	default:
 		str = "Reserved";
 		break;
diff --git a/monitor/packet.c b/monitor/packet.c
index c8a53a119294..0909cac77fa6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1004,6 +1004,7 @@ static const struct {
 	{ 0x43, "Limit Reached"						},
 	{ 0x44, "Operation Cancelled by Host"				},
 	{ 0x45, "Packet Too Long"					},
+	{ 0xfe, "MIC Length Too Short"					},
 	{ }
 };
 
@@ -3209,6 +3210,7 @@ static const struct bitfield_data features_le_0[] = {
 	{ 46, "Channel Sounding"				},
 	{ 47, "Channel Sounding (Host Support)"			},
 	{ 48, "Channel Sounding Tone Quality Indication"	},
+	{ 59, "Higher Data Throughput (Intel)"			},
 	{ 63, "LL Extended Feature Set"				},
 	{ }
 };
@@ -3224,6 +3226,15 @@ static const struct bitfield_data features_le_1[] = {
 	{  9, "Shorter Connection Intervals (Host Support)"	},
 	{ 10, "LE Flushable ACL Data"				},
 	{ 11, "Channel Sounding Enhancement #1"			},
+	{ 12, "Encryption Key Schedule"				},
+	{ 13, "High Data Throughput"				},
+	{ 14, "Receive HDT6 Rate"				},
+	{ 15, "Transmit HDT6 Rate"				},
+	{ 16, "Receive HDT7.5 Rate"				},
+	{ 17, "Transmit HDT7.5 Rate"				},
+	{ 18, "HDT Packet Format 1"				},
+	{ 19, "Link Quality Feedback"				},
+	{ 26, "Opportunistic Encryption (Host Support)"		},
 	{ }
 };
 
@@ -3299,6 +3310,7 @@ static void print_features(uint8_t page, const uint8_t *features_array,
 			break;
 		case 1:
 			features_table = features_le_1;
+			break;
 		}
 		break;
 	case 0xf0:
@@ -3612,9 +3624,11 @@ static const struct bitfield_data events_page2_table[] = {
 	{ 23, "Authenticated Payload Timeout Expired"			},
 	{ 24, "SAM Status Change"					},
 	{ 25, "Encryption Change [v2]"					},
+	{ 26, "Encryption Change [v3]"					},
+	{ 27, "Encryption Key Refresh Complete [v2]"			},
+	{ 28, "Encryption Key Debug Report"				},
 	{ }
 };
-
 static const struct bitfield_data events_le_table[] = {
 	{  0, "LE Connection Complete"					},
 	{  1, "LE Advertising Report"					},
@@ -3672,6 +3686,9 @@ static const struct bitfield_data events_le_table[] = {
 	{ 53, "LE UTP Received"						},
 	{ 54, "LE Connection Rate Change"				},
 	{ 55, "LE CS Read Remote Supported Capabilities Complete [v2]"	},
+	{ 56, "LE Data Length Change [v2]"				},
+	{ 57, "LE CIS Established [v3]"				},
+	{ 58, "LE Create BIG Complete [v2]"				},
 	{ }
 };
 
@@ -8165,6 +8182,9 @@ static void print_le_phy(const char *prefix, uint8_t phy)
 	case 0x03:
 		str = "LE Coded";
 		break;
+	case 0x05:
+		str = "LE HDT";
+		break;
 	default:
 		str = "Reserved";
 		break;
@@ -8187,6 +8207,7 @@ static const struct bitfield_data le_phys[] = {
 	{  0, "LE 1M"	},
 	{  1, "LE 2M"	},
 	{  2, "LE Coded"},
+	{  4, "LE HDT"	},
 	{ }
 };
 
@@ -8232,26 +8253,36 @@ static void le_set_default_phy_cmd(uint16_t index, const void *data,
 	print_le_phys_preference(cmd->all_phys, cmd->tx_phys, cmd->rx_phys);
 }
 
+static const struct bitfield_data hdt_phy_opts[] = {
+	{ 0, "Coded S=2" },
+	{ 0, "Coded S=8" },
+	{ 2, "HDT 2M" },
+	{ 3, "HDT 3M" },
+	{ 4, "HDT 4M" },
+	{ 5, "HDT 6M" },
+	{ 6, "HDT 7.5M" },
+	{ }
+};
+
+static void print_le_phy_options(const char *label, uint16_t opts)
+{
+	uint16_t mask;
+
+	print_field("%s: 0x%4.4x", label, opts);
+
+	mask = print_bitfield(4, opts, hdt_phy_opts);
+	if (mask)
+		print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%4.4x)", mask);
+}
+
 static void le_set_phy_cmd(uint16_t index, const void *data, uint8_t size)
 {
 	const struct bt_hci_cmd_le_set_phy *cmd = data;
-	const char *str;
 
 	print_handle(cmd->handle);
 	print_le_phys_preference(cmd->all_phys, cmd->tx_phys, cmd->rx_phys);
-	switch (le16_to_cpu(cmd->phy_opts)) {
-	case 0x0001:
-		str = "S2 coding";
-		break;
-	case 0x0002:
-		str = "S8 coding";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("PHY options preference: %s (0x%4.4x)", str, cmd->phy_opts);
+	print_le_phy_options("PHY Options", le16_to_cpu(cmd->phy_opts));
 }
 
 static void le_enhanced_receiver_test_cmd(uint16_t index, const void *data,
@@ -9208,7 +9239,7 @@ static void print_framing(uint8_t value)
 		print_field("Framing: Framed (0x%2.2x)", value);
 		return;
 	default:
-		print_field("Packing: Reserved (0x%2.2x)", value);
+		print_field("Framing: Reserved (0x%2.2x)", value);
 	}
 }
 
@@ -10302,229 +10333,750 @@ static void le_read_conn_interval_rsp(uint16_t index, const void *data,
 	}
 }
 
-struct opcode_data {
-	uint16_t opcode;
-	int bit;
+static void print_le_def_phys(uint8_t phys)
+{
 	const char *str;
-	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);
-	uint8_t cmd_size;
-	bool cmd_fixed;
-	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);
-	uint8_t rsp_size;
-	bool rsp_fixed;
-};
 
-static const struct opcode_data opcode_table[] = {
-	{ 0x0000,  -1, "NOP" },
+	switch (phys) {
+	case 0x00:
+		str = "All GFSK";
+		break;
+	case 0x01:
+		str = "HDT";
+		break;
+	default:
+		str = "RFU";
+		break;
+	}
 
-	/* OGF 1 - Link Control */
-	{ 0x0401,   0, "Inquiry",
-				inquiry_cmd, 5, true },
-	{ 0x0402,   1, "Inquiry Cancel",
-				null_cmd, 0, true,
-				status_rsp, 1, true },
-	{ 0x0403,   2, "Periodic Inquiry Mode",
-				periodic_inquiry_cmd, 9, true,
-				status_rsp, 1, true },
-	{ 0x0404,   3, "Exit Periodic Inquiry Mode",
-				null_cmd, 0, true,
-				status_rsp, 1, true },
-	{ 0x0405,   4, "Create Connection",
-				create_conn_cmd, 13, true },
-	{ 0x0406,   5, "Disconnect",
-				disconnect_cmd, 3, true },
-	{ 0x0407,   6, "Add SCO Connection",
-				add_sco_conn_cmd, 4, true },
-	{ 0x0408,   7, "Create Connection Cancel",
-				create_conn_cancel_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x0409,   8, "Accept Connection Request",
-				accept_conn_request_cmd, 7, true },
-	{ 0x040a,   9, "Reject Connection Request",
-				reject_conn_request_cmd, 7, true },
-	{ 0x040b,  10, "Link Key Request Reply",
-				link_key_request_reply_cmd, 22, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x040c,  11, "Link Key Request Negative Reply",
-				link_key_request_neg_reply_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x040d,  12, "PIN Code Request Reply",
-				pin_code_request_reply_cmd, 23, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x040e,  13, "PIN Code Request Negative Reply",
-				pin_code_request_neg_reply_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x040f,  14, "Change Connection Packet Type",
-				change_conn_pkt_type_cmd, 4, true },
-	{ 0x0411,  15, "Authentication Requested",
-				auth_requested_cmd, 2, true },
-	{ 0x0413,  16, "Set Connection Encryption",
-				set_conn_encrypt_cmd, 3, true },
-	{ 0x0415,  17, "Change Connection Link Key",
-				change_conn_link_key_cmd, 2, true },
-	{ 0x0417,  18, "Temporary Link Key",
-				link_key_selection_cmd, 1, true },
-	{ 0x0419,  19, "Remote Name Request",
-				remote_name_request_cmd, 10, true },
-	{ 0x041a,  20, "Remote Name Request Cancel",
-				remote_name_request_cancel_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x041b,  21, "Read Remote Supported Features",
-				read_remote_features_cmd, 2, true },
-	{ 0x041c,  22, "Read Remote Extended Features",
-				read_remote_ext_features_cmd, 3, true },
-	{ 0x041d,  23, "Read Remote Version Information",
-				read_remote_version_cmd, 2, true },
-	{ 0x041f,  24, "Read Clock Offset",
-				read_clock_offset_cmd, 2, true },
-	{ 0x0420,  25, "Read LMP Handle",
-				read_lmp_handle_cmd, 2, true,
-				read_lmp_handle_rsp, 8, true },
-	{ 0x0428, 131, "Setup Synchronous Connection",
-				setup_sync_conn_cmd, 17, true },
-	{ 0x0429, 132, "Accept Synchronous Connection Request",
-				accept_sync_conn_request_cmd, 21, true },
-	{ 0x042a, 133, "Reject Synchronous Connection Request",
-				reject_sync_conn_request_cmd, 7, true },
-	{ 0x042b, 151, "IO Capability Request Reply",
-				io_capability_request_reply_cmd, 9, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x042c, 152, "User Confirmation Request Reply",
-				user_confirm_request_reply_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x042d, 153, "User Confirmation Request Neg Reply",
-				user_confirm_request_neg_reply_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x042e, 154, "User Passkey Request Reply",
-				user_passkey_request_reply_cmd, 10, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x042f, 155, "User Passkey Request Negative Reply",
-				user_passkey_request_neg_reply_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x0430, 156, "Remote OOB Data Request Reply",
-				remote_oob_data_request_reply_cmd, 38, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x0433, 159, "Remote OOB Data Request Neg Reply",
-				remote_oob_data_request_neg_reply_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x0434, 163, "IO Capability Request Negative Reply",
-				io_capability_request_neg_reply_cmd, 7, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x0435, 168, "Create Physical Link",
-				create_phy_link_cmd, 3, false },
-	{ 0x0436, 169, "Accept Physical Link",
-				accept_phy_link_cmd, 3, false },
-	{ 0x0437, 170, "Disconnect Physical Link",
-				disconn_phy_link_cmd, 2, true },
-	{ 0x0438, 171, "Create Logical Link",
-				create_logic_link_cmd, 33, true },
-	{ 0x0439, 172, "Accept Logical Link",
-				accept_logic_link_cmd, 33, true },
-	{ 0x043a, 173, "Disconnect Logical Link",
-				disconn_logic_link_cmd, 2, true },
-	{ 0x043b, 174, "Logical Link Cancel",
-				logic_link_cancel_cmd, 2, true,
-				logic_link_cancel_rsp, 3, true },
-	{ 0x043c, 175, "Flow Specification Modify",
-				flow_spec_modify_cmd, 34, true },
-	{ 0x043d, 235, "Enhanced Setup Synchronous Connection",
-				enhanced_setup_sync_conn_cmd, 59, true },
-	{ 0x043e, 236, "Enhanced Accept Synchronous Connection Request",
-				enhanced_accept_sync_conn_request_cmd, 63, true },
-	{ 0x043f, 246, "Truncated Page",
-				truncated_page_cmd, 9, true },
-	{ 0x0440, 247, "Truncated Page Cancel",
-				truncated_page_cancel_cmd, 6, true,
-				status_bdaddr_rsp, 7, true },
-	{ 0x0441, 248, "Set Connectionless Peripheral Broadcast",
-				set_peripheral_broadcast_cmd, 11, true,
-				set_peripheral_broadcast_rsp, 4, true },
-	{ 0x0442, 249, "Set Connectionless Peripheral Broadcast Receive",
-				set_peripheral_broadcast_receive_cmd, 34, true,
-				set_peripheral_broadcast_receive_rsp, 8, true },
-	{ 0x0443, 250, "Start Synchronization Train",
-				null_cmd, 0, true },
-	{ 0x0444, 251, "Receive Synchronization Train",
-				receive_sync_train_cmd, 12, true },
-	{ 0x0445, 257, "Remote OOB Extended Data Request Reply",
-				remote_oob_ext_data_request_reply_cmd, 70, true,
-				status_bdaddr_rsp, 7, true },
+	print_field("PHYs: %s (0x%2.2x)", str, phys);
+}
 
-	/* OGF 2 - Link Policy */
-	{ 0x0801,  33, "Hold Mode",
-				hold_mode_cmd, 6, true },
-	{ 0x0803,  34, "Sniff Mode",
-				sniff_mode_cmd, 10, true },
-	{ 0x0804,  35, "Exit Sniff Mode",
-				exit_sniff_mode_cmd, 2, true },
-	{ 0x0805,  36, "Park State",
-				park_state_cmd, 6, true },
-	{ 0x0806,  37, "Exit Park State",
-				exit_park_state_cmd, 2, true },
-	{ 0x0807,  38, "QoS Setup",
-				qos_setup_cmd, 20, true },
-	{ 0x0809,  39, "Role Discovery",
-				role_discovery_cmd, 2, true,
-				role_discovery_rsp, 4, true },
-	{ 0x080b,  40, "Switch Role",
-				switch_role_cmd, 7, true },
-	{ 0x080c,  41, "Read Link Policy Settings",
-				read_link_policy_cmd, 2, true,
-				read_link_policy_rsp, 5, true },
-	{ 0x080d,  42, "Write Link Policy Settings",
-				write_link_policy_cmd, 4, true,
-				write_link_policy_rsp, 3, true },
-	{ 0x080e,  43, "Read Default Link Policy Settings",
-				null_cmd, 0, true,
-				read_default_link_policy_rsp, 3, true },
-	{ 0x080f,  44, "Write Default Link Policy Settings",
-				write_default_link_policy_cmd, 2, true,
-				status_rsp, 1, true },
-	{ 0x0810,  45, "Flow Specification",
-				flow_spec_cmd, 21, true },
-	{ 0x0811, 140, "Sniff Subrating",
-				sniff_subrating_cmd, 8, true,
-				sniff_subrating_rsp, 3, true },
+static void le_write_def_data_len_v2(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_write_def_data_len_v2 *cmd = data;
 
-	/* OGF 3 - Host Control */
-	{ 0x0c01,  46, "Set Event Mask",
-				set_event_mask_cmd, 8, true,
-				status_rsp, 1, true },
-	{ 0x0c03,  47, "Reset",
-				null_cmd, 0, true,
-				status_rsp, 1, true },
-	{ 0x0c05,  48, "Set Event Filter",
-				set_event_filter_cmd, 1, false,
-				status_rsp, 1, true },
-	{ 0x0c08,  49, "Flush",
-				flush_cmd, 2, true,
-				flush_rsp, 3, true },
-	{ 0x0c09,  50, "Read PIN Type",
-				null_cmd, 0, true,
-				read_pin_type_rsp, 2, true },
-	{ 0x0c0a,  51, "Write PIN Type",
-				write_pin_type_cmd, 1, true,
-				status_rsp, 1, true },
-	{ 0x0c0b,  52, "Create New Unit Key",
-				null_cmd, 0, true,
-				status_rsp, 1, true },
-	{ 0x0c0d,  53, "Read Stored Link Key",
-				read_stored_link_key_cmd, 7, true,
-				read_stored_link_key_rsp, 5, true },
-	{ 0x0c11,  54, "Write Stored Link Key",
-				write_stored_link_key_cmd, 1, false,
-				write_stored_link_key_rsp, 2, true },
-	{ 0x0c12,  55, "Delete Stored Link Key",
-				delete_stored_link_key_cmd, 7, true,
-				delete_stored_link_key_rsp, 3, true },
-	{ 0x0c13,  56, "Write Local Name",
-				write_local_name_cmd, 248, true,
-				status_rsp, 1, true },
-	{ 0x0c14,  57, "Read Local Name",
-				null_cmd, 0, true,
-				read_local_name_rsp, 249, true },
-	{ 0x0c15,  58, "Read Connection Accept Timeout",
-				null_cmd, 0, true,
+	print_field("TX octets: %d", le16_to_cpu(cmd->tx_len));
+	print_field("TX time: %d", le16_to_cpu(cmd->tx_time));
+	print_le_def_phys(cmd->phys);
+}
+
+static void le_read_def_data_len_v2(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_cmd_le_read_def_data_len_v2 *cmd = data;
+
+	print_le_def_phys(cmd->phys);
+}
+
+static void le_read_def_data_len_v2_rsp(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_def_data_len_v2 *rsp = data;
+
+	print_status(rsp->status);
+	print_field("TX octets: %d", le16_to_cpu(rsp->tx_len));
+	print_field("TX time: %d", le16_to_cpu(rsp->tx_time));
+}
+
+static void print_prefer_mic_len(uint8_t mic_len)
+{
+	const char *str;
+
+	switch (mic_len) {
+	case 0x01:
+		str = "Prefer 64 bits";
+		break;
+	case 0x02:
+		str = "128 bits";
+		break;
+	default:
+		str = "RFU";
+		break;
+	}
+
+	print_field("MIC Length: %s (0x%2.2x)", str, mic_len);
+}
+
+static void print_enable_encrypt(uint8_t encrypt)
+{
+	const char *str;
+
+	switch (encrypt) {
+	case 0x00:
+		str = "LTK";
+		break;
+	case 0x01:
+		str = "Opportunistic with Key Schedule";
+		break;
+	default:
+		str = "RFU";
+		break;
+	}
+
+	print_field("Encryption: %s (0x%2.2x)", str, encrypt);
+}
+
+static void le_enable_encrypt_v2(uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_enable_encrypt_v2 *cmd = data;
+
+	print_handle(cmd->handle);
+	print_random_number(cmd->rand);
+	print_encrypted_diversifier(cmd->ediv);
+	print_key("Long term key", cmd->ltk);
+	print_prefer_mic_len(cmd->mic_len);
+	print_enable_encrypt(cmd->encryption);
+}
+
+static void print_set_le_phy(const char *prefix, uint8_t phy)
+{
+	if (phy)
+		return print_le_phy(prefix, phy);
+
+	print_field("%s: No PHY (0x%2.2x)", prefix, phy);
+}
+
+static void le_read_max_data_len_v2(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_cmd_le_read_data_len_v2 *cmd = data;
+
+	print_set_le_phy("PHY", cmd->phy);
+}
+
+static void le_read_max_data_len_v2_rsp(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_data_len_v2 *rsp = data;
+
+	print_status(rsp->status);
+	print_field("Max TX octets: %d", le16_to_cpu(rsp->max_tx_len));
+	print_field("Max TX time: %d", le16_to_cpu(rsp->max_tx_time));
+	print_field("Max RX octets: %d", le16_to_cpu(rsp->max_rx_len));
+	print_field("Max RX time: %d", le16_to_cpu(rsp->max_rx_time));
+	print_field("Max TX Payload Window size: %d", rsp->max_tx_win);
+	print_field("Max RX Payload Window size: %d", rsp->max_rx_win);
+	print_field("Max RX Payload Packet size: %d",
+			le16_to_cpu(rsp->max_rx_packet));
+}
+
+static void print_phys(uint8_t phys)
+{
+	const char *str;
+
+	switch (phys) {
+	case 0x00:
+		str = "GFSK";
+		break;
+	case 0x01:
+		str = "HDT";
+		break;
+	default:
+		str = "RFU";
+		break;
+	}
+
+	print_field("PHYs: %s (0x%2.2x)", str, phys);
+}
+
+static void le_set_max_data_len_v2(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_data_len_v2 *cmd = data;
+
+	print_handle(cmd->handle);
+	print_field("TX octets: %d", le16_to_cpu(cmd->tx_len));
+	print_field("TX time: %d", le16_to_cpu(cmd->tx_time));
+	print_phys(cmd->phys);
+}
+
+static void le_set_max_data_len_v2_rsp(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_data_len_v2 *rsp = data;
+
+	print_status(rsp->status);
+	print_handle(rsp->handle);
+}
+
+static const struct bitfield_data coded_rates[] = {
+	{ 0, "CODED S=8" },
+	{ 1, "CODED S=0" },
+	{ }
+};
+
+static const struct bitfield_data hdt_rates[] = {
+	{ 0, "HDT 2M" },
+	{ 1, "HDT 3M" },
+	{ 2, "HDT 4M" },
+	{ 3, "HDT 6M" },
+	{ 4, "HDT 7.5M" },
+	{ }
+};
+
+static void print_rates(const char *prefix, uint8_t phy, uint16_t rates)
+{
+	const struct bitfield_data *fields = NULL;
+
+	switch (phy) {
+	case 0x01:
+	case 0x02:
+		break;
+	case 0x03:
+		fields = coded_rates;
+		break;
+	case 0x05:
+		fields = hdt_rates;
+		break;
+	default:
+		break;
+	}
+
+	print_field("%s: 0x%4.4x", prefix, rates);
+
+	if (fields) {
+		uint16_t mask = print_bitfield(2, rates, fields);
+		if (mask)
+			print_text(COLOR_UNKNOWN_OPTIONS_BIT, "  Reserved"
+							" (0x%4.4x)", mask);
+	}
+}
+
+static void print_packet_format(uint8_t format)
+{
+	const char *str;
+
+	switch (format) {
+	case 0x00:
+		str = "No preffered format";
+		break;
+	case 0x01:
+		str = "Packet Format 0";
+		break;
+	case 0x02:
+		str = "Packet Format 1";
+		break;
+	default:
+		str = "RFU";
+		break;
+	}
+
+	print_field("Packet Format: %s (0x%2.2x)", str, format);
+}
+
+static void print_cis_params_v2(const void *data, int i)
+{
+	const struct bt_hci_cis_params_v2 *cis = data;
+
+	print_field("CIS ID: 0x%2.2x", cis->cis_id);
+	print_field("Central to Peripheral Maximum SDU Size: %u",
+						le16_to_cpu(cis->c_sdu));
+	print_field("Peripheral to Central Maximum SDU Size: %u",
+						le16_to_cpu(cis->p_sdu));
+	print_le_phys("Central to Peripheral PHY", cis->c_phy);
+	print_le_phys("Peripheral to Central PHY", cis->p_phy);
+	print_field("Central to Peripheral Retransmission attempts: 0x%2.2x",
+							cis->c_rtn);
+	print_field("Peripheral to Central Retransmission attempts: 0x%2.2x",
+							cis->p_rtn);
+	print_rates("Central to Peripheral Coded Rates", 0x03,
+			cis->c_coded_rates);
+	print_rates("Peripheral to Central Coded Rates", 0x03,
+			cis->p_coded_rates);
+	print_rates("Central to Peripheral HDT Rates", 0x05,
+			le16_to_cpu(cis->c_hdt_rates));
+	print_rates("Peripheral to Central HDT Rates", 0x05,
+			le16_to_cpu(cis->p_hdt_rates));
+	print_prefer_mic_len(cis->mic_len);
+	print_packet_format(cis->format);
+}
+
+static void le_set_cig_params_v2(uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_cig_params_v2 *cmd = data;
+
+	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
+	print_usec_interval("Central to Peripheral SDU Interval",
+							cmd->c_interval);
+	print_usec_interval("Peripheral to Central SDU Interval",
+							cmd->p_interval);
+	print_sca(cmd->sca);
+	print_packing(cmd->packing);
+	print_framing(cmd->framing);
+	print_field("Central to Peripheral Maximum Latency: %d ms (0x%4.4x)",
+		le16_to_cpu(cmd->c_latency), le16_to_cpu(cmd->c_latency));
+	print_field("Peripheral to Central Maximum Latency: %d ms (0x%4.4x)",
+		le16_to_cpu(cmd->p_latency), le16_to_cpu(cmd->p_latency));
+	print_field("Number of CIS: %u", cmd->num_cis);
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->cis, size, cmd->num_cis, sizeof(*cmd->cis),
+						print_cis_params_v2);
+}
+
+static void le_set_cig_params_v2_rsp(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_cig_params *rsp = data;
+
+	print_status(rsp->status);
+
+	if (size == 1)
+		return;
+
+	print_field("CIG ID: 0x%2.2x", rsp->cig_id);
+	print_field("Number of Handles: %u", rsp->num_handles);
+
+	size -= sizeof(*rsp);
+
+	print_list(rsp->handle, size, rsp->num_handles, sizeof(*rsp->handle),
+						print_cig_handle);
+}
+
+static void print_cis_params_test_v2(const void *data, int i)
+{
+	const struct bt_hci_cis_params_test_v2 *cis = data;
+
+	print_field("CIS ID: 0x%2.2x", cis->cis_id);
+	print_field("NSE: 0x%2.2x", cis->nse);
+	print_field("Central to Peripheral Maximum SDU: 0x%4.4x",
+						le16_to_cpu(cis->c_sdu));
+	print_field("Peripheral to Central Maximum SDU: 0x%4.4x",
+						le16_to_cpu(cis->p_sdu));
+	print_field("Central to Peripheral Maximum PDU: 0x%4.4x",
+						le16_to_cpu(cis->c_pdu));
+	print_field("Peripheral to Central Maximum PDU: 0x%4.4x",
+						le16_to_cpu(cis->p_pdu));
+	print_le_phys("Central to Peripheral PHY", cis->c_phy);
+	print_le_phys("Peripheral to Central PHY", cis->p_phy);
+	print_field("Central to Peripheral Burst Number: 0x%2.2x", cis->c_bn);
+	print_field("Peripheral to Central Burst Number: 0x%2.2x", cis->p_bn);
+	print_rates("Central to Peripheral Coded Rates", 0x03,
+			cis->c_coded_rates);
+	print_rates("Peripheral to Central Coded Rates", 0x03,
+			cis->p_coded_rates);
+	print_rates("Central to Peripheral HDT Rates", 0x05,
+			le16_to_cpu(cis->c_hdt_rates));
+	print_rates("Peripheral to Central HDT Rates", 0x05,
+			le16_to_cpu(cis->p_hdt_rates));
+	print_prefer_mic_len(cis->mic_len);
+	print_packet_format(cis->format);
+	print_field("Central to Peripheral Payload Window size: %d",
+			cis->c_win);
+	print_field("Peripheral to Central Payload Window size: %d",
+			cis->p_win);
+}
+
+static void le_set_cig_params_test_v2(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_cig_params_test_v2 *cmd = data;
+
+	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
+	print_usec_interval("Central to Peripheral SDU Interval",
+							cmd->c_interval);
+	print_usec_interval("Peripheral to Central SDU Interval",
+							cmd->p_interval);
+	print_field("Central to Peripheral Flush Timeout: 0x%2.2x", cmd->c_ft);
+	print_field("Peripheral to Central Flush Timeout: 0x%2.2x", cmd->p_ft);
+	print_field("ISO Interval: %.2f ms (0x%4.4x)",
+				le16_to_cpu(cmd->iso_interval) * 1.25,
+				le16_to_cpu(cmd->iso_interval));
+	print_sca(cmd->sca);
+	print_packing(cmd->packing);
+	print_framing(cmd->framing);
+	print_field("Number of CIS: %u", cmd->num_cis);
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->cis, size, cmd->num_cis, sizeof(*cmd->cis),
+						print_cis_params_test_v2);
+}
+
+static void le_set_cig_params_test_v2_rsp(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_cig_params_v2 *rsp = data;
+
+	print_status(rsp->status);
+
+	if (size == 1)
+		return;
+
+	print_field("CIG ID: 0x%2.2x", rsp->cig_id);
+	print_field("Number of Handles: %u", rsp->num_handles);
+
+	size -= sizeof(*rsp);
+
+	print_list(rsp->handle, size, rsp->num_handles, sizeof(*rsp->handle),
+						print_cig_handle);
+}
+
+static void print_bis_v2(const struct bt_hci_bis_v2 *bis)
+{
+	print_usec_interval("SDU Interval", bis->sdu_interval);
+	print_field("Maximum SDU size: %u", le16_to_cpu(bis->sdu));
+	print_field("Maximum Latency: %u ms (0x%4.4x)",
+			le16_to_cpu(bis->latency), le16_to_cpu(bis->latency));
+	print_field("RTN: 0x%2.2x", bis->rtn);
+	print_le_phys("PHY", bis->phy);
+	print_packing(bis->packing);
+	print_framing(bis->framing);
+	print_field("Encryption: 0x%2.2x", bis->encryption);
+	print_hex_field("Broadcast Code", bis->bcode, 16);
+	print_rates("Coded Rates", 0x03, bis->coded_rates);
+	print_rates("HDT Rates", 0x05, le16_to_cpu(bis->hdt_rates));
+	print_prefer_mic_len(bis->mic_len);
+	print_packet_format(bis->format);
+}
+
+static void le_create_big_v2(uint16_t index, const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_create_big_v2 *cmd = data;
+
+	print_field("Handle: 0x%2.2x", cmd->handle);
+	print_field("Advertising Handle: 0x%2.2x", cmd->adv_handle);
+	print_field("Number of BIS: %u", cmd->num_bis);
+	print_bis_v2(&cmd->bis);
+}
+
+static void print_bis_test_v2(const void *data, int i)
+{
+	const struct bt_hci_bis_test_v2 *bis = data;
+
+	print_usec_interval("SDU Interval", bis->sdu_interval);
+	print_field("ISO Interval: %.2f ms (0x%4.4x)",
+				le16_to_cpu(bis->iso_interval) * 1.25,
+				le16_to_cpu(bis->iso_interval));
+	print_field("Number of Subevents: %u", bis->nse);
+	print_field("Maximum SDU: %u", bis->sdu);
+	print_field("Maximum PDU: %u", bis->pdu);
+	print_packing(bis->packing);
+	print_framing(bis->framing);
+	print_le_phy("PHY", bis->phy);
+	print_field("Burst Number: %u", bis->bn);
+	print_field("Immediate Repetition Count: %u", bis->irc);
+	print_field("Pre Transmission Offset: 0x%2.2x", bis->pto);
+	print_field("Encryption: 0x%2.2x", bis->encryption);
+	print_hex_field("Broadcast Code", bis->bcode, 16);
+	print_rates("Coded Rates", 0x03, bis->coded_rates);
+	print_rates("HDT Rates", 0x05, le16_to_cpu(bis->hdt_rates));
+	print_prefer_mic_len(bis->mic_len);
+	print_packet_format(bis->format);
+	print_field("Blocks per Payload: %u", bis->blocks);
+}
+
+static void le_create_big_test_v2(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_cmd_le_create_big_test_v2 *cmd = data;
+
+	print_field("BIG Handle: 0x%2.2x", cmd->big_handle);
+	print_field("Advertising Handle: 0x%2.2x", cmd->adv_handle);
+	print_field("Number of BIS: %u", cmd->num_bis);
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->bis, size, cmd->num_bis, sizeof(*cmd->bis),
+						print_bis_test_v2);
+}
+
+static void le_set_hdt_default_params(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_cmd_le_hdt_set_default_params *cmd = data;
+
+	print_prefer_mic_len(cmd->mic_len);
+	print_packet_format(cmd->format);
+	print_rates("ACL Rates", 0x05, le16_to_cpu(cmd->rates));
+}
+
+static void le_set_hdt_params_test(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_cmd_le_hdt_set_params_test *cmd = data;
+
+	print_handle(cmd->handle);
+	print_prefer_mic_len(cmd->mic_len);
+	print_packet_format(cmd->format);
+	print_field("Blocks per Payload: %u", cmd->blocks);
+	print_rates("TX Rates", 0x05, cmd->tx_rates);
+}
+
+static void le_set_hdt_params_test_rsp(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_rsp_le_hdt_set_params_test *rsp = data;
+
+	print_status(rsp->status);
+	print_handle(rsp->handle);
+}
+
+static void print_eks_debug_mode(uint8_t mode)
+{
+	const char *str;
+
+	switch (mode) {
+	case 0x00:
+		str = "Disable";
+		break;
+	case 0x01:
+		str = "Accept";
+		break;
+	case 0x02:
+		str = "Enable";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("Debug Mode: %s (0x%2.2x)", str, mode);
+}
+
+static void le_read_eks_debug_mode_rsp(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_eks_debug_mode *rsp = data;
+
+	print_status(rsp->status);
+	print_eks_debug_mode(rsp->mode);
+}
+
+static void le_write_eks_debug_mode(uint16_t index, const void *data,
+					uint8_t size)
+{
+	const struct bt_hci_cmd_le_write_eks_debug_mode *cmd = data;
+
+	print_eks_debug_mode(cmd->mode);
+}
+
+struct opcode_data {
+	uint16_t opcode;
+	int bit;
+	const char *str;
+	void (*cmd_func) (uint16_t index, const void *data, uint8_t size);
+	uint8_t cmd_size;
+	bool cmd_fixed;
+	void (*rsp_func) (uint16_t index, const void *data, uint8_t size);
+	uint8_t rsp_size;
+	bool rsp_fixed;
+};
+
+static const struct opcode_data opcode_table[] = {
+	{ 0x0000,  -1, "NOP" },
+
+	/* OGF 1 - Link Control */
+	{ 0x0401,   0, "Inquiry",
+				inquiry_cmd, 5, true },
+	{ 0x0402,   1, "Inquiry Cancel",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
+	{ 0x0403,   2, "Periodic Inquiry Mode",
+				periodic_inquiry_cmd, 9, true,
+				status_rsp, 1, true },
+	{ 0x0404,   3, "Exit Periodic Inquiry Mode",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
+	{ 0x0405,   4, "Create Connection",
+				create_conn_cmd, 13, true },
+	{ 0x0406,   5, "Disconnect",
+				disconnect_cmd, 3, true },
+	{ 0x0407,   6, "Add SCO Connection",
+				add_sco_conn_cmd, 4, true },
+	{ 0x0408,   7, "Create Connection Cancel",
+				create_conn_cancel_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x0409,   8, "Accept Connection Request",
+				accept_conn_request_cmd, 7, true },
+	{ 0x040a,   9, "Reject Connection Request",
+				reject_conn_request_cmd, 7, true },
+	{ 0x040b,  10, "Link Key Request Reply",
+				link_key_request_reply_cmd, 22, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x040c,  11, "Link Key Request Negative Reply",
+				link_key_request_neg_reply_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x040d,  12, "PIN Code Request Reply",
+				pin_code_request_reply_cmd, 23, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x040e,  13, "PIN Code Request Negative Reply",
+				pin_code_request_neg_reply_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x040f,  14, "Change Connection Packet Type",
+				change_conn_pkt_type_cmd, 4, true },
+	{ 0x0411,  15, "Authentication Requested",
+				auth_requested_cmd, 2, true },
+	{ 0x0413,  16, "Set Connection Encryption",
+				set_conn_encrypt_cmd, 3, true },
+	{ 0x0415,  17, "Change Connection Link Key",
+				change_conn_link_key_cmd, 2, true },
+	{ 0x0417,  18, "Temporary Link Key",
+				link_key_selection_cmd, 1, true },
+	{ 0x0419,  19, "Remote Name Request",
+				remote_name_request_cmd, 10, true },
+	{ 0x041a,  20, "Remote Name Request Cancel",
+				remote_name_request_cancel_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x041b,  21, "Read Remote Supported Features",
+				read_remote_features_cmd, 2, true },
+	{ 0x041c,  22, "Read Remote Extended Features",
+				read_remote_ext_features_cmd, 3, true },
+	{ 0x041d,  23, "Read Remote Version Information",
+				read_remote_version_cmd, 2, true },
+	{ 0x041f,  24, "Read Clock Offset",
+				read_clock_offset_cmd, 2, true },
+	{ 0x0420,  25, "Read LMP Handle",
+				read_lmp_handle_cmd, 2, true,
+				read_lmp_handle_rsp, 8, true },
+	{ 0x0428, 131, "Setup Synchronous Connection",
+				setup_sync_conn_cmd, 17, true },
+	{ 0x0429, 132, "Accept Synchronous Connection Request",
+				accept_sync_conn_request_cmd, 21, true },
+	{ 0x042a, 133, "Reject Synchronous Connection Request",
+				reject_sync_conn_request_cmd, 7, true },
+	{ 0x042b, 151, "IO Capability Request Reply",
+				io_capability_request_reply_cmd, 9, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x042c, 152, "User Confirmation Request Reply",
+				user_confirm_request_reply_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x042d, 153, "User Confirmation Request Neg Reply",
+				user_confirm_request_neg_reply_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x042e, 154, "User Passkey Request Reply",
+				user_passkey_request_reply_cmd, 10, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x042f, 155, "User Passkey Request Negative Reply",
+				user_passkey_request_neg_reply_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x0430, 156, "Remote OOB Data Request Reply",
+				remote_oob_data_request_reply_cmd, 38, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x0433, 159, "Remote OOB Data Request Neg Reply",
+				remote_oob_data_request_neg_reply_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x0434, 163, "IO Capability Request Negative Reply",
+				io_capability_request_neg_reply_cmd, 7, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x0435, 168, "Create Physical Link",
+				create_phy_link_cmd, 3, false },
+	{ 0x0436, 169, "Accept Physical Link",
+				accept_phy_link_cmd, 3, false },
+	{ 0x0437, 170, "Disconnect Physical Link",
+				disconn_phy_link_cmd, 2, true },
+	{ 0x0438, 171, "Create Logical Link",
+				create_logic_link_cmd, 33, true },
+	{ 0x0439, 172, "Accept Logical Link",
+				accept_logic_link_cmd, 33, true },
+	{ 0x043a, 173, "Disconnect Logical Link",
+				disconn_logic_link_cmd, 2, true },
+	{ 0x043b, 174, "Logical Link Cancel",
+				logic_link_cancel_cmd, 2, true,
+				logic_link_cancel_rsp, 3, true },
+	{ 0x043c, 175, "Flow Specification Modify",
+				flow_spec_modify_cmd, 34, true },
+	{ 0x043d, 235, "Enhanced Setup Synchronous Connection",
+				enhanced_setup_sync_conn_cmd, 59, true },
+	{ 0x043e, 236, "Enhanced Accept Synchronous Connection Request",
+				enhanced_accept_sync_conn_request_cmd, 63, true },
+	{ 0x043f, 246, "Truncated Page",
+				truncated_page_cmd, 9, true },
+	{ 0x0440, 247, "Truncated Page Cancel",
+				truncated_page_cancel_cmd, 6, true,
+				status_bdaddr_rsp, 7, true },
+	{ 0x0441, 248, "Set Connectionless Peripheral Broadcast",
+				set_peripheral_broadcast_cmd, 11, true,
+				set_peripheral_broadcast_rsp, 4, true },
+	{ 0x0442, 249, "Set Connectionless Peripheral Broadcast Receive",
+				set_peripheral_broadcast_receive_cmd, 34, true,
+				set_peripheral_broadcast_receive_rsp, 8, true },
+	{ 0x0443, 250, "Start Synchronization Train",
+				null_cmd, 0, true },
+	{ 0x0444, 251, "Receive Synchronization Train",
+				receive_sync_train_cmd, 12, true },
+	{ 0x0445, 257, "Remote OOB Extended Data Request Reply",
+				remote_oob_ext_data_request_reply_cmd, 70, true,
+				status_bdaddr_rsp, 7, true },
+
+	/* OGF 2 - Link Policy */
+	{ 0x0801,  33, "Hold Mode",
+				hold_mode_cmd, 6, true },
+	{ 0x0803,  34, "Sniff Mode",
+				sniff_mode_cmd, 10, true },
+	{ 0x0804,  35, "Exit Sniff Mode",
+				exit_sniff_mode_cmd, 2, true },
+	{ 0x0805,  36, "Park State",
+				park_state_cmd, 6, true },
+	{ 0x0806,  37, "Exit Park State",
+				exit_park_state_cmd, 2, true },
+	{ 0x0807,  38, "QoS Setup",
+				qos_setup_cmd, 20, true },
+	{ 0x0809,  39, "Role Discovery",
+				role_discovery_cmd, 2, true,
+				role_discovery_rsp, 4, true },
+	{ 0x080b,  40, "Switch Role",
+				switch_role_cmd, 7, true },
+	{ 0x080c,  41, "Read Link Policy Settings",
+				read_link_policy_cmd, 2, true,
+				read_link_policy_rsp, 5, true },
+	{ 0x080d,  42, "Write Link Policy Settings",
+				write_link_policy_cmd, 4, true,
+				write_link_policy_rsp, 3, true },
+	{ 0x080e,  43, "Read Default Link Policy Settings",
+				null_cmd, 0, true,
+				read_default_link_policy_rsp, 3, true },
+	{ 0x080f,  44, "Write Default Link Policy Settings",
+				write_default_link_policy_cmd, 2, true,
+				status_rsp, 1, true },
+	{ 0x0810,  45, "Flow Specification",
+				flow_spec_cmd, 21, true },
+	{ 0x0811, 140, "Sniff Subrating",
+				sniff_subrating_cmd, 8, true,
+				sniff_subrating_rsp, 3, true },
+
+	/* OGF 3 - Host Control */
+	{ 0x0c01,  46, "Set Event Mask",
+				set_event_mask_cmd, 8, true,
+				status_rsp, 1, true },
+	{ 0x0c03,  47, "Reset",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
+	{ 0x0c05,  48, "Set Event Filter",
+				set_event_filter_cmd, 1, false,
+				status_rsp, 1, true },
+	{ 0x0c08,  49, "Flush",
+				flush_cmd, 2, true,
+				flush_rsp, 3, true },
+	{ 0x0c09,  50, "Read PIN Type",
+				null_cmd, 0, true,
+				read_pin_type_rsp, 2, true },
+	{ 0x0c0a,  51, "Write PIN Type",
+				write_pin_type_cmd, 1, true,
+				status_rsp, 1, true },
+	{ 0x0c0b,  52, "Create New Unit Key",
+				null_cmd, 0, true,
+				status_rsp, 1, true },
+	{ 0x0c0d,  53, "Read Stored Link Key",
+				read_stored_link_key_cmd, 7, true,
+				read_stored_link_key_rsp, 5, true },
+	{ 0x0c11,  54, "Write Stored Link Key",
+				write_stored_link_key_cmd, 1, false,
+				write_stored_link_key_rsp, 2, true },
+	{ 0x0c12,  55, "Delete Stored Link Key",
+				delete_stored_link_key_cmd, 7, true,
+				delete_stored_link_key_rsp, 3, true },
+	{ 0x0c13,  56, "Write Local Name",
+				write_local_name_cmd, 248, true,
+				status_rsp, 1, true },
+	{ 0x0c14,  57, "Read Local Name",
+				null_cmd, 0, true,
+				read_local_name_rsp, 249, true },
+	{ 0x0c15,  58, "Read Connection Accept Timeout",
+				null_cmd, 0, true,
 				read_conn_accept_timeout_rsp, 3, true },
 	{ 0x0c16,  59, "Write Connection Accept Timeout",
 				write_conn_accept_timeout_cmd, 2, true,
@@ -11432,6 +11984,83 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x20a6, 395, "LE CS Write Cached Remote Supported Capabilities [v2]" },
 	{ 0x20a7, 396, "LE CS Set Security Requirements" },
 	{ 0x20a8, 397, "LE CS Set Default Security Requirements" },
+	{ BT_HCI_CMD_LE_WRITE_DEF_DATA_LEN_V2,
+			BT_HCI_BIT_LE_WRITE_DEF_DATA_LEN_V2,
+			"LE Write Suggested Default Data Length V2",
+			le_write_def_data_len_v2,
+			sizeof(struct bt_hci_cmd_le_write_def_data_len_v2),
+			true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_READ_DEF_DATA_LEN_V2,
+			BT_HCI_BIT_LE_READ_DEF_DATA_LEN_V2,
+			"LE Read Suggested Default Data Length v2",
+			le_read_def_data_len_v2,
+			sizeof(struct bt_hci_cmd_le_read_def_data_len_v2),
+			true, le_read_def_data_len_v2_rsp,
+			sizeof(struct bt_hci_rsp_le_read_def_data_len_v2),
+			true },
+	{ BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2, BT_HCI_BIT_LE_ENABLE_ENCRYPT_V2,
+				"LE Enable Encryption v2", le_enable_encrypt_v2,
+				sizeof(struct bt_hci_cmd_le_enable_encrypt_v2),
+				true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_READ_MAX_DATA_LEN_V2,
+			BT_HCI_BIT_LE_READ_MAX_DATA_LEN_V2,
+			"LE Read Max Data Length v2", le_read_max_data_len_v2,
+			sizeof(struct bt_hci_cmd_le_read_data_len_v2),
+			true, le_read_max_data_len_v2_rsp,
+			sizeof(struct bt_hci_rsp_le_read_data_len_v2),
+			true },
+	{ BT_HCI_CMD_LE_SET_MAX_DATA_LEN_V2, BT_HCI_BIT_LE_SET_MAX_DATA_LEN_V2,
+			"LE Set Max Data Length v2", le_set_max_data_len_v2,
+			sizeof(struct bt_hci_cmd_le_set_data_len_v2),
+			true, le_set_max_data_len_v2_rsp,
+			sizeof(struct bt_hci_rsp_le_set_data_len_v2),
+			true },
+	{ BT_HCI_CMD_LE_SET_CIG_PARAMS_V2, BT_HCI_BIT_LE_SET_CIG_PARAMS_V2,
+			"LE Set Connected Isochronous Group Parameters v2",
+			le_set_cig_params_v2,
+			sizeof(struct bt_hci_cmd_le_set_cig_params_v2),
+			false, le_set_cig_params_v2_rsp,
+			sizeof(struct bt_hci_rsp_le_set_cig_params_v2),
+			false },
+	{ BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST_V2,
+			BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST_V2,
+			"LE Set Connected Isochronous Group Parameters Test v2",
+			le_set_cig_params_test_v2,
+			sizeof(struct bt_hci_cmd_le_set_cig_params_test_v2),
+			true, le_set_cig_params_test_v2_rsp,
+			sizeof(struct bt_hci_rsp_le_set_cig_params_v2),
+			true },
+	{ BT_HCI_CMD_LE_CREATE_BIG_V2, BT_HCI_BIT_LE_CREATE_BIG_V2,
+				"LE Create Broadcast Isochronous Group v2",
+				le_create_big_v2 },
+	{ BT_HCI_CMD_LE_CREATE_BIG_TEST_V2, BT_HCI_BIT_LE_CREATE_BIG_TEST_V2,
+				"LE Create Broadcast Isochronous Group Test v2",
+				le_create_big_test_v2 },
+	{ BT_HCI_CMD_LE_SET_HDT_DEFAULT_PARAMS,
+			BT_HCI_BIT_LE_SET_HDT_DEFAULT_PARAMS,
+			"LE Set HDT Default Parameters",
+			le_set_hdt_default_params,
+			sizeof(struct bt_hci_cmd_le_hdt_set_default_params),
+			true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_SET_HDT_PARAMS_TEST, BT_HCI_BIT_LE_SET_HDT_PARAMS_TEST,
+			"LE Set HDT Parameters Test",
+			le_set_hdt_params_test,
+			sizeof(struct bt_hci_cmd_le_hdt_set_params_test), true,
+			le_set_hdt_params_test_rsp,
+			sizeof(struct bt_hci_rsp_le_hdt_set_params_test),
+			true },
+	{ BT_HCI_CMD_LE_READ_EKS_DEBUG_MODE, BT_HCI_BIT_LE_READ_EKS_DEBUG_MODE,
+			"LE Read Encryption Key Schedule Debug Mode",
+			null_cmd, 0, true,
+			le_read_eks_debug_mode_rsp,
+			sizeof(struct bt_hci_rsp_le_read_eks_debug_mode),
+			true },
+	{ BT_HCI_CMD_LE_WRITE_EKS_DEBUG_MODE,
+			BT_HCI_BIT_LE_WRITE_EKS_DEBUG_MODE,
+			"LE Write Encryption Key Schedule Debug Mode",
+			le_write_eks_debug_mode,
+			sizeof(struct bt_hci_cmd_le_write_eks_debug_mode),
+			true },
 	{ }
 };
 
@@ -14179,6 +14808,191 @@ static void le_conn_rate_change_evt(struct timeval *tv, uint16_t index,
 					le16_to_cpu(evt->supv_timeout));
 }
 
+static void print_mic_len(uint8_t value)
+{
+	const char *str;
+
+	switch (value) {
+	case 0x00:
+		str = "32 bits";
+		break;
+	case 0x01:
+		str = "64 bits";
+		break;
+	case 0x02:
+		str = "128 bits";
+		break;
+	default:
+		str = "RFU";
+	}
+
+	print_field("MIC length: %s (0x%2.2x)", str, value);
+}
+
+static void print_eks_mode(uint8_t mode)
+{
+	const char *str;
+
+	switch (mode) {
+	case 0x00:
+		str = "off";
+		break;
+	case 0x01:
+		str = "AES-CCM";
+		break;
+	case 0x02:
+		str = "opportunistic ASE-CCM";
+		break;
+	default:
+		str = "RFU";
+		break;
+	}
+
+	print_field("Key Schedule: %s (%d)", str, mode);
+}
+
+static void encrypt_change_v3_evt(struct timeval *tv, uint16_t index,
+					const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_encrypt_change_v3 *evt = data;
+
+	print_status(evt->status);
+	print_handle(evt->handle);
+	print_encr_mode_change(evt->mode, evt->handle);
+	print_field("Key size: %u", evt->key_size);
+	print_mic_len(evt->mic_len);
+	print_eks_mode(evt->eks_mode);
+	print_field("EKS Debug: %s (0x%2.2x)",
+		    evt->eks_debug ? "Enabled" : "Disabled", evt->eks_debug);
+}
+
+static void encrypt_key_refresh_complete_v2_evt(struct timeval *tv,
+						uint16_t index,
+						const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_encrypt_key_refresh_complete_v2 *evt = data;
+
+	print_status(evt->status);
+	print_handle(evt->handle);
+	print_mic_len(evt->mic_len);
+	print_eks_mode(evt->eks_mode);
+	print_field("EKS Debug: %s (0x%2.2x)",
+		    evt->eks_debug ? "Enabled" : "Disabled", evt->eks_debug);
+}
+
+static void le_data_len_change_v2_evt(struct timeval *tv, uint16_t index,
+						const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_data_length_change_v2 *evt = data;
+
+	print_handle(evt->handle);
+	print_field("Max TX octets: %d", le16_to_cpu(evt->max_tx_len));
+	print_field("Max TX time: %d", le16_to_cpu(evt->max_tx_time));
+	print_field("Max RX octets: %d", le16_to_cpu(evt->max_rx_len));
+	print_field("Max RX time: %d", le16_to_cpu(evt->max_rx_time));
+	print_phys(evt->phys);
+}
+
+static void print_cis_encryption(uint8_t encryption)
+{
+	const char *str;
+
+	switch (encryption) {
+	case 0x00:
+		str = "Disabled";
+		break;
+	case 0x01:
+		str = "Enabled";
+		break;
+	case 0x02:
+		str = "Key Schedule";
+		break;
+	case 0x03:
+		str = "Opportunistic and Key Schedule";
+		break;
+	default:
+		str = "RFU";
+		break;
+	}
+
+	print_field("Encryption: %s (%d)", str, encryption);
+}
+
+static void le_cis_estabilished_v3_evt(struct timeval *tv, uint16_t index,
+						const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_cis_established_v3 *evt = data;
+
+	print_status(evt->status);
+	print_field("Connection Handle: %d", le16_to_cpu(evt->conn_handle));
+	print_usec_interval("CIG Synchronization Delay", evt->cig_sync_delay);
+	print_usec_interval("CIS Synchronization Delay", evt->cis_sync_delay);
+	print_usec_interval("Central to Peripheral Latency", evt->c_latency);
+	print_usec_interval("Peripheral to Central Latency", evt->p_latency);
+	print_le_phy("Central to Peripheral PHY", evt->c_phy);
+	print_le_phy("Peripheral to Central PHY", evt->p_phy);
+	print_field("Number of Subevents: %u", evt->nse);
+	print_field("Central to Peripheral Burst Number: %u", evt->c_bn);
+	print_field("Peripheral to Central Burst Number: %u", evt->p_bn);
+	print_field("Central to Peripheral Flush Timeout: %u", evt->c_ft);
+	print_field("Peripheral to Central Flush Timeout: %u", evt->p_ft);
+	print_field("Central to Peripheral MTU: %u", le16_to_cpu(evt->c_mtu));
+	print_field("Peripheral to Central MTU: %u", le16_to_cpu(evt->p_mtu));
+	print_slot_125("ISO Interval", evt->interval);
+	print_usec_interval("ISO Sub-Interval", evt->sub_interval);
+	print_field("Central to Peripheral SDU: %u", le16_to_cpu(evt->c_sdu));
+	print_field("Peripheral to Central SDU: %u", le16_to_cpu(evt->p_sdu));
+	print_usec_interval("Central to Peripheral SDU Interval",
+				evt->c_sdu_interval);
+	print_usec_interval("Peripheral to Central SDU Interval",
+				evt->p_sdu_interval);
+	print_framing(evt->framing);
+	print_rates("Central to Peripheral Rates", evt->c_phy,
+			le16_to_cpu(evt->c_rates));
+	print_rates("Peripheral to Central Rates", evt->p_phy,
+			le16_to_cpu(evt->p_rates));
+	print_field("Config ID: %u", evt->config_id);
+	print_field("Group ID: %u", evt->group_id);
+	print_cis_encryption(evt->encryption);
+	print_mic_len(evt->mic_len);
+
+	if (!evt->status)
+		assign_handle(index, le16_to_cpu(evt->conn_handle), 0x05,
+					NULL, BDADDR_LE_PUBLIC);
+}
+
+static void le_big_complete_v2_evt(struct timeval *tv, uint16_t index,
+						const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_big_complete_v2 *evt = data;
+
+	print_status(evt->status);
+	print_field("Handle: 0x%2.2x", evt->handle);
+	print_usec_interval("BIG Synchronization Delay", evt->sync_delay);
+	print_usec_interval("Transport Latency", evt->latency);
+	print_le_phy("PHY", evt->phy);
+	print_field("NSE: %u", evt->nse);
+	print_field("BN: %u", evt->bn);
+	print_field("PTO: %u", evt->pto);
+	print_field("IRC: %u", evt->irc);
+	print_field("Maximum PDU: %u", evt->max_pdu);
+	print_slot_125("ISO Interval", evt->interval);
+	print_rates("Rates", evt->phy, le16_to_cpu(evt->rates));
+	print_field("Encryption: %s (0x%2.2x)",
+			evt->encryption ? "Encrypted" : "Unencrypted",
+			evt->encryption);
+	print_list(evt->bis_handle, size, evt->num_bis,
+				sizeof(*evt->bis_handle), print_bis_handle);
+
+	if (!evt->status) {
+		int i;
+
+		for (i = 0; i < evt->num_bis; i++)
+			assign_handle(index, le16_to_cpu(evt->bis_handle[i]),
+					0x05, NULL, BDADDR_LE_PUBLIC);
+	}
+}
+
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
@@ -14353,6 +15167,18 @@ static const struct subevent_data le_meta_event_table[] = {
 		"LE Connection Rate Change",
 		le_conn_rate_change_evt,
 		sizeof(struct bt_hci_evt_le_conn_rate_change) },
+	{ BT_HCI_EVT_LE_DATA_LENGTH_CHANGE_V2,
+		"LE Data Length Change v2",
+		le_data_len_change_v2_evt,
+		sizeof(struct bt_hci_evt_encrypt_key_refresh_complete_v2) },
+	{ BT_HCI_EVT_LE_CIS_ESTABLISHED_V3,
+		"LE Connected Isochronous Stream Established v3",
+		le_cis_estabilished_v3_evt,
+		sizeof(struct bt_hci_evt_le_cis_established_v3) },
+	{ BT_HCI_EVT_LE_BIG_COMPLETE_V2,
+		"LE Broadcast Isochronous Group Complete v2",
+		le_big_complete_v2_evt,
+		sizeof(struct bt_hci_evt_le_big_complete_v2) },
 	{ }
 };
 
@@ -14583,8 +15409,17 @@ static const struct event_data event_table[] = {
 	{ 0x57, "Authenticated Payload Timeout Expired",
 				auth_payload_timeout_expired_evt, 2, true },
 	{ 0x58, "SAM Status Change" },
+
 	{ 0x59, "Encryption Change v2",
 				encrypt_change_evt_v2, 5, true },
+	{ BT_HCI_EVT_ENCRYPT_CHANGE_V3, "Encrypt Change V3",
+				encrypt_change_v3_evt,
+				sizeof(struct bt_hci_evt_encrypt_change_v3),
+				true },
+	{ BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2,
+		"Encrypt Key Refresh Complete v2",
+		encrypt_key_refresh_complete_v2_evt,
+		sizeof(struct bt_hci_evt_encrypt_key_refresh_complete_v2) },
 	{ 0xfe, "Testing" },
 	{ 0xff, "Vendor", evt_vendor, 0, false },
 	{ }
@@ -15610,6 +16445,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 23, "PAST Sender"		},
 	{ 24, "PAST Receiver"		},
 	{ 25, "Shorter Connection Interval"	},
+	{ 26, "HDT"			},
 	{}
 };
 
@@ -17104,6 +17940,10 @@ static const struct {
 	{0x001e, "LE No Filter Scanning Duration for adv monitoring"  },
 	{0x001f, "LE Enable Interleave Scan for adv monitoring"       },
 	{0x0020, "BR/EDR Connection Idle Timeout"                     },
+	{0x0021, "LE HDT Default MIC Length"                          },
+	{0x0022, "LE HDT Default Packet Format"                      },
+	{0x0023, "LE HDT Default Rates"                              },
+	{0x0024, "LE Opportunistic Encryption"                        },
 	{ }
 };
 
-- 
2.56.0

