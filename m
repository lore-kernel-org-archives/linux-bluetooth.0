Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651C34166B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885102; cv=none; b=Bx30G201Frwx2ONpvumNNyi8sYT6uAD2qc+585RU3FDjdOlSoO7/6xb1rfFWaTj3ZBes2j7eFCqcMtNrLYe82j3VMvXZB1BuCnl5E7KlF2UTCkN6HaVLeMZ4zWPTJshzn7Ee/zfn/DjOEjlVXjneASFV7Ve+O6RshFMZtgRNBZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885102; c=relaxed/simple;
	bh=7nIVoKVThy65uPDZOkGoE/z4N51+dwDHf+GjY0+w28o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SgUyRkYKuYXwE4BG7Q+mQZj37rd+GiHR/T+yqUGXvg3KlhaTxh+oGtNBx4nJj0MElwCQbngV+4ofQyvmM2g89JsiKtehcbQcGRj6Ul/xmSx1AjxGItCXj5tdUH1/aArWu/ai11uiE7p0hh8epPIakoNWEmdna9wioZZf5VjdTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkLzKrM7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PycaOnZi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkLzKrM7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PycaOnZi"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG8JkUH2573615
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TgYAN4yw6y4+L04Z4M0np2Q+16k4jSDGpfP
	mbYe7oJk=; b=RkLzKrM7z07SCWiyseQdCZ8hsSDn1la7WHh06xcAThuBcjsg/gs
	f5Ic8Qy9x7BalpZT61GmbPkesgm9oXsk1sNisdQobjSjLSM86WEpme2hXZZgUn4D
	d0uB52Q+rVKbaVuaM5I7I8SwHhtBcygedV3KK1owlmTrmvQSbkFEErpnhAo+4x/d
	udF3JD8vNyoG1VC9aHhNqVGnTQyukmmhF3XinPf0bZmzHShqKSap86Le3UkkTqoE
	AzOKgaAvGwKQnG1+XZqIihMkpIrknzQqfxhI5ifEwl+s8dqDrDtKFg1J7rAamA0d
	lKW3wOtQRLMCPYznRu2rFM1p5jwxmC/M5/A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33thru5m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:38:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c5d203988so5739966a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 03:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765885098; x=1766489898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TgYAN4yw6y4+L04Z4M0np2Q+16k4jSDGpfPmbYe7oJk=;
        b=PycaOnZivwcLDZIno3AICK+f+r5J+ix6lz85/M+pymKKL7+5o390bbHGerSygWdZBU
         wxkZdbS6EHxrjRdH5fYPJeDNzxhrbOAhmNwJ8fZA+uigJBKVYtLK7AqfwVlXomvtH8AO
         qpYBJKEG5sJ8STrxvAvs4ow71bCcWoFRtpkyg0E4n3vKjBkENyLLDru1eNXd3NJvbz1E
         kZrftY3Q7lt37qwZ4rJ2vi3PJsJp5qB7ATAlFYJLjCk9NtSqSoANeE9mCUgdqsms+am1
         POeXg1IPLZ9SQqCsY/EJ+WyARmKXzOCBzC+IntgF8Ovs4DFjjyrlt1coe1BGVITTnC5U
         QoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885098; x=1766489898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgYAN4yw6y4+L04Z4M0np2Q+16k4jSDGpfPmbYe7oJk=;
        b=UDDL+2SIpkPJydZ0cdbDIaGrzWosw6QIo0TlZYzGhm9+8e/esddMnVvK8otOdCyfbs
         S9u2Xios20IhxRc0OA/PoIPYj0Ooyi9O7Sa5a5It39K0srkQ+FhZ0HkP58XSm2a91e6M
         XrW84C/cWmKE8M+AJOAO6TQ6ib5aY5fN486pbdyqYvUMSzGETWDb6sc8X5Gv4qYRKPGh
         iCCt5DKF3oRHpCcBV1wQehIb+z37xBxJKDOk+jwXjRuC3GJoLpYFNa79JEBPLH8YSvy+
         DF6hJxKcIvbxTswFd6leHgC2q4KUHFIlNeqVvSuzIb3pxI8bbWCTLBnrHbw/fvDH4Ict
         wWNw==
X-Forwarded-Encrypted: i=1; AJvYcCVx1SzsWprUXvXFcfOOulZPJnqI66tBH9fpIw+wgwcyutJVbbSWW/21l6417KK8q7ZeoQHw5Nsv8tWC2+Y/BIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZgj+eg8c/k+9KJrGHxN4fXpnAyp6vT+DzFl/RYJA5BvaWS97
	G6+QXSyGUWMadCxtrrNEmi92QEY8toyl4Qcm2uIXQeiKwfL08VsQiUN9e0yWhfAhCgky95EZhSp
	e+srgm+ZBbI4j3H1HokT+xsyykunHNiag8hEMUI9mq72hxSQmg+HZpiGvrNkYsoDROWhtrJM=
X-Gm-Gg: AY/fxX4wHW7jO1PxFA9lfkqv8tOhk/TzZyIgA0dszSK+E26lJ+oWVa99M++3FtKAGzH
	6O4DQj6GPy9IjHHh/7zW/L3zzWOKzebIV9fqiWuz+1vryee2O18gpdSMrKab2yZXcFQKrI6lU/5
	JfYMWhFjA7fdgJSsOmjf880hchlbimcHjvTrpySC1gu80b7o6ekPVeHJ8DMUtTj9chs/ho0pA62
	Y4y9sQq0KqVI+dw/Vv999Zxe8RRms5vpD4BeVzOIZvkLdeRj3CE1A494ovvNG4fYtDl66DGgxAS
	e6Mt7fq99bNvlE3IKkpyjTdiGGm9ga4aG8jgMyYN0vzaOklwMm++Z7jTIl4siDAqQe5bBoAaMfD
	Z/7QWT/SxdxY1ZUl9tfMWq0ERVbYM1FoifePHtwg=
X-Received: by 2002:a17:90b:5548:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-34abd76c9c3mr13237336a91.24.1765885098364;
        Tue, 16 Dec 2025 03:38:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcVJEPeG7P/u2oRZcEqqVrh4H9YnPnZW1cJy+TtF08gxo0XlstyOjV8povT0OJpkbw6i30+w==
X-Received: by 2002:a17:90b:5548:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-34abd76c9c3mr13237313a91.24.1765885097844;
        Tue, 16 Dec 2025 03:38:17 -0800 (PST)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba5eesm11384625a91.6.2025.12.16.03.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:38:17 -0800 (PST)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: anubhavg@qti.qualcomm.com, mohamull@qti.qualcomm.com,
        hbandi@qti.qualcomm.com, Simon Horman <horms@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH v1] Bluetooth: hci_sync: Initial LE Channel Sounding support by defining required HCI command/event structures.
Date: Tue, 16 Dec 2025 17:07:53 +0530
Message-Id: <20251216113753.3969183-1-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZIPaWH7b c=1 sm=1 tr=0 ts=694144ab cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bzIxpeA4gcRnvUxJc7wA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: E6BmE80HTHqICmoyggQN4muiOaUtRd7o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA5OCBTYWx0ZWRfX8t727BvcztAl
 H6YGoYg4fvc9THAAeGk6sn8EWcHrbVGSabuOzARkyyvcyBz6brVA+lJxbPvLV3irGCsKPS7Jon0
 kKBZ2e+FoOK0dH0KyXWUicyfPkytLXnwWA5dMZqufFnZ2o3ZKPkl57+Yp66DjrJVl1Cfoylnoli
 iS8NVdYlWPwxUZo4br7SVyRbae8txr/aN/Br75YTYvVkasAypY3LE0VsI+0MSZP8byHMVW1z15d
 imT8FJZFFRWxz8Z1quQMo7PmWpUKpyfHQcCBVg9/XCn3ZjV/aimlvO+AXARDvMiWspEY4YtlDQF
 4bwsnZjeQ3C8FpbfmB2biFbf4Y9YdqefvEccmKBg4QXQ6UkOM88OF6f52XWchEO5NRZ8ZJaLqGV
 paYQRZkkZpKRp9vKoSR+Ma1ORr6A7Q==
X-Proofpoint-ORIG-GUID: E6BmE80HTHqICmoyggQN4muiOaUtRd7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160098

1. Implementing the LE Event Mask to include events required for
   LE Channel Sounding.
2. Enabling the Channel Sounding feature bit in the
   LE Host Supported Features command.
3. Defining HCI command and event structures necessary for
   LE Channel Sounding functionality.

Signed-off-by: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h      | 323 +++++++++++++++++++++++++++++++
 include/net/bluetooth/hci_core.h |   6 +
 net/bluetooth/hci_sync.c         |  15 ++
 3 files changed, 344 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index a27cd3626b87..33ec8ddd2119 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -654,6 +654,8 @@ enum {
 #define HCI_LE_ISO_BROADCASTER		0x40
 #define HCI_LE_ISO_SYNC_RECEIVER	0x80
 #define HCI_LE_LL_EXT_FEATURE		0x80
+#define HCI_LE_CHANNEL_SOUNDING		0x40
+#define HCI_LE_CHANNEL_SOUNDING_HOST	0x80
 
 /* Connection modes */
 #define HCI_CM_ACTIVE	0x0000
@@ -2269,6 +2271,204 @@ struct hci_cp_le_read_all_remote_features {
 	__u8	 pages;
 } __packed;
 
+/* Channel Sounding Commands */
+#define HCI_OP_LE_CS_RD_LOCAL_SUPP_CAP	0x2089
+struct hci_rp_le_cs_rd_local_supp_cap {
+	__u8	status;
+	__u8	num_config_supported;
+	__le16	max_consecutive_procedures_supported;
+	__u8	num_antennas_supported;
+	__u8	max_antenna_paths_supported;
+	__u8	roles_supported;
+	__u8	modes_supported;
+	__u8	rtt_capability;
+	__u8	rtt_aa_only_n;
+	__u8	rtt_sounding_n;
+	__u8	rtt_random_payload_n;
+	__le16	nadm_sounding_capability;
+	__le16	nadm_random_capability;
+	__u8	cs_sync_phys_supported;
+	__le16	subfeatures_supported;
+	__le16	t_ip1_times_supported;
+	__le16	t_ip2_times_supported;
+	__le16	t_fcs_times_supported;
+	__le16	t_pm_times_supported;
+	__u8	t_sw_time_supported;
+	__u8	tx_snr_capability;
+} __packed;
+
+#define HCI_OP_LE_CS_RD_RMT_SUPP_CAP		0x208A
+struct hci_cp_le_cs_rd_local_supp_cap {
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_WR_CACHED_RMT_SUPP_CAP	0x208B
+struct hci_cp_le_cs_wr_cached_rmt_supp_cap {
+	__le16	conn_hdl;
+	__u8	num_config_supported;
+	__le16	max_consecutive_procedures_supported;
+	__u8	num_antennas_supported;
+	__u8	max_antenna_paths_supported;
+	__u8	roles_supported;
+	__u8	modes_supported;
+	__u8	rtt_capability;
+	__u8	rtt_aa_only_n;
+	__u8	rtt_sounding_n;
+	__u8	rtt_random_payload_n;
+	__le16	nadm_sounding_capability;
+	__le16	nadm_random_capability;
+	__u8	cs_sync_phys_supported;
+	__le16	subfeatures_supported;
+	__le16	t_ip1_times_supported;
+	__le16	t_ip2_times_supported;
+	__le16	t_fcs_times_supported;
+	__le16	t_pm_times_supported;
+	__u8	t_sw_time_supported;
+	__u8	tx_snr_capability;
+} __packed;
+
+struct hci_rp_le_cs_wr_cached_rmt_supp_cap {
+	__u8	status;
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_SEC_ENABLE			0x208C
+struct hci_cp_le_cs_sec_enable {
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_DEFAULT_SETTINGS	0x208D
+struct hci_cp_le_cs_set_default_settings {
+	__le16  conn_hdl;
+	__u8    role_enable;
+	__u8    cs_sync_ant_sel;
+	__s8    max_tx_power;
+} __packed;
+
+struct hci_rp_le_cs_set_default_settings {
+	__u8    status;
+	__le16  conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_RD_RMT_FAE_TABLE		0x208E
+struct hci_cp_le_cs_rd_rmt_fae_table {
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_WR_CACHED_RMT_FAE_TABLE	0x208F
+struct hci_cp_le_cs_wr_rmt_cached_fae_table {
+	__le16	conn_hdl;
+	__u8	remote_fae_table[72];
+} __packed;
+
+struct hci_rp_le_cs_wr_rmt_cached_fae_table {
+	__u8    status;
+	__le16  conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_CREATE_CONFIG		0x2090
+struct hci_cp_le_cs_create_config {
+	__le16	conn_hdl;
+	__u8	config_id;
+	__u8	create_context;
+	__u8	main_mode_type;
+	__u8	sub_mode_type;
+	__u8	min_main_mode_steps;
+	__u8	max_main_mode_steps;
+	__u8	main_mode_repetition;
+	__u8	mode_0_steps;
+	__u8	role;
+	__u8	rtt_type;
+	__u8	cs_sync_phy;
+	__u8	channel_map[10];
+	__u8	channel_map_repetition;
+	__u8	channel_selection_type;
+	__u8	ch3c_shape;
+	__u8	ch3c_jump;
+	__u8	reserved;
+} __packed;
+
+#define HCI_OP_LE_CS_REMOVE_CONFIG		0x2091
+struct hci_cp_le_cs_remove_config {
+	__le16	conn_hdl;
+	__u8	config_id;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_CH_CLASSIFICATION	0x2092
+struct hci_cp_le_cs_set_ch_classification {
+	__u8	ch_classification[10];
+} __packed;
+
+struct hci_rp_le_cs_set_ch_classification {
+	__u8    status;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_PROC_PARAM		0x2093
+struct hci_cp_le_cs_set_proc_param {
+	__le16  conn_hdl;
+	__u8	config_id;
+	__le16	max_procedure_len;
+	__le16	min_procedure_interval;
+	__le16	max_procedure_interval;
+	__le16	max_procedure_count;
+	__u8	min_subevent_len[3];
+	__u8	max_subevent_len[3];
+	__u8	tone_antenna_config_selection;
+	__u8	phy;
+	__u8	tx_power_delta;
+	__u8	preferred_peer_antenna;
+	__u8	snr_control_initiator;
+	__u8	snr_control_reflector;
+} __packed;
+
+struct hci_rp_le_cs_set_proc_param {
+	__u8    status;
+	__le16  conn_hdl;
+} __packed;
+
+#define HCI_OP_LE_CS_SET_PROC_ENABLE		0x2094
+struct hci_cp_le_cs_set_proc_param {
+	__le16  conn_hdl;
+	__u8	config_id;
+	__u8	enable;
+} __packed;
+
+#define HCI_OP_LE_CS_TEST			0x2095
+struct hci_cp_le_cs_test {
+	__u8	main_mode_type;
+	__u8	sub_mode_type;
+	__u8	main_mode_repetition;
+	__u8	mode_0_steps;
+	__u8	role;
+	__u8	rtt_type;
+	__u8	cs_sync_phy;
+	__u8	cs_sync_antenna_selection;
+	__u8	subevent_len[3];
+	__le16	subevent_interval;
+	__u8	max_num_subevents;
+	__u8	transmit_power_level;
+	__u8	t_ip1_time;
+	__u8	t_ip2_time;
+	__u8	t_fcs_time;
+	__u8	t_pm_time;
+	__u8	t_sw_time;
+	__u8	tone_antenna_config_selection;
+	__u8	reserved;
+	__u8	snr_control_initiator;
+	__u8	snr_control_reflector;
+	__le16	drbg_nonce;
+	__u8	channel_map_repetition;
+	__le16	override_config;
+	__u8	override_parameters_length;
+	__u8	override_parameters_data[];
+} __packed;
+
+struct hci_rp_le_cs_test {
+	__u8    status;
+} __packed;
+
+#define HCI_OP_LE_CS_TEST_END			0x2096
+
 /* ---- HCI Events ---- */
 struct hci_ev_status {
 	__u8    status;
@@ -2960,6 +3160,129 @@ struct hci_evt_le_read_all_remote_features_complete {
 	__u8    features[248];
 } __packed;
 
+/* Channel Sounding Events */
+#define HCI_EVT_LE_CS_READ_RMT_SUPP_CAP_COMPLETE	0x2C
+struct hci_evt_le_cs_read_rmt_supp_cap_complete {
+	__u8	status;
+	__le16	conn_hdl;
+	__u8	num_configs_supp;
+	__le16	max_consec_proc_supp;
+	__u8	num_ant_supp;
+	__u8	max_ant_path_supp;
+	__u8	roles_supp;
+	__u8	modes_supp;
+	__u8	rtt_cap;
+	__u8	rtt_aa_only_n;
+	__u8	rtt_sounding_n;
+	__u8	rtt_rand_payload_n;
+	__le16	nadm_sounding_cap;
+	__le16	nadm_rand_cap;
+	__u8	cs_sync_phys_supp;
+	__le16	sub_feat_supp;
+	__le16	t_ip1_times_supp;
+	__le16	t_ip2_times_supp;
+	__le16	t_fcs_times_supp;
+	__le16	t_pm_times_supp;
+	__u8	t_sw_times_supp;
+	__u8	tx_snr_cap;
+} __packed;
+
+#define HCI_EVT_LE_CS_READ_RMT_FAE_TABLE_COMPLETE	0x2D
+struct hci_evt_le_cs_read_rmt_fae_table_complete {
+	__u8	status;
+	__le16	conn_hdl;
+	__u8	remote_fae_table[72];
+} __packed;
+
+#define HCI_EVT_LE_CS_SECURITY_ENABLE_COMPLETE		0x2E
+struct hci_evt_le_cs_security_enable_complete {
+	__u8	status;
+	__le16	conn_hdl;
+} __packed;
+
+#define HCI_EVT_LE_CS_CONFIG_COMPLETE			0x2F
+struct hci_evt_le_cs_config_complete {
+	__u8	status;
+	__le16	conn_hdl;
+	__u8	config_id;
+	__u8	action;
+	__u8	main_mode_type;
+	__u8	sub_mode_type;
+	__u8	min_main_mode_steps;
+	__u8	max_main_mode_steps;
+	__u8	main_mode_rep;
+	__u8	mode_0_steps;
+	__u8	role;
+	__u8	rtt_type;
+	__u8	cs_sync_phy;
+	__u8	channel_map[10];
+	__u8	channel_map_rep;
+	__u8	channel_sel_type;
+	__u8	ch3c_shape;
+	__u8	ch3c_jump;
+	__u8	reserved;
+	__u8	t_ip1_time;
+	__u8	t_ip2_time;
+	__u8	t_fcs_time;
+	__u8	t_pm_time;
+} __packed;
+
+#define HCI_EVT_LE_CS_PROCEDURE_ENABLE_COMPLETE		0x30
+struct hci_evt_le_cs_procedure_enable_complete {
+	__u8	status;
+	__le16	conn_hdl;
+	__u8	config_id;
+	__u8	state;
+	__u8	tone_ant_config_sel;
+	__s8	sel_tx_pwr;
+	__u8	sub_evt_len[3];
+	__u8	sub_evts_per_evt;
+	__le16	sub_evt_intrvl;
+	__le16	evt_intrvl;
+	__le16	proc_intrvl;
+	__le16	proc_counter;
+	__le16	max_proc_len;
+} __packed;
+
+#define HCI_EVT_LE_CS_SUBEVENT_RESULT			0x31
+struct hci_evt_le_cs_subevent_result {
+	__le16	conn_hdl;
+	__u8	config_id;
+	__le16	start_acl_conn_evt_counter;
+	__le16	proc_counter;
+	__le16	freq_comp;
+	__u8	ref_pwr_lvl;
+	__u8	proc_done_status;
+	__u8	subevt_done_status;
+	__u8	abort_reason;
+	__u8	num_ant_paths;
+	__u8	num_steps_reported;
+	__u8	step_mode[0]; /* depends on num_steps_reported */
+	__u8	step_channel[0]; /* depends on num_steps_reported */
+	__u8	step_data_length[0]; /* depends on num_steps_reported */
+	__u8	step_data[0]; /* depends on num_steps_reported */
+} __packed;
+
+#define HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE		0x32
+struct hci_evt_le_cs_subevent_result_continue {
+	__le16	conn_hdl;
+	__u8	config_id;
+	__u8	proc_done_status;
+	__u8	subevt_done_status;
+	__u8	abort_reason;
+	__u8	num_ant_paths;
+	__u8	num_steps_reported;
+	__u8	step_mode[0]; /* depends on num_steps_reported */
+	__u8	step_channel[0]; /* depends on num_steps_reported */
+	__u8	step_data_length[0]; /* depends on num_steps_reported */
+	__u8	step_data[0]; /* depends on num_steps_reported */
+} __packed;
+
+#define HCI_EVT_LE_CS_TEST_END_COMPLETE			0x33
+struct hci_evt_le_cs_test_end_complete {
+	__u8	status;
+} __packed;
+
 #define HCI_EV_VENDOR			0xff
 
 /* Internal events generated by Bluetooth stack */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4263e71a23ef..0152299a00b9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2071,6 +2071,12 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define ll_ext_feature_capable(dev) \
 	((dev)->le_features[7] & HCI_LE_LL_EXT_FEATURE)
 
+/* Channel sounding support */
+#define chann_sounding_capable(dev) \
+	(((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING))
+#define chann_sounding_host_capable(dev) \
+	(((dev)->le_features[5] & HCI_LE_CHANNEL_SOUNDING_HOST))
+
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a9f5b1a68356..67b2c55ec043 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4427,6 +4427,17 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 		events[4] |= 0x02;	/* LE BIG Info Advertising Report */
 	}
 
+	if (chann_sounding_capable(hdev)) {
+		/* Channel Sounding events */
+		events[5] |= 0x08;	/* LE CS Read Remote Supported Cap Complete event */
+		events[5] |= 0x10;	/* LE CS Read Remote FAE Table Complete event */
+		events[5] |= 0x20;	/* LE CS Security Enable Complete event */
+		events[5] |= 0x40;	/* LE CS Config Complete event */
+		events[5] |= 0x80;	/* LE CS Procedure Enable Complete event */
+		events[6] |= 0x01;	/* LE CS Subevent Result event */
+		events[6] |= 0x02;	/* LE CS Subevent Result Continue event */
+		events[6] |= 0x04;	/* LE CS Test End Complete event */
+	}
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EVENT_MASK,
 				     sizeof(events), events, HCI_CMD_TIMEOUT);
 }
@@ -4572,6 +4583,10 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 	cp.bit_number = 32;
 	cp.bit_value = iso_enabled(hdev) ? 0x01 : 0x00;
 
+	/* Channel Sounding (Host Support) */
+	cp.bit_number = 47;
+	cp.bit_value = chann_sounding_capable(hdev) ? 0x01 : 0x00;
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

