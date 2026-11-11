Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427633;
	b=uRaLroTYWLp8wz+AG5mFkrf5FpHnO9/R9USPurfCENqLpMQceJSpSf3jO4EM1XcfMO3S
	 ChfYw/ySpKthYZdUL/oSzGv/UANE0vnc5U3E8XDD1idET+ul9fuY+3jLP0sl3CQCeAawN
	 /e1my6WtlS9oInfHXBkMDIP0wQwH5BaU4Up/+nKSHA2TZW98M7OP8rPxb2fCm2/t8erpy
	 0gPPF0G3DyvepFayZp/W/U7h0FEHD0RNNOnHsfjIEPchenqptRXdaw7dsC2V6EeDNDhcn
	 IUmne3+ZGEVs4AFzH7Hv44LQd4vahl1OosFC4lCyaU7RK1Y6MBuB92bqOKo0QWdYX+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CC203hbotUPGYudLaNJ0DSCHycJ07PySV48gFP6XOgY=;
	b=z2bJxbAqhZYBDwj4R74sKFqrn5ecnniKJV9mbH7RYiZtM4S1pf0QfCb3RGS7jOX1hQ+M
	 SFY7sd6O6lvQN4TO38mX3Mupx4zyEIoakIinG4UGPZdOXUDcSs/zfHGSV2sRORh0K+iwc
	 j6kD//PV2eIdWbjHoFy0ej1yCQ+uFsGS1zBBaEPjZ0+4pUmW1oPiRFVHq2fbrzzji+AhK
	 tfWL/JBJ4I6Y80x1bHupEkvFOTrCqHH8d+XPiKzagh2ppqO/RMSR98H4SXa0GOYfF3KpB
	 KYBOAr6EbrBQWxhlE1wrQnv4GTg+QJH0RuxZP32iQnU9osnQeIciC4KCy4vLjkRIolQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3Nfe6Sv;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9F606A324
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB9F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3Nfe6Sv
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so1154134137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794427630; x=1795032430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CC203hbotUPGYudLaNJ0DSCHycJ07PySV48gFP6XOgY=;
        b=a3Nfe6SvyK4312jHXR1bENzF/ZXROlob0cCLnItcFt3+cUrntHQGx9KCONqPkAFm46
         E/6L3DMTzZKE6WBzmaJhWhPa/2bFi/aWrJC1re3HqcOyeYoz8MqmLWQbD2NJDT5R28hE
         xfvvroTqL3A7sGDvZIGN9fVRZP6PVYHqPXJQ8j6/pQVCVsdwBsc5UJEUu6ZuwLIAgLWJ
         zxtIkmhddm0iBtLkJwCvTQPzFd54R697fk6bcPT1G7mT0gaxe6P4bkd3e4OXgWuDLArr
         mgmH+RKlkR8uV0g1A28KKdt7Bs/DmQLPxX2FTA4ITtoVcS5AN53mytf4Vg57pFEJ2SHf
         G0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794427630; x=1795032430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CC203hbotUPGYudLaNJ0DSCHycJ07PySV48gFP6XOgY=;
        b=s207PhZgQHufRIVzSd+YISd+GAN0A3/fyOJfzSwVeUBibd/mNf12tIwcVqVr32lSxQ
         kdg7gJ0QL4JLirErngj3ati2KROsvUziguwOiOZlbWEVxPLBYtNQdo4iyu8fRTcOXYLG
         SmZGXEAPNKE3aP0isjl1emZUePC5oadAgE7qOKJCgGx9WdSLsMeGaL4tIW/mvPpo8IqK
         HtAnxnmwmZwVQDuzAY1w6+xLS4f1Xucoll4ZIOiumsXXaj6CLcyCr+MJDnQBiORyC5bG
         0fVEOim268Fqp/ppDeupwEkRt47vkUOWxwEmUlyDQiVaklBSP6sK3Nuds22Vlxo+gBia
         ZzuQ==
X-Gm-Message-State: APuU4Z/5SJ2CTYpPzuitx+/qbtoboI2RDq8aK5kZQ3e9yXmLjkEZbVqh
	BOgisq3/t+hC3U9bjJBtguRQu4e4L4ctw/Gakc23Ly0ARTJ7deCNpt2BRS8OhQ==
X-Gm-Gg: AYBFou2LdYAq8STOZI+1kF2xfa43+pi+P4qknQFK3vzaxMKM17QkeQcAv4+ZI0F+KH0
	MwBwcqJaRombA274FE+9MGQ6Vs3C0BbGrUntY/vowygcFCC6XiYRZioRSPIvhqDco0NBgUvpsAG
	ujNfd/rAjIoFt/5IOf5Mm94+s3mgfvut5qhh02A8FDhpCSDIYxgCUphzovxYUKm2LhcjLWiE2Bj
	KMzduWgLFQSfwxzqb2Zvushv7nruBN/fL9fxsQtIK61DDtgwHzuyrUHdZchHab/NU5lYdAbjbjq
	sOyAsDo4jVlFJ2y0UFqgn4ddFqksAe7N8ERhJu3GKaZDhYUCkPzsAR75aNshhVmo6QjgOjMHZP1
	vJxhh1DA62MW+/ATtQNRsmdcHnRRMHdNCaMwjBYktOXdRreTq0KKvMrixlGLjHKQCfCjo484IPN
	srEEs3OlAzmaCgjBFyQpipVn/ZXRF+Ra23OE7Ycy6WgugCCkSy30HAupAF77V2v4q1i93MEWsDF
	+Yk7htLJE/jCSsZVCpsaqlCPv+u7X3YYnKN12WHvURHV5aXrmlUe7vji+IiZSyn5NpAoDIK0H1N
	8tmka082SJo+dkEUCM2nY5XJ4b/u1NyesA57QOPkveeRpKxMA66isBg0ZEXij04ChDHWVC1A/kj
	i7JyB94vY5KgG1oPtKUDolDvqKVt0abHjl6W/c+FDynOZoFszCq65dWyp4C/B9embKH4hH+L8lJ
	0dE2Y=
X-Received: by 2002:a05:6102:3f44:b0:7d0:3ed0:c61d with SMTP id ada2fe7eead31-7d4edd08a5dmr1260977137.2.1794427629164;
        Wed, 11 Nov 2026 12:07:09 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30209ff97sm4954449137.0.2026.11.11.12.07.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:07:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v10 01/11] monitor: Use __packed in bt.h and its users
Date: Wed, 11 Nov 2026 15:06:54 -0500
Message-ID: <20261111200705.3802779-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111200705.3802779-1-luiz.dentz@gmail.com>
References: <20261111200705.3802779-1-luiz.dentz@gmail.com>
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

Define __packed in monitor/bt.h, as lib/bluetooth/mgmt.h and the
src/shared headers do, guarded so it matches theirs whichever is
included first, and use it instead of __attribute__ ((packed)) in
bt.h and the files that include it.

This is what checkpatch asks for (PREFER_DEFINED_ATTRIBUTE_MACRO), so
new definitions no longer get flagged for following the style of the
existing ones.

The structs btdev.c declared with struct __packed, meaning to pack
them, now are: until now __packed was taken as their tag name.
---
 emulator/btdev.c     |    6 +-
 emulator/bthost.c    |    6 +-
 emulator/vhci.c      |    4 +-
 monitor/bt.h         | 1294 +++++++++++++++++++++---------------------
 monitor/packet.c     |    4 +-
 tools/3dsp.c         |    4 +-
 tools/bluemoon.c     |   24 +-
 tools/l2cap-tester.c |    2 +-
 8 files changed, 674 insertions(+), 670 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7a8d8a4645f6..2fe593ac4959 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -145,7 +145,7 @@ struct le_cig {
 	struct bt_hci_cmd_le_set_cig_params params;
 	struct bt_hci_cis_params cis[CIS_SIZE];
 	bool activated;
-} __attribute__ ((packed));
+} __packed;
 
 struct pending_conn {
 	struct btdev *dev;
@@ -6851,7 +6851,7 @@ static int cmd_set_cig_params(struct btdev *dev, const void *data,
 	struct lescp {
 		struct bt_hci_rsp_le_set_cig_params params;
 		uint16_t handle[CIS_SIZE];
-	} __attribute__ ((packed)) rsp;
+	} __packed rsp;
 	int i = 0;
 	int cig_idx;
 	uint32_t interval;
@@ -8040,7 +8040,7 @@ static int cmd_le_read_conn_interval(struct btdev *dev, const void *data,
 	struct {
 		struct bt_hci_rsp_le_read_conn_interval rsp;
 		struct bt_hci_le_conn_interval_group grp;
-	} __attribute__ ((packed)) pdu;
+	} __packed pdu;
 
 	memset(&pdu, 0, sizeof(pdu));
 	pdu.rsp.status = BT_HCI_ERR_SUCCESS;
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 2f05573786f8..0c669f92efc4 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2597,7 +2597,7 @@ static bool l2cap_ecred_conn_req(struct bthost *bthost, struct btconn *conn,
 	struct {
 		struct bt_l2cap_pdu_ecred_conn_rsp pdu;
 		uint16_t dcid[5];
-	} __attribute__ ((packed)) rsp;
+	} __packed rsp;
 	uint16_t psm;
 	int num_scid, i = 0;
 
@@ -2640,10 +2640,10 @@ respond:
 static bool l2cap_ecred_conn_rsp(struct bthost *bthost, struct btconn *conn,
 				uint8_t ident, const void *data, uint16_t len)
 {
-	const struct  {
+	const struct __packed {
 		const struct bt_l2cap_pdu_ecred_conn_rsp pdu;
 		uint16_t scid[5];
-	} __attribute__ ((packed)) *rsp = data;
+	} *rsp = data;
 	int num_scid, i;
 	struct l2conn *l2conn;
 
diff --git a/emulator/vhci.c b/emulator/vhci.c
index 1edba8cfcd53..e524de8637a3 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -118,13 +118,13 @@ bool vhci_set_debug(struct vhci *vhci, vhci_debug_func_t callback,
 struct vhci_create_req {
 	uint8_t  pkt_type;
 	uint8_t  opcode;
-} __attribute__((packed));
+} __packed;
 
 struct vhci_create_rsp {
 	uint8_t  pkt_type;
 	uint8_t  opcode;
 	uint16_t index;
-} __attribute__((packed));
+} __packed;
 
 struct vhci *vhci_open(uint8_t type)
 {
diff --git a/monitor/bt.h b/monitor/bt.h
index 2ddf37ccc22f..1a4aa394182d 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -12,12 +12,16 @@
 
 #include <stdint.h>
 
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
+
 #define BT_HCI_CMD_BIT(_byte, _bit) ((8 * _byte) + _bit)
 
 struct bt_ll_hdr {
 	uint8_t  preamble;
 	uint32_t access_addr;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CONN_UPDATE_REQ	0x00
 struct bt_ll_conn_update_req {
@@ -27,18 +31,18 @@ struct bt_ll_conn_update_req {
 	uint16_t latency;
 	uint16_t timeout;
 	uint16_t instant;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CHANNEL_MAP_REQ	0x01
 struct bt_ll_channel_map_req {
 	uint8_t  map[5];
 	uint16_t instant;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_TERMINATE_IND	0x02
 struct bt_ll_terminate_ind {
 	uint8_t  error;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_ENC_REQ		0x03
 struct bt_ll_enc_req {
@@ -46,13 +50,13 @@ struct bt_ll_enc_req {
 	uint16_t ediv;
 	uint64_t skd;
 	uint32_t iv;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_ENC_RSP		0x04
 struct bt_ll_enc_rsp {
 	uint64_t skd;
 	uint32_t iv;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_START_ENC_REQ	0x05
 
@@ -61,17 +65,17 @@ struct bt_ll_enc_rsp {
 #define BT_LL_UNKNOWN_RSP	0x07
 struct bt_ll_unknown_rsp {
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_FEATURE_REQ	0x08
 struct bt_ll_feature_req {
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_FEATURE_RSP	0x09
 struct bt_ll_feature_rsp {
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_PAUSE_ENC_REQ	0x0a
 
@@ -82,17 +86,17 @@ struct bt_ll_version_ind {
 	uint8_t  version;
 	uint16_t company;
 	uint16_t subversion;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_REJECT_IND	0x0d
 struct bt_ll_reject_ind {
 	uint8_t  error;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_PERIPHERAL_FEATURE_REQ	0x0e
 struct bt_ll_peripheral_feature_req {
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CONN_PARAM_REQ	0x0f
 struct bt_ll_conn_param_req {
@@ -108,7 +112,7 @@ struct bt_ll_conn_param_req {
 	uint8_t offset_3;
 	uint8_t offset_4;
 	uint8_t offset_5;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CONN_PARAM_RSP	0x10
 struct bt_ll_conn_param_rsp {
@@ -124,13 +128,13 @@ struct bt_ll_conn_param_rsp {
 	uint8_t offset_3;
 	uint8_t offset_4;
 	uint8_t offset_5;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_REJECT_IND_EXT	0x11
 struct bt_ll_reject_ind_ext {
 	uint8_t  opcode;
 	uint8_t  error;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_PING_REQ		0x12
 
@@ -142,7 +146,7 @@ struct bt_ll_length {
 	uint16_t rx_time;
 	uint16_t tx_len;
 	uint16_t tx_time;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_LENGTH_RSP	0x15
 
@@ -150,7 +154,7 @@ struct bt_ll_length {
 struct bt_ll_phy {
 	uint8_t  tx_phys;
 	uint8_t  rx_phys;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_PHY_RSP		0x17
 
@@ -159,18 +163,18 @@ struct bt_ll_phy_update_ind {
 	uint8_t  c_phy;
 	uint8_t  p_phy;
 	uint16_t instant;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_MIN_USED_CHANNELS	0x19
 struct bt_ll_min_used_channels {
 	uint8_t  phys;
 	uint8_t  min_channels;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CTE_REQ		0x1a
 struct bt_ll_cte_req {
 	uint8_t  cte;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CTE_RSP		0x1b
 
@@ -184,12 +188,12 @@ struct bt_ll_periodic_sync_ind {
 	uint8_t  phy;
 	uint8_t  adv_addr[6];
 	uint16_t sync_counter;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CLOCK_ACCURACY_REQ 0x1d
 struct bt_ll_clock_acc {
 	uint8_t  sca;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CLOCK_ACCURACY_RSP 0x1e
 
@@ -214,14 +218,14 @@ struct bt_ll_cis_req {
 	uint8_t  offset_min[3];
 	uint8_t  offset_max[3];
 	uint16_t conn_event_count;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CIS_RSP		0x20
 struct bt_ll_cis_rsp {
 	uint8_t  offset_min[3];
 	uint8_t  offset_max[3];
 	uint16_t conn_event_count;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CIS_IND		0x21
 struct bt_ll_cis_ind {
@@ -230,97 +234,97 @@ struct bt_ll_cis_ind {
 	uint8_t  cig_sync_delay[3];
 	uint8_t  cis_sync_delay[3];
 	uint16_t conn_event_count;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_CIS_TERMINATE_IND	0x22
 struct bt_ll_cis_term_ind {
 	uint8_t  cig;
 	uint8_t  cis;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_FEATURE_EXT_REQ	0x2b
 struct bt_ll_feature_ext_req {
 	uint8_t  max_page;
 	uint8_t  page;
 	uint8_t  features[24];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LL_FEATURE_EXT_RSP	0x2c
 struct bt_ll_feature_ext_rsp {
 	uint8_t  max_page;
 	uint8_t  page;
 	uint8_t  features[24];
-} __attribute__ ((packed));
+} __packed;
 
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
 struct bt_lmp_name_req {
 	uint8_t  offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_NAME_RSP			2
 struct bt_lmp_name_rsp {
 	uint8_t  offset;
 	uint8_t  length;
 	uint8_t  fragment[14];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_ACCEPTED			3
 struct bt_lmp_accepted {
 	uint8_t  opcode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_NOT_ACCEPTED		4
 struct bt_lmp_not_accepted {
 	uint8_t  opcode;
 	uint8_t  error;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_CLKOFFSET_REQ		5
 
 #define BT_LMP_CLKOFFSET_RSP		6
 struct bt_lmp_clkoffset_rsp {
 	uint16_t offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_DETACH			7
 struct bt_lmp_detach {
 	uint8_t  error;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_AU_RAND			11
 struct bt_lmp_au_rand {
 	uint8_t  number[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_SRES			12
 struct bt_lmp_sres {
 	uint8_t  response[4];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_ENCRYPTION_MODE_REQ	15
 struct bt_lmp_encryption_mode_req {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_ENCRYPTION_KEY_SIZE_REQ	16
 struct bt_lmp_encryption_key_size_req {
 	uint8_t  key_size;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_START_ENCRYPTION_REQ	17
 struct bt_lmp_start_encryption_req {
 	uint8_t  number[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_STOP_ENCRYPTION_REQ	18
 
 #define BT_LMP_SWITCH_REQ		19
 struct bt_lmp_switch_req {
 	uint32_t instant;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_UNSNIFF_REQ		24
 
@@ -333,41 +337,41 @@ struct bt_lmp_switch_req {
 #define BT_LMP_PREFERRED_RATE		36
 struct bt_lmp_preferred_rate {
 	uint8_t  rate;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_VERSION_REQ		37
 struct bt_lmp_version_req {
 	uint8_t  version;
 	uint16_t company;
 	uint16_t subversion;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_VERSION_RES		38
 struct bt_lmp_version_res {
 	uint8_t  version;
 	uint16_t company;
 	uint16_t subversion;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_FEATURES_REQ		39
 struct bt_lmp_features_req {
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_FEATURES_RES		40
 struct bt_lmp_features_res {
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_MAX_SLOT			45
 struct bt_lmp_max_slot {
 	uint8_t  slots;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_MAX_SLOT_REQ		46
 struct bt_lmp_max_slot_req {
 	uint8_t  slots;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_TIMING_ACCURACY_REQ	47
 
@@ -375,7 +379,7 @@ struct bt_lmp_max_slot_req {
 struct bt_lmp_timing_accuracy_res {
 	uint8_t  drift;
 	uint8_t  jitter;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_SETUP_COMPLETE		49
 
@@ -387,13 +391,13 @@ struct bt_lmp_timing_accuracy_res {
 struct bt_lmp_slot_offset {
 	uint16_t offset;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_PAGE_SCAN_MODE_REQ	54
 struct bt_lmp_page_scan_mode_req {
 	uint8_t  scheme;
 	uint8_t  settings;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_TEST_ACTIVATE		56
 
@@ -404,34 +408,34 @@ struct bt_lmp_set_afh {
 	uint32_t instant;
 	uint8_t  mode;
 	uint8_t  map[10];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_ENCAPSULATED_HEADER	61
 struct bt_lmp_encapsulated_header {
 	uint8_t  major;
 	uint8_t  minor;
 	uint8_t  length;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_ENCAPSULATED_PAYLOAD	62
 struct bt_lmp_encapsulated_payload {
 	uint8_t  data[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_SIMPLE_PAIRING_CONFIRM	63
 struct bt_lmp_simple_pairing_confirm {
 	uint8_t  value[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_SIMPLE_PAIRING_NUMBER	64
 struct bt_lmp_simple_pairing_number {
 	uint8_t  value[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_DHKEY_CHECK		65
 struct bt_lmp_dhkey_check {
 	uint8_t  value[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_PAUSE_ENCRYPTION_AES_REQ	66
 
@@ -439,45 +443,45 @@ struct bt_lmp_dhkey_check {
 struct bt_lmp_accepted_ext {
 	uint8_t  escape;
 	uint8_t  opcode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_NOT_ACCEPTED_EXT		LMP_ESC4(2)
 struct bt_lmp_not_accepted_ext {
 	uint8_t  escape;
 	uint8_t  opcode;
 	uint8_t  error;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_FEATURES_REQ_EXT		LMP_ESC4(3)
 struct bt_lmp_features_req_ext {
 	uint8_t  page;
 	uint8_t  max_page;
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_FEATURES_RES_EXT		LMP_ESC4(4)
 struct bt_lmp_features_res_ext {
 	uint8_t  page;
 	uint8_t  max_page;
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_PACKET_TYPE_TABLE_REQ	LMP_ESC4(11)
 struct bt_lmp_packet_type_table_req {
 	uint8_t  table;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_CHANNEL_CLASSIFICATION_REQ	LMP_ESC4(16)
 struct bt_lmp_channel_classification_req {
 	uint8_t  mode;
 	uint16_t min_interval;
 	uint16_t max_interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_CHANNEL_CLASSIFICATION	LMP_ESC4(17)
 struct bt_lmp_channel_classification {
 	uint8_t  classification[10];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_PAUSE_ENCRYPTION_REQ	LMP_ESC4(23)
 
@@ -488,14 +492,14 @@ struct bt_lmp_io_capability_req {
 	uint8_t  capability;
 	uint8_t  oob_data;
 	uint8_t  authentication;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_IO_CAPABILITY_RES	LMP_ESC4(26)
 struct bt_lmp_io_capability_res {
 	uint8_t  capability;
 	uint8_t  oob_data;
 	uint8_t  authentication;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_NUMERIC_COMPARISON_FAILED	LMP_ESC(27)
 
@@ -506,12 +510,12 @@ struct bt_lmp_io_capability_res {
 #define BT_LMP_POWER_CONTROL_REQ	LMP_ESC4(31)
 struct bt_lmp_power_control_req {
 	uint8_t  request;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_POWER_CONTROL_RES	LMP_ESC4(32)
 struct bt_lmp_power_control_res {
 	uint8_t  response;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_LMP_PING_REQ			LMP_ESC4(33)
 
@@ -526,36 +530,36 @@ struct bt_lmp_power_control_res {
 struct bt_hci_cmd_hdr {
 	uint16_t opcode;
 	uint8_t  plen;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_acl_hdr {
 	uint16_t handle;
 	uint16_t dlen;
 	uint8_t  data[];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_sco_hdr {
 	uint16_t handle;
 	uint8_t  dlen;
 	uint8_t  data[];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_iso_hdr {
 	uint16_t handle;
 	uint16_t dlen;
 	uint8_t  data[];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_iso_data_start {
 	uint16_t sn;
 	uint16_t slen;
 	uint8_t  data[];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_evt_hdr {
 	uint8_t  evt;
 	uint8_t  plen;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_NOP				0x0000
 
@@ -564,7 +568,7 @@ struct bt_hci_cmd_inquiry {
 	uint8_t  lap[3];
 	uint8_t  length;
 	uint8_t  num_resp;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_INQUIRY_CANCEL		0x0402
 
@@ -575,7 +579,7 @@ struct bt_hci_cmd_periodic_inquiry {
 	uint8_t  lap[3];
 	uint8_t  length;
 	uint8_t  num_resp;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_EXIT_PERIODIC_INQUIRY	0x0404
 
@@ -587,102 +591,102 @@ struct bt_hci_cmd_create_conn {
 	uint8_t  pscan_mode;
 	uint16_t clock_offset;
 	uint8_t  role_switch;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_DISCONNECT			0x0406
 struct bt_hci_cmd_disconnect {
 	uint16_t handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ADD_SCO_CONN			0x0407
 struct bt_hci_cmd_add_sco_conn {
 	uint16_t handle;
 	uint16_t pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_CREATE_CONN_CANCEL		0x0408
 struct bt_hci_cmd_create_conn_cancel {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_create_conn_cancel {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ACCEPT_CONN_REQUEST		0x0409
 struct bt_hci_cmd_accept_conn_request {
 	uint8_t  bdaddr[6];
 	uint8_t  role;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_REJECT_CONN_REQUEST		0x040a
 struct bt_hci_cmd_reject_conn_request {
 	uint8_t  bdaddr[6];
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LINK_KEY_REQUEST_REPLY	0x040b
 struct bt_hci_cmd_link_key_request_reply {
 	uint8_t  bdaddr[6];
 	uint8_t  link_key[16];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_link_key_request_reply {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LINK_KEY_REQUEST_NEG_REPLY	0x040c
 struct bt_hci_cmd_link_key_request_neg_reply {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_link_key_request_neg_reply {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_PIN_CODE_REQUEST_REPLY	0x040d
 struct bt_hci_cmd_pin_code_request_reply {
 	uint8_t  bdaddr[6];
 	uint8_t  pin_len;
 	uint8_t  pin_code[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_PIN_CODE_REQUEST_NEG_REPLY	0x040e
 struct bt_hci_cmd_pin_code_request_neg_reply {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_pin_code_request_neg_reply {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_CHANGE_CONN_PKT_TYPE		0x040f
 struct bt_hci_cmd_change_conn_pkt_type {
 	uint16_t handle;
 	uint16_t pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_AUTH_REQUESTED		0x0411
 struct bt_hci_cmd_auth_requested {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_CONN_ENCRYPT		0x0413
 struct bt_hci_cmd_set_conn_encrypt {
 	uint16_t handle;
 	uint8_t  encr_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_CHANGE_CONN_LINK_KEY		0x0415
 struct bt_hci_cmd_change_conn_link_key {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LINK_KEY_SELECTION		0x0417
 struct bt_hci_cmd_link_key_selection {
 	uint8_t  key_flag;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_REMOTE_NAME_REQUEST		0x0419
 struct bt_hci_cmd_remote_name_request {
@@ -690,48 +694,48 @@ struct bt_hci_cmd_remote_name_request {
 	uint8_t  pscan_rep_mode;
 	uint8_t  pscan_mode;
 	uint16_t clock_offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_REMOTE_NAME_REQUEST_CANCEL	0x041a
 struct bt_hci_cmd_remote_name_request_cancel {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_remote_name_request_cancel {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_REMOTE_FEATURES		0x041b
 struct bt_hci_cmd_read_remote_features {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_REMOTE_EXT_FEATURES	0x041c
 struct bt_hci_cmd_read_remote_ext_features {
 	uint16_t handle;
 	uint8_t  page;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_REMOTE_VERSION		0x041d
 struct bt_hci_cmd_read_remote_version {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_CLOCK_OFFSET		0x041f
 struct bt_hci_cmd_read_clock_offset {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LMP_HANDLE		0x0420
 struct bt_hci_cmd_read_lmp_handle {
 	uint16_t  handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_lmp_handle {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  lmp_handle;
 	uint32_t reserved;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SETUP_SYNC_CONN		0x0428
 struct bt_hci_cmd_setup_sync_conn {
@@ -742,7 +746,7 @@ struct bt_hci_cmd_setup_sync_conn {
 	uint16_t voice_setting;
 	uint8_t  retrans_effort;
 	uint16_t pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ACCEPT_SYNC_CONN_REQUEST	0x0429
 struct bt_hci_cmd_accept_sync_conn_request {
@@ -753,13 +757,13 @@ struct bt_hci_cmd_accept_sync_conn_request {
 	uint16_t voice_setting;
 	uint8_t  retrans_effort;
 	uint16_t pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_REJECT_SYNC_CONN_REQUEST	0x042a
 struct bt_hci_cmd_reject_sync_conn_request {
 	uint8_t  bdaddr[6];
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_IO_CAPABILITY_REQUEST_REPLY		0x042b
 struct bt_hci_cmd_io_capability_request_reply {
@@ -767,119 +771,119 @@ struct bt_hci_cmd_io_capability_request_reply {
 	uint8_t  capability;
 	uint8_t  oob_data;
 	uint8_t  authentication;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_io_capability_request_reply {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_USER_CONFIRM_REQUEST_REPLY		0x042c
 struct bt_hci_cmd_user_confirm_request_reply {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_user_confirm_request_reply {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_USER_CONFIRM_REQUEST_NEG_REPLY	0x042d
 struct bt_hci_cmd_user_confirm_request_neg_reply {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_user_confirm_request_neg_reply {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_USER_PASSKEY_REQUEST_REPLY		0x042e
 struct bt_hci_cmd_user_passkey_request_reply {
 	uint8_t  bdaddr[6];
 	uint32_t passkey;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_USER_PASSKEY_REQUEST_NEG_REPLY	0x042f
 struct bt_hci_cmd_user_passkey_request_neg_reply {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_REMOTE_OOB_DATA_REQUEST_REPLY	0x0430
 struct bt_hci_cmd_remote_oob_data_request_reply {
 	uint8_t  bdaddr[6];
 	uint8_t  hash[16];
 	uint8_t  randomizer[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_REMOTE_OOB_DATA_REQUEST_NEG_REPLY	0x0433
 struct bt_hci_cmd_remote_oob_data_request_neg_reply {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_IO_CAPABILITY_REQUEST_NEG_REPLY	0x0434
 struct bt_hci_cmd_io_capability_request_neg_reply {
 	uint8_t  bdaddr[6];
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_io_capability_request_neg_reply {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_CREATE_PHY_LINK		0x0435
 struct bt_hci_cmd_create_phy_link {
 	uint8_t  phy_handle;
 	uint8_t  key_len;
 	uint8_t  key_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ACCEPT_PHY_LINK		0x0436
 struct bt_hci_cmd_accept_phy_link {
 	uint8_t  phy_handle;
 	uint8_t  key_len;
 	uint8_t  key_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_DISCONN_PHY_LINK		0x0437
 struct bt_hci_cmd_disconn_phy_link {
 	uint8_t  phy_handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_CREATE_LOGIC_LINK		0x0438
 struct bt_hci_cmd_create_logic_link {
 	uint8_t  phy_handle;
 	uint8_t  tx_flow_spec[16];
 	uint8_t  rx_flow_spec[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ACCEPT_LOGIC_LINK		0x0439
 struct bt_hci_cmd_accept_logic_link {
 	uint8_t  phy_handle;
 	uint8_t  tx_flow_spec[16];
 	uint8_t  rx_flow_spec[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_DISCONN_LOGIC_LINK		0x043a
 struct bt_hci_cmd_disconn_logic_link {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LOGIC_LINK_CANCEL		0x043b
 struct bt_hci_cmd_logic_link_cancel {
 	uint8_t  phy_handle;
 	uint8_t  flow_spec;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_logic_link_cancel {
 	uint8_t  status;
 	uint8_t  phy_handle;
 	uint8_t  flow_spec;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_FLOW_SPEC_MODIFY		0x043c
 struct bt_hci_cmd_flow_spec_modify {
 	uint16_t handle;
 	uint8_t  tx_flow_spec[16];
 	uint8_t  rx_flow_spec[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ENHANCED_SETUP_SYNC_CONN	0x043d
 struct bt_hci_cmd_enhanced_setup_sync_conn {
@@ -907,7 +911,7 @@ struct bt_hci_cmd_enhanced_setup_sync_conn {
 	uint16_t max_latency;
 	uint16_t pkt_type;
 	uint8_t  retrans_effort;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQUEST	0x043e
 struct bt_hci_cmd_enhanced_accept_sync_conn_request {
@@ -935,19 +939,19 @@ struct bt_hci_cmd_enhanced_accept_sync_conn_request {
 	uint16_t max_latency;
 	uint16_t pkt_type;
 	uint8_t  retrans_effort;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_TRUNCATED_PAGE		0x043f
 struct bt_hci_cmd_truncated_page {
 	uint8_t  bdaddr[6];
 	uint8_t  pscan_rep_mode;
 	uint16_t clock_offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_TRUNCATED_PAGE_CANCEL	0x0440
 struct bt_hci_cmd_truncated_page_cancel {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST	0x0441
 struct bt_hci_cmd_set_peripheral_broadcast {
@@ -958,12 +962,12 @@ struct bt_hci_cmd_set_peripheral_broadcast {
 	uint16_t min_interval;
 	uint16_t max_interval;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_set_peripheral_broadcast {
 	uint8_t  status;
 	uint8_t  lt_addr;
 	uint16_t interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_RECEIVE	0x0442
 struct bt_hci_cmd_set_peripheral_broadcast_receive {
@@ -978,12 +982,12 @@ struct bt_hci_cmd_set_peripheral_broadcast_receive {
 	uint8_t  skip;
 	uint16_t pkt_type;
 	uint8_t  map[10];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_set_peripheral_broadcast_receive {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_START_SYNC_TRAIN		0x0443
 
@@ -993,7 +997,7 @@ struct bt_hci_cmd_receive_sync_train {
 	uint16_t timeout;
 	uint16_t window;
 	uint16_t interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_REMOTE_OOB_EXT_DATA_REQUEST_REPLY	0x0445
 struct bt_hci_cmd_remote_oob_ext_data_request_reply {
@@ -1002,14 +1006,14 @@ struct bt_hci_cmd_remote_oob_ext_data_request_reply {
 	uint8_t  randomizer192[16];
 	uint8_t  hash256[16];
 	uint8_t  randomizer256[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_HOLD_MODE			0x0801
 struct bt_hci_cmd_hold_mode {
 	uint16_t handle;
 	uint16_t max_interval;
 	uint16_t min_interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SNIFF_MODE			0x0803
 struct bt_hci_cmd_sniff_mode {
@@ -1018,24 +1022,24 @@ struct bt_hci_cmd_sniff_mode {
 	uint16_t min_interval;
 	uint16_t attempt;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_EXIT_SNIFF_MODE		0x0804
 struct bt_hci_cmd_exit_sniff_mode {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_PARK_STATE			0x0805
 struct bt_hci_cmd_park_state {
 	uint16_t handle;
 	uint16_t max_interval;
 	uint16_t min_interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_EXIT_PARK_STATE		0x0806
 struct bt_hci_cmd_exit_park_state {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_QOS_SETUP			0x0807
 struct bt_hci_cmd_qos_setup {
@@ -1046,54 +1050,54 @@ struct bt_hci_cmd_qos_setup {
 	uint32_t peak_bandwidth;
 	uint32_t latency;
 	uint32_t delay_variation;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ROLE_DISCOVERY		0x0809
 struct bt_hci_cmd_role_discovery {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_role_discovery {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  role;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SWITCH_ROLE			0x080b
 struct bt_hci_cmd_switch_role {
 	uint8_t  bdaddr[6];
 	uint8_t  role;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LINK_POLICY		0x080c
 struct bt_hci_cmd_read_link_policy {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_link_policy {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t policy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_LINK_POLICY		0x080d
 struct bt_hci_cmd_write_link_policy {
 	uint16_t handle;
 	uint16_t policy;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_write_link_policy {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_DEFAULT_LINK_POLICY	0x080e
 struct bt_hci_rsp_read_default_link_policy {
 	uint8_t  status;
 	uint16_t policy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_DEFAULT_LINK_POLICY	0x080f
 struct bt_hci_cmd_write_default_link_policy {
 	uint16_t policy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_FLOW_SPEC			0x0810
 struct bt_hci_cmd_flow_spec {
@@ -1105,7 +1109,7 @@ struct bt_hci_cmd_flow_spec {
 	uint32_t token_bucket_size;
 	uint32_t peak_bandwidth;
 	uint32_t access_latency;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SNIFF_SUBRATING		0x0811
 struct bt_hci_cmd_sniff_subrating {
@@ -1113,16 +1117,16 @@ struct bt_hci_cmd_sniff_subrating {
 	uint16_t max_latency;
 	uint16_t min_remote_timeout;
 	uint16_t min_local_timeout;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_sniff_subrating {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_EVENT_MASK		0x0c01
 struct bt_hci_cmd_set_event_mask {
 	uint8_t  mask[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_RESET			0x0c03
 
@@ -1131,27 +1135,27 @@ struct bt_hci_cmd_set_event_filter {
 	uint8_t  type;
 	uint8_t  cond_type;
 	uint8_t  cond[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_FLUSH			0x0c08
 struct bt_hci_cmd_flush {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_flush {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_PIN_TYPE		0x0c09
 struct bt_hci_rsp_read_pin_type {
 	uint8_t  status;
 	uint8_t  pin_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_PIN_TYPE		0x0c0a
 struct bt_hci_cmd_write_pin_type {
 	uint8_t  pin_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_CREATE_NEW_UNIT_KEY		0x0c0b
 
@@ -1159,214 +1163,214 @@ struct bt_hci_cmd_write_pin_type {
 struct bt_hci_cmd_read_stored_link_key {
 	uint8_t  bdaddr[6];
 	uint8_t  read_all;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_stored_link_key {
 	uint8_t  status;
 	uint16_t max_num_keys;
 	uint16_t num_keys;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_STORED_LINK_KEY	0x0c11
 struct bt_hci_cmd_write_stored_link_key {
 	uint8_t  num_keys;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_write_stored_link_key {
 	uint8_t  status;
 	uint8_t  num_keys;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_DELETE_STORED_LINK_KEY	0x0c12
 struct bt_hci_cmd_delete_stored_link_key {
 	uint8_t  bdaddr[6];
 	uint8_t  delete_all;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_delete_stored_link_key {
 	uint8_t  status;
 	uint16_t num_keys;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_LOCAL_NAME		0x0c13
 struct bt_hci_cmd_write_local_name {
 	uint8_t  name[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_NAME		0x0c14
 struct bt_hci_rsp_read_local_name {
 	uint8_t  status;
 	uint8_t  name[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_CONN_ACCEPT_TIMEOUT	0x0c15
 struct bt_hci_rsp_read_conn_accept_timeout {
 	uint8_t  status;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_CONN_ACCEPT_TIMEOUT	0x0c16
 struct bt_hci_cmd_write_conn_accept_timeout {
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_PAGE_TIMEOUT		0x0c17
 struct bt_hci_rsp_read_page_timeout {
 	uint8_t  status;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_PAGE_TIMEOUT		0x0c18
 struct bt_hci_cmd_write_page_timeout {
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_SCAN_ENABLE		0x0c19
 struct bt_hci_rsp_read_scan_enable {
 	uint8_t  status;
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_SCAN_ENABLE		0x0c1a
 struct bt_hci_cmd_write_scan_enable {
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_PAGE_SCAN_ACTIVITY	0x0c1b
 struct bt_hci_rsp_read_page_scan_activity {
 	uint8_t  status;
 	uint16_t interval;
 	uint16_t window;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_PAGE_SCAN_ACTIVITY	0x0c1c
 struct bt_hci_cmd_write_page_scan_activity {
 	uint16_t interval;
 	uint16_t window;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_INQUIRY_SCAN_ACTIVITY	0x0c1d
 struct bt_hci_rsp_read_inquiry_scan_activity {
 	uint8_t  status;
 	uint16_t interval;
 	uint16_t window;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_INQUIRY_SCAN_ACTIVITY	0x0c1e
 struct bt_hci_cmd_write_inquiry_scan_activity {
 	uint16_t interval;
 	uint16_t window;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_AUTH_ENABLE		0x0c1f
 struct bt_hci_rsp_read_auth_enable {
 	uint8_t  status;
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_AUTH_ENABLE		0x0c20
 struct bt_hci_cmd_write_auth_enable {
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_ENCRYPT_MODE		0x0c21
 struct bt_hci_rsp_read_encrypt_mode {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_ENCRYPT_MODE		0x0c22
 struct bt_hci_cmd_write_encrypt_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_CLASS_OF_DEV		0x0c23
 struct bt_hci_rsp_read_class_of_dev {
 	uint8_t  status;
 	uint8_t  dev_class[3];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_CLASS_OF_DEV		0x0c24
 struct bt_hci_cmd_write_class_of_dev {
 	uint8_t  dev_class[3];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_VOICE_SETTING		0x0c25
 struct bt_hci_rsp_read_voice_setting {
 	uint8_t  status;
 	uint16_t setting;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_VOICE_SETTING		0x0c26
 struct bt_hci_cmd_write_voice_setting {
 	uint16_t setting;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_AUTO_FLUSH_TIMEOUT	0x0c27
 struct bt_hci_cmd_read_auto_flush_timeout {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_auto_flush_timeout {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_AUTO_FLUSH_TIMEOUT	0x0c28
 struct bt_hci_cmd_write_auto_flush_timeout {
 	uint16_t handle;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_write_auto_flush_timeout {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_NUM_BROADCAST_RETRANS	0x0c29
 struct bt_hci_rsp_read_num_broadcast_retrans {
 	uint8_t  status;
 	uint8_t  num_retrans;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_NUM_BROADCAST_RETRANS	0x0c2a
 struct bt_hci_cmd_write_num_broadcast_retrans {
 	uint8_t  num_retrans;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_HOLD_MODE_ACTIVITY	0x0c2b
 struct bt_hci_rsp_read_hold_mode_activity {
 	uint8_t  status;
 	uint8_t  activity;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_HOLD_MODE_ACTIVITY	0x0c2c
 struct bt_hci_cmd_write_hold_mode_activity {
 	uint8_t  activity;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_TX_POWER		0x0c2d
 struct bt_hci_cmd_read_tx_power {
 	uint16_t handle;
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_tx_power {
 	uint8_t  status;
 	uint16_t handle;
 	int8_t   level;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_SYNC_FLOW_CONTROL	0x0c2e
 struct bt_hci_rsp_read_sync_flow_control {
 	uint8_t  status;
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_SYNC_FLOW_CONTROL	0x0c2f
 struct bt_hci_cmd_write_sync_flow_control {
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_HOST_FLOW_CONTROL	0x0c31
 struct bt_hci_cmd_set_host_flow_control {
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_HOST_BUFFER_SIZE		0x0c33
 struct bt_hci_cmd_host_buffer_size {
@@ -1374,203 +1378,203 @@ struct bt_hci_cmd_host_buffer_size {
 	uint8_t  sco_mtu;
 	uint16_t acl_max_pkt;
 	uint16_t sco_max_pkt;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_HOST_NUM_COMPLETED_PACKETS	0x0c35
 struct bt_hci_cmd_host_num_completed_packets {
 	uint8_t  num_handles;
 	uint16_t handle;
 	uint16_t count;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LINK_SUPV_TIMEOUT	0x0c36
 struct bt_hci_cmd_read_link_supv_timeout {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_link_supv_timeout {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_LINK_SUPV_TIMEOUT	0x0c37
 struct bt_hci_cmd_write_link_supv_timeout {
 	uint16_t handle;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_write_link_supv_timeout {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_NUM_SUPPORTED_IAC	0x0c38
 struct bt_hci_rsp_read_num_supported_iac {
 	uint8_t  status;
 	uint8_t  num_iac;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_CURRENT_IAC_LAP		0x0c39
 struct bt_hci_rsp_read_current_iac_lap {
 	uint8_t  status;
 	uint8_t  num_iac;
 	uint8_t  iac_lap[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_CURRENT_IAC_LAP	0x0c3a
 struct bt_hci_cmd_write_current_iac_lap {
 	uint8_t  num_iac;
 	uint8_t  iac_lap[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_PAGE_SCAN_PERIOD_MODE	0x0c3b
 struct bt_hci_rsp_read_page_scan_period_mode {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_PAGE_SCAN_PERIOD_MODE	0x0c3c
 struct bt_hci_cmd_write_page_scan_period_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_PAGE_SCAN_MODE		0x0c3d
 struct bt_hci_rsp_read_page_scan_mode {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_PAGE_SCAN_MODE		0x0c3e
 struct bt_hci_cmd_write_page_scan_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_AFH_HOST_CLASSIFICATION	0x0c3f
 struct bt_hci_cmd_set_afh_host_classification {
 	uint8_t  map[10];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_INQUIRY_SCAN_TYPE	0x0c42
 struct bt_hci_rsp_read_inquiry_scan_type {
 	uint8_t  status;
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_INQUIRY_SCAN_TYPE	0x0c43
 struct bt_hci_cmd_write_inquiry_scan_type {
 	uint8_t type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_INQUIRY_MODE		0x0c44
 struct bt_hci_rsp_read_inquiry_mode {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_INQUIRY_MODE		0x0c45
 struct bt_hci_cmd_write_inquiry_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_PAGE_SCAN_TYPE		0x0c46
 struct bt_hci_rsp_read_page_scan_type {
 	uint8_t status;
 	uint8_t type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_PAGE_SCAN_TYPE		0x0c47
 struct bt_hci_cmd_write_page_scan_type {
 	uint8_t type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_AFH_ASSESSMENT_MODE	0x0c48
 struct bt_hci_rsp_read_afh_assessment_mode {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_AFH_ASSESSMENT_MODE	0x0c49
 struct bt_hci_cmd_write_afh_assessment_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_EXT_INQUIRY_RESPONSE	0x0c51
 struct bt_hci_rsp_read_ext_inquiry_response {
 	uint8_t  status;
 	uint8_t  fec;
 	uint8_t  data[240];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_EXT_INQUIRY_RESPONSE	0x0c52
 struct bt_hci_cmd_write_ext_inquiry_response {
 	uint8_t  fec;
 	uint8_t  data[240];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_REFRESH_ENCRYPT_KEY		0x0c53
 struct bt_hci_cmd_refresh_encrypt_key {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_SIMPLE_PAIRING_MODE	0x0c55
 struct bt_hci_rsp_read_simple_pairing_mode {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_SIMPLE_PAIRING_MODE	0x0c56
 struct bt_hci_cmd_write_simple_pairing_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_OOB_DATA		0x0c57
 struct bt_hci_rsp_read_local_oob_data {
 	uint8_t  status;
 	uint8_t  hash[16];
 	uint8_t  randomizer[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_INQUIRY_RESP_TX_POWER	0x0c58
 struct bt_hci_rsp_read_inquiry_resp_tx_power {
 	uint8_t  status;
 	int8_t   level;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_INQUIRY_TX_POWER	0x0c59
 struct bt_hci_cmd_write_inquiry_tx_power {
 	int8_t   level;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_ERRONEOUS_REPORTING	0x0c5a
 struct bt_hci_rsp_read_erroneous_reporting {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_ERRONEOUS_REPORTING	0x0c5b
 struct bt_hci_cmd_write_erroneous_reporting {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ENHANCED_FLUSH		0x0c5f
 struct bt_hci_cmd_enhanced_flush {
 	uint16_t handle;
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SEND_KEYPRESS_NOTIFY		0x0c60
 struct bt_hci_cmd_send_keypress_notify {
 	uint8_t  bdaddr[6];
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_send_keypress_notify {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_EVENT_MASK_PAGE2		0x0c63
 struct bt_hci_cmd_set_event_mask_page2 {
 	uint8_t  mask[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCATION_DATA		0x0c64
 struct bt_hci_rsp_read_location_data {
@@ -1579,7 +1583,7 @@ struct bt_hci_rsp_read_location_data {
 	uint8_t  domain[2];
 	uint8_t  domain_options;
 	uint8_t  options;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_LOCATION_DATA		0x0c65
 struct bt_hci_cmd_write_location_data {
@@ -1587,79 +1591,79 @@ struct bt_hci_cmd_write_location_data {
 	uint8_t  domain[2];
 	uint8_t  domain_options;
 	uint8_t  options;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_FLOW_CONTROL_MODE	0x0c66
 struct bt_hci_rsp_read_flow_control_mode {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_FLOW_CONTROL_MODE	0x0c67
 struct bt_hci_cmd_write_flow_control_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_ENHANCED_TX_POWER	0x0c68
 struct bt_hci_cmd_read_enhanced_tx_power {
 	uint16_t handle;
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_enhanced_tx_power {
 	uint8_t  status;
 	uint16_t handle;
 	int8_t   level_gfsk;
 	int8_t   level_dqpsk;
 	int8_t   level_8dpsk;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SHORT_RANGE_MODE		0x0c6b
 struct bt_hci_cmd_short_range_mode {
 	uint8_t  phy_handle;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LE_HOST_SUPPORTED	0x0c6c
 struct bt_hci_rsp_read_le_host_supported {
 	uint8_t  status;
 	uint8_t  supported;
 	uint8_t  simultaneous;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED	0x0c6d
 struct bt_hci_cmd_write_le_host_supported {
 	uint8_t  supported;
 	uint8_t  simultaneous;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_RESERVED_LT_ADDR		0x0c74
 struct bt_hci_cmd_set_reserved_lt_addr {
 	uint8_t  lt_addr;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_set_reserved_lt_addr {
 	uint8_t  status;
 	uint8_t  lt_addr;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_DELETE_RESERVED_LT_ADDR	0x0c75
 struct bt_hci_cmd_delete_reserved_lt_addr {
 	uint8_t  lt_addr;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_delete_reserved_lt_addr {
 	uint8_t  status;
 	uint8_t  lt_addr;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_PERIPHERAL_BROADCAST_DATA	0x0c76
 struct bt_hci_cmd_set_peripheral_broadcast_data {
 	uint8_t  lt_addr;
 	uint8_t  fragment;
 	uint8_t  length;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_set_peripheral_broadcast_data {
 	uint8_t  status;
 	uint8_t  lt_addr;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_SYNC_TRAIN_PARAMS	0x0c77
 struct bt_hci_rsp_read_sync_train_params {
@@ -1667,7 +1671,7 @@ struct bt_hci_rsp_read_sync_train_params {
 	uint16_t interval;
 	uint32_t timeout;
 	uint8_t  service_data;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_SYNC_TRAIN_PARAMS	0x0c78
 struct bt_hci_cmd_write_sync_train_params {
@@ -1675,42 +1679,42 @@ struct bt_hci_cmd_write_sync_train_params {
 	uint16_t max_interval;
 	uint32_t timeout;
 	uint8_t  service_data;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_write_sync_train_params {
 	uint8_t  status;
 	uint16_t interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_SECURE_CONN_SUPPORT	0x0c79
 struct bt_hci_rsp_read_secure_conn_support {
 	uint8_t  status;
 	uint8_t  support;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_SECURE_CONN_SUPPORT	0x0c7a
 struct bt_hci_cmd_write_secure_conn_support {
 	uint8_t support;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_AUTH_PAYLOAD_TIMEOUT	0x0c7b
 struct bt_hci_cmd_read_auth_payload_timeout {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_auth_payload_timeout {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_AUTH_PAYLOAD_TIMEOUT	0x0c7c
 struct bt_hci_cmd_write_auth_payload_timeout {
 	uint16_t handle;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_write_auth_payload_timeout {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA	0x0c7d
 struct bt_hci_rsp_read_local_oob_ext_data {
@@ -1719,29 +1723,29 @@ struct bt_hci_rsp_read_local_oob_ext_data {
 	uint8_t  randomizer192[16];
 	uint8_t  hash256[16];
 	uint8_t  randomizer256[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_EXT_PAGE_TIMEOUT	0x0c7e
 struct bt_hci_rsp_read_ext_page_timeout {
 	uint8_t  status;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_EXT_PAGE_TIMEOUT	0x0c7f
 struct bt_hci_cmd_write_ext_page_timeout {
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_EXT_INQUIRY_LENGTH	0x0c80
 struct bt_hci_rsp_read_ext_inquiry_length {
 	uint8_t  status;
 	uint16_t interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_EXT_INQUIRY_LENGTH	0x0c81
 struct bt_hci_cmd_write_ext_inquiry_length {
 	uint16_t interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_CONFIG_DATA_PATH		0x0c83
 #define BT_HCI_BIT_CONFIG_DATA_PATH		BT_HCI_CMD_BIT(45, 5)
@@ -1750,7 +1754,7 @@ struct bt_hci_cmd_config_data_path {
 	uint8_t  id;
 	uint8_t  vnd_config_len;
 	uint8_t  vnd_config[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_VERSION		0x1001
 struct bt_hci_rsp_read_local_version {
@@ -1760,30 +1764,30 @@ struct bt_hci_rsp_read_local_version {
 	uint8_t  lmp_ver;
 	uint16_t manufacturer;
 	uint16_t lmp_subver;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_COMMANDS		0x1002
 struct bt_hci_rsp_read_local_commands {
 	uint8_t  status;
 	uint8_t  commands[64];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_FEATURES		0x1003
 struct bt_hci_rsp_read_local_features {
 	uint8_t  status;
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_EXT_FEATURES	0x1004
 struct bt_hci_cmd_read_local_ext_features {
 	uint8_t  page;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_local_ext_features {
 	uint8_t  status;
 	uint8_t  page;
 	uint8_t  max_page;
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_BUFFER_SIZE		0x1005
 struct bt_hci_rsp_read_buffer_size {
@@ -1792,19 +1796,19 @@ struct bt_hci_rsp_read_buffer_size {
 	uint8_t  sco_mtu;
 	uint16_t acl_max_pkt;
 	uint16_t sco_max_pkt;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_COUNTRY_CODE		0x1007
 struct bt_hci_rsp_read_country_code {
 	uint8_t  status;
 	uint8_t  code;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_BD_ADDR			0x1009
 struct bt_hci_rsp_read_bd_addr {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_DATA_BLOCK_SIZE		0x100a
 struct bt_hci_rsp_read_data_block_size {
@@ -1812,21 +1816,21 @@ struct bt_hci_rsp_read_data_block_size {
 	uint16_t max_acl_len;
 	uint16_t block_len;
 	uint16_t num_blocks;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_CODECS		0x100b
 struct bt_hci_rsp_read_local_codecs {
 	uint8_t  status;
 	uint8_t  num_codecs;
 	uint8_t  codec[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_PAIRING_OPTIONS	0x100c
 struct bt_hci_rsp_read_local_pairing_options {
 	uint8_t  status;
 	uint8_t  pairing_options;
 	uint8_t  max_key_size;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_CODECS_V2		0x100d
 #define BT_HCI_BIT_READ_LOCAL_CODECS_V2		BT_HCI_CMD_BIT(45, 2)
@@ -1839,43 +1843,43 @@ struct bt_hci_vnd_codec_v2 {
 	uint16_t cid;
 	uint16_t vid;
 	uint8_t  transport;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_vnd_codec {
 	uint8_t  id;
 	uint16_t cid;
 	uint16_t vid;
 	uint8_t  transport;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_codec {
 	uint8_t  id;
 	uint8_t  transport;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_read_local_codecs_v2 {
 	uint8_t  status;
 	uint8_t  num_codecs;
 	struct bt_hci_codec codec[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_CODEC_CAPS	0x100e
 #define BT_HCI_BIT_READ_LOCAL_CODEC_CAPS	BT_HCI_CMD_BIT(45, 3)
 struct bt_hci_cmd_read_local_codec_caps {
 	struct bt_hci_vnd_codec codec;
 	uint8_t  dir;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_codec_caps {
 	uint8_t  len;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_read_local_codec_caps {
 	uint8_t  status;
 	uint8_t  num;
 	struct bt_hci_codec_caps caps[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_CTRL_DELAY	0x100f
 #define BT_HCI_BIT_READ_LOCAL_CTRL_DELAY	BT_HCI_CMD_BIT(45, 4)
@@ -1884,85 +1888,85 @@ struct bt_hci_cmd_read_local_ctrl_delay {
 	uint8_t  dir;
 	uint8_t  codec_cfg_len;
 	uint8_t  codec_cfg[0];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_read_local_ctrl_delay {
 	uint8_t  status;
 	uint8_t  min_delay[3];
 	uint8_t  max_delay[3];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_FAILED_CONTACT_COUNTER	0x1401
 struct bt_hci_cmd_read_failed_contact_counter {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_failed_contact_counter {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t counter;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_RESET_FAILED_CONTACT_COUNTER	0x1402
 struct bt_hci_cmd_reset_failed_contact_counter {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_reset_failed_contact_counter {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LINK_QUALITY		0x1403
 struct bt_hci_cmd_read_link_quality {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_link_quality {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  link_quality;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_RSSI			0x1405
 struct bt_hci_cmd_read_rssi {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_rssi {
 	uint8_t  status;
 	uint16_t handle;
 	int8_t   rssi;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_AFH_CHANNEL_MAP		0x1406
 struct bt_hci_cmd_read_afh_channel_map {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_afh_channel_map {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  mode;
 	uint8_t  map[10];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_CLOCK			0x1407
 struct bt_hci_cmd_read_clock {
 	uint16_t handle;
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_clock {
 	uint8_t  status;
 	uint16_t handle;
 	uint32_t clock;
 	uint16_t accuracy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_ENCRYPT_KEY_SIZE	0x1408
 struct bt_hci_cmd_read_encrypt_key_size {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_encrypt_key_size {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  key_size;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_AMP_INFO		0x1409
 struct bt_hci_rsp_read_local_amp_info {
@@ -1977,20 +1981,20 @@ struct bt_hci_rsp_read_local_amp_info {
 	uint16_t max_assoc_len;
 	uint32_t max_flush_to;
 	uint32_t be_flush_to;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOCAL_AMP_ASSOC		0x140a
 struct bt_hci_cmd_read_local_amp_assoc {
 	uint8_t  phy_handle;
 	uint16_t len_so_far;
 	uint16_t max_assoc_len;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_read_local_amp_assoc {
 	uint8_t  status;
 	uint8_t  phy_handle;
 	uint16_t remain_assoc_len;
 	uint8_t  assoc_fragment[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_REMOTE_AMP_ASSOC	0x140b
 struct bt_hci_cmd_write_remote_amp_assoc {
@@ -1998,18 +2002,18 @@ struct bt_hci_cmd_write_remote_amp_assoc {
 	uint16_t len_so_far;
 	uint16_t remain_assoc_len;
 	uint8_t  assoc_fragment[248];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_write_remote_amp_assoc {
 	uint8_t  status;
 	uint8_t  phy_handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_GET_MWS_TRANSPORT_CONFIG	0x140c
 struct bt_hci_rsp_get_mws_transport_config {
 	uint8_t  status;
 	uint8_t  num_transports;
 	uint8_t  transport[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_TRIGGERED_CLOCK_CAPTURE	0x140d
 struct bt_hci_cmd_set_triggered_clock_capture {
@@ -2018,48 +2022,48 @@ struct bt_hci_cmd_set_triggered_clock_capture {
 	uint8_t  type;
 	uint8_t  lpo_allowed;
 	uint8_t  num_filter;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_READ_LOOPBACK_MODE		0x1801
 struct bt_hci_rsp_read_loopback_mode {
 	uint8_t  status;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_WRITE_LOOPBACK_MODE		0x1802
 struct bt_hci_cmd_write_loopback_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_ENABLE_DUT_MODE		0x1803
 
 #define BT_HCI_CMD_WRITE_SSP_DEBUG_MODE		0x1804
 struct bt_hci_cmd_write_ssp_debug_mode {
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_EVENT_MASK		0x2001
 struct bt_hci_cmd_le_set_event_mask {
 	uint8_t  mask[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_BUFFER_SIZE		0x2002
 struct bt_hci_rsp_le_read_buffer_size {
 	uint8_t  status;
         uint16_t le_mtu;
         uint8_t  le_max_pkt;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_LOCAL_FEATURES	0x2003
 struct bt_hci_rsp_le_read_local_features {
 	uint8_t  status;
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_RANDOM_ADDRESS	0x2005
 struct bt_hci_cmd_le_set_random_address {
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_ADV_PARAMETERS	0x2006
 struct bt_hci_cmd_le_set_adv_parameters {
@@ -2071,30 +2075,30 @@ struct bt_hci_cmd_le_set_adv_parameters {
 	uint8_t  direct_addr[6];
 	uint8_t  channel_map;
 	uint8_t  filter_policy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_ADV_TX_POWER		0x2007
 struct bt_hci_rsp_le_read_adv_tx_power {
 	uint8_t  status;
 	int8_t   level;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_ADV_DATA		0x2008
 struct bt_hci_cmd_le_set_adv_data {
 	uint8_t  len;
 	uint8_t  data[31];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_SCAN_RSP_DATA		0x2009
 struct bt_hci_cmd_le_set_scan_rsp_data {
 	uint8_t  len;
 	uint8_t  data[31];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_ADV_ENABLE		0x200a
 struct bt_hci_cmd_le_set_adv_enable {
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_SCAN_PARAMETERS	0x200b
 struct bt_hci_cmd_le_set_scan_parameters {
@@ -2103,13 +2107,13 @@ struct bt_hci_cmd_le_set_scan_parameters {
 	uint16_t window;
 	uint8_t  own_addr_type;
 	uint8_t  filter_policy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_SCAN_ENABLE		0x200c
 struct bt_hci_cmd_le_set_scan_enable {
 	uint8_t  enable;
 	uint8_t  filter_dup;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CREATE_CONN		0x200d
 struct bt_hci_cmd_le_create_conn {
@@ -2125,7 +2129,7 @@ struct bt_hci_cmd_le_create_conn {
 	uint16_t supv_timeout;
 	uint16_t min_length;
 	uint16_t max_length;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CREATE_CONN_CANCEL	0x200e
 
@@ -2133,7 +2137,7 @@ struct bt_hci_cmd_le_create_conn {
 struct bt_hci_rsp_le_read_accept_list_size {
 	uint8_t  status;
 	uint8_t  size;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST		0x2010
 
@@ -2141,13 +2145,13 @@ struct bt_hci_rsp_le_read_accept_list_size {
 struct bt_hci_cmd_le_add_to_accept_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST	0x2012
 struct bt_hci_cmd_le_remove_from_accept_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CONN_UPDATE		0x2013
 struct bt_hci_cmd_le_conn_update {
@@ -2158,43 +2162,43 @@ struct bt_hci_cmd_le_conn_update {
 	uint16_t supv_timeout;
 	uint16_t min_length;
 	uint16_t max_length;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_HOST_CLASSIFICATION	0x2014
 struct bt_hci_cmd_le_set_host_classification {
 	uint8_t  map[5];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_CHANNEL_MAP		0x2015
 struct bt_hci_cmd_le_read_channel_map {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_read_channel_map {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  map[5];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_REMOTE_FEATURES	0x2016
 struct bt_hci_cmd_le_read_remote_features {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_ENCRYPT			0x2017
 struct bt_hci_cmd_le_encrypt {
 	uint8_t  key[16];
 	uint8_t  plaintext[16];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_encrypt {
 	uint8_t  status;
 	uint8_t  data[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_RAND			0x2018
 struct bt_hci_rsp_le_rand {
 	uint8_t  status;
 	uint64_t number;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_START_ENCRYPT		0x2019
 struct bt_hci_cmd_le_start_encrypt {
@@ -2202,50 +2206,50 @@ struct bt_hci_cmd_le_start_encrypt {
 	uint64_t rand;
 	uint16_t ediv;
 	uint8_t  ltk[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_LTK_REQ_REPLY		0x201a
 struct bt_hci_cmd_le_ltk_req_reply {
 	uint16_t handle;
 	uint8_t  ltk[16];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_ltk_req_reply {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_LTK_REQ_NEG_REPLY		0x201b
 struct bt_hci_cmd_le_ltk_req_neg_reply {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_ltk_req_neg_reply {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_SUPPORTED_STATES	0x201c
 struct bt_hci_rsp_le_read_supported_states {
 	uint8_t  status;
 	uint8_t  states[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_RECEIVER_TEST		0x201d
 struct bt_hci_cmd_le_receiver_test {
 	uint8_t  frequency;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_TRANSMITTER_TEST		0x201e
 struct bt_hci_cmd_le_transmitter_test {
 	uint8_t  frequency;
 	uint8_t  data_len;
 	uint8_t  payload;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_TEST_END			0x201f
 struct bt_hci_rsp_le_test_end {
 	uint8_t  status;
 	uint16_t num_packets;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CONN_PARAM_REQ_REPLY	0x2020
 struct bt_hci_cmd_le_conn_param_req_reply {
@@ -2256,52 +2260,52 @@ struct bt_hci_cmd_le_conn_param_req_reply {
 	uint16_t supv_timeout;
 	uint16_t min_length;
 	uint16_t max_length;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_conn_param_req_reply {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CONN_PARAM_REQ_NEG_REPLY	0x2021
 struct bt_hci_cmd_le_conn_param_req_neg_reply {
 	uint16_t handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_conn_param_req_neg_reply {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_DATA_LENGTH		0x2022
 struct bt_hci_cmd_le_set_data_length {
 	uint16_t handle;
 	uint16_t tx_len;
 	uint16_t tx_time;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_set_data_length {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_DEFAULT_DATA_LENGTH	0x2023
 struct bt_hci_rsp_le_read_default_data_length {
 	uint8_t  status;
 	uint16_t tx_len;
 	uint16_t tx_time;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_WRITE_DEFAULT_DATA_LENGTH	0x2024
 struct bt_hci_cmd_le_write_default_data_length {
 	uint16_t tx_len;
 	uint16_t tx_time;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_LOCAL_PK256		0x2025
 
 #define BT_HCI_CMD_LE_GENERATE_DHKEY		0x2026
 struct bt_hci_cmd_le_generate_dhkey {
 	uint8_t  remote_pk256[64];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_ADD_TO_RESOLV_LIST	0x2027
 struct bt_hci_cmd_le_add_to_resolv_list {
@@ -2309,13 +2313,13 @@ struct bt_hci_cmd_le_add_to_resolv_list {
 	uint8_t  addr[6];
 	uint8_t  peer_irk[16];
 	uint8_t  local_irk[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST	0x2028
 struct bt_hci_cmd_le_remove_from_resolv_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CLEAR_RESOLV_LIST		0x2029
 
@@ -2323,37 +2327,37 @@ struct bt_hci_cmd_le_remove_from_resolv_list {
 struct bt_hci_rsp_le_read_resolv_list_size {
 	uint8_t  status;
 	uint8_t  size;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_PEER_RESOLV_ADDR	0x202b
 struct bt_hci_cmd_le_read_peer_resolv_addr {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_read_peer_resolv_addr {
 	uint8_t  status;
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_LOCAL_RESOLV_ADDR	0x202c
 struct bt_hci_cmd_le_read_local_resolv_addr {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_read_local_resolv_addr {
 	uint8_t  status;
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_RESOLV_ENABLE		0x202d
 struct bt_hci_cmd_le_set_resolv_enable {
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_RESOLV_TIMEOUT	0x202e
 struct bt_hci_cmd_le_set_resolv_timeout {
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_MAX_DATA_LENGTH	0x202f
 struct bt_hci_rsp_le_read_max_data_length {
@@ -2362,25 +2366,25 @@ struct bt_hci_rsp_le_read_max_data_length {
 	uint16_t max_tx_time;
 	uint16_t max_rx_len;
 	uint16_t max_rx_time;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_PHY			0x2030
 struct bt_hci_cmd_le_read_phy {
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 struct bt_hci_rsp_le_read_phy {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  tx_phy;
 	uint8_t  rx_phy;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_DEFAULT_PHY		0x2031
 struct bt_hci_cmd_le_set_default_phy {
 	uint8_t  all_phys;
 	uint8_t  tx_phys;
 	uint8_t  rx_phys;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_PHY			0x2032
 struct bt_hci_cmd_le_set_phy {
@@ -2389,14 +2393,14 @@ struct bt_hci_cmd_le_set_phy {
 	uint8_t  tx_phys;
 	uint8_t  rx_phys;
 	uint16_t phy_opts;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_ENHANCED_RECEIVER_TEST			0x2033
 struct bt_hci_cmd_le_enhanced_receiver_test {
 	uint8_t rx_channel;
 	uint8_t phy;
 	uint8_t modulation_index;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_ENHANCED_TRANSMITTER_TEST			0x2034
 struct bt_hci_cmd_le_enhanced_transmitter_test {
@@ -2404,13 +2408,13 @@ struct bt_hci_cmd_le_enhanced_transmitter_test {
 	uint8_t data_len;
 	uint8_t payload;
 	uint8_t phy;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR			0x2035
 struct bt_hci_cmd_le_set_adv_set_rand_addr {
 	uint8_t  handle;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS			0x2036
 struct bt_hci_cmd_le_set_ext_adv_params {
@@ -2429,11 +2433,11 @@ struct bt_hci_cmd_le_set_ext_adv_params {
 	uint8_t  secondary_phy;
 	uint8_t  sid;
 	uint8_t  notif_enable;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_rsp_le_set_ext_adv_params {
 	uint8_t  status;
 	uint8_t  tx_power;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_EXT_ADV_DATA			0x2037
 struct bt_hci_cmd_le_set_ext_adv_data {
@@ -2442,7 +2446,7 @@ struct bt_hci_cmd_le_set_ext_adv_data {
 	uint8_t  fragment_preference;
 	uint8_t  data_len;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_EXT_SCAN_RSP_DATA			0x2038
 struct bt_hci_cmd_le_set_ext_scan_rsp_data {
@@ -2451,35 +2455,35 @@ struct bt_hci_cmd_le_set_ext_scan_rsp_data {
 	uint8_t  fragment_preference;
 	uint8_t  data_len;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE			0x2039
 struct bt_hci_cmd_le_set_ext_adv_enable {
 	uint8_t  enable;
 	uint8_t  num_of_sets;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_cmd_ext_adv_set {
 	uint8_t  handle;
 	uint16_t duration;
 	uint8_t  max_events;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_MAX_ADV_DATA_LEN			0x203a
 struct bt_hci_rsp_le_read_max_adv_data_len {
 	uint8_t  status;
 	uint16_t max_len;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS			0x203b
 struct bt_hci_rsp_le_read_num_supported_adv_sets {
 	uint8_t  status;
 	uint8_t  num_of_sets;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_REMOVE_ADV_SET			0x203c
 struct bt_hci_cmd_le_remove_adv_set {
 	uint8_t  handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CLEAR_ADV_SETS			0x203d
 
@@ -2489,7 +2493,7 @@ struct bt_hci_cmd_le_set_pa_params {
 	uint16_t min_interval;
 	uint16_t max_interval;
 	uint16_t properties;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_PA_DATA			0x203f
 struct bt_hci_cmd_le_set_pa_data {
@@ -2497,13 +2501,13 @@ struct bt_hci_cmd_le_set_pa_data {
 	uint8_t  operation;
 	uint8_t  data_len;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_PA_ENABLE			0x2040
 struct bt_hci_cmd_le_set_pa_enable {
 	uint8_t  enable;
 	uint8_t  handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_EXT_SCAN_PARAMS		0x2041
 struct bt_hci_cmd_le_set_ext_scan_params {
@@ -2511,12 +2515,12 @@ struct bt_hci_cmd_le_set_ext_scan_params {
 	uint8_t  filter_policy;
 	uint8_t  num_phys;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_le_scan_phy {
 	uint8_t  type;
 	uint16_t interval;
 	uint16_t window;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_EXT_SCAN_ENABLE		0x2042
 struct bt_hci_cmd_le_set_ext_scan_enable {
@@ -2524,7 +2528,7 @@ struct bt_hci_cmd_le_set_ext_scan_enable {
 	uint8_t  filter_dup;
 	uint16_t duration;
 	uint16_t period;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_EXT_CREATE_CONN		0x2043
 struct bt_hci_cmd_le_ext_create_conn {
@@ -2534,7 +2538,7 @@ struct bt_hci_cmd_le_ext_create_conn {
 	uint8_t  peer_addr[6];
 	uint8_t  phys;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_le_ext_create_conn {
 	uint16_t scan_interval;
 	uint16_t scan_window;
@@ -2544,7 +2548,7 @@ struct bt_hci_le_ext_create_conn {
 	uint16_t supv_timeout;
 	uint16_t min_length;
 	uint16_t max_length;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_PA_CREATE_SYNC		0x2044
 struct bt_hci_cmd_le_pa_create_sync {
@@ -2555,28 +2559,28 @@ struct bt_hci_cmd_le_pa_create_sync {
 	uint16_t skip;
 	uint16_t sync_timeout;
 	uint8_t  sync_cte_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_PA_CREATE_SYNC_CANCEL		0x2045
 
 #define BT_HCI_CMD_LE_PA_TERM_SYNC		0x2046
 struct bt_hci_cmd_le_pa_term_sync {
 	uint16_t sync_handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_ADD_DEV_PA_LIST		0x2047
 struct bt_hci_cmd_le_add_dev_pa_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 	uint8_t  sid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_REMOVE_DEV_PA_LIST		0x2048
 struct bt_hci_cmd_le_remove_dev_pa_list {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
 	uint8_t  sid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CLEAR_PA_LIST		0x2049
 
@@ -2584,34 +2588,34 @@ struct bt_hci_cmd_le_remove_dev_pa_list {
 struct bt_hci_rsp_le_read_dev_pa_list_size {
 	uint8_t  status;
 	uint8_t  list_size;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_TX_POWER		0x204b
 struct bt_hci_rsp_le_read_tx_power {
 	uint8_t  status;
 	int8_t  min_tx_power;
 	int8_t  max_tx_power;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_RF_PATH_COMPENSATION		0x204c
 struct bt_hci_rsp_le_read_rf_path_comp {
 	uint8_t  status;
 	uint16_t rf_tx_path_comp;
 	uint16_t rf_rx_path_comp;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_WRITE_RF_PATH_COMPENSATION		0x204d
 struct bt_hci_cmd_le_write_rf_path_comp {
 	uint16_t rf_tx_path_comp;
 	uint16_t rf_rx_path_comp;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_PRIV_MODE		0x204e
 struct bt_hci_cmd_le_set_priv_mode {
 	uint8_t  peer_id_addr_type;
 	uint8_t  peer_id_addr[6];
 	uint8_t  priv_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_RECEIVER_TEST_V3		0x204f
 struct bt_hci_cmd_le_receiver_test_v3 {
@@ -2623,7 +2627,7 @@ struct bt_hci_cmd_le_receiver_test_v3 {
 	uint8_t  duration;
 	uint8_t  num_antenna_id;
 	uint8_t  antenna_ids[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_TX_TEST_V3		0x2050
 struct bt_hci_cmd_le_tx_test_v3 {
@@ -2636,37 +2640,37 @@ struct bt_hci_cmd_le_tx_test_v3 {
 	uint8_t  duration;
 	uint8_t  num_antenna_id;
 	uint8_t  antenna_ids[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_SET_PA_REC_ENABLE		0x2059
 struct bt_hci_cmd_set_pa_rec_enable {
 	uint16_t sync_handle;
 	uint8_t  enable;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_PAST			0x205a
 struct bt_hci_cmd_le_past {
 	uint16_t handle;
 	uint16_t service_data;
 	uint16_t sync_handle;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_past {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_PAST_SET_INFO		0x205b
 struct bt_hci_cmd_le_past_set_info {
 	uint16_t handle;
 	uint16_t service_data;
 	uint8_t  adv_handle;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_past_set_info {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_PAST_PARAMS		0x205c
 struct bt_hci_cmd_le_past_params {
@@ -2675,12 +2679,12 @@ struct bt_hci_cmd_le_past_params {
 	uint16_t  skip;
 	uint16_t  sync_timeout;
 	uint8_t   cte_type;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_past_params {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_DEFAULT_PAST_PARAMS		0x205d
 struct bt_hci_cmd_le_default_past_params {
@@ -2688,7 +2692,7 @@ struct bt_hci_cmd_le_default_past_params {
 	uint16_t skip;
 	uint16_t sync_timeout;
 	uint8_t  cte_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2	0x2060
 #define BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2	BT_HCI_CMD_BIT(41, 5)
@@ -2698,13 +2702,13 @@ struct bt_hci_rsp_le_read_buffer_size_v2 {
 	uint8_t  acl_max_pkt;
 	uint16_t iso_mtu;
 	uint8_t  iso_max_pkt;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_ISO_TX_SYNC		0x2061
 #define BT_HCI_BIT_LE_READ_ISO_TX_SYNC		BT_HCI_CMD_BIT(41, 6)
 struct bt_hci_cmd_le_read_iso_tx_sync {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_read_iso_tx_sync {
 	uint8_t  status;
@@ -2712,7 +2716,7 @@ struct bt_hci_rsp_le_read_iso_tx_sync {
 	uint16_t seq;
 	uint32_t timestamp;
 	uint8_t  offset[3];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_CIG_PARAMS		0x2062
 #define BT_HCI_BIT_LE_SET_CIG_PARAMS		BT_HCI_CMD_BIT(41, 7)
@@ -2724,7 +2728,7 @@ struct bt_hci_cis_params {
 	uint8_t  p_phys;
 	uint8_t  c_rtn;
 	uint8_t  p_rtn;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_cmd_le_set_cig_params {
 	uint8_t  cig_id;
@@ -2737,14 +2741,14 @@ struct bt_hci_cmd_le_set_cig_params {
 	uint16_t p_latency;
 	uint8_t  num_cis;
 	struct bt_hci_cis_params cis[0];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_set_cig_params {
 	uint8_t  status;
 	uint8_t  cig_id;
 	uint8_t  num_handles;
 	uint16_t handle[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST	0x2063
 #define BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST	BT_HCI_CMD_BIT(42, 0)
@@ -2759,7 +2763,7 @@ struct bt_hci_cis_params_test {
 	uint8_t  p_phys;
 	uint8_t  c_bn;
 	uint8_t  p_bn;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_cmd_le_set_cig_params_test {
 	uint8_t  cig_id;
@@ -2773,43 +2777,43 @@ struct bt_hci_cmd_le_set_cig_params_test {
 	uint8_t  framing;
 	uint8_t  num_cis;
 	struct bt_hci_cis_params_test cis[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CREATE_CIS		0x2064
 #define BT_HCI_BIT_LE_CREATE_CIS		BT_HCI_CMD_BIT(42, 1)
 struct bt_hci_cis {
 	uint16_t  cis_handle;
 	uint16_t  acl_handle;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_cmd_le_create_cis {
 	uint8_t  num_cis;
 	struct bt_hci_cis cis[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_REMOVE_CIG		0x2065
 #define BT_HCI_BIT_LE_REMOVE_CIG		BT_HCI_CMD_BIT(42, 2)
 struct bt_hci_cmd_le_remove_cig {
 	uint8_t  cig_id;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_remove_cig {
 	uint8_t  status;
 	uint8_t  cig_id;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_ACCEPT_CIS		0x2066
 #define BT_HCI_BIT_LE_ACCEPT_CIS		BT_HCI_CMD_BIT(42, 3)
 struct bt_hci_cmd_le_accept_cis {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_REJECT_CIS		0x2067
 #define BT_HCI_BIT_LE_REJECT_CIS		BT_HCI_CMD_BIT(42, 4)
 struct bt_hci_cmd_le_reject_cis {
 	uint16_t handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CREATE_BIG		0x2068
 #define BT_HCI_BIT_LE_CREATE_BIG		BT_HCI_CMD_BIT(42, 5)
@@ -2823,14 +2827,14 @@ struct bt_hci_bis {
 	uint8_t  framing;
 	uint8_t  encryption;
 	uint8_t  bcode[16];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_cmd_le_create_big {
 	uint8_t  handle;
 	uint8_t  adv_handle;
 	uint8_t  num_bis;
 	struct bt_hci_bis bis;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CREATE_BIG_TEST		0x2069
 #define BT_HCI_BIT_LE_CREATE_BIG_TEST		BT_HCI_CMD_BIT(42, 6)
@@ -2848,27 +2852,27 @@ struct bt_hci_bis_test {
 	uint8_t  pto;
 	uint8_t  encryption;
 	uint8_t  bcode[16];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_cmd_le_create_big_test {
 	uint8_t  big_handle;
 	uint8_t  adv_handle;
 	uint8_t  num_bis;
 	struct bt_hci_bis_test bis[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_TERM_BIG			0x206a
 #define BT_HCI_BIT_LE_TERM_BIG			BT_HCI_CMD_BIT(42, 7)
 struct bt_hci_cmd_le_term_big {
 	uint8_t  handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_BIG_CREATE_SYNC		0x206b
 #define BT_HCI_BIT_LE_BIG_CREATE_SYNC		BT_HCI_CMD_BIT(43, 0)
 struct bt_hci_bis_sync {
 	uint8_t  index;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_cmd_le_big_create_sync {
 	uint8_t  handle;
@@ -2879,24 +2883,24 @@ struct bt_hci_cmd_le_big_create_sync {
 	uint16_t timeout;
 	uint8_t  num_bis;
 	struct bt_hci_bis_sync bis[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_BIG_TERM_SYNC		0x206c
 #define BT_HCI_BIT_LE_BIG_TERM_SYNC		BT_HCI_CMD_BIT(43, 1)
 struct bt_hci_cmd_le_big_term_sync {
 	uint8_t  handle;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_big_term_sync {
 	uint8_t  status;
 	uint8_t  handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_REQ_PEER_SCA		0x206d
 #define BT_HCI_BIT_LE_REQ_PEER_SCA		BT_HCI_CMD_BIT(43, 2)
 struct bt_hci_cmd_le_req_peer_sca {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SETUP_ISO_PATH		0x206e
 #define BT_HCI_BIT_LE_SETUP_ISO_PATH		BT_HCI_CMD_BIT(43, 3)
@@ -2910,24 +2914,24 @@ struct bt_hci_cmd_le_setup_iso_path {
 	uint8_t  delay[3];
 	uint8_t  codec_cfg_len;
 	uint8_t  codec_cfg[0];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_setup_iso_path {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_REMOVE_ISO_PATH		0x206f
 #define BT_HCI_BIT_LE_REMOVE_ISO_PATH		BT_HCI_CMD_BIT(43, 4)
 struct bt_hci_cmd_le_remove_iso_path {
 	uint16_t handle;
 	uint8_t  direction;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_remove_iso_path {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_ISO_TX_TEST		0x2070
 #define BT_HCI_BIT_LE_ISO_TX_TEST		BT_HCI_CMD_BIT(43, 5)
@@ -2946,13 +2950,13 @@ struct bt_hci_rsp_le_remove_iso_path {
 struct bt_hci_cmd_le_set_host_feature {
 	uint8_t  bit_number;
 	uint8_t  bit_value;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_ISO_LINK_QUALITY	0x2075
 #define BT_HCI_BIT_LE_READ_ISO_LINK_QUALITY	BT_HCI_CMD_BIT(44, 2)
 struct bt_hci_cmd_le_read_iso_link_quality {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_read_iso_link_quality {
 	uint8_t  status;
@@ -2964,7 +2968,7 @@ struct bt_hci_rsp_le_read_iso_link_quality {
 	uint32_t crc_error_packets;
 	uint32_t rx_unreceived_packets;
 	uint32_t duplicated_packets;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES	0x2087
 #define BT_HCI_BIT_LE_READ_ALL_LOCAL_FEATURES	BT_HCI_CMD_BIT(47, 2)
@@ -2972,14 +2976,14 @@ struct bt_hci_rsp_le_read_all_local_features {
 	uint8_t  status;
 	uint8_t  page;
 	uint8_t  features[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_ALL_REMOTE_FEATURES	0x2088
 #define BT_HCI_BIT_LE_READ_ALL_REMOTE_FEATURES	BT_HCI_CMD_BIT(47, 3)
 struct bt_hci_cmd_le_read_all_remote_features {
 	uint16_t handle;
 	uint8_t  pages;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_RD_LOC_SUPP_CAP	0x2089
 #define BT_HCI_BIT_LE_CS_RD_LOC_SUPP_CAP	BT_HCI_CMD_BIT(20, 5)
@@ -3005,13 +3009,13 @@ struct bt_hci_rsp_le_cs_rd_loc_supp_cap {
 	uint16_t t_pm_times_supported;
 	uint8_t t_sw_time_supported;
 	uint8_t tx_snr_capability;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_RD_REM_SUPP_CAP	0x208A
 #define BT_HCI_BIT_LE_CS_RD_REM_SUPP_CAP	BT_HCI_CMD_BIT(20, 6)
 struct bt_hci_cmd_le_cs_rd_rem_supp_cap {
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_WR_CACHED_REM_SUPP_CAP	0x208B
 #define BT_HCI_BIT_LE_CS_WR_CACHED_REM_SUPP_CAP	BT_HCI_CMD_BIT(20, 7)
@@ -3037,17 +3041,17 @@ struct bt_hci_cmd_le_cs_wr_cached_rem_supp_cap {
 	uint16_t t_pm_times_supported;
 	uint8_t t_sw_time_supported;
 	uint8_t tx_snr_capability;
-} __attribute__((packed));
+} __packed;
 struct bt_hci_rsp_le_cs_wr_cached_rem_supp_cap {
 	uint8_t status;
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_SEC_ENABLE		0x208C
 #define BT_HCI_BIT_LE_CS_SEC_ENABLE		BT_HCI_CMD_BIT(24, 1)
 struct bt_hci_cmd_le_cs_sec_enable {
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_SET_DEF_SETTINGS	0x208D
 #define BT_HCI_BIT_LE_CS_SET_DEF_SETTINGS	BT_HCI_CMD_BIT(24, 7)
@@ -3056,28 +3060,28 @@ struct bt_hci_cmd_le_cs_set_def_settings {
 	uint8_t role_enable;
 	uint8_t cs_sync_antenna_selection;
 	uint8_t max_tx_power;
-} __attribute__((packed));
+} __packed;
 struct bt_hci_rsp_le_cs_set_def_settings {
 	uint8_t status;
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_RD_REM_FAE		0x208E
 #define BT_HCI_BIT_LE_CS_RD_REM_FAE		BT_HCI_CMD_BIT(12, 2)
 struct bt_hci_cmd_le_cs_rd_rem_fae {
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_WR_CACHED_REM_FAE	0x208F
 #define BT_HCI_BIT_LE_CS_WR_CACHED_REM_FAE	BT_HCI_CMD_BIT(12, 3)
 struct bt_hci_cmd_le_cs_wr_cached_rem_fae {
 	uint16_t handle;
 	uint8_t remote_fae_table[72];
-} __attribute__((packed));
+} __packed;
 struct bt_hci_rsp_le_cs_wr_cached_rem_fae {
 	uint8_t status;
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_CREATE_CONFIG		0x2090
 #define BT_HCI_BIT_LE_CS_CREATE_CONFIG		BT_HCI_CMD_BIT(16, 6)
@@ -3100,23 +3104,23 @@ struct bt_hci_cmd_le_cs_create_config {
 	uint8_t ch3c_shape;
 	uint8_t ch3c_jump;
 	uint8_t reserved;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_REMOVE_CONFIG		0x2091
 #define BT_HCI_BIT_LE_CS_REMOVE_CONFIG		BT_HCI_CMD_BIT(16, 7)
 struct bt_hci_cmd_le_cs_remove_config {
 	uint16_t handle;
 	uint8_t config_id;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_SET_CHAN_CLASS		0x2092
 #define BT_HCI_BIT_LE_CS_SET_CHAN_CLASS		BT_HCI_CMD_BIT(29, 0)
 struct bt_hci_cmd_le_cs_set_chan_class {
 	uint8_t channel_classification[10];
-} __attribute__((packed));
+} __packed;
 struct bt_hci_rsp_le_cs_set_chan_class {
 	uint8_t status;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_SET_PROC_PARAMS	0x2093
 #define BT_HCI_BIT_LE_CS_SET_PROC_PARAMS	BT_HCI_CMD_BIT(29, 1)
@@ -3135,11 +3139,11 @@ struct bt_hci_cmd_le_cs_set_proc_params {
 	uint8_t preferred_peer_antenna;
 	uint8_t snr_control_initiator;
 	uint8_t snr_control_reflector;
-} __attribute__((packed));
+} __packed;
 struct bt_hci_rsp_le_cs_set_proc_params {
 	uint8_t status;
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_PROC_ENABLE		0x2094
 #define BT_HCI_BIT_LE_CS_PROC_ENABLE		BT_HCI_CMD_BIT(29, 2)
@@ -3147,7 +3151,7 @@ struct bt_hci_cmd_le_cs_proc_enable {
 	uint16_t handle;
 	uint8_t config_id;
 	uint8_t enable;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_TEST			0x2095
 #define BT_HCI_BIT_LE_CS_TEST			BT_HCI_CMD_BIT(23, 3)
@@ -3178,10 +3182,10 @@ struct bt_hci_cmd_le_cs_test {
 	uint16_t override_config;
 	uint8_t override_parameters_length;
 	uint8_t override_parameters_data[];
-} __attribute__((packed));
+} __packed;
 struct bt_hci_rsp_le_cs_test {
 	uint8_t status;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CS_TEST_END		0x2096
 #define BT_HCI_BIT_LE_CS_TEST_END		BT_HCI_CMD_BIT(23, 4)
@@ -3191,7 +3195,7 @@ struct bt_hci_rsp_le_cs_test {
 struct bt_hci_cmd_le_set_host_feature_v2 {
 	uint16_t bit_number;
 	uint8_t  bit_value;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_FSU			0x209d
 #define BT_HCI_BIT_LE_FSU			BT_HCI_CMD_BIT(48, 1)
@@ -3201,7 +3205,7 @@ struct bt_hci_cmd_le_fsu {
 	uint16_t frame_space_max;
 	uint8_t  phys;
 	uint8_t  types;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_CONN_RATE		0x20a1
 #define BT_HCI_BIT_LE_CONN_RATE		BT_HCI_CMD_BIT(48, 5)
@@ -3216,7 +3220,7 @@ struct bt_hci_cmd_le_conn_rate {
 	uint16_t supv_timeout;
 	uint16_t min_ce_len;
 	uint16_t max_ce_len;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_SET_DEF_RATE		0x20a2
 #define BT_HCI_BIT_LE_SET_DEF_RATE		BT_HCI_CMD_BIT(48, 6)
@@ -3230,7 +3234,7 @@ struct bt_hci_cmd_le_set_def_rate {
 	uint16_t supv_timeout;
 	uint16_t min_ce_len;
 	uint16_t max_ce_len;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_CMD_LE_READ_CONN_INTERVAL	0x20a3
 #define BT_HCI_BIT_LE_READ_CONN_INTERVAL	BT_HCI_CMD_BIT(48, 7)
@@ -3238,19 +3242,19 @@ struct bt_hci_le_conn_interval_group {
 	uint16_t min;
 	uint16_t max;
 	uint16_t stride;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_rsp_le_read_conn_interval {
 	uint8_t  status;
 	uint8_t  min;
 	uint8_t  num_grps;
 	struct bt_hci_le_conn_interval_group grps[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_INQUIRY_RESULT		0x02
 struct bt_hci_evt_inquiry_result {
@@ -3261,7 +3265,7 @@ struct bt_hci_evt_inquiry_result {
 	uint8_t  pscan_mode;
 	uint8_t  dev_class[3];
 	uint16_t clock_offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_CONN_COMPLETE		0x03
 struct bt_hci_evt_conn_complete {
@@ -3270,61 +3274,61 @@ struct bt_hci_evt_conn_complete {
 	uint8_t  bdaddr[6];
 	uint8_t  link_type;
 	uint8_t  encr_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_CONN_REQUEST			0x04
 struct bt_hci_evt_conn_request {
 	uint8_t  bdaddr[6];
 	uint8_t  dev_class[3];
 	uint8_t  link_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_DISCONNECT_COMPLETE		0x05
 struct bt_hci_evt_disconnect_complete {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_AUTH_COMPLETE		0x06
 struct bt_hci_evt_auth_complete {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_REMOTE_NAME_REQUEST_COMPLETE	0x07
 struct bt_hci_evt_remote_name_request_complete {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
 	uint8_t  name[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_ENCRYPT_CHANGE		0x08
 struct bt_hci_evt_encrypt_change {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  encr_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_CHANGE_CONN_LINK_KEY_COMPLETE 0x09
 struct bt_hci_evt_change_conn_link_key_complete {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LINK_KEY_TYPE_CHANGED	0x0a
 struct bt_hci_evt_link_key_type_changed {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  key_flag;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_REMOTE_FEATURES_COMPLETE	0x0b
 struct bt_hci_evt_remote_features_complete {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_REMOTE_VERSION_COMPLETE	0x0c
 struct bt_hci_evt_remote_version_complete {
@@ -3333,7 +3337,7 @@ struct bt_hci_evt_remote_version_complete {
 	uint8_t  lmp_ver;
 	uint16_t manufacturer;
 	uint16_t lmp_subver;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_QOS_SETUP_COMPLETE		0x0d
 struct bt_hci_evt_qos_setup_complete {
@@ -3345,44 +3349,44 @@ struct bt_hci_evt_qos_setup_complete {
 	uint32_t peak_bandwidth;
 	uint32_t latency;
 	uint32_t delay_variation;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_CMD_COMPLETE			0x0e
 struct bt_hci_evt_cmd_complete {
 	uint8_t  ncmd;
 	uint16_t opcode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_CMD_STATUS			0x0f
 struct bt_hci_evt_cmd_status {
 	uint8_t  status;
 	uint8_t  ncmd;
 	uint16_t opcode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_HARDWARE_ERROR		0x10
 struct bt_hci_evt_hardware_error {
 	uint8_t  code;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_FLUSH_OCCURRED		0x11
 struct bt_hci_evt_flush_occurred {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_ROLE_CHANGE			0x12
 struct bt_hci_evt_role_change {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
 	uint8_t  role;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_NUM_COMPLETED_PACKETS	0x13
 struct bt_hci_evt_num_completed_packets {
 	uint8_t  num_handles;
 	uint16_t handle;
 	uint16_t count;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_MODE_CHANGE			0x14
 struct bt_hci_evt_mode_change {
@@ -3390,74 +3394,74 @@ struct bt_hci_evt_mode_change {
 	uint16_t handle;
 	uint8_t  mode;
 	uint16_t interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_RETURN_LINK_KEYS		0x15
 struct bt_hci_evt_return_link_keys {
 	uint8_t  num_keys;
 	uint8_t  keys[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_PIN_CODE_REQUEST		0x16
 struct bt_hci_evt_pin_code_request {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LINK_KEY_REQUEST		0x17
 struct bt_hci_evt_link_key_request {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LINK_KEY_NOTIFY		0x18
 struct bt_hci_evt_link_key_notify {
 	uint8_t  bdaddr[6];
 	uint8_t  link_key[16];
 	uint8_t  key_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LOOPBACK_COMMAND		0x19
 
 #define BT_HCI_EVT_DATA_BUFFER_OVERFLOW		0x1a
 struct bt_hci_evt_data_buffer_overflow {
 	uint8_t  link_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_MAX_SLOTS_CHANGE		0x1b
 struct bt_hci_evt_max_slots_change {
 	uint16_t handle;
 	uint8_t  max_slots;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_CLOCK_OFFSET_COMPLETE	0x1c
 struct bt_hci_evt_clock_offset_complete {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t clock_offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_CONN_PKT_TYPE_CHANGED	0x1d
 struct bt_hci_evt_conn_pkt_type_changed {
 	uint8_t  status;
 	uint16_t handle;
 	uint16_t pkt_type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_QOS_VIOLATION		0x1e
 struct bt_hci_evt_qos_violation {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_PSCAN_MODE_CHANGE		0x1f
 struct bt_hci_evt_pscan_mode_change {
 	uint8_t  bdaddr[6];
 	uint8_t  pscan_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_PSCAN_REP_MODE_CHANGE	0x20
 struct bt_hci_evt_pscan_rep_mode_change {
 	uint8_t  bdaddr[6];
 	uint8_t  pscan_rep_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_FLOW_SPEC_COMPLETE		0x21
 struct bt_hci_evt_flow_spec_complete {
@@ -3470,7 +3474,7 @@ struct bt_hci_evt_flow_spec_complete {
 	uint32_t token_bucket_size;
 	uint32_t peak_bandwidth;
 	uint32_t access_latency;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_INQUIRY_RESULT_WITH_RSSI	0x22
 struct bt_hci_evt_inquiry_result_with_rssi {
@@ -3481,7 +3485,7 @@ struct bt_hci_evt_inquiry_result_with_rssi {
 	uint8_t  dev_class[3];
 	uint16_t clock_offset;
 	int8_t   rssi;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_REMOTE_EXT_FEATURES_COMPLETE	0x23
 struct bt_hci_evt_remote_ext_features_complete {
@@ -3490,7 +3494,7 @@ struct bt_hci_evt_remote_ext_features_complete {
 	uint8_t  page;
 	uint8_t  max_page;
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_SYNC_CONN_COMPLETE		0x2c
 struct bt_hci_evt_sync_conn_complete {
@@ -3503,7 +3507,7 @@ struct bt_hci_evt_sync_conn_complete {
 	uint16_t rx_pkt_len;
 	uint16_t tx_pkt_len;
 	uint8_t  air_mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_SYNC_CONN_CHANGED		0x2d
 struct bt_hci_evt_sync_conn_changed {
@@ -3513,7 +3517,7 @@ struct bt_hci_evt_sync_conn_changed {
 	uint8_t  retrans_window;
 	uint16_t rx_pkt_len;
 	uint16_t tx_pkt_len;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_SNIFF_SUBRATING		0x2e
 struct bt_hci_evt_sniff_subrating {
@@ -3523,7 +3527,7 @@ struct bt_hci_evt_sniff_subrating {
 	uint16_t max_rx_latency;
 	uint16_t min_remote_timeout;
 	uint16_t min_local_timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_EXT_INQUIRY_RESULT		0x2f
 struct bt_hci_evt_ext_inquiry_result {
@@ -3535,18 +3539,18 @@ struct bt_hci_evt_ext_inquiry_result {
 	uint16_t clock_offset;
 	int8_t   rssi;
 	uint8_t  data[240];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE	0x30
 struct bt_hci_evt_encrypt_key_refresh_complete {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_IO_CAPABILITY_REQUEST	0x31
 struct bt_hci_evt_io_capability_request {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_IO_CAPABILITY_RESPONSE	0x32
 struct bt_hci_evt_io_capability_response {
@@ -3554,58 +3558,58 @@ struct bt_hci_evt_io_capability_response {
 	uint8_t  capability;
 	uint8_t  oob_data;
 	uint8_t  authentication;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_USER_CONFIRM_REQUEST		0x33
 struct bt_hci_evt_user_confirm_request {
 	uint8_t  bdaddr[6];
 	uint32_t passkey;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_USER_PASSKEY_REQUEST		0x34
 struct bt_hci_evt_user_passkey_request {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_REMOTE_OOB_DATA_REQUEST	0x35
 struct bt_hci_evt_remote_oob_data_request {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_SIMPLE_PAIRING_COMPLETE	0x36
 struct bt_hci_evt_simple_pairing_complete {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LINK_SUPV_TIMEOUT_CHANGED	0x38
 struct bt_hci_evt_link_supv_timeout_changed {
 	uint16_t handle;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_ENHANCED_FLUSH_COMPLETE	0x39
 struct bt_hci_evt_enhanced_flush_complete {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_USER_PASSKEY_NOTIFY		0x3b
 struct bt_hci_evt_user_passkey_notify {
 	uint8_t  bdaddr[6];
 	uint32_t passkey;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_KEYPRESS_NOTIFY		0x3c
 struct bt_hci_evt_keypress_notify {
 	uint8_t  bdaddr[6];
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_REMOTE_HOST_FEATURES_NOTIFY	0x3d
 struct bt_hci_evt_remote_host_features_notify {
 uint8_t  bdaddr[6];
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_META_EVENT		0x3e
 
@@ -3613,30 +3617,30 @@ uint8_t  bdaddr[6];
 struct bt_hci_evt_phy_link_complete {
 	uint8_t  status;
 	uint8_t  phy_handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_CHANNEL_SELECTED		0x41
 struct bt_hci_evt_channel_selected {
 	uint8_t  phy_handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_DISCONN_PHY_LINK_COMPLETE	0x42
 struct bt_hci_evt_disconn_phy_link_complete {
 	uint8_t  status;
 	uint8_t  phy_handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_PHY_LINK_LOSS_EARLY_WARNING	0x43
 struct bt_hci_evt_phy_link_loss_early_warning {
 	uint8_t  phy_handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_PHY_LINK_RECOVERY		0x44
 struct bt_hci_evt_phy_link_recovery {
 	uint8_t  phy_handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LOGIC_LINK_COMPLETE		0x45
 struct bt_hci_evt_logic_link_complete {
@@ -3644,20 +3648,20 @@ struct bt_hci_evt_logic_link_complete {
 	uint16_t handle;
 	uint8_t  phy_handle;
 	uint8_t  flow_spec;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_DISCONN_LOGIC_LINK_COMPLETE	0x46
 struct bt_hci_evt_disconn_logic_link_complete {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_FLOW_SPEC_MODIFY_COMPLETE	0x47
 struct bt_hci_evt_flow_spec_modify_complete {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_NUM_COMPLETED_DATA_BLOCKS	0x48
 struct bt_hci_evt_num_completed_data_blocks {
@@ -3666,20 +3670,20 @@ struct bt_hci_evt_num_completed_data_blocks {
 	uint16_t handle;
 	uint16_t num_packets;
 	uint16_t num_blocks;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_SHORT_RANGE_MODE_CHANGE	0x4c
 struct bt_hci_evt_short_range_mode_change {
 	uint8_t  status;
 	uint8_t  phy_handle;
 	uint8_t  mode;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_AMP_STATUS_CHANGE		0x4d
 struct bt_hci_evt_amp_status_change {
 	uint8_t  status;
 	uint8_t  amp_status;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_TRIGGERED_CLOCK_CAPTURE	0x4e
 struct bt_hci_evt_triggered_clock_capture {
@@ -3687,12 +3691,12 @@ struct bt_hci_evt_triggered_clock_capture {
 	uint8_t  type;
 	uint32_t clock;
 	uint16_t clock_offset;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_SYNC_TRAIN_COMPLETE		0x4f
 struct bt_hci_evt_sync_train_complete {
 	uint8_t  status;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_SYNC_TRAIN_RECEIVED		0x50
 struct bt_hci_evt_sync_train_received {
@@ -3704,7 +3708,7 @@ struct bt_hci_evt_sync_train_received {
 	uint32_t instant;
 	uint16_t interval;
 	uint8_t  service_data;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_PERIPHERAL_BROADCAST_RECEIVE	0x51
 struct bt_hci_evt_peripheral_broadcast_receive {
@@ -3715,37 +3719,37 @@ struct bt_hci_evt_peripheral_broadcast_receive {
 	uint8_t  status;
 	uint8_t  fragment;
 	uint8_t  length;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_PERIPHERAL_BROADCAST_TIMEOUT	0x52
 struct bt_hci_evt_peripheral_broadcast_timeout {
 	uint8_t  bdaddr[6];
 	uint8_t  lt_addr;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_TRUNCATED_PAGE_COMPLETE	0x53
 struct bt_hci_evt_truncated_page_complete {
 	uint8_t  status;
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_PERIPHERAL_PAGE_RESPONSE_TIMEOUT	0x54
 
 #define BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE	0x55
 struct bt_hci_evt_channel_map_change {
 	uint8_t  map[10];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_INQUIRY_RESPONSE_NOTIFY	0x56
 struct bt_hci_evt_inquiry_response_notify {
 	uint8_t  lap[3];
 	int8_t   rssi;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_AUTH_PAYLOAD_TIMEOUT_EXPIRED	0x57
 struct bt_hci_evt_auth_payload_timeout_expired {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_ENCRYPT_CHANGE_V2		0x59
 struct bt_hci_evt_encrypt_change_v2 {
@@ -3753,7 +3757,7 @@ struct bt_hci_evt_encrypt_change_v2 {
 	uint16_t handle;
 	uint8_t  encr_mode;
 	uint8_t  encr_key_size;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CONN_COMPLETE		0x01
 struct bt_hci_evt_le_conn_complete {
@@ -3766,7 +3770,7 @@ struct bt_hci_evt_le_conn_complete {
 	uint16_t latency;
 	uint16_t supv_timeout;
 	uint8_t  clock_accuracy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_ADV_REPORT		0x02
 struct bt_hci_evt_le_adv_report {
@@ -3776,7 +3780,7 @@ struct bt_hci_evt_le_adv_report {
 	uint8_t  addr[6];
 	uint8_t  data_len;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE	0x03
 struct bt_hci_evt_le_conn_update_complete {
@@ -3785,21 +3789,21 @@ struct bt_hci_evt_le_conn_update_complete {
 	uint16_t interval;
 	uint16_t latency;
 	uint16_t supv_timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_REMOTE_FEATURES_COMPLETE	0x04
 struct bt_hci_evt_le_remote_features_complete {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  features[8];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST	0x05
 struct bt_hci_evt_le_long_term_key_request {
 	uint16_t handle;
 	uint64_t rand;
 	uint16_t ediv;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CONN_PARAM_REQUEST	0x06
 struct bt_hci_evt_le_conn_param_request {
@@ -3808,7 +3812,7 @@ struct bt_hci_evt_le_conn_param_request {
 	uint16_t max_interval;
 	uint16_t latency;
 	uint16_t supv_timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_DATA_LENGTH_CHANGE	0x07
 struct bt_hci_evt_le_data_length_change {
@@ -3817,19 +3821,19 @@ struct bt_hci_evt_le_data_length_change {
 	uint16_t max_tx_time;
 	uint16_t max_rx_len;
 	uint16_t max_rx_time;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_READ_LOCAL_PK256_COMPLETE	0x08
 struct bt_hci_evt_le_read_local_pk256_complete {
 	uint8_t  status;
 	uint8_t  local_pk256[64];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_GENERATE_DHKEY_COMPLETE	0x09
 struct bt_hci_evt_le_generate_dhkey_complete {
 	uint8_t  status;
 	uint8_t  dhkey[32];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE	0x0a
 struct bt_hci_evt_le_enhanced_conn_complete {
@@ -3844,7 +3848,7 @@ struct bt_hci_evt_le_enhanced_conn_complete {
 	uint16_t latency;
 	uint16_t supv_timeout;
 	uint8_t  clock_accuracy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_DIRECT_ADV_REPORT		0x0b
 struct bt_hci_evt_le_direct_adv_report {
@@ -3855,7 +3859,7 @@ struct bt_hci_evt_le_direct_adv_report {
 	uint8_t  direct_addr_type;
 	uint8_t  direct_addr[6];
 	int8_t   rssi;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE	0x0c
 struct bt_hci_evt_le_phy_update_complete {
@@ -3863,12 +3867,12 @@ struct bt_hci_evt_le_phy_update_complete {
 	uint16_t handle;
 	uint8_t  tx_phy;
 	uint8_t  rx_phy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_EXT_ADV_REPORT	0x0d
 struct bt_hci_evt_le_ext_adv_report {
 	uint8_t  num_reports;
-} __attribute__ ((packed));
+} __packed;
 struct bt_hci_le_ext_adv_report {
 	uint16_t event_type;
 	uint8_t  addr_type;
@@ -3883,7 +3887,7 @@ struct bt_hci_le_ext_adv_report {
 	uint8_t  direct_addr[6];
 	uint8_t  data_len;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED	0x0e
 struct bt_hci_evt_le_per_sync_established {
@@ -3895,35 +3899,35 @@ struct bt_hci_evt_le_per_sync_established {
 	uint8_t  phy;
 	uint16_t interval;
 	uint8_t  clock_accuracy;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_le_pa_base_codec {
 	uint8_t  id;
 	uint16_t cid;
 	uint16_t vid;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_lv_data {
 	uint8_t  len;
 	uint8_t  data[];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_le_pa_base_bis {
 	uint8_t  index;
 	struct bt_hci_lv_data codec_cfg[];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_le_pa_base_subgroup {
 	uint8_t  num_bis;
 	struct bt_hci_le_pa_base_codec codec;
 	uint8_t  data[];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_hci_le_pa_base_data {
 	uint8_t  pd[3];
 	uint8_t  num_subgroups;
 	struct bt_hci_le_pa_base_subgroup subgroups[];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_PA_REPORT			0x0f
 struct bt_hci_le_pa_report {
@@ -3934,12 +3938,12 @@ struct bt_hci_le_pa_report {
 	uint8_t  data_status;
 	uint8_t  data_len;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_PA_SYNC_LOST		0x10
 struct bt_hci_evt_le_per_sync_lost {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_ADV_SET_TERM		0x12
 struct bt_hci_evt_le_adv_set_term {
@@ -3947,26 +3951,26 @@ struct bt_hci_evt_le_adv_set_term {
 	uint8_t  handle;
 	uint16_t conn_handle;
 	uint8_t  num_evts;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_SCAN_REQ_RECEIVED		0x13
 struct bt_hci_evt_le_scan_req_received {
 	uint8_t  handle;
 	uint8_t  scanner_addr_type;
 	uint8_t  scanner_addr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CHAN_SELECT_ALG		0x14
 struct bt_hci_evt_le_chan_select_alg {
 	uint16_t handle;
 	uint8_t  algorithm;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CTE_REQUEST_FAILED	0x17
 struct bt_hci_evt_le_cte_request_failed {
 	uint8_t  status;
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_PAST_RECEIVED		0x18
 struct bt_hci_evt_le_past_recv {
@@ -3980,7 +3984,7 @@ struct bt_hci_evt_le_past_recv {
 	uint8_t  phy;
 	uint16_t interval;
 	uint8_t  clock_accuracy;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CIS_ESTABLISHED		0x19
 struct bt_hci_evt_le_cis_established {
@@ -4000,7 +4004,7 @@ struct bt_hci_evt_le_cis_established {
 	uint16_t c_mtu;
 	uint16_t p_mtu;
 	uint16_t interval;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CIS_REQ			0x1a
 struct bt_hci_evt_le_cis_req {
@@ -4008,7 +4012,7 @@ struct bt_hci_evt_le_cis_req {
 	uint16_t cis_handle;
 	uint8_t  cig_id;
 	uint8_t  cis_id;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_BIG_COMPLETE		0x1b
 struct bt_hci_evt_le_big_complete {
@@ -4025,13 +4029,13 @@ struct bt_hci_evt_le_big_complete {
 	uint16_t interval;
 	uint8_t  num_bis;
 	uint16_t bis_handle[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_BIG_TERMINATE		0x1c
 struct bt_hci_evt_le_big_terminate {
 	uint8_t  handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED	0x1d
 struct bt_hci_evt_le_big_sync_estabilished {
@@ -4046,20 +4050,20 @@ struct bt_hci_evt_le_big_sync_estabilished {
 	uint16_t interval;
 	uint8_t  num_bis;
 	uint16_t bis[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_BIG_SYNC_LOST		0x1e
 struct bt_hci_evt_le_big_sync_lost {
 	uint8_t  big_handle;
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE	0x1f
 struct bt_hci_evt_le_req_peer_sca_complete {
 	uint8_t  status;
 	uint16_t handle;
 	uint8_t  sca;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_BIG_INFO_ADV_REPORT	0x22
 struct bt_hci_evt_le_big_info_adv_report {
@@ -4076,7 +4080,7 @@ struct bt_hci_evt_le_big_info_adv_report {
 	uint8_t  phy;
 	uint8_t  framing;
 	uint8_t  encryption;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_READ_ALL_REMOTE_FEATURES_COMPLETE	0x2B
 struct bt_hci_evt_le_read_all_remote_features_complete {
@@ -4085,7 +4089,7 @@ struct bt_hci_evt_le_read_all_remote_features_complete {
 	uint8_t  max_pages;
 	uint8_t  valid_pages;
 	uint8_t  features[248];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CS_RD_REM_SUPP_CAP_COMPLETE	(0x2C)
 struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete {
@@ -4111,20 +4115,20 @@ struct bt_hci_evt_le_cs_rd_rem_supp_cap_complete {
 	uint16_t t_pm_times_supported;
 	uint8_t t_sw_time_supported;
 	uint8_t tx_snr_capability;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CS_RD_REM_FAE_COMPLETE	(0x2D)
 struct bt_hci_evt_le_cs_rd_rem_fae_complete {
 	uint8_t status;
 	uint16_t handle;
 	uint8_t remote_fae_table[72];
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CS_SEC_ENABLE_COMPLETE	(0x2E)
 struct bt_hci_evt_le_cs_sec_enable_complete {
 	uint8_t status;
 	uint16_t handle;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CS_CONFIG_COMPLETE	(0x2F)
 struct bt_hci_evt_le_cs_config_complete {
@@ -4151,7 +4155,7 @@ struct bt_hci_evt_le_cs_config_complete {
 	uint8_t t_ip2_time;
 	uint8_t t_fcs_time;
 	uint8_t t_pm_time;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CS_PROC_ENABLE_COMPLETE	(0x30)
 struct bt_hci_evt_le_cs_proc_enable_complete {
@@ -4168,7 +4172,7 @@ struct bt_hci_evt_le_cs_proc_enable_complete {
 	uint16_t procedure_interval;
 	uint16_t procedure_count;
 	uint16_t max_procedure_len;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CS_SUBEVENT_RESULT	(0x31)
 struct bt_hci_evt_le_cs_subevent_result {
@@ -4184,7 +4188,7 @@ struct bt_hci_evt_le_cs_subevent_result {
 	uint8_t num_antenna_paths;
 	uint8_t num_steps_reported;
 	uint8_t steps[];
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE	(0x32)
 struct bt_hci_evt_le_cs_subevent_result_continue {
@@ -4196,12 +4200,12 @@ struct bt_hci_evt_le_cs_subevent_result_continue {
 	uint8_t num_antenna_paths;
 	uint8_t num_steps_reported;
 	uint8_t steps[];
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CS_TEST_END_COMPLETE	(0x33)
 struct bt_hci_evt_le_cs_test_end_complete {
 	uint8_t status;
-} __attribute__((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_FSU_COMPLETE		0x35
 struct bt_hci_evt_le_fsu_complete {
@@ -4211,7 +4215,7 @@ struct bt_hci_evt_le_fsu_complete {
 	uint16_t frame_space;
 	uint8_t  phys;
 	uint8_t  types;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_EVT_LE_CONN_RATE_CHANGE		0x37
 struct bt_hci_evt_le_conn_rate_change {
@@ -4222,7 +4226,7 @@ struct bt_hci_evt_le_conn_rate_change {
 	uint16_t latency;
 	uint16_t cont_number;
 	uint16_t supv_timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
@@ -4248,24 +4252,24 @@ struct bt_l2cap_hdr {
 	uint16_t len;
 	uint16_t cid;
 	uint8_t  data[];
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_l2cap_hdr_sig {
 	uint8_t  code;
 	uint8_t  ident;
 	uint16_t len;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CMD_REJECT		0x01
 struct bt_l2cap_pdu_cmd_reject {
 	uint16_t reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CONN_REQ		0x02
 struct bt_l2cap_pdu_conn_req {
 	uint16_t psm;
 	uint16_t scid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CONN_RSP		0x03
 struct bt_l2cap_pdu_conn_rsp {
@@ -4273,32 +4277,32 @@ struct bt_l2cap_pdu_conn_rsp {
 	uint16_t scid;
 	uint16_t result;
 	uint16_t status;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CONFIG_REQ		0x04
 struct bt_l2cap_pdu_config_req {
 	uint16_t dcid;
 	uint16_t flags;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CONFIG_RSP		0x05
 struct bt_l2cap_pdu_config_rsp {
 	uint16_t scid;
 	uint16_t flags;
 	uint16_t result;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_DISCONN_REQ	0x06
 struct bt_l2cap_pdu_disconn_req {
 	uint16_t dcid;
 	uint16_t scid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_DISCONN_RSP	0x07
 struct bt_l2cap_pdu_disconn_rsp {
 	uint16_t dcid;
 	uint16_t scid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_ECHO_REQ		0x08
 
@@ -4307,21 +4311,21 @@ struct bt_l2cap_pdu_disconn_rsp {
 #define BT_L2CAP_PDU_INFO_REQ		0x0a
 struct bt_l2cap_pdu_info_req {
 	uint16_t type;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_INFO_RSP		0x0b
 struct bt_l2cap_pdu_info_rsp {
 	uint16_t type;
 	uint16_t result;
 	uint8_t  data[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CREATE_CHAN_REQ	0x0c
 struct bt_l2cap_pdu_create_chan_req {
 	uint16_t psm;
 	uint16_t scid;
 	uint8_t  ctrlid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CREATE_CHAN_RSP	0x0d
 struct bt_l2cap_pdu_create_chan_rsp {
@@ -4329,30 +4333,30 @@ struct bt_l2cap_pdu_create_chan_rsp {
 	uint16_t scid;
 	uint16_t result;
 	uint16_t status;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_MOVE_CHAN_REQ	0x0e
 struct bt_l2cap_pdu_move_chan_req {
 	uint16_t icid;
 	uint8_t  ctrlid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_MOVE_CHAN_RSP	0x0f
 struct bt_l2cap_pdu_move_chan_rsp {
 	uint16_t icid;
 	uint16_t result;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_MOVE_CHAN_CFM	0x10
 struct bt_l2cap_pdu_move_chan_cfm {
 	uint16_t icid;
 	uint16_t result;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_MOVE_CHAN_CFM_RSP	0x11
 struct bt_l2cap_pdu_move_chan_cfm_rsp {
 	uint16_t icid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CONN_PARAM_REQ	0x12
 struct bt_l2cap_pdu_conn_param_req {
@@ -4360,12 +4364,12 @@ struct bt_l2cap_pdu_conn_param_req {
 	uint16_t max_interval;
 	uint16_t latency;
 	uint16_t timeout;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_CONN_PARAM_RSP	0x13
 struct bt_l2cap_pdu_conn_param_rsp {
 	uint16_t result;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_LE_CONN_REQ	0x14
 struct bt_l2cap_pdu_le_conn_req {
@@ -4374,7 +4378,7 @@ struct bt_l2cap_pdu_le_conn_req {
 	uint16_t mtu;
 	uint16_t mps;
 	uint16_t credits;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_LE_CONN_RSP	0x15
 struct bt_l2cap_pdu_le_conn_rsp {
@@ -4383,13 +4387,13 @@ struct bt_l2cap_pdu_le_conn_rsp {
 	uint16_t mps;
 	uint16_t credits;
 	uint16_t result;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_LE_FLOWCTL_CREDS	0x16
 struct bt_l2cap_pdu_le_flowctl_creds {
 	uint16_t cid;
 	uint16_t credits;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_ECRED_CONN_REQ	0x17
 struct bt_l2cap_pdu_ecred_conn_req {
@@ -4398,7 +4402,7 @@ struct bt_l2cap_pdu_ecred_conn_req {
 	uint16_t mps;
 	uint16_t credits;
 	uint16_t scid[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_ECRED_CONN_RSP	0x18
 struct bt_l2cap_pdu_ecred_conn_rsp {
@@ -4407,46 +4411,46 @@ struct bt_l2cap_pdu_ecred_conn_rsp {
 	uint16_t credits;
 	uint16_t result;
 	uint16_t dcid[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_ECRED_RECONF_REQ	0x19
 struct bt_l2cap_pdu_ecred_reconf_req {
 	uint16_t mtu;
 	uint16_t mps;
 	uint16_t scid[0];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_PDU_ECRED_RECONF_RSP	0x1a
 struct bt_l2cap_pdu_ecred_reconf_rsp {
 	uint16_t result;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_l2cap_hdr_connless {
 	uint16_t psm;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_l2cap_hdr_amp {
 	uint8_t  code;
 	uint8_t  ident;
 	uint16_t len;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_CMD_REJECT		0x01
 struct bt_l2cap_amp_cmd_reject {
 	uint16_t reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_DISCOVER_REQ	0x02
 struct bt_l2cap_amp_discover_req {
 	uint16_t size;
 	uint16_t features;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_DISCOVER_RSP	0x03
 struct bt_l2cap_amp_discover_rsp {
 	uint16_t size;
 	uint16_t features;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_CHANGE_NOTIFY	0x04
 
@@ -4455,7 +4459,7 @@ struct bt_l2cap_amp_discover_rsp {
 #define BT_L2CAP_AMP_GET_INFO_REQ	0x06
 struct bt_l2cap_amp_get_info_req {
 	uint8_t  ctrlid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_GET_INFO_RSP	0x07
 struct bt_l2cap_amp_get_info_rsp {
@@ -4466,81 +4470,81 @@ struct bt_l2cap_amp_get_info_rsp {
 	uint32_t min_latency;
 	uint16_t pal_cap;
 	uint16_t max_assoc_len;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_GET_ASSOC_REQ	0x08
 struct bt_l2cap_amp_get_assoc_req {
 	uint8_t  ctrlid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_GET_ASSOC_RSP	0x09
 struct bt_l2cap_amp_get_assoc_rsp {
 	uint8_t  ctrlid;
 	uint8_t  status;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_CREATE_PHY_LINK_REQ	0x0a
 struct bt_l2cap_amp_create_phy_link_req {
 	uint8_t  local_ctrlid;
 	uint8_t  remote_ctrlid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_CREATE_PHY_LINK_RSP	0x0b
 struct bt_l2cap_amp_create_phy_link_rsp {
 	uint8_t  local_ctrlid;
 	uint8_t  remote_ctrlid;
 	uint8_t  status;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_DISCONN_PHY_LINK_REQ	0x0c
 struct bt_l2cap_amp_disconn_phy_link_req {
 	uint8_t  local_ctrlid;
 	uint8_t  remote_ctrlid;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_AMP_DISCONN_PHY_LINK_RSP	0x0d
 struct bt_l2cap_amp_disconn_phy_link_rsp {
 	uint8_t  local_ctrlid;
 	uint8_t  remote_ctrlid;
 	uint8_t  status;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_l2cap_hdr_att {
 	uint8_t  code;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_ERROR_RESPONSE		0x01
 struct bt_l2cap_att_error_response {
 	uint8_t  request;
 	uint16_t handle;
 	uint8_t  error;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_EXCHANGE_MTU_REQ		0x02
 struct bt_l2cap_att_exchange_mtu_req {
 	uint16_t mtu;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_EXCHANGE_MTU_RSP		0x03
 struct bt_l2cap_att_exchange_mtu_rsp {
 	uint16_t mtu;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_READ_TYPE_REQ		0x08
 struct bt_l2cap_att_read_type_req {
 	uint16_t start_handle;
 	uint16_t end_handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_READ_TYPE_RSP		0x09
 struct bt_l2cap_att_read_type_rsp {
 	uint8_t  length;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_READ_REQ			0x0a
 struct bt_l2cap_att_read_req {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_READ_RSP			0x0b
 
@@ -4548,28 +4552,28 @@ struct bt_l2cap_att_read_req {
 struct bt_l2cap_att_read_group_type_req {
 	uint16_t start_handle;
 	uint16_t end_handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_READ_GROUP_TYPE_RSP	0x11
 struct bt_l2cap_att_read_group_type_rsp {
 	uint8_t  length;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_HANDLE_VALUE_NOTIFY	0x1b
 struct bt_l2cap_att_handle_value_notify {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_HANDLE_VALUE_IND		0x1d
 struct bt_l2cap_att_handle_value_ind {
 	uint16_t handle;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_ATT_HANDLE_VALUE_CONF		0x1e
 
 struct bt_l2cap_hdr_smp {
 	uint8_t  code;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_PAIRING_REQUEST	0x01
 struct bt_l2cap_smp_pairing_request {
@@ -4579,7 +4583,7 @@ struct bt_l2cap_smp_pairing_request {
 	uint8_t  max_key_size;
 	uint8_t  init_key_dist;
 	uint8_t  resp_key_dist;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_PAIRING_RESPONSE	0x02
 struct bt_l2cap_smp_pairing_response {
@@ -4589,73 +4593,73 @@ struct bt_l2cap_smp_pairing_response {
 	uint8_t  max_key_size;
 	uint8_t  init_key_dist;
 	uint8_t  resp_key_dist;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_PAIRING_CONFIRM	0x03
 struct bt_l2cap_smp_pairing_confirm {
 	uint8_t  value[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_PAIRING_RANDOM	0x04
 struct bt_l2cap_smp_pairing_random {
 	uint8_t  value[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_PAIRING_FAILED	0x05
 struct bt_l2cap_smp_pairing_failed {
 	uint8_t  reason;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_ENCRYPT_INFO	0x06
 struct bt_l2cap_smp_encrypt_info {
 	uint8_t  ltk[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_CENTRAL_IDENT	0x07
 struct bt_l2cap_smp_central_ident {
 	uint16_t ediv;
 	uint64_t rand;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_IDENT_INFO		0x08
 struct bt_l2cap_smp_ident_info {
 	uint8_t  irk[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_IDENT_ADDR_INFO	0x09
 struct bt_l2cap_smp_ident_addr_info {
 	uint8_t  addr_type;
 	uint8_t  addr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_SIGNING_INFO	0x0a
 struct bt_l2cap_smp_signing_info {
 	uint8_t  csrk[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_SECURITY_REQUEST	0x0b
 struct bt_l2cap_smp_security_request {
 	uint8_t  auth_req;
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_PUBLIC_KEY		0x0c
 struct bt_l2cap_smp_public_key {
 	uint8_t  x[32];
 	uint8_t  y[32];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_DHKEY_CHECK	0x0d
 struct bt_l2cap_smp_dhkey_check {
 	uint8_t  e[16];
-} __attribute__ ((packed));
+} __packed;
 
 #define BT_L2CAP_SMP_KEYPRESS_NOTIFY	0x0e
 struct bt_l2cap_smp_keypress_notify {
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 
 struct bt_sdp_hdr {
 	uint8_t  pdu;
 	uint16_t tid;
 	uint16_t plen;
-} __attribute__ ((packed));
+} __packed;
diff --git a/monitor/packet.c b/monitor/packet.c
index 0ad106eeaf3b..9162b41f72ed 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4689,7 +4689,7 @@ struct broadcast_message {
 	uint16_t right_close_offset;
 	uint16_t frame_sync_period;
 	uint8_t  frame_sync_period_fraction;
-} __attribute__ ((packed));
+} __packed;
 
 static void print_3d_broadcast(const void *data, uint8_t size)
 {
@@ -14680,7 +14680,7 @@ void packet_system_note(struct timeval *tv, struct ucred *cred, uint16_t index,
 struct monitor_l2cap_hdr {
 	uint16_t cid;
 	uint16_t psm;
-} __attribute__((packed));
+} __packed;
 
 static void packet_decode(struct timeval *tv, struct ucred *cred, char dir,
 				uint16_t index, const char *color,
diff --git a/tools/3dsp.c b/tools/3dsp.c
index 267a39e9043b..76026bef29e3 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -37,7 +37,7 @@ struct broadcast_message {
 	uint16_t right_close_offset;
 	uint16_t frame_sync_period;
 	uint8_t  frame_sync_period_fraction;
-} __attribute__ ((packed));
+} __packed;
 
 struct brcm_evt_sync_train_received {
 	uint8_t  status;
@@ -48,7 +48,7 @@ struct brcm_evt_sync_train_received {
 	uint8_t  lt_addr;
 	uint32_t instant;
 	uint16_t interval;
-} __attribute__ ((packed));
+} __packed;
 
 static struct bt_hci *hci_dev;
 
diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 9aaf6428da42..322366a9e1d2 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -35,7 +35,7 @@ struct cmd_reset {
 	uint8_t  otp_ddc_reload;
 	uint8_t  boot_option;
 	uint32_t boot_addr;
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_NO_OPERATION	0xfc02
 
@@ -51,7 +51,7 @@ struct rsp_read_version {
 	uint8_t  fw_build_cw;
 	uint8_t  fw_build_yy;
 	uint8_t  fw_patch;
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_READ_BOOT_PARAMS	0xfc0d
 struct rsp_read_boot_params {
@@ -72,7 +72,7 @@ struct rsp_read_boot_params {
 	uint8_t  min_fw_build_yy;
 	uint8_t  limited_cce;
 	uint8_t  unlocked_state;
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_WRITE_BOOT_PARAMS	0xfc0e
 struct cmd_write_boot_params {
@@ -80,13 +80,13 @@ struct cmd_write_boot_params {
 	uint8_t  fw_build_nn;
 	uint8_t  fw_build_cw;
 	uint8_t  fw_build_yy;
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_MANUFACTURER_MODE	0xfc11
 struct cmd_manufacturer_mode {
 	uint8_t  mode_switch;
 	uint8_t  reset;
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_WRITE_BD_DATA	0xfc2f
 struct cmd_write_bd_data {
@@ -97,7 +97,7 @@ struct cmd_write_bd_data {
 	uint8_t  reserved2[32];
 	uint8_t  lmp_version;
 	uint8_t  reserved3[26];
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_READ_BD_DATA	0xfc30
 struct rsp_read_bd_data {
@@ -109,24 +109,24 @@ struct rsp_read_bd_data {
 	uint8_t  reserved2[32];
 	uint8_t  lmp_version;
 	uint8_t  reserved3[26];
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_WRITE_BD_ADDRESS	0xfc31
 struct cmd_write_bd_address {
 	uint8_t  bdaddr[6];
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_ACT_DEACT_TRACES	0xfc43
 struct cmd_act_deact_traces {
 	uint8_t  tx_trace;
 	uint8_t  tx_arq;
 	uint8_t  rx_trace;
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_TRIGGER_EXCEPTION	0xfc4d
 struct cmd_trigger_exception {
 	uint8_t  type;
-} __attribute__ ((packed));
+} __packed;
 
 #define CMD_DDC_CONFIG_WRITE	0xfc8b
 
@@ -755,7 +755,7 @@ struct ddc {
 	uint8_t  size;
 	uint16_t id;
 	uint8_t  value[0];
-} __attribute__ ((packed));
+} __packed;
 
 static unsigned int analyze_ddc(uint8_t *data, ssize_t len)
 {
@@ -852,7 +852,7 @@ struct css_hdr {
 	uint32_t modulus_size;
 	uint32_t exponent_size;
 	uint8_t  reserved[88];
-} __attribute__ ((packed));
+} __packed;
 
 static void analyze_firmware(const char *path)
 {
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 4002ca561db8..bc4495237b9c 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1701,7 +1701,7 @@ static void setup_powered_client(const void *test_data)
 		struct {
 			struct mgmt_cp_load_conn_subrate cp;
 			struct mgmt_conn_subrate param;
-		} __attribute__((packed)) load;
+		} __packed load;
 
 		client_bdaddr = hciemu_get_client_bdaddr(data->hciemu);
 		if (!client_bdaddr) {
-- 
2.56.0

