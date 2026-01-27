Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31B21ADB7
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536149; cv=none; b=dMSkOZ4mTQcBrQJpIzRbR848BAE8+IjuHVGNeXwtKuePRMYre7sMoxuqYKwfJGX5UQQT6CC9qyu3pPa/qv2EZHYJO9QUMahv+07kerUBEBeuYs6kq46EZBxS+OQUfuj8hYSYjSSTDiHnvzFmykP2/zfSdPlmHb1eGfSehoS5QrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536149; c=relaxed/simple;
	bh=65YxQ6TYxcV3LNAjr5XWP8XK/OvClJm+lYnRSNRRIQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sDcBinDL+V6xSFsACaWQhKOixleXHANBqdS/QNbV0pNgbH/PsJd6I84aJ17X68YaQ+me6pmp4xu7c+QSjT2K6rTYAs/V6CO2hQjRUmOG9nwP7qIhTprlOYds3nG6TagKhm8Mkz8s2iPveywM8rShZ67KeTvu3jSmJUBxJunzlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XoUkF7VP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=acIczQ8E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XoUkF7VP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="acIczQ8E"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RH7YQk496030
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=55drZOaUghl
	kOfNlelqfQQ4hPCZ6DImSLKCz1CXsYlI=; b=XoUkF7VPmk4mmCRtpDzC8AN2lDh
	SaCbnHrWTklkKX1QPDfcctUkxXJ8I7qzWt4oBvw4z2EF1Fp8E1V69bmZZ2ctD9vz
	1tpmm3/W8/PeNdhNBprVUrIEoj8nRLVbtiEcYpv2AdY3OXFYNXyq5yAEJJgHSZSY
	T3ldOR1wudD7QT26KuxMVs0OsiQ46LLdaiQ5pAzNSyQ3vAGcP9v2Ou96bFwLA5Uf
	r6dFlqfcVcyLWllnbTBMSdZAXOFIE/q01bH4U+BBw2oi+wbPcVsRFG8OMnuaBq/8
	kRmQA3+EX5iJyqG6y70UhzvRCiTepm2cclpTFJ5aaCKodRbxqyCH/WRClqg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3bkv4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:49:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c5d203988so11391148a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769536146; x=1770140946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55drZOaUghlkOfNlelqfQQ4hPCZ6DImSLKCz1CXsYlI=;
        b=acIczQ8Emdg2qGcLxKqp0b1HejZsqLl8fUDMVbxWmjrq5fxMft2XGBHBao5hImpA7m
         rj3ZdDzyi/vHJSyJSUHJZsQSmftiv/uTlAAzViRBiG8U8UMszz/6q8C2NrrzUvO8DoBJ
         JJQWYXT+jXiaxHhJwyzpTMgg5Psgkno65wu9og5C7Q35ypYza9uWZYNh9EQVDieFfkR3
         iemytL0q3A+OQhNNYuEzTuSZqhaO63dcoWj1dsyjyBOpQl6bdWRzJh0ugpXs5mEaZ1Sw
         Tq6oEMZrufGi1DexVt2CsofYaupUhlaj3A5/TYD4RRQJdKau5ex9fvBjR2yp/0T//ynG
         Jgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536146; x=1770140946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55drZOaUghlkOfNlelqfQQ4hPCZ6DImSLKCz1CXsYlI=;
        b=dCkvDr9NoPiSzH6xFhq/kPtFgsfy9sRoIny19AaMizZpHxAe4lq2V4vx4fOol8Y6Y4
         ltJWHjlWbdhC5dDNln6VCwuR0joqd80LT22cAeyu7zXLYmEyHx64ZTd0bDW9lujNkGYe
         2nfZqK+Qw4eBqZecM2tVrqBlJulDZqdlJ8AGsjAwuIivqyc9VMxvgOJJvo5AjmMbGU2N
         Z9TOsdZI5qYn9/aMPzQMPiNDTDeEWv4GgLuWc5/+b8We/+qV8yp8vjZm57K+zHBA0eUK
         439tpJEAR4R3bXkKee7ilXv9rh9EVVbVdFM21hFO58fWt6g3yG039QRne6G6uZJJodmV
         JDsw==
X-Gm-Message-State: AOJu0Yz9EHs0tx2iJQu09MAXYzb0chy9dnWeH0jPuDo+t+LLDRFJB2YF
	mIAKvl14e7sx3B4eYTkbptSksSkOH+snktLnqivuBywdty2OFDoMk189dlcfoesWZ2900f2rdtD
	k6OJumAXKrcM/Gjb5CcJMkTBHttTmNPZENS8Sg6ltCPqUD91aR00SjtPEaXMVvSEKGXaPChIqTo
	a3lP8=
X-Gm-Gg: AZuq6aJvWHz7juqzWfGHLTLprNiDWBSMqb5HzwNgYxLn77gEspY+iw75UKI2c6BOEqr
	YHuQN5Oe5sKpVzUsZlsYiXMtBPwJ6ivhss4YhXckN4S97WqkZsFAx7Ie3euzVsaqxEpMtjAQiVP
	8Pwx70QDy0CUg7dLGidpXEdc+lqw34sY9HfQbzucHU+3OMg6su/CR7sV3Je4STfa9wbwMtyRfZm
	sA/ghO8jXDr2q/lmuzRqnZxttA1V0ppi14jkpju1Q0SRNc80iaYlnuTC+BGsSSy4FyXKz8xQfEm
	c6eepDO09a2787MOa9eSTyt5mvzdWFaRH8k2V+yt7dzIom7LUDDJiQeDZmWzri8Ag/hj8Xyyl9c
	k7n/cFoBaRW+AFpofQ0LwZPBe9hKwCmoO7M8Q6tSxoS6imzAZ
X-Received: by 2002:a17:903:2a84:b0:2a7:aac1:7205 with SMTP id d9443c01a7336-2a870ddd139mr23046755ad.48.1769536145577;
        Tue, 27 Jan 2026 09:49:05 -0800 (PST)
X-Received: by 2002:a17:903:2a84:b0:2a7:aac1:7205 with SMTP id d9443c01a7336-2a870ddd139mr23046475ad.48.1769536144865;
        Tue, 27 Jan 2026 09:49:04 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e5fb0sm110385ad.91.2026.01.27.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 09:49:04 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v5 2/5] monitor: Add support for Ranging Service (RAS)
Date: Tue, 27 Jan 2026 23:18:53 +0530
Message-Id: <20260127174856.3418323-3-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127174856.3418323-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rDAWhOYgTGiGKIiX6e0uRaCjy4lsf0zy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NSBTYWx0ZWRfX9SIZ0ZwqKYFx
 HndodwWMWwlBu0H7t1SLxyDLDCci6eVwn+XJzpEu2jpwH/Jt9pkfuaLQ+/BiwiIPkmzLBwEThgN
 LdJzwUA3+C7BpqsthOyHQf80n3Aht74eUorZ6yCILXt6wP59xNhzTdSl9lHITrzfPTalkRWeBB8
 81g9dA4ge8sTz1S4K4iVizMavylTYSJsw5IYllZeFtk8qg4uycxD+OTT4naI/MemW11RxfA/AUd
 /NszeSSbLwyg66gz6RRIAm9OZvNe5wcgt0mr+PeUb2Qcrzc/tc5S2w6VsfTFgK5K/ca9A6cCxUc
 N7vnI/yDw5sb8fvOVYyL2sGWPLSiX3X/TmiDy188nLndfubkA8yhjeYuqufAgCKQ/byKCSaT5ur
 1gg6AxSw8QlV5mmbwN+NJWGzL5qH/x2y0EvLtooYNksoiYFzz6scxzCKypUgv2/8NH7e/ZqpZ+f
 YolMYHkuztvuaQSZEfQ==
X-Proofpoint-GUID: rDAWhOYgTGiGKIiX6e0uRaCjy4lsf0zy
X-Authority-Analysis: v=2.4 cv=AOFXvqQI c=1 sm=1 tr=0 ts=6978fa92 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jOuAIO0l5H7y6RX90eoA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270145

Implement comprehensive decoding support for the Bluetooth Ranging
Service (RAS) in the ATT monitor, including:

- RAS Features characteristic (0x2c14) with feature bitfield decoding
- Real-time and On-demand Ranging Data characteristics (0x2c15, 0x2c16)
  with segmentation header, ranging header, and subevent header parsing
- RAS Control Point (0x2c17) with command opcodes:
  * Get Ranging Data
  * ACK Ranging Data
  * Retrieve Lost Ranging Data Segments
  * Abort Operation
  * Set Filter
- RAS Ranging Data Ready (0x2c18) and Data Overwritten (0x2c19)
  notification characteristics

Also add RAS service and characteristic UUIDs to the shared UUID table.

This enables btmon to properly decode and display RAS protocol
operations for debugging and analysis of Bluetooth ranging
implementations.
---
 monitor/att.c     | 447 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/util.c |   9 +-
 2 files changed, 454 insertions(+), 2 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index abcdf15a8..24aaa264c 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -4055,6 +4055,438 @@ static void bgr_features_read(const struct l2cap_frame *frame)
 								mask);
 }
 
+static const struct bitfield_data ras_features_table[] = {
+	{  0, "Real-time Ranging Data (0x00000001)"		},
+	{  1, "Retrieve Lost Ranging Data Segments (0x00000002)"	},
+	{  2, "Abort Operation (0x00000004)"			},
+	{  3, "Filter Ranging Data (0x00000008)"		},
+	{ }
+};
+
+static const struct bitfield_data antenna_paths_table[] = {
+	{  0, "Antenna Path 1 (0x01)"	},
+	{  1, "Antenna Path 2 (0x02)"	},
+	{  2, "Antenna Path 3 (0x04)"	},
+	{  3, "Antenna Path 4 (0x08)"	},
+	{ }
+};
+
+static void ras_features_read(const struct l2cap_frame *frame)
+{
+	uint32_t features;
+	uint32_t mask;
+
+	if (!l2cap_frame_get_le32((void *)frame, &features)) {
+		print_text(COLOR_ERROR, "    Features: invalid size");
+		goto done;
+	}
+
+	print_field("    Features: 0x%8.8x", features);
+
+	mask = print_bitfield(6, features, ras_features_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    RFU fields (0x%8.8x)",
+								mask);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void print_ras_segmentation_header(uint8_t header)
+{
+	bool first_segment = header & 0x01;
+	bool last_segment = (header >> 1) & 0x01;
+	uint8_t segment_index = (header >> 2) & 0x3F;
+
+	print_field("  Segmentation Header: 0x%2.2x", header);
+	print_field("    First Segment: %s", first_segment ? "True" : "False");
+	print_field("    Last Segment: %s", last_segment ? "True" : "False");
+	print_field("    Segment Index: %u", segment_index);
+}
+
+static void print_ras_ranging_header(const struct l2cap_frame *frame)
+{
+	uint16_t ranging_counter_config;
+	uint8_t selected_tx_power;
+	uint8_t antenna_paths_mask;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_le16((void *)frame, &ranging_counter_config)) {
+		print_text(COLOR_ERROR, "    Ranging Header: invalid size");
+		return;
+	}
+
+	/* Lower 12 bits: Ranging Counter, Upper 4 bits: Configuration ID */
+	print_field("    Ranging Counter: 0x%3.3x",
+					ranging_counter_config & 0x0FFF);
+	print_field("    Configuration ID: %u",
+					(ranging_counter_config >> 12) & 0x0F);
+
+	if (!l2cap_frame_get_u8((void *)frame, &selected_tx_power)) {
+		print_text(COLOR_ERROR, "    Selected TX Power: invalid size");
+		return;
+	}
+
+	print_field("    Selected TX Power: %d dBm", (int8_t)selected_tx_power);
+
+	if (!l2cap_frame_get_u8((void *)frame, &antenna_paths_mask)) {
+		print_text(COLOR_ERROR, "    Antenna Paths Mask: invalid size");
+		return;
+	}
+
+	print_field("    Antenna Paths Mask: 0x%2.2x", antenna_paths_mask);
+
+	mask = print_bitfield(6, antenna_paths_mask,
+					antenna_paths_table);
+
+	if (mask)
+		print_text(COLOR_WHITE_BG, "      RFU (0x%2.2x)", mask);
+}
+
+static const char *ras_ranging_done_status_str(uint8_t status)
+{
+	switch (status) {
+	case 0x0:
+		return "All results complete";
+	case 0x1:
+		return "Partial results, more to follow";
+	case 0xF:
+		return "All subsequent procedures aborted";
+	default:
+		return "RFU";
+	}
+}
+
+static const char *ras_subevent_done_status_str(uint8_t status)
+{
+	switch (status) {
+	case 0x0:
+		return "All results complete";
+	case 0xF:
+		return "Current subevent aborted";
+	default:
+		return "RFU";
+	}
+}
+
+static const char *ras_abort_reason_str(uint8_t reason)
+{
+	switch (reason) {
+	case 0x0:
+		return "No abort";
+	case 0x1:
+		return "Local/remote request";
+	case 0x2:
+		return "Filtered channel map < 15 channels";
+	case 0x3:
+		return "Channel map update instant passed";
+	case 0xF:
+		return "Unspecified";
+	default:
+		return "RFU";
+	}
+}
+
+static void print_ras_subevent_header(const struct l2cap_frame *frame)
+{
+	uint16_t start_acl_conn_event;
+	uint16_t freq_compensation;
+	uint8_t status_byte1, status_byte2;
+	uint8_t ranging_done_status, subevent_done_status;
+	uint8_t ranging_abort_reason, subevent_abort_reason;
+	uint8_t ref_power_level;
+	uint8_t num_steps_reported;
+
+	if (!l2cap_frame_get_le16((void *)frame, &start_acl_conn_event)) {
+		print_text(COLOR_ERROR,
+			"      Start ACL Connection Event: invalid size");
+		return;
+	}
+
+	print_field("      Start ACL Connection Event: %u",
+						start_acl_conn_event);
+
+	if (!l2cap_frame_get_le16((void *)frame, &freq_compensation)) {
+		print_text(COLOR_ERROR,
+			"      Frequency Compensation: invalid size");
+		return;
+	}
+
+	print_field("      Frequency Compensation: %d (0.01 ppm)",
+					(int16_t)freq_compensation);
+
+	if (!l2cap_frame_get_u8((void *)frame, &status_byte1)) {
+		print_text(COLOR_ERROR, "      Status: invalid size");
+		return;
+	}
+
+	ranging_done_status = status_byte1 & 0x0F;
+	subevent_done_status = (status_byte1 >> 4) & 0x0F;
+
+	print_field("      Ranging Done Status: %s (0x%x)",
+			ras_ranging_done_status_str(ranging_done_status),
+			ranging_done_status);
+	print_field("      Subevent Done Status: %s (0x%x)",
+			ras_subevent_done_status_str(subevent_done_status),
+			subevent_done_status);
+
+	if (!l2cap_frame_get_u8((void *)frame, &status_byte2)) {
+		print_text(COLOR_ERROR, "      Abort Reasons: invalid size");
+		return;
+	}
+
+	ranging_abort_reason = status_byte2 & 0x0F;
+	subevent_abort_reason = (status_byte2 >> 4) & 0x0F;
+
+	print_field("      Ranging Abort Reason: %s (0x%x)",
+			ras_abort_reason_str(ranging_abort_reason),
+			ranging_abort_reason);
+	print_field("      Subevent Abort Reason: %s (0x%x)",
+			ras_abort_reason_str(subevent_abort_reason),
+			subevent_abort_reason);
+
+	if (!l2cap_frame_get_u8((void *)frame, &ref_power_level)) {
+		print_text(COLOR_ERROR,
+			"      Reference Power Level: invalid size");
+		return;
+	}
+
+	print_field("      Reference Power Level: %d dBm",
+					(int8_t)ref_power_level);
+
+	if (!l2cap_frame_get_u8((void *)frame, &num_steps_reported)) {
+		print_text(COLOR_ERROR,
+			"      Number of Steps Reported: invalid size");
+		return;
+	}
+
+	print_field("      Number of Steps Reported: %u", num_steps_reported);
+}
+
+static void ras_ranging_data_read(const struct l2cap_frame *frame)
+{
+	uint8_t seg_header;
+	bool first_segment;
+
+	if (!l2cap_frame_get_u8((void *)frame, &seg_header)) {
+		print_text(COLOR_ERROR, "  Segmentation Header: invalid size");
+		goto done;
+	}
+
+	print_ras_segmentation_header(seg_header);
+
+	first_segment = seg_header & 0x01;
+
+	/* Only try to decode headers if this is the first segment */
+	if (first_segment && frame->size >= 6) {
+		print_field("  Ranging Data Body:");
+		print_ras_ranging_header(frame);
+
+		/* Try to decode subevent header if enough data remains */
+		if (frame->size >= 10) {
+			print_field("    Subevent #0:");
+			print_ras_subevent_header(frame);
+		}
+	}
+
+	if (frame->size > 0) {
+		print_hex_field("  Remaining Ranging Data Segment", frame->data,
+								frame->size);
+	}
+
+done:
+	if (frame->size)
+		print_hex_field("  Remaining Data", frame->data, frame->size);
+}
+
+static void ras_ranging_data_notify(const struct l2cap_frame *frame)
+{
+	ras_ranging_data_read(frame);
+}
+
+static bool ras_get_ranging_data_cmd(const struct l2cap_frame *frame)
+{
+	uint16_t ranging_counter;
+
+	if (!l2cap_frame_get_le16((void *)frame, &ranging_counter)) {
+		print_text(COLOR_ERROR, "    Ranging Counter: invalid size");
+		return false;
+	}
+
+	print_field("    Ranging Counter: 0x%4.4x", ranging_counter);
+
+	return true;
+}
+
+static bool ras_ack_ranging_data_cmd(const struct l2cap_frame *frame)
+{
+	uint16_t ranging_counter;
+
+	if (!l2cap_frame_get_le16((void *)frame, &ranging_counter)) {
+		print_text(COLOR_ERROR, "    Ranging Counter: invalid size");
+		return false;
+	}
+
+	print_field("    Ranging Counter: 0x%4.4x", ranging_counter);
+
+	return true;
+}
+
+static bool ras_retrieve_lost_segments_cmd(const struct l2cap_frame *frame)
+{
+	uint16_t ranging_counter;
+	uint8_t first_segment, last_segment;
+
+	if (!l2cap_frame_get_le16((void *)frame, &ranging_counter)) {
+		print_text(COLOR_ERROR, "    Ranging Counter: invalid size");
+		return false;
+	}
+
+	print_field("    Ranging Counter: 0x%4.4x", ranging_counter);
+
+	if (!l2cap_frame_get_u8((void *)frame, &first_segment)) {
+		print_text(COLOR_ERROR,
+			"    First Segment Index: invalid size");
+		return false;
+	}
+
+	print_field("    First Segment Index: %u", first_segment);
+
+	if (!l2cap_frame_get_u8((void *)frame, &last_segment)) {
+		print_text(COLOR_ERROR, "    Last Segment Index: invalid size");
+		return false;
+	}
+
+	if (last_segment == 0xFF)
+		print_field("    Last Segment Index: All remaining (0xFF)");
+	else
+		print_field("    Last Segment Index: %u", last_segment);
+
+	return true;
+}
+
+static bool ras_set_filter_cmd(const struct l2cap_frame *frame)
+{
+	uint16_t filter_config;
+	uint8_t mode;
+	uint16_t filter_mask;
+
+	if (!l2cap_frame_get_le16((void *)frame, &filter_config)) {
+		print_text(COLOR_ERROR,
+			"    Filter Configuration: invalid size");
+		return false;
+	}
+
+	mode = filter_config & 0x03;
+	filter_mask = (filter_config >> 2) & 0x3FFF;
+
+	print_field("    Filter Configuration: 0x%4.4x", filter_config);
+	print_field("      Mode: %u", mode);
+	print_field("      Filter Bit Mask: 0x%4.4x", filter_mask);
+
+	return true;
+}
+
+#define RAS_CMD(_op, _desc, _func) \
+[_op] = { \
+	.desc = _desc, \
+	.func = _func, \
+}
+
+static const struct ras_cmd {
+	const char *desc;
+	bool (*func)(const struct l2cap_frame *frame);
+} ras_cmd_table[] = {
+	/* Opcode = 0x00 (Get Ranging Data) */
+	RAS_CMD(0x00, "Get Ranging Data", ras_get_ranging_data_cmd),
+	/* Opcode = 0x01 (ACK Ranging Data) */
+	RAS_CMD(0x01, "ACK Ranging Data", ras_ack_ranging_data_cmd),
+	/* Opcode = 0x02 (Retrieve Lost Ranging Data Segments) */
+	RAS_CMD(0x02, "Retrieve Lost Ranging Data Segments",
+					ras_retrieve_lost_segments_cmd),
+	/* Opcode = 0x03 (Abort Operation) */
+	RAS_CMD(0x03, "Abort Operation", NULL),
+	/* Opcode = 0x04 (Set Filter) */
+	RAS_CMD(0x04, "Set Filter", ras_set_filter_cmd),
+};
+
+static const struct ras_cmd *ras_get_cmd(uint8_t op)
+{
+	if (op > ARRAY_SIZE(ras_cmd_table))
+		return NULL;
+
+	return &ras_cmd_table[op];
+}
+
+static void ras_control_point_write(const struct l2cap_frame *frame)
+{
+	uint8_t opcode;
+	const struct ras_cmd *cmd;
+
+	if (!l2cap_frame_get_u8((void *)frame, &opcode)) {
+		print_text(COLOR_ERROR, "    Opcode: invalid size");
+		goto done;
+	}
+
+	cmd = ras_get_cmd(opcode);
+	if (!cmd) {
+		print_field("    Opcode: Reserved (0x%2.2x)", opcode);
+		goto done;
+	}
+
+	print_field("    Opcode: %s (0x%2.2x)", cmd->desc, opcode);
+
+	if (cmd->func && !cmd->func(frame))
+		goto done;
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void ras_data_ready_read(const struct l2cap_frame *frame)
+{
+	uint16_t counter;
+
+	if (!l2cap_frame_get_le16((void *)frame, &counter)) {
+		print_text(COLOR_ERROR, "    Counter: invalid size");
+		goto done;
+	}
+
+	print_field("    Counter: %u", counter);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void ras_data_ready_notify(const struct l2cap_frame *frame)
+{
+	ras_data_ready_read(frame);
+}
+
+static void ras_data_overwritten_read(const struct l2cap_frame *frame)
+{
+	uint16_t counter;
+
+	if (!l2cap_frame_get_le16((void *)frame, &counter)) {
+		print_text(COLOR_ERROR, "    Counter: invalid size");
+		goto done;
+	}
+
+	print_field("    Overwritten Count: %u", counter);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void ras_data_overwritten_notify(const struct l2cap_frame *frame)
+{
+	ras_data_overwritten_read(frame);
+}
+
 #define GMAS \
 	GATT_HANDLER(0x2c00, gmap_role_read, NULL, NULL), \
 	GATT_HANDLER(0x2c01, ugg_features_read, NULL, NULL), \
@@ -4062,6 +4494,18 @@ static void bgr_features_read(const struct l2cap_frame *frame)
 	GATT_HANDLER(0x2c02, bgs_features_read, NULL, NULL), \
 	GATT_HANDLER(0x2c03, bgr_features_read, NULL, NULL)
 
+#define RAS \
+	GATT_HANDLER(0x2c14, ras_features_read, NULL, NULL), \
+	GATT_HANDLER(0x2c15, ras_ranging_data_read, NULL, \
+					ras_ranging_data_notify), \
+	GATT_HANDLER(0x2c16, ras_ranging_data_read, NULL, \
+					ras_ranging_data_notify), \
+	GATT_HANDLER(0x2c17, NULL, ras_control_point_write, NULL), \
+	GATT_HANDLER(0x2c18, ras_data_ready_read, NULL, \
+					ras_data_ready_notify), \
+	GATT_HANDLER(0x2c19, ras_data_overwritten_read, NULL, \
+					ras_data_overwritten_notify)
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -4144,7 +4588,8 @@ static const struct gatt_handler {
 	GATT_HANDLER(0x2bc1, incoming_call_read, NULL, incoming_call_notify),
 	GATT_HANDLER(0x2bc2, call_friendly_name_read, NULL,
 					call_friendly_name_notify),
-	GMAS
+	GMAS,
+	RAS
 };
 
 static const struct gatt_handler *get_handler_uuid(const bt_uuid_t *uuid)
diff --git a/src/shared/util.c b/src/shared/util.c
index 6f7ce0a25..07e718bca 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -844,7 +844,8 @@ static const struct {
 	{ 0x1855, "Telephony and Media Audio"			},
 	{ 0x1856, "Public Broadcast Announcement"		},
 	{ 0x1858, "Gaming Audio"				},
-	/* 0x1857 to 0x27ff undefined */
+	{ 0x185b, "Ranging Service"				},
+	/* 0x185c to 0x27ff undefined */
 	{ 0x2800, "Primary Service"				},
 	{ 0x2801, "Secondary Service"				},
 	{ 0x2802, "Include"					},
@@ -1157,6 +1158,12 @@ static const struct {
 	{ 0x2c02, "UGT Features"				},
 	{ 0x2c03, "BGS Features"				},
 	{ 0x2c03, "BGR Features"				},
+	{ 0x2c14, "RAS Features"				},
+	{ 0x2c15, "RAS Real-time Ranging Data"			},
+	{ 0x2c16, "RAS On-demand Ranging Data"			},
+	{ 0x2c17, "RAS Control Point"				},
+	{ 0x2c18, "RAS Ranging Data Ready"			},
+	{ 0x2c19, "RAS Ranging Data Overwritten"		},
 	/* vendor defined */
 	{ 0xfeff, "GN Netcom"					},
 	{ 0xfefe, "GN ReSound A/S"				},
-- 
2.34.1

