Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54A2459C5
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393627; cv=none; b=swW9QA7O0jWLxp2Qzxqxw7AyPV+PTrwmmz5+6te5hcHMbCGkOComA0qGPdjgJ8Y/eyBfh7iafh5y+12L91nBAYm2vAMSLrPMMbacrG2ArYnhEpH+Z7LDcPKPpXF3qikuNAAWxSg/Cff15RlV4GA8hiTvwuhme3QBwU7TiGfEzFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393627; c=relaxed/simple;
	bh=CyIikq0hLTXDF+FpBuTnBJVk/W88tu6lS+rc7BAfckA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eS10iwLe/fPeAg+BcGFynhSicJU+N41Qj60EWcCcDneu38XgAdrQW82RWU9c7BQS5z+X+XqD2EcIL2vVq8dj6qlnfZb58N0RXUi55qmhge5CI46xilmP7OT9p+Vg/w2po1mOmXW3LuTAcht9XsV7eqUKhiaPqmIIfkE3xWeL5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fV2BTftr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fCKcKtcl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fV2BTftr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fCKcKtcl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6awxI3729291
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FkL7rxEMRj1
	TypC8ksxQ64+IST0RCwG8dIdLeWL/ulA=; b=fV2BTftrOPtPEjtb9CH32OdXvSu
	6aKNWsWssuA2HIHsJNjrGPegR19nNM3qs/VvSZ/KvuyESCsJkaXyjpruKSbYElzv
	qFS+qmjjdLxM1JzhleqDH2V6kyIzmK9Z/BhC2uDgrLFekK3tBmS22ofevZT4Sh0R
	VVdG4zdkBlnyXDT88jgDdBduxzdsrYOV/PJNLXwTaVP59T8gtyXb57vQ/XHfeAFF
	5uZf1mVLSee+ywDwqToGb8Qdhne0cOuHGo7N+QNfSt9pmOJMfqA/kDtHQiuEaX00
	etxbkMMbjaQQEJI+FTPPywzLcKDYMotNpbDI5hPK909KQdDO1UMG14Cch7g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr19ag2yn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 06:40:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cd01a14e81so23708495ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785393624; x=1785998424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FkL7rxEMRj1TypC8ksxQ64+IST0RCwG8dIdLeWL/ulA=;
        b=fCKcKtcl18a6J8cVN9FWBTbKfXExUgPFKNFqmeFedoJ4t6pq7FTRd1/Q9w0ixf2CE+
         2J5HqKMGLptJlMgzCw+1Ebx465GEGKj23xNgbX1Sgiy7c8GfShgL1n+DaBglVcx8o0Fe
         ukTl8os74av/aiBRUKseGMUdQDK+Pd/owXxdeonCiLNgv07pMcYO3Vxw4UPG44hZFmJi
         V4UFSD5vsBS33f6dY6i3S0iBOdl4cycUXQfKlTxsMRTpKAJeCtyVLy5PxyTS/z8jFpZJ
         HDe5vN+kCCpVdvxAbANPE31SR3aMo343khYLrYfPpWZBfy5bM/LTyBp9q/UGHilssOwH
         uHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393624; x=1785998424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FkL7rxEMRj1TypC8ksxQ64+IST0RCwG8dIdLeWL/ulA=;
        b=lbkj/P1wYgZOnbhsFDiezdHs7y5QRi2oUOPAnVeb0DWJTalI9lBRGuHNJoGP+ZFTOY
         lKE+TfAjFeOD8UBg6IAZ/3ep+ax0aRQ+EpbACJY2HQQuPWWtMgMVmRTD1xffBYnuZhBW
         UumqMtcf8wfZoTo7r6EzKEcp157SMJ73CpbMl5BuGc5kHpyq/jIbV/OalXOPN8AG/ezC
         SehCdTv3FT1A3eyqHVoRjyI8vKQFuzGhwDjY9zzTg0XBKKY7vcjHbSQ9OfXVtxnGadUa
         RwjcLOuSBE5w/X60S9xamrcGLlkomJXQh5GAUPDRekuR54DTTvjM+fprUuOBTrEyOPAt
         WFkg==
X-Gm-Message-State: AOJu0YwJovYxW1qpkMfqYAZjL9NFBsD9S8PVk8Msfan2ixaDZU3YBdTT
	DMWZ8wmHUwmEkbo1daKlPNe/eedYjgapnHXXciKgYur59wUxIC2GRTSJNvuLZUrV4f4++JHp8dZ
	5YeLEcCw6LZT13FNeHQ9KV/htxHXUsQSj7JObHp0ASgddXVe9BcsIDxftow54P+niwVpuShMJZN
	MusAc=
X-Gm-Gg: AR+sD12Mf4ZW0NWTmJ4heISm+E0rpjC3dDilbilW8lL10tCXJCS177tSGVXTmYdmbNw
	p0XM52ZSvnncSZMEG0hEi7oVe0BVzQ+VGuXhpK15+mFxzyw5PykSLk8vnitifPw0GkC7jjA19b9
	1QybCH+LX1OSm/zqPnDSy/MS/kS0fh00hhy3sA3oi2ysTzxNJHQTa/Bc3qdpp7dbffeDDBKx7FX
	RlekrEtlLzfm3Aaawdyz5Eksd7tNUJox+8RgelCSu7HYRqqE0hypjUpmeb2A0SBi5jeX3le5Wa0
	0v99Y1o8gziobYBUoKBDoARBSt9l7/LUJnAnF2VMNbft66VF+YoUPLLmFyEPGeqyVf1ndZd76g9
	6Th7WsaJKZ+bs4ym9IYL00brzbd4WPw==
X-Received: by 2002:a05:6a20:72a3:b0:3c0:9c19:659d with SMTP id adf61e73a8af0-3c9009ed050mr1132506637.69.1785393623718;
        Wed, 29 Jul 2026 23:40:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a3:b0:3c0:9c19:659d with SMTP id adf61e73a8af0-3c9009ed050mr1132480637.69.1785393623158;
        Wed, 29 Jul 2026 23:40:23 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm26304321c88.5.2026.07.29.23.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:40:22 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v3 2/3] profiles/ranging: Emit CS ProcedureData signal over D-Bus
Date: Thu, 30 Jul 2026 12:10:06 +0530
Message-Id: <20260730064007.1229304-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730064007.1229304-1-naga.akella@oss.qualcomm.com>
References: <20260730064007.1229304-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0NSBTYWx0ZWRfX8k4kMWPpIGpS
 h4Caarzv/A/r4NhLhmnByXZ30WUKFKL7JLrRv3TnE4MnQyyivVMRK43TlsmaSvit+4hERXnF/kX
 UfwpRVMfZE9qSVkNQzXKmak90w5KFt4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0NSBTYWx0ZWRfXw7I+gtne2mf1
 o9xeVgAHgl1gkb4D/+vESAVdo6OMVmBpYZn3mp1VLiI7Mp1+dsQ6kRTLAP2268PrsF3z/059Ie7
 uPWid5ieI8IltSmoPCLauv3+KKV4FijigxMJgrtbpCKLj8kUTlZOOhzfpqvgb15CX8wcl9NgZjZ
 aHvZ+LgidN8J2XAKjp44MU7eCHxk83SleGLgHNJ/UxU7V6UlQUeh70DsM3egzUs4ZxYYom+PVTt
 eWN82NGe6pG5jbf4T4ageIjdg/wzZGRlRdUxMtMBkCaZXldb/4MzK283R5Q2/0s89kBqEqtc21y
 37D19dISW4ajtuJy8xu7UR1obuKxvJclXTGhomJLtm+z6ryRoSLv17LtZa4U6FMqWRYB85dPk1m
 YrzbZJVjNreGP2Q8u8MnyQBhSqeP7oWP1HLA9p676uvdtNbZaO+YHKetxJhP1FTkNEKL1SZgIQm
 n6DmcsZc7UHNOh/JA4w==
X-Proofpoint-GUID: tBEKalQ7OnHn1gu5qU764tmotTBLKXtZ
X-Proofpoint-ORIG-GUID: tBEKalQ7OnHn1gu5qU764tmotTBLKXtZ
X-Authority-Analysis: v=2.4 cv=RPuD2Yi+ c=1 sm=1 tr=0 ts=6a6af1d8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=nbUfrh2uDlpe-W9YnDoA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300045

Serialize completed BCS procedure data (subevent/step results,
CS config, and procedure-enable parameters) into a byte blob and
emit it via a new ProcedureData D-Bus signal on the CS interface,
so an external ranging estimation daemon can consume raw controller
measurements
---
 profiles/ranging/rap.c     | 292 ++++++++++++++++++++++++++++++++++++-
 profiles/ranging/rap_hci.c |  59 ++++++++
 2 files changed, 348 insertions(+), 3 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 91f30ac30..cabf8a5de 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -433,6 +433,274 @@ static const struct cs_dict_param_desc *cs_find_dict_param_desc(
 	return NULL;
 }
 
+/*
+ * ProcedureData is emitted as a single opaque byte blob rather than an
+ * a{sv} dict: every field here is raw controller measurement data with
+ * no standalone meaning, consumed only by an external ranging estimation
+ * daemon that immediately unpacks it again. See
+ * doc/org.bluez.ChannelSounding1.rst for the documented binary layout.
+ *
+ * The blob's size is unbounded (variable subevent/step counts), so every
+ * field is appended with util_iov_append(), which reallocs as needed --
+ * unlike util_iov_push_*(), which assumes a pre-sized buffer.
+ */
+static void blob_push_u8(struct iovec *buf, uint8_t val)
+{
+	util_iov_append(buf, &val, sizeof(val));
+}
+
+static void blob_push_le16(struct iovec *buf, uint16_t val)
+{
+	uint8_t tmp[2];
+
+	put_le16(val, tmp);
+	util_iov_append(buf, tmp, sizeof(tmp));
+}
+
+static void blob_push_le32(struct iovec *buf, uint32_t val)
+{
+	uint8_t tmp[4];
+
+	put_le32(val, tmp);
+	util_iov_append(buf, tmp, sizeof(tmp));
+}
+
+static void blob_push_le64(struct iovec *buf, uint64_t val)
+{
+	uint8_t tmp[8];
+
+	put_le64(val, tmp);
+	util_iov_append(buf, tmp, sizeof(tmp));
+}
+
+static void serialize_mode_zero(struct iovec *buf,
+				const struct cs_mode_zero_data *m0)
+{
+	blob_push_u8(buf, m0->packet_quality);
+	blob_push_u8(buf, m0->packet_rssi_dbm);
+	blob_push_u8(buf, m0->packet_ant);
+	blob_push_le16(buf, m0->init_measured_freq_offset);
+}
+
+static void serialize_mode_one(struct iovec *buf,
+				const struct cs_mode_one_data *m1)
+{
+	blob_push_u8(buf, m1->packet_quality);
+	blob_push_u8(buf, m1->packet_nadm);
+	blob_push_u8(buf, m1->packet_rssi_dbm);
+	blob_push_le16(buf, (uint16_t)m1->toa_tod_init);
+	blob_push_le16(buf, (uint16_t)m1->tod_toa_refl);
+	blob_push_u8(buf, m1->packet_ant);
+	blob_push_le16(buf, (uint16_t)m1->packet_pct1.i_sample);
+	blob_push_le16(buf, (uint16_t)m1->packet_pct1.q_sample);
+	blob_push_le16(buf, (uint16_t)m1->packet_pct2.i_sample);
+	blob_push_le16(buf, (uint16_t)m1->packet_pct2.q_sample);
+}
+
+static void serialize_mode_two(struct iovec *buf,
+				const struct cs_mode_two_data *m2,
+				uint8_t num_ant_paths)
+{
+	int num_paths;
+	int j;
+
+	/*
+	 * num_ant_paths is the HCI "number of antenna paths" value
+	 * (0-indexed), so actual tone sample count = num_ant_paths + 1,
+	 * capped at array size.
+	 */
+	num_paths = (num_ant_paths + 1) < CS_MAX_ANT_PATHS ?
+				(num_ant_paths + 1) : CS_MAX_ANT_PATHS;
+
+	blob_push_u8(buf, m2->ant_perm_index);
+
+	for (j = 0; j < num_paths; j++) {
+		blob_push_le16(buf, (uint16_t)m2->tone_pct[j].i_sample);
+		blob_push_le16(buf, (uint16_t)m2->tone_pct[j].q_sample);
+	}
+
+	for (j = 0; j < num_paths; j++)
+		blob_push_u8(buf, m2->tone_quality_indicator[j]);
+}
+
+static void serialize_proc_enable_config(struct iovec *buf,
+				const struct rap_ev_cs_proc_enable_cmplt *cfg)
+{
+	uint32_t sub_evt_len_us;
+
+	sub_evt_len_us = cfg->sub_evt_len[0] |
+			 ((uint32_t)cfg->sub_evt_len[1] << 8) |
+			 ((uint32_t)cfg->sub_evt_len[2] << 16);
+
+	blob_push_u8(buf, cfg->tone_ant_config_sel);
+	blob_push_le32(buf, sub_evt_len_us);
+	blob_push_u8(buf, cfg->sub_evts_per_evt);
+	blob_push_le16(buf, cfg->sub_evt_intrvl);
+	blob_push_le16(buf, cfg->evt_intrvl);
+	blob_push_le16(buf, cfg->proc_intrvl);
+	blob_push_le16(buf, cfg->proc_counter);
+	blob_push_le16(buf, cfg->max_proc_len);
+}
+
+static void serialize_cs_config_param(struct iovec *buf,
+				const struct bcs_procedure_data *bcs)
+{
+	const struct rap_ev_cs_config_cmplt *cfg = &bcs->cs_config;
+
+	blob_push_u8(buf, cfg->main_mode_type);
+	blob_push_u8(buf, cfg->sub_mode_type);
+	blob_push_u8(buf, cfg->rtt_type);
+	util_iov_append(buf, cfg->channel_map, sizeof(cfg->channel_map));
+	blob_push_u8(buf, cfg->min_main_mode_steps);
+	blob_push_u8(buf, cfg->max_main_mode_steps);
+	blob_push_u8(buf, cfg->main_mode_rep);
+	blob_push_u8(buf, cfg->mode_0_steps);
+	blob_push_u8(buf, cfg->role);
+	blob_push_u8(buf, cfg->cs_sync_phy);
+	blob_push_u8(buf, cfg->channel_sel_type);
+	blob_push_u8(buf, cfg->ch3c_shape);
+	blob_push_u8(buf, cfg->ch3c_jump);
+	blob_push_u8(buf, cfg->channel_map_rep);
+	blob_push_u8(buf, cfg->t_ip1_time);
+	blob_push_u8(buf, cfg->t_ip2_time);
+	blob_push_u8(buf, cfg->t_fcs_time);
+	blob_push_u8(buf, cfg->t_pm_time);
+	blob_push_u8(buf, bcs->t_sw_time_us_supported_by_local);
+	blob_push_u8(buf, bcs->t_sw_time_us_supported_by_remote);
+	blob_push_le16(buf, bcs->ble_conn_interval);
+}
+
+static void serialize_step(struct iovec *buf,
+				const struct cs_step_data *step,
+				uint8_t num_ant_paths)
+{
+	blob_push_u8(buf, step->step_mode);
+	blob_push_u8(buf, step->step_chnl);
+
+	switch (step->step_mode) {
+	case CS_MODE_ZERO:
+		serialize_mode_zero(buf, &step->step_mode_data.mode_zero_data);
+		break;
+
+	case CS_MODE_ONE:
+		serialize_mode_one(buf, &step->step_mode_data.mode_one_data);
+		break;
+
+	case CS_MODE_TWO:
+		serialize_mode_two(buf, &step->step_mode_data.mode_two_data,
+					num_ant_paths);
+		break;
+
+	case CS_MODE_THREE:
+		serialize_mode_one(buf,
+			&step->step_mode_data.mode_three_data.mode_one_data);
+		serialize_mode_two(buf,
+			&step->step_mode_data.mode_three_data.mode_two_data,
+			num_ant_paths);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void serialize_subevent(struct iovec *buf,
+				const struct cs_subevent_result_data *sub)
+{
+	uint32_t i;
+
+	blob_push_le16(buf, sub->start_acl_conn_evt_counter);
+	blob_push_le16(buf, sub->freq_comp);
+	blob_push_u8(buf, (uint8_t)sub->ref_pwr_lvl);
+	blob_push_u8(buf, sub->num_ant_paths);
+	blob_push_u8(buf, sub->subevent_abort_reason);
+	blob_push_le64(buf, sub->timestamp_nanos);
+	blob_push_le32(buf, sub->num_steps);
+
+	if (!sub->step_data)
+		return;
+
+	for (i = 0; i < sub->num_steps; i++)
+		serialize_step(buf, &sub->step_data[i], sub->num_ant_paths);
+}
+
+static void serialize_subevent_array(struct iovec *buf,
+				const struct cs_subevent_result_data *subevents,
+				uint32_t count)
+{
+	uint32_t i;
+
+	for (i = 0; i < count; i++)
+		serialize_subevent(buf, &subevents[i]);
+}
+
+static void rap_emit_procedure_data(struct rap_data *data,
+				const struct bcs_procedure_data *bcs)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter, array;
+	struct iovec blob = { 0 };
+	const uint8_t *ptr;
+
+	signal = dbus_message_new_signal(device_get_path(data->device),
+					 CS_INTERFACE, "ProcedureData");
+	if (!signal) {
+		error("Failed to allocate ProcedureData signal");
+		return;
+	}
+
+	blob_push_le16(&blob, bcs->procedure_counter);
+	blob_push_le16(&blob, bcs->procedure_sequence);
+	blob_push_u8(&blob, (uint8_t)bcs->initiator_selected_tx_power);
+	blob_push_u8(&blob, (uint8_t)bcs->reflector_selected_tx_power);
+
+	if (!bcs->initiator_subevent_results) {
+		blob_push_le32(&blob, 0);
+	} else {
+		blob_push_le32(&blob, bcs->initiator_subevent_count);
+		serialize_subevent_array(&blob,
+					bcs->initiator_subevent_results,
+					bcs->initiator_subevent_count);
+	}
+
+	blob_push_u8(&blob, bcs->initiator_procedure_abort_reason);
+
+	if (!bcs->reflector_subevent_results) {
+		blob_push_le32(&blob, 0);
+	} else {
+		blob_push_le32(&blob, bcs->reflector_subevent_count);
+		serialize_subevent_array(&blob,
+					bcs->reflector_subevent_results,
+					bcs->reflector_subevent_count);
+	}
+
+	blob_push_u8(&blob, bcs->reflector_procedure_abort_reason);
+
+	serialize_proc_enable_config(&blob, &bcs->proc_enable_config);
+	serialize_cs_config_param(&blob, bcs);
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "y", &array);
+	ptr = blob.iov_base;
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE, &ptr,
+						blob.iov_len);
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(btd_get_dbus_connection(), signal);
+
+	free(blob.iov_base);
+}
+
+static void rap_procedure_data(struct bt_rap *rap,
+				struct bcs_procedure_data *bcs,
+				void *user_data)
+{
+	struct rap_data *data = user_data;
+
+	DBG("procedure_counter=%u", bcs->procedure_counter);
+	rap_emit_procedure_data(data, bcs);
+}
+
 static DBusMessage *start_measurement(DBusConnection *conn,
 				DBusMessage *msg, void *user_data)
 {
@@ -588,6 +856,9 @@ bad_type:
 	data->active_session.cfg           = cfg;
 	data->active_session.freq          = freq;
 
+	bt_rap_hci_set_procedure_data_cb(data->hci_sm, rap_procedure_data,
+					 data, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -605,6 +876,8 @@ static DBusMessage *stop_measurement(DBusConnection *conn,
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
 					"Stop measurement failed");
 
+	bt_rap_hci_set_procedure_data_cb(data->hci_sm, NULL, NULL, NULL);
+
 	memset(&data->active_session, 0, sizeof(data->active_session));
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -642,6 +915,11 @@ static const GDBusPropertyTable cs_dbus_properties[] = {
 	{ }
 };
 
+static const GDBusSignalTable cs_dbus_signals[] = {
+	{ GDBUS_SIGNAL("ProcedureData", GDBUS_ARGS({ "data", "ay" })) },
+	{ }
+};
+
 static void rap_measurement_timeout_cb(void *user_data)
 {
 	struct rap_data *data = user_data;
@@ -720,6 +998,10 @@ static void rap_remove(struct btd_service *service)
 		return;
 	}
 
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				    device_get_path(device),
+				    CS_INTERFACE);
+
 	rap_data_remove(data);
 }
 
@@ -794,9 +1076,9 @@ static int rap_setup_reflector(struct rap_data *data)
 
 	if (!data->dbus_registered) {
 		if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					device_get_path(device),
-					CS_INTERFACE, cs_dbus_methods,
-					NULL, cs_dbus_properties, data, NULL)) {
+			 device_get_path(device),
+			CS_INTERFACE, cs_dbus_methods,
+			cs_dbus_signals, cs_dbus_properties, data, NULL)) {
 			error("Failed to register %s interface for %s",
 				CS_INTERFACE, addr);
 			return -EINVAL;
@@ -854,6 +1136,10 @@ static int rap_disconnect(struct btd_service *service)
 		data->conn_handle = 0;
 	}
 
+	if (data->hci_sm)
+		bt_rap_hci_set_procedure_data_cb(data->hci_sm, NULL, NULL,
+							NULL);
+
 	memset(&data->active_session, 0, sizeof(data->active_session));
 
 	btd_service_disconnecting_complete(service, 0);
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 58ccf87bf..66bc7b5eb 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -437,6 +437,8 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 	DBG("  T_SW Time Supported: %u", rsp->t_sw_time_supported);
 	DBG("  TX SNR Capability: 0x%02X", rsp->tx_snr_capability);
 
+	bt_rap_set_local_sw_time(sm->rap, rsp->t_sw_time_supported);
+
 	/* Transition to INIT state before reading remote capabilities */
 	cs_set_state(sm, CS_STATE_INIT);
 
@@ -860,6 +862,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 	subfeatures_supported = le16_to_cpu(evt->subfeatures_supported);
 	DBG("subfeatures_supported=0x%04X", subfeatures_supported);
 
+	bt_rap_set_remote_sw_time(sm->rap, evt->t_sw_time_supported);
+
 	/* Check Bit 1 of subfeatures_supported (0x0002) */
 	if (!(subfeatures_supported & 0x0002)) {
 		DBG("Bit 1 not set, sending Read Remote FAE Table");
@@ -1169,6 +1173,46 @@ static void rap_cs_proc_enable_cmplt_evt(const void *data, uint8_t size,
 			&rap_ev, sm->rap);
 }
 
+static void rap_le_conn_update_complete_evt(const void *data, uint8_t size,
+					    void *user_data)
+{
+	struct cs_state_machine *sm = user_data;
+	const struct bt_hci_evt_le_conn_update_complete *evt;
+	struct rap_conn_mapping *mapping;
+	struct bt_rap *rap;
+	struct iovec iov;
+
+	if (!sm || !data ||
+	    size < sizeof(struct bt_hci_evt_le_conn_update_complete))
+		return;
+
+	iov.iov_base = (void *)data;
+	iov.iov_len = size;
+
+	evt = util_iov_pull_mem(&iov, sizeof(*evt));
+	if (!evt) {
+		error("Failed to pull LE conn update complete struct");
+		return;
+	}
+
+	DBG("status=0x%02X handle=0x%04X interval=%u",
+	    evt->status, evt->handle, evt->interval);
+
+	if (evt->status != 0)
+		return;
+
+	mapping = find_mapping_by_handle(sm, evt->handle);
+	if (mapping && mapping->rap) {
+		DBG("Found handle 0x%04X in mapping cache", evt->handle);
+		rap = mapping->rap;
+	} else {
+		DBG("No RAP mapping for handle 0x%04X, ignoring", evt->handle);
+		return;
+	}
+
+	bt_rap_set_conn_interval(rap, evt->interval);
+}
+
 static void parse_i_q_sample(struct iovec *iov, int16_t *i_sample,
 				int16_t *q_sample)
 {
@@ -1669,6 +1713,8 @@ void *bt_rap_attach_hci(struct bt_rap *rap, struct bt_hci *hci,
 					rap_cs_subevt_result_evt },
 		{ BT_HCI_EVT_LE_CS_SUBEVENT_RESULT_CONTINUE,
 					rap_cs_subevt_result_cont_evt },
+		{ BT_HCI_EVT_LE_CONN_UPDATE_COMPLETE,
+					rap_le_conn_update_complete_evt },
 	};
 	struct cs_state_machine *sm;
 	unsigned int i;
@@ -1788,6 +1834,19 @@ bool bt_rap_stop_measurement(void *hci_sm)
 						false);
 }
 
+bool bt_rap_hci_set_procedure_data_cb(void *hci_sm,
+				bt_rap_procedure_data_func_t cb,
+				void *user_data,
+				bt_rap_destroy_func_t destroy)
+{
+	struct cs_state_machine *sm = hci_sm;
+
+	if (!sm || !sm->rap)
+		return false;
+
+	return bt_rap_set_procedure_data_cb(sm->rap, cb, user_data, destroy);
+}
+
 bool bt_rap_set_conn_hndl(void *hci_sm, struct bt_rap *rap,
 		uint16_t handle, const uint8_t *bdaddr, uint8_t bdaddr_type,
 		bool is_central)
-- 
