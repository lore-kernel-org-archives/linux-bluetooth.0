Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BF722D4C8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769496457; cv=none; b=RphVg3e3kH4yTPLx32gpSDxYcSFYcjy9r2SKQLX54E6pLyK0tIVFyiT/B/jgOBYdpuqMKY1B9Y1RxBQSx7uriGSUIpaIwE/IrfKEp/D+ZNQ2pig1WTN+YoNbqYh9Mmji1k5l0XiSC8pXpsv3zjaCoBbOJ5Qv13Bgcvb01xMJcRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769496457; c=relaxed/simple;
	bh=STSD/1cHPPYiHfaPtrPbOsAtx+/M6CGp+D1e1jB8dUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EeadX/LAIEl2gmBUaX13UBc2teeihT/+eWJikgzrdX9szqk9JSZ3syK5PGYxWzPAUFBLqp8tSz+HtxwvXt9fdL9MmHDu8kC/5BkM1In67yf9B6AT1GET1S5yPFjLV6ag6ce1Bz+CsqJUrO/gI4KyeW6p9Nfs097ZVBNmypBp7CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NL4v5DSu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=InJAem4O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NL4v5DSu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="InJAem4O"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UTEh1900665
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=55drZOaUghl
	kOfNlelqfQQ4hPCZ6DImSLKCz1CXsYlI=; b=NL4v5DSuq8CeerZ2+02aiuhVEJd
	DXJi/vpTnSTqRTgADahr6c43As7UxXSmOWiywLhj1aGJnNGTcG3pETNRlQFrkS01
	fMizpPvPHsRD1osDtssgfOLSfVUdNiSQKzfiDEGN4Joae9ReWemsbvfGvXMd+nYb
	PXrY2KEsxlQkQ1AifedAGnpYpK86odaF9A2lyJUKpzmGJ5bjp95h4UTTMeDggN1R
	k3AkaSVJb33Yh7VI6OjPrlR5HKx4ceiL8ssCW73pIeVi3YZkpWcUsGp9P16UCqWT
	S+wGI+zg8mv80ixvGk0kxfahX5BoyCKLvhYVDcXRtOqsF6coEnzpIPxMEPg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxadptje4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 06:47:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82343404fa0so1097615b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769496454; x=1770101254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55drZOaUghlkOfNlelqfQQ4hPCZ6DImSLKCz1CXsYlI=;
        b=InJAem4OvAcVKALT9e/aUJ/Jbq5+UEtTGCTav8QokvcYmF8MjA/+bgufjVbwJkK8Ls
         hgk0JkF2z+aqMNqRzXwJ8VdXvQxMj0UemJqRfno51swKUvSSC0zM7+nPnV/knShdKYHX
         iN8ybNooemdkjZlzQMCPKwIBqOynVlBJRVtiYrPrJ+PUXuxA0bj+ldrxwaEiz2S3fPbk
         3Ck3J1zyrpFqmFCGTNmg9P6KcwCMN6keiM+HiDKYi2WOoyGWxVW7esknpb6SwJLQaTH9
         hU59f3gku4/UooXg3nR09WNBLbMBlizCfTWvO2zDvmAmXgnzhGNU0j2mdrTB1mSeFz40
         8pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496454; x=1770101254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55drZOaUghlkOfNlelqfQQ4hPCZ6DImSLKCz1CXsYlI=;
        b=KiJ2QPB7SOv6YYmVJ4WquC4IfkZFyznaKbIN4j9zRBw9U1gjD/8rQMmVCVggIqrPn2
         Ph8fM0zPYOuS1YW6GZD7L44iFqFeUkdewaqGEnt2HqX3O66TYWPhrhK59CaM5ffSF7sh
         UVudrQ41QUSJirEF/+3iYW0eQJ+GlAxHtyacMv9FUFo3IRgF6KMbwtt/wkj/ulBrVjeX
         aLpjQRMX8mprFI1GWi8lklwmQxBIQ1T0fCgQ014Of2Z5f+rfKyLSNc9JlO5IHqkzMAhl
         pLb4jH7vpbWwZrrrBY8k9hBW6KRGhq3x5D8cKU7Wd6MqOBgxwoyL+Ag7ghOjE81TJzlc
         U4wg==
X-Gm-Message-State: AOJu0Ywdheg6JwGz6AfPIQpmyXNDIagSRsk+GWlCp+8G5IdCdR6HhttQ
	6pjCgmjWnUoo+tljwHm2wX+oyu5V4dqki3WomZMQIb2K5O00i4Xfos7wGmNBctZICs+F9+std8N
	/iyybWoMXLf0Q6lshZ1ncSJAwBJLCuDET4U6yKrbBZ3rb9NcsTfi00wr5fL00PsWVfbdW6UGiUw
	wOj1k=
X-Gm-Gg: AZuq6aJhugg7tN6fQqThxHQdej5KiUW0pMRXn1aKcbRMfNluvnBhnUeAdlN2ORAxenu
	kkJ0nyxjcP5i3y+9dm5apFlVcjFzpybScGXyA7gDjUgP+5vx6C1C/VPzx4xxazoZkh5P8WdH5s3
	+AaUPCY3irCwrj9kON4tL9xIlAecCvoAB1hTuar536J2MQjDStd3KsOMW9tBx5LrItY+RlRGE/5
	e+NqKy5ZZOhhS7nk5ADJ5CeRNL+IeQoArI59WyciQqf90LFQ0mamKBTmZUwQ9pD525fQcL2vtON
	TKWZiZIWJY0OfS5WiDw5WTof9SA8KCKGfXaB0BRR7yDAMkNLwEFPXkBdNosIOAPv5wDRvRWP0f3
	+WaJobIiPGRrTNQakU7woTGNpa8V0g1yFA0VFdo1XB+rkb4TK
X-Received: by 2002:a05:6a00:88c:b0:81f:852b:a925 with SMTP id d2e1a72fcca58-8236916984amr1067236b3a.1.1769496453999;
        Mon, 26 Jan 2026 22:47:33 -0800 (PST)
X-Received: by 2002:a05:6a00:88c:b0:81f:852b:a925 with SMTP id d2e1a72fcca58-8236916984amr1067213b3a.1.1769496453419;
        Mon, 26 Jan 2026 22:47:33 -0800 (PST)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876e5d0sm11032924b3a.61.2026.01.26.22.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 22:47:33 -0800 (PST)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1 2/5] monitor: Add support for Ranging Service (RAS)
Date: Tue, 27 Jan 2026 12:17:21 +0530
Message-Id: <20260127064724.2949465-3-prathibha.madugonde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127064724.2949465-1-prathibha.madugonde@oss.qualcomm.com>
References: <20260127064724.2949465-1-prathibha.madugonde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: enHZqM5unTjIY03bp7ZOXaDKJQ5fcQ67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA1MyBTYWx0ZWRfX+NQHHI/j0ddp
 sI6CQoZF7xJeiQ7KzZcAN5CaVYLB+ahIqXKTZvZEILZldCz/fwRhK0411YDOesO5xwpw5gr0Piz
 d24FAxGpB7sQv+YidioW3B/WzHXJpfagfD1ENFyzQdZTOQMO+zhktILHNiMGc2TsqNqJbCWU1XU
 B7MMqeUO5J7fIKB44wLoyJYF3vQRuSqH0nj1iafukjUL8EXVbz/53s68KGaB1QcKrxign4Zk7+F
 Ut3jc71SST8Lol8X9wn6TVbkwKFGVotGS29fRf8AuKTF6T1TbBM0XUhL/6nfUDn9N1a4erhWEEn
 NWfW7N1Z7bsYVtLGGKV/6IHFKRw1/4BxAOJmMY4aCUGA2qTIfzqvdReW2J62DJRLhBmC1N5kOCz
 rubsYhYh3tPRpmdCKtKm9q7+Fh6qkxh37jJZDKTlpjXQ2kfJMQi45z6HV/fzyAmKD7boJDH6rRk
 tQn2ya9LWkmxVdl8F/w==
X-Authority-Analysis: v=2.4 cv=GvdPO01C c=1 sm=1 tr=0 ts=69785f87 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jOuAIO0l5H7y6RX90eoA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: enHZqM5unTjIY03bp7ZOXaDKJQ5fcQ67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270053

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

