Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFC3C3F63
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321037; cv=none; b=BCB2M74A9blC/u+u5pAxJLn8bQiKqlqw352xSLW2E+tfq+Si/Kqw/Ge4FHXbYjDv39KD3749KU4pCEVtiUrRP+frAhiMmMYM6a48TpHoWhFGzHZKzMssJCk2X6zFtqZnFJJC90AMBK7yECY2DkDHDFxMcYN8DPMxaC1lDlhirRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321037; c=relaxed/simple;
	bh=f1XK2aPRO6WkDZ/MfSQ6WGdgbUvaS6iztL2I+AiY7R8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NeQ0blKcm6Rc5BbIvIR1McbuFSUfM/8OhQsXFi5fty/J4S80+P7EqZgmYa0RfoPiKqvJFl4jZVuZxbE8tTXpQwRFzqRKrninpdqPX1fyJbrZ3QkBmN5UKCbT11QvVafliVC3+qR7uConLEaHIUn2TWLLIQafXUmBILixWONXsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aNd0BQEQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DTsWPuOJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aNd0BQEQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DTsWPuOJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T8hthb1484359
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BPbCOLGFGCg
	fEBoolz6wAbP1WXsfFMpggTDXNEE6vlc=; b=aNd0BQEQhRDFZT9a1jrlRBT0mYi
	g/9exxkFH6+Id6K9i1YhO25ye+eI9M7lIzs/1vbOQk35X4Mccy9yz0JJXm7s2Fo5
	zxGABEOQjOQe59azhrz9yZt48GoAHnestOINM7uBYv2XxoiRQb9kt9/XuaBvCrfw
	1J/Dn168AfJmwr2J0lXzSHnB6xJkxmcZtdcx3GEARn0aR6KmeuprdTWgej0CVfoi
	c/VBivp99g1hDW2epODq/tTs0HOGaTlHtqasKp9GUhVaGySe/u1F1OJJEUbyKQzd
	UpqgnBsEhzfNlKL7bLdZ35wUwUyqntmXZT0uboCaP/QR3zi4tGyUEu0UuuQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqe920fk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 10:30:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3811279d51aso1393447a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785321034; x=1785925834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BPbCOLGFGCgfEBoolz6wAbP1WXsfFMpggTDXNEE6vlc=;
        b=DTsWPuOJmjd2QoJqoTQIiXBpNc5wPlLki0D75c/mWFh5ruaYTCOlvuJfOtj6C4LLRj
         fYkxAvWB4WZdXqGPVaRCnVKe1+QkgAvbE6cUTrb+b71UFCTGCjIymsFpN8DCu3cCNnmN
         O3Rmr2SJZUHPoHbBxMeAtd6MtT9jGmDeLSwAbVk8mGFrvwn64TZ+kYzgKvunX9723qPM
         YqCEjUqYxAL3ejgGaWsrPKmSoJOf/A+S7ZWzin2M8006nv8qMZXXXC4mcXu/gJsyhFlp
         mVvVWtCqDqR3732h0rTZ2QtNcxBWACvIZv0SyUWX795qpgKGOBnxGhcXRd7QJJ9ucitn
         9RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321034; x=1785925834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BPbCOLGFGCgfEBoolz6wAbP1WXsfFMpggTDXNEE6vlc=;
        b=Os9nThP/BrWLCiBufSqGVhDq3LWw1hglx1rK2jUu46OHoLCbldM9xWs4KfRb4nH6aQ
         KcdwJ7V8OfQS2o2N7vTw8rhGhoQPnfjWa+Y5m1DdQL1hl46+z6ZqHFs2zx/UYVGVB/Vc
         KVif/TMTLKtccE3S/vsUsKLl89rG0AW0E1VK2JPawC5WUdzForjCl5z/TOZSMmfIwwKZ
         bW/l7lyx6WwFKz8gnHiMohrqx7TTzjYvBi6OPgK+/bwAEMAVhagrLU/7CdajPgsVz6RQ
         9xsuEAV4u0+S4Jb6293tFwEYGRFZpD84M5Y/JyoHVVvQkvAMh+vluW2hRFWkZoMXd2kY
         /Y9A==
X-Gm-Message-State: AOJu0YyS3aSR+PqsyIlg6Kc9eMDkXfwk/d0vc9KvEum1ikQV46CgiOBL
	7cT2HrY1Y6zIO27PkH5dq7TXHyq/F5oQnPRnDKPGg7/WAKKR+Pnl4yH6hHCbOz9THdjSo03eeGk
	BuJJxBOTaWuzqtw6lqiM6+t76OCfZubnCJX1iL2GzTjrsnOXeaG+zJgM9y4eJgJmmYPRAJxD8Jn
	MWuqI=
X-Gm-Gg: AR+sD12TfHfP+8OsCAlo35Ihh4QhqHBzczRYCQWJzOg004buY17Be6P7enHHM7da0OL
	iNowdn1Dqr8j6LYrbJGH3iCkY9XhRyPcx6IET1aEROkDOwVlW5hftdUuAalmfS0MwUbPJr1kh0P
	ggqJg2z6Rf3qc9IVXtih7yUbs75iAdr3S7FFr1v5wrbSXq9eBc7y38y/21hKOKtkuB50kPte6xz
	/guRB9wC3MMXj+CvRG1n/HUcZjdpT/Pjhud8ZOkq/dvgBOP5pKzF7EOcP9jPD0yyMz8dx7ZYLeJ
	xomhIRoNlmsWeDl0/i4U4d9/229l50nA2EPrSkmLblMZ/SKpd2mbi6hFeP14MtM97H2i4hz7hfE
	0fWzirxHf2NYFZn5sCZIzibLZML1XSA==
X-Received: by 2002:a05:6a20:431e:b0:3c3:935a:af2c with SMTP id adf61e73a8af0-3c8aafc1955mr7341237637.3.1785321033915;
        Wed, 29 Jul 2026 03:30:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:431e:b0:3c3:935a:af2c with SMTP id adf61e73a8af0-3c8aafc1955mr7341195637.3.1785321033400;
        Wed, 29 Jul 2026 03:30:33 -0700 (PDT)
Received: from hu-nakella-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e7262bc27sm11028649c88.2.2026.07.29.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:30:32 -0700 (PDT)
From: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com,
        Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Subject: [PATCH BlueZ v2 2/3] profiles/ranging: Emit CS ProcedureData signal over D-Bus
Date: Wed, 29 Jul 2026 16:00:18 +0530
Message-Id: <20260729103019.4178720-3-naga.akella@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729103019.4178720-1-naga.akella@oss.qualcomm.com>
References: <20260729103019.4178720-1-naga.akella@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfX7tkXv8AQARdM
 w67emyFfJjhHA8q4JEsWQbWsgUaKK8PYE8qKkVqO0Vzg4/unWXsVn15DPK5uUIyYv++yiO8ksdH
 l+Os94kXcmJEsvqvtXbxS+p5LjkSV+c=
X-Proofpoint-GUID: P76-0HJofU07aoFu6CrqomeQ12Wn-bKl
X-Proofpoint-ORIG-GUID: P76-0HJofU07aoFu6CrqomeQ12Wn-bKl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4NiBTYWx0ZWRfXzpipVOUxhPkm
 bK9FQOMzVM2nQlvZbhduH0UsORa89PSdOcemqU7Bmnn+qpJCoDFewagtAc3uNvHJKGVw3HDIurT
 3zCiUU/3+l1vMiRt0udzSryM8vBgSjofw/F5ZIMR2OzABZRRCWLFhOSL22oKG6kJUWyLRl9oq8r
 cI0WLiamZiIyoCiADAIYDKXBM1S0ubC3RK2HKtrngF8fRWmb3g5hCUsywW4KfWj1pnQgXzeVK2+
 S/EsRDu7qGpuxDnCO6okU20iwZzOG0eebC+wQs6+jUIcDnEECtZCkMVaQbDNPf3OJKuC/JvUp++
 hlgUPMe6cZFfjZK/HYDDRCeJW8TDwQ7/W3mFjUgepikiuoofY0zOhYuCr2QUNthsZCymh7wL3FA
 rL0ehV/yXsF+fED/tPKl+HOX6nhTQ6+Le1xHH2mg0KWfR7mWfCIgC3f+LzxsF5NTh5hm+UlkKRX
 khzOogshDLYLyY5JT8w==
X-Authority-Analysis: v=2.4 cv=JeiMa0KV c=1 sm=1 tr=0 ts=6a69d64a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=m_sgnNQ15PSjf8zhIx0A:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290086

Serialize completed BCS procedure data (subevent/step results,
CS config, and procedure-enable parameters) into a byte blob and
emit it via a new ProcedureData D-Bus signal on the CS interface,
so an external ranging estimation daemon can consume raw controller
measurements
---
 profiles/ranging/rap.c     | 285 ++++++++++++++++++++++++++++++++++++-
 profiles/ranging/rap_hci.c |  59 ++++++++
 2 files changed, 343 insertions(+), 1 deletion(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index 082c35558..1a5efb025 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -380,6 +380,274 @@ static const struct cs_dict_param_desc *cs_find_dict_param_desc(
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
@@ -535,6 +803,9 @@ bad_type:
 	data->active_session.cfg           = cfg;
 	data->active_session.freq          = freq;
 
+	bt_rap_hci_set_procedure_data_cb(data->hci_sm, rap_procedure_data,
+					 data, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -552,6 +823,8 @@ static DBusMessage *stop_measurement(DBusConnection *conn,
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
 					"Stop measurement failed");
 
+	bt_rap_hci_set_procedure_data_cb(data->hci_sm, NULL, NULL, NULL);
+
 	memset(&data->active_session, 0, sizeof(data->active_session));
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
@@ -589,6 +862,11 @@ static const GDBusPropertyTable cs_dbus_properties[] = {
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
@@ -753,7 +1031,8 @@ static int rap_accept(struct btd_service *service)
 	g_dbus_register_interface(btd_get_dbus_connection(),
 				  device_get_path(data->device),
 				  CS_INTERFACE, cs_dbus_methods,
-				  NULL, cs_dbus_properties, data, NULL);
+				  cs_dbus_signals, cs_dbus_properties,
+				  data, NULL);
 
 	return 0;
 }
@@ -775,6 +1054,10 @@ static int rap_disconnect(struct btd_service *service)
 		data->conn_handle = 0;
 	}
 
+	if (data->hci_sm)
+		bt_rap_hci_set_procedure_data_cb(data->hci_sm, NULL, NULL,
+							NULL);
+
 	memset(&data->active_session, 0, sizeof(data->active_session));
 
 	btd_service_disconnecting_complete(service, 0);
diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 58ccf87bf..6f00c31fb 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -443,6 +443,8 @@ static void rap_rd_loc_supp_cap_done_cb(const void *data, uint8_t size,
 	DBG("Sending read remote capabilities for handle 0x%04X",
 		sm->active_conn_handle);
 	bt_rap_read_remote_supported_capabilities(sm, sm->active_conn_handle);
+
+	bt_rap_set_local_sw_time(sm->rap, rsp->t_sw_time_supported);
 }
 
 static void rap_send_hci_cs_create_config_command(struct cs_state_machine *sm,
@@ -879,6 +881,8 @@ static void rap_rd_rmt_supp_cap_cmplt_evt(const void *data, uint8_t size,
 		cs_set_state(sm, CS_STATE_INIT);
 		rap_send_hci_def_settings_command(sm, evt);
 	}
+
+	bt_rap_set_remote_sw_time(sm->rap, evt->t_sw_time_supported);
 }
 
 static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
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

