Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989099;
	b=LWOzIlDtAzQub7gtNNXYRQ95ynDarsYihL6Y2Kbumn10/qIcbYQUCN4WMeHr9GJ77Vzb
	 jPtrpUUdCp7wdufpxx3NAMHg94YzA45X3eMi1+vqP3sqtHBgmLO45vFxGubeWdbwY6f4T
	 cgHo2IOh90xu6KdSmg3uVskg0AvLHXibaUL+XiKEF0r35UWhR8n5E4TBZxPADy9LLLk4x
	 Z8VY4RFs92lrRbIrf7Ot6WwtkFtTrL0XsbPDjVEI3mOV+AGeYs2Y+qQc89ShnPfhiilZG
	 1FTwUKB9t4m9/EjdGecxnv+CVOkxbypTHjGLVk6Qv519kiwIyjpsCqEmmpFwmVMbbgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rCf1d1+K0JReeW6UZVOOYu9fTJy7vuZmp5hoL+m3MJg=;
	b=WSeJAGIh1P1LZaLPUkmm/I34SiPi2NSGmE3oBlzJrjVUp+36TxjJVRVCXhFXJt7cpe8z
	 URzU9BEKM0aKFJRm3e/iEU1mciKyLZugTdjo536B5YJyGNb9TN0Uhhi6j0NTM3imstwmk
	 HZpTvp18RUPgR1p7yQV9cmDObSXaPz0CAM6Inog7XSyIdApV2HdGJSdSe48UdEBY9HjDO
	 QLEI++yYgJ+/AXo0NUR8SJMplefrCgp3EO3Cq0avcyb50Q94GFFcZ9P8oaUujUmP9C5e+
	 tid5wfzkljJMv4Bv5nTojianxp0mz4xO50O2lSjR6yY9B6bHmpzf4ij9nOXovxJBCWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c91QcdVN;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096F606A32C
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1096F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c91QcdVN
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so356064e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989097; x=1794593897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rCf1d1+K0JReeW6UZVOOYu9fTJy7vuZmp5hoL+m3MJg=;
        b=c91QcdVNiW0lpPhelDByVgpKGgOzABpG9VUL0O99+ES4e22iEm84TxftrbwTwvQrtz
         KzyloaCYOSVHxMfDjTBe/QtwpWWs7KmqwqMBuDex0EHLGxxQOSUgX+EDZTEhhhspeIaA
         EMfg4q4Ol3R1XY8YStUPri8CIIaAl6WiWIyXxK+SyC1e7Fw24R210/4Zk52HG1kSdlwI
         i7w0An8Y9y0Wo/85SC11xEDNmh7AQBXr62n/KcU7gJWkyO7ep2Or0eHoQpo2itxYtQvH
         BhO2PxUL66Osqxy1yx2VpAfS7TPH/vjy+Mz6//zwvzF7NFYjdVclTN+TguIwyP34sjTF
         cxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989097; x=1794593897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rCf1d1+K0JReeW6UZVOOYu9fTJy7vuZmp5hoL+m3MJg=;
        b=khy6o4dzvhOzmlt86tDzoyn6F6VzhL9suaQH1/wMnr9r3DaZkw3NwVboM5VMDPqYfu
         4Q6t8NXZ65zTPMq3DXotRbX2x3yklhUApF13dVpUOf2lfLNHGjJM9VoIZemgnsgnsls/
         plFppik1A5x2fs/7S528Ed9WR4iwx956rJ84jPV+wD6HZVY3yi5S04OFqrQYhaQfWwvj
         DLyhz4drD/NcPssQFVo5rUjCINPjxBBENXwY7aVxXpjD7k9AYG/CV33ziGh8DcWMryeE
         ksIJ+VoOL8Asupg+dQjVyRtfHqad4vjTX4GvYLB9L+IGpli5PNLRQ46vFOrV7WCGm4Wu
         lCiQ==
X-Gm-Message-State: APuU4Z8XAITU0dTwYAOdtnFF4Y2W+cjNHsnX/9ANXlE/wLATeaOi/owd
	0k5PXYDQgOfJr/3v2Rj5Hw+8va2av4u6oVQnwPshyY3HRZPbIH7y3uPdHmZXKA==
X-Gm-Gg: AYBFou1d3ommpO5cHMOv7uHZpFC22LjLq0l8P+Ka4tpCZXOw1Vx8uBZuoQuDOIU/TP/
	TySuAa1R2PEt6IlYE+OHfpKzN+/FaiLGFj+ogrvySOJToy0TVIT4NQFZfvQ8tsLTfm4if7Tq28b
	515CyJDXAT/kRlYSgrSOfSlULvOVBF1rzjEEDaeBPJKynjdHtDKW1eDhSiM0rffhUUME2LH1oC+
	WBaM5jiLgX7iOqKosdS0BIFYkBoxOYokdMaDZk7ZY3qTre3VuZkPIFUJiO6CMEfmyDBPR1rdHbS
	4g1N/w/yca+9Uw1kDEHJhGqNue8UH7mkVMce7sy4k1cWjhQyMkRv8pMHN4KudDeaQFfIj9xm6Wp
	5xi8jH3lyPFOIezSy3nxy24i0iiF7obLGF9xDVDli059rzgxRd0YLr/m6rbTs7TB36j5fkkpyDv
	ql0r8TOr7k+/Ia6YBOJcactV4DLQevxrZxk2e+3flbRUoQzakTiN4fNaYOSpqd7TBANr4Yl98oh
	aLEdrLs70TI5r2N5NUoEFwf2RCOfGMTWg7jN+C8ZmJPrm6Ep16inmpRTRDEYO4JipHwC6JsVvqg
	oFeBL7FLYxpW82lGQ5AMVDi2hWaA7nRFk3dE5iHPaBGOnNFZ9V5junY7vPY+s6NkMOSOGosCbH1
	jT91K8Qa5IRaHD+VBQzezaNNgox3mk6qa7knOvT1es+ULTrigRUfXz0tph+LTT/CvoXxq2hE5TP
	zlxCw+acy4LEXDLZNyT+RAz/gN
X-Received: by 2002:a05:6122:2218:b0:5dc:d0cb:7d74 with SMTP id 71dfb90a1353d-5ecc42de125mr1801824e0c.2.1793989096559;
        Fri, 06 Nov 2026 10:18:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc6517dc0sm1922904e0c.17.2026.11.06.10.18.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:18:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 04/11] monitor: Add HCI decoding for HDT
Date: Fri,  6 Nov 2026 13:18:01 -0500
Message-ID: <20261106181809.3134862-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106181809.3134862-1-luiz.dentz@gmail.com>
References: <20261106181809.3134862-1-luiz.dentz@gmail.com>
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
 monitor/att.c    |   3 +
 monitor/bt.h     | 378 ++++++++++++++++++++
 monitor/l2cap.c  |   6 +
 monitor/packet.c | 886 ++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 1257 insertions(+), 16 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index a35198949e3d..1d16ae21dadf 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -364,6 +364,9 @@ static void att_error_response(const struct l2cap_frame *frame)
 	case 0x13:
 		str = "Value Not Allowed";
 		break;
+	case 0x14:
+		str = "MIC Length Too Short";
+		break;
 	case 0xfd:
 		str = "CCC Improperly Configured";
 		break;
diff --git a/monitor/bt.h b/monitor/bt.h
index 1a4aa394182d..59bc90ccd30d 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -257,6 +257,68 @@ struct bt_ll_feature_ext_rsp {
 	uint8_t  features[24];
 } __packed;
 
+/* Fields added at the end of LL_PHY_REQ and LL_PHY_RSP [v2] */
+struct bt_ll_phy_v2 {
+	uint8_t  flags;
+} __packed;
+
+/* Fields added at the end of LL_PHY_UPDATE_IND [v2] */
+struct bt_ll_phy_update_ind_v2 {
+	uint8_t  address[5];
+	uint8_t  flags;
+} __packed;
+
+/* Fields added at the end of LL_CIS_REQ [v2] */
+struct bt_ll_cis_req_v2 {
+	uint16_t c_rates;
+	uint16_t p_rates;
+	uint8_t  config_id;
+	uint8_t  tl_group_id;
+	uint8_t  flags;
+	uint8_t  se_length[3];
+} __packed;
+
+/* Fields added at the end of LL_CIS_IND [v2] */
+struct bt_ll_cis_ind_v2 {
+	uint8_t  pca_h;
+} __packed;
+
+#define BT_LL_ENC_ECDH_RSP	0x41
+struct bt_ll_enc_ecdh_rsp {
+	uint8_t flags;
+	uint8_t rand[16];
+	uint8_t key_type;
+	uint8_t pubkey[64];
+} __packed;
+
+#define BT_LL_ENC_ECDH_REQ	0x40
+struct bt_ll_enc_ecdh_req {
+	uint8_t flags;
+	uint8_t rand[16];
+	uint8_t key_type;
+	uint8_t pubkey[64];
+} __packed;
+
+#define BT_LL_HDT_CONFIG_RSP	0x43
+struct bt_ll_hdt_config_rsp {
+	uint8_t  wincfg;
+	uint16_t acl_rx_rates;
+	uint16_t acl_rx_mtu;
+} __packed;
+
+#define BT_LL_HDT_CONFIG_REQ	0x42
+struct bt_ll_hdt_config_req {
+	uint8_t  wincfg;
+	uint16_t acl_rx_rates;
+	uint16_t acl_rx_mtu;
+} __packed;
+
+#define BT_LL_HDT_LQF_REPORTING_IND 0x44
+struct bt_ll_hdt_lqf_ind {
+	uint8_t  transport;
+} __packed;
+
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
@@ -3251,6 +3313,235 @@ struct bt_hci_rsp_le_read_conn_interval {
 	struct bt_hci_le_conn_interval_group grps[0];
 } __packed;
 
+#define BT_HCI_CMD_LE_WRITE_DEF_DATA_LEN_V2	0x20b2
+#define BT_HCI_BIT_LE_WRITE_DEF_DATA_LEN_V2	BT_HCI_CMD_BIT(50, 7)
+struct bt_hci_cmd_le_write_def_data_len_v2 {
+	uint16_t tx_len;
+	uint16_t tx_time;
+	uint8_t  phys;
+} __packed;
+
+#define BT_HCI_CMD_LE_READ_DEF_DATA_LEN_V2	0x20b1
+#define BT_HCI_BIT_LE_READ_DEF_DATA_LEN_V2	BT_HCI_CMD_BIT(50, 6)
+struct bt_hci_cmd_le_read_def_data_len_v2 {
+	uint8_t  phys;
+} __packed;
+
+struct bt_hci_rsp_le_read_def_data_len_v2 {
+	uint8_t  status;
+	uint16_t tx_len;
+	uint16_t tx_time;
+} __packed;
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
+} __packed;
+
+#define BT_HCI_CMD_LE_READ_MAX_DATA_LEN_V2	0x20b0
+#define BT_HCI_BIT_LE_READ_MAX_DATA_LEN_V2	BT_HCI_CMD_BIT(50, 5)
+struct bt_hci_cmd_le_read_data_len_v2 {
+	uint8_t  phy;
+} __packed;
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
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_DATA_LEN_V2	0x20aa
+#define BT_HCI_BIT_LE_SET_DATA_LEN_V2	BT_HCI_CMD_BIT(52, 3)
+struct bt_hci_cmd_le_set_data_len_v2 {
+	uint16_t handle;
+	uint16_t tx_len;
+	uint16_t tx_time;
+	uint8_t  phys;
+} __packed;
+
+struct bt_hci_rsp_le_set_data_len_v2 {
+	uint8_t  status;
+	uint16_t handle;
+} __packed;
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
+} __packed;
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
+	struct bt_hci_cis_params_v2 cis[];
+} __packed;
+
+struct bt_hci_rsp_le_set_cig_params_v2 {
+	uint8_t  status;
+	uint8_t  cig_id;
+	uint8_t  num_handles;
+	uint16_t handle[];
+} __packed;
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
+} __packed;
+
+struct bt_hci_cmd_le_set_cig_params_test_v2 {
+	uint8_t  cig_id;
+	uint8_t  c_interval[3];
+	uint8_t  p_interval[3];
+	uint8_t  c_ft;
+	uint8_t  p_ft;
+	uint16_t iso_interval;
+	uint8_t  sca;
+	uint16_t anchor_update;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  num_cis;
+	struct bt_hci_cis_params_test_v2 cis[];
+} __packed;
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
+} __packed;
+
+struct bt_hci_cmd_le_create_big_v2 {
+	uint8_t  handle;
+	uint8_t  adv_handle;
+	uint8_t  num_bis;
+	struct bt_hci_bis_v2 bis;
+} __packed;
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
+} __packed;
+
+struct bt_hci_cmd_le_create_big_test_v2 {
+	uint8_t  big_handle;
+	uint8_t  adv_handle;
+	uint8_t  num_bis;
+	struct bt_hci_bis_test_v2 bis[];
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_HDT_DEFAULT_PARAMS	0x20bc
+#define BT_HCI_BIT_LE_SET_HDT_DEFAULT_PARAMS	BT_HCI_CMD_BIT(52, 1)
+struct bt_hci_cmd_le_hdt_set_default_params {
+	uint8_t  mic_len;
+	uint8_t  format;
+	uint16_t rates;
+} __packed;
+
+#define BT_HCI_CMD_LE_SET_HDT_PARAMS_TEST	0x20bd
+#define BT_HCI_BIT_LE_SET_HDT_PARAMS_TEST	BT_HCI_CMD_BIT(52, 2)
+struct bt_hci_cmd_le_hdt_set_params_test {
+	uint16_t handle;
+	uint8_t  mic_len;
+	uint8_t  format;
+	uint8_t  blocks;
+	uint16_t tx_rates;
+} __packed;
+
+struct bt_hci_rsp_le_hdt_set_params_test {
+	uint8_t  status;
+	uint16_t handle;
+} __packed;
+
+#define BT_HCI_CMD_LE_READ_EKS_DEBUG_MODE	0x20b8
+#define BT_HCI_BIT_LE_READ_EKS_DEBUG_MODE	BT_HCI_CMD_BIT(51, 5)
+struct bt_hci_rsp_le_read_eks_debug_mode {
+	uint8_t  status;
+	uint8_t  mode;
+} __packed;
+
+#define BT_HCI_CMD_LE_WRITE_EKS_DEBUG_MODE	0x20b9
+#define BT_HCI_BIT_LE_WRITE_EKS_DEBUG_MODE	BT_HCI_CMD_BIT(51, 6)
+struct bt_hci_cmd_le_write_eks_debug_mode {
+	uint8_t  mode;
+} __packed;
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
@@ -4228,6 +4519,93 @@ struct bt_hci_evt_le_conn_rate_change {
 	uint16_t supv_timeout;
 } __packed;
 
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
+} __packed;
+
+#define BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2 0x5b
+#define BT_HCI_BIT_ENCRYPT_KEY_REFRESH_COMPLETE_V2 27
+struct bt_hci_evt_encrypt_key_refresh_complete_v2 {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  mic_len;
+	uint8_t  eks_mode;
+	uint8_t  eks_debug;
+} __packed;
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
+} __packed;
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
+} __packed;
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
+	uint16_t bis_handle[];
+} __packed;
+
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index d94d996010ff..ddc2388d55b8 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -633,6 +633,9 @@ static void print_le_conn_result(uint16_t result)
 	case 0x000b:
 		str = "Connection refused - unacceptable parameters";
 		break;
+	case 0x000c:
+		str = "Connection refused - MIC length too short";
+		break;
 	default:
 		str = "Reserved";
 		break;
@@ -1440,6 +1443,9 @@ static void print_ecred_conn_result(uint16_t result)
 	case 0x000b:
 		str = "All Connections refused - unacceptable parameters";
 		break;
+	case 0x0010:
+		str = "All Connections refused - MIC length too short";
+		break;
 	default:
 		str = "Reserved";
 		break;
diff --git a/monitor/packet.c b/monitor/packet.c
index 9162b41f72ed..4e1f6949b76a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -1004,6 +1004,9 @@ static const struct {
 	{ 0x43, "Limit Reached"						},
 	{ 0x44, "Operation Cancelled by Host"				},
 	{ 0x45, "Packet Too Long"					},
+	{ 0x49, "Invalid Packet Format"					},
+	{ 0x4a, "Invalid Public Key"					},
+	{ 0x4b, "Debug Key Not Allowed"					},
 	{ }
 };
 
@@ -3227,6 +3230,15 @@ static const struct bitfield_data features_le_1[] = {
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
 
@@ -3302,6 +3314,7 @@ static void print_features(uint8_t page, const uint8_t *features_array,
 			break;
 		case 1:
 			features_table = features_le_1;
+			break;
 		}
 		break;
 	case 0xf0:
@@ -3615,9 +3628,11 @@ static const struct bitfield_data events_page2_table[] = {
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
@@ -3675,6 +3690,9 @@ static const struct bitfield_data events_le_table[] = {
 	{ 53, "LE UTP Received"						},
 	{ 54, "LE Connection Rate Change"				},
 	{ 55, "LE CS Read Remote Supported Capabilities Complete [v2]"	},
+	{ 56, "LE Data Length Change [v2]"				},
+	{ 57, "LE CIS Established [v3]"				},
+	{ 58, "LE Create BIG Complete [v2]"				},
 	{ }
 };
 
@@ -8168,6 +8186,9 @@ static void print_le_phy(const char *prefix, uint8_t phy)
 	case 0x03:
 		str = "LE Coded";
 		break;
+	case 0x05:
+		str = "LE HDT";
+		break;
 	default:
 		str = "Reserved";
 		break;
@@ -8190,6 +8211,7 @@ static const struct bitfield_data le_phys[] = {
 	{  0, "LE 1M"	},
 	{  1, "LE 2M"	},
 	{  2, "LE Coded"},
+	{  4, "LE HDT"	},
 	{ }
 };
 
@@ -8235,26 +8257,36 @@ static void le_set_default_phy_cmd(uint16_t index, const void *data,
 	print_le_phys_preference(cmd->all_phys, cmd->tx_phys, cmd->rx_phys);
 }
 
+static const struct bitfield_data hdt_phy_opts[] = {
+	{ 0, "Coded S=2" },
+	{ 1, "Coded S=8" },
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
@@ -9211,7 +9243,7 @@ static void print_framing(uint8_t value)
 		print_field("Framing: Framed (0x%2.2x)", value);
 		return;
 	default:
-		print_field("Packing: Reserved (0x%2.2x)", value);
+		print_field("Framing: Reserved (0x%2.2x)", value);
 	}
 }
 
@@ -10305,6 +10337,530 @@ static void le_read_conn_interval_rsp(uint16_t index, const void *data,
 	}
 }
 
+static void print_le_def_phys(uint8_t phys)
+{
+	const char *str;
+
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
+
+	print_field("PHYs: %s (0x%2.2x)", str, phys);
+}
+
+static void le_write_def_data_len_v2(uint16_t index, const void *data,
+							uint8_t size)
+{
+	const struct bt_hci_cmd_le_write_def_data_len_v2 *cmd = data;
+
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
+static void le_set_data_len_v2(uint16_t index, const void *data,
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
+static void le_set_data_len_v2_rsp(uint16_t index, const void *data,
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
+	{ 1, "CODED S=2" },
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
+
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
+	print_field("Anchor Update Buffer Time: %u us",
+					le16_to_cpu(cmd->anchor_update));
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
+	print_field("Maximum SDU: %u", le16_to_cpu(bis->sdu));
+	print_field("Maximum PDU: %u", le16_to_cpu(bis->pdu));
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
+	print_rates("TX Rates", 0x05, le16_to_cpu(cmd->tx_rates));
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
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -11435,6 +11991,87 @@ static const struct opcode_data opcode_table[] = {
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
+	{ BT_HCI_CMD_LE_SET_DATA_LEN_V2, BT_HCI_BIT_LE_SET_DATA_LEN_V2,
+			"LE Set Data Length v2", le_set_data_len_v2,
+			sizeof(struct bt_hci_cmd_le_set_data_len_v2),
+			true, le_set_data_len_v2_rsp,
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
+			false, le_set_cig_params_test_v2_rsp,
+			sizeof(struct bt_hci_rsp_le_set_cig_params_v2),
+			false },
+	{ BT_HCI_CMD_LE_CREATE_BIG_V2, BT_HCI_BIT_LE_CREATE_BIG_V2,
+				"LE Create Broadcast Isochronous Group v2",
+				le_create_big_v2,
+				sizeof(struct bt_hci_cmd_le_create_big_v2),
+				true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_CREATE_BIG_TEST_V2, BT_HCI_BIT_LE_CREATE_BIG_TEST_V2,
+				"LE Create Broadcast Isochronous Group Test v2",
+				le_create_big_test_v2,
+				sizeof(struct bt_hci_cmd_le_create_big_test_v2),
+				false, status_rsp, 1, true },
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
 
@@ -14182,6 +14819,197 @@ static void le_conn_rate_change_evt(struct timeval *tv, uint16_t index,
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
+	print_field("Maximum PDU: %u", le16_to_cpu(evt->max_pdu));
+	print_slot_125("ISO Interval", evt->interval);
+	print_rates("Rates", evt->phy, le16_to_cpu(evt->rates));
+	print_field("Encryption: %s (0x%2.2x)",
+			evt->encryption ? "Encrypted" : "Unencrypted",
+			evt->encryption);
+	print_mic_len(evt->mic_len);
+
+	/* Only the handles the event has room for */
+	size -= sizeof(*evt);
+
+	print_list(evt->bis_handle, size, evt->num_bis,
+				sizeof(*evt->bis_handle), print_bis_handle);
+
+	if (!evt->status) {
+		int max = size / sizeof(*evt->bis_handle);
+		int i;
+
+		for (i = 0; i < evt->num_bis && i < max; i++)
+			assign_handle(index, le16_to_cpu(evt->bis_handle[i]),
+					0x05, NULL, BDADDR_LE_PUBLIC);
+	}
+}
+
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
@@ -14356,6 +15184,18 @@ static const struct subevent_data le_meta_event_table[] = {
 		"LE Connection Rate Change",
 		le_conn_rate_change_evt,
 		sizeof(struct bt_hci_evt_le_conn_rate_change) },
+	{ BT_HCI_EVT_LE_DATA_LENGTH_CHANGE_V2,
+		"LE Data Length Change v2",
+		le_data_len_change_v2_evt,
+		sizeof(struct bt_hci_evt_le_data_length_change_v2) },
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
 
@@ -14586,8 +15426,17 @@ static const struct event_data event_table[] = {
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
@@ -15613,6 +16462,7 @@ static const struct bitfield_data mgmt_settings_table[] = {
 	{ 23, "PAST Sender"		},
 	{ 24, "PAST Receiver"		},
 	{ 25, "Shorter Connection Interval"	},
+	{ 26, "HDT"			},
 	{}
 };
 
@@ -17107,6 +17957,10 @@ static const struct {
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

