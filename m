Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E8F31D75E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177264; cv=none; b=MMu24LnGdHyxUMjc5c+hAuO3n3X3aslTANKvlsZNMcZsXd7RaoR4SDntsKtkz1OiPJp+qR3/HyH9hUDu2TENYKK3rDaAumnIwAH4vduYJC275KvDc0U3N82Fmadgjc+9nzDJAOP11sWQII2dnUoc2iP96RkPudMeGfBP7XspfRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177264; c=relaxed/simple;
	bh=iqtTT2daO8Hp7oStAZPq0WWHJ8R50dVUIVa+IsV1PRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qd7OQN1GNvR2m+Cv5ruK+zq7rQpcmNps4lUlpRrv14gOClIu2UyIPo0ohBrGRIuNLTMZnjvgZkVtUmw0nUgEBxHBjym2XWWYX2vVtDtFL8I5dWy+r/ascEXak+Z4FeSqYt1EFO+PbqZwrdv/VNIMT6AUhN5SEQLOaF4EcG4GotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MJ+6thzY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGWZ6981; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MJ+6thzY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGWZ6981"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647HofDH1971771
	for <linux-bluetooth@vger.kernel.org>; Thu, 7 May 2026 18:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=G/VhcWlqSzWX7ys+xdjSl8jmWv7WqNL4ggD
	prUdpxi0=; b=MJ+6thzY8UqjEHXw/99d7gL0FCDX2XUpcceij+vn8e23+hS6aCI
	6J9xeUY5nRGOjrResyIFEpaQwnYhce6f4aaU+hzXxq0nmroLbUulucw02ri159Ch
	2Rv+49i5XJ0YCHEOt9rC1+fNylvvrEt/cPp5p7eIiYs35LqtJTB9ruzVYd+X2IiF
	cuW+ZhRzN/OzsX6fd14oI5uISjqQ5BxZiqts4JtG3HqnrD2YWD20eKHQ/u3lOqX3
	EFLPEH0ikxh56/ZOwlHoLCzL4S55Hx39ryAxEpC82cEO3KUjoeL3JsvFIi+7wIY0
	e2Mwrt9inYasf/JW9YWxVIBJyKIPGaAzzvg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej9hpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 18:07:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-83603145987so797727b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778177261; x=1778782061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/VhcWlqSzWX7ys+xdjSl8jmWv7WqNL4ggDprUdpxi0=;
        b=XGWZ6981zz9E9x04uValqv2TYFjPG+8VbIsrpX1w+xLcZuMHnOtFff+mvpEMCsvNo6
         vieay9HzdjzKyUesPHitthDvyiyYu69uE0+CGoDziP6GOmpX+59nsBvZY5+cfZBp7YIk
         qFnE22iTaU9BGK43PyveF9i/0wt2am+xuxvArZS2LDo7kuzY0/6GS1TDsxKPVq1Ar1y6
         p6dromqL7UZtFw6Sb9zSXWeVPkWd2zi1CBYaPltcvAN3ww9cIrm+/WaWk/wUK2uR84I7
         i0BsVCg8wQ0QK/kZTla3XIyLFx8AKf1X4keV6EWKRZbsFftKKZNyLh/6QuJa7x7xR3gZ
         QVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177261; x=1778782061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/VhcWlqSzWX7ys+xdjSl8jmWv7WqNL4ggDprUdpxi0=;
        b=SMiH4WuiPJlGaxUm0hWNoEfkqmmJcRCuHVXqjvCCNgEoQQqhF7/ICNiVv3v1BplHPu
         SkfnPJG1E8PaHPtCqMNlNq3hrPLmYnS9xDueyZsx9I0jZGn/HseojA+BAWEpyhpkDA6o
         OjZRC5UwDgdaGGear+r/0TodjjV8zoxdHmEEpr2TxHwHhuC4Drx2REELvY7Wt+IqJYKL
         nJyBbVY+b+NF2ZKYUiTp//t57ngKO4e06Nm7U6EA4GAuMVdnpZ/zdJlCoBabTTQKK/c8
         vulFePdu0SGXon3ETR/ZUq9APcPwHmmNqD68NtLr8q+kRUL+85+qKzQfDUvBhgYrE6jY
         NaLg==
X-Gm-Message-State: AOJu0Yyv1atlr2p1X4TcFUEr8aVyt6I6qyNc4YedosmhfNJplcnSjJNw
	VJB1wztE5bGmHHQePQ7PKHLakYmGIdKHvjZNzMHmF3RZcuW3i0779Mn7mmcMd2hbMmymlLojmVP
	Bgv2dqFjEo+kEYYYGbhhOv2ZXzrtnkTMv18iPHw26G7KtiwVd/OjkH3w66wX0DMsNdK1h300r2P
	aC9zU=
X-Gm-Gg: AeBDietjpBrx/8bdg47G0tNPdvxcIhK+wtzN0rEEZ9PyQB8iHG4dUtAN93pYW8kg2cN
	9V4jgRymoBihEz7fCWp1JR/82T3AO2KCdGsK3hiogf7Ou3CdOFxYnCOtPpkK7qcyvqe/QTr+M6u
	1qOmRvMdL7NoaxAo+oKkBdhQINxGa+ornLr2Pw43PyM0bblH38GNcwYJVpT/6kakS0XHXOm6QfD
	3vVPpz++hNvg08aVB/REwMObH3XUqV0oWvaKX/OxtAX4M3+MnCESY+cQuU8jzRD2kDw9xMDDjHr
	jkZH33tO5Rs4iEfpgLLvIgyUZ39vzE0r/mJ1v26z4kY2y9fxNsVPz9LHSjtgvv8t2UmhfukMCyN
	e8ZS3Nxy9GOtgOwMY/M5o7IKcGBEqGJrhuHrn96E9T4Y=
X-Received: by 2002:a05:6a00:21ca:b0:838:1c02:2763 with SMTP id d2e1a72fcca58-83a5b3ca97dmr8484604b3a.9.1778177260835;
        Thu, 07 May 2026 11:07:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:21ca:b0:838:1c02:2763 with SMTP id d2e1a72fcca58-83a5b3ca97dmr8484572b3a.9.1778177260178;
        Thu, 07 May 2026 11:07:40 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm12777253b3a.49.2026.05.07.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:07:39 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v2] monitor: Add parsing of CS step mode data in RAS
 Notifications             Subevent #0:               Start ACL Connection
 Event: 406               Frequency Compensation: -16384 (0.01 ppm)
            Ranging Done Status: Partial results, more to follow (0x1)
               Subevent Done Status: All results complete (0x0)
               Ranging Abort Reason: No abort (0x0)               Subevent
 Abort Reason: No abort (0x0)    Reference Power Level: -14 dBm
               Number of Steps Reported: 58                 Step 0
                   Mode Type: 0            Aborted: No                   Packet
 Quality: 0x00                     CS Access Address check is successful, and
 all bits match the expected sequence                     Bit errors: 0
                   Packet RSSI: -52 Packet Antenna: 1                 Step 1
                   Mode Type: 0                   Aborted: No
                   Packet Quality: 0x00                     CS Access Address
 check is successful, and all bits match the expected sequence
                     Bit errors: 0                 Packet RSSI: -48
                   Packet Antenna: 1                 Step 2 Mode Type: 1
                   Aborted: No                  Packet Quality: 0x00
                     CS Access Address check is successful, and all bits match
 the expected sequence                     Bit errors: 0                   Packet
 NADM: Unknown NADM (0xff)                  Packet RSSI: -60
                   ToA_ToD: 0xffffff45                   Packet Antenna: 1
                 Step 3                   Mode Type: 1       Aborted: No
                   Packet Quality: 0x00                CS Access Address check
 is successful, and all bits match the expected sequence                     Bit
 errors: 0                   Packet NADM: Unknown NADM (0xff)
                   Packet RSSI: -54                   ToA_ToD: 0xffffff53
                   Packet Antenna: 1
Date: Thu,  7 May 2026 23:37:36 +0530
Message-Id: <20260507180736.2990540-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE4MiBTYWx0ZWRfX2row1+1IYdr7
 tBlHmTCDAhp42HsJm9IpbOoGrSIrIHOmyPqnZn++ormuqgM0J/5kLkH6Q9POe0G8v+NDl+Sx1hv
 qjiVijI+zLuZXXWcFa0nri5HNaj6snRqZwkiD+nI6tDMoK+6VlJdVQb17MR3j1FnMxZIE373BbY
 911x+XhH3TI6cZW6PqiR+xnupxL5kfg6mDrkO6tmtjqYtFGxqWBqD9qRF0sVewGEvpLqmeNxhS3
 hANFG+cDLX0TZP8JNq/HHLDJ0LYgiDr0PHxImdHCM7qWyPUwRqfn89swxYAJ9woo4vg/cTB/RFF
 Wig8FLU4K+RbIB4Y8x8JNYQpVrM/7iH/qVdNEXu4ddO/KXC1HEq7y4rXi/uta5D3F4vDoUXfPmu
 Fx3dnhEegwIBesNXPnJjquKnvw1G0Cjos0UXjxmBXZcAnH50nGF5eCvaweTiw187Ti82L0ZGIjV
 nBWalNnOEImPEOMC51Q==
X-Proofpoint-GUID: s60TKgweJMYARiWD4jTU9Xv1hnTTMLeF
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fcd4ed cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=R78RYALgJh4NzzZS:21 a=OOwXq_LPoFEA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ovStltXwVjbntL60XsoA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: s60TKgweJMYARiWD4jTU9Xv1hnTTMLeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070182

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

---
 monitor/att.c | 521 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 500 insertions(+), 21 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 03d46634f..c8915ab04 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -4120,16 +4120,18 @@ static void print_ras_segmentation_header(uint8_t header)
 	print_field("    Segment Index: %u", segment_index);
 }
 
-static void print_ras_ranging_header(const struct l2cap_frame *frame)
+static uint8_t print_ras_ranging_header(const struct l2cap_frame *frame)
 {
 	uint16_t ranging_counter_config;
 	uint8_t selected_tx_power;
 	uint8_t antenna_paths_mask;
 	uint8_t mask;
+	uint8_t num_antenna_paths = 0;
+	uint8_t i;
 
 	if (!l2cap_frame_get_le16((void *)frame, &ranging_counter_config)) {
 		print_text(COLOR_ERROR, "    Ranging Header: invalid size");
-		return;
+		return 0;
 	}
 
 	/* Lower 12 bits: Ranging Counter, Upper 4 bits: Configuration ID */
@@ -4140,14 +4142,14 @@ static void print_ras_ranging_header(const struct l2cap_frame *frame)
 
 	if (!l2cap_frame_get_u8((void *)frame, &selected_tx_power)) {
 		print_text(COLOR_ERROR, "    Selected TX Power: invalid size");
-		return;
+		return 0;
 	}
 
 	print_field("    Selected TX Power: %d dBm", (int8_t)selected_tx_power);
 
 	if (!l2cap_frame_get_u8((void *)frame, &antenna_paths_mask)) {
 		print_text(COLOR_ERROR, "    Antenna Paths Mask: invalid size");
-		return;
+		return 0;
 	}
 
 	print_field("    Antenna Paths Mask: 0x%2.2x", antenna_paths_mask);
@@ -4157,6 +4159,14 @@ static void print_ras_ranging_header(const struct l2cap_frame *frame)
 
 	if (mask)
 		print_text(COLOR_WHITE_BG, "      RFU (0x%2.2x)", mask);
+
+	/* Count the number of set bits in antenna_paths_mask */
+	for (i = 0; i < 4; i++) {
+		if (antenna_paths_mask & (1 << i))
+			num_antenna_paths++;
+	}
+
+	return num_antenna_paths;
 }
 
 static const char *ras_ranging_done_status_str(uint8_t status)
@@ -4203,7 +4213,7 @@ static const char *ras_abort_reason_str(uint8_t reason)
 	}
 }
 
-static void print_ras_subevent_header(const struct l2cap_frame *frame)
+static uint8_t print_ras_subevent_header(const struct l2cap_frame *frame)
 {
 	uint16_t start_acl_conn_event;
 	uint16_t freq_compensation;
@@ -4216,7 +4226,7 @@ static void print_ras_subevent_header(const struct l2cap_frame *frame)
 	if (!l2cap_frame_get_le16((void *)frame, &start_acl_conn_event)) {
 		print_text(COLOR_ERROR,
 			"      Start ACL Connection Event: invalid size");
-		return;
+		return 0;
 	}
 
 	print_field("      Start ACL Connection Event: %u",
@@ -4225,7 +4235,7 @@ static void print_ras_subevent_header(const struct l2cap_frame *frame)
 	if (!l2cap_frame_get_le16((void *)frame, &freq_compensation)) {
 		print_text(COLOR_ERROR,
 			"      Frequency Compensation: invalid size");
-		return;
+		return 0;
 	}
 
 	print_field("      Frequency Compensation: %d (0.01 ppm)",
@@ -4233,7 +4243,7 @@ static void print_ras_subevent_header(const struct l2cap_frame *frame)
 
 	if (!l2cap_frame_get_u8((void *)frame, &status_byte1)) {
 		print_text(COLOR_ERROR, "      Status: invalid size");
-		return;
+		return 0;
 	}
 
 	ranging_done_status = status_byte1 & 0x0F;
@@ -4248,7 +4258,7 @@ static void print_ras_subevent_header(const struct l2cap_frame *frame)
 
 	if (!l2cap_frame_get_u8((void *)frame, &status_byte2)) {
 		print_text(COLOR_ERROR, "      Abort Reasons: invalid size");
-		return;
+		return 0;
 	}
 
 	ranging_abort_reason = status_byte2 & 0x0F;
@@ -4264,7 +4274,7 @@ static void print_ras_subevent_header(const struct l2cap_frame *frame)
 	if (!l2cap_frame_get_u8((void *)frame, &ref_power_level)) {
 		print_text(COLOR_ERROR,
 			"      Reference Power Level: invalid size");
-		return;
+		return 0;
 	}
 
 	print_field("      Reference Power Level: %d dBm",
@@ -4273,10 +4283,460 @@ static void print_ras_subevent_header(const struct l2cap_frame *frame)
 	if (!l2cap_frame_get_u8((void *)frame, &num_steps_reported)) {
 		print_text(COLOR_ERROR,
 			"      Number of Steps Reported: invalid size");
-		return;
+		return 0;
 	}
 
 	print_field("      Number of Steps Reported: %u", num_steps_reported);
+
+	return num_steps_reported;
+}
+
+static const char *packet_quality_str(uint8_t quality)
+{
+	switch (quality & 0x03) {
+	case 0x00:
+		return "CS Access Address check is successful, and all bits "
+			"match the expected sequence";
+	case 0x01:
+		return "CS Access Address check is successful, but some bits "
+			"do not match the expected sequence";
+	case 0x02:
+		return "CS Access Address check failed";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *tone_quality_str(uint8_t quality)
+{
+	switch (quality & 0x03) {
+	case 0x00:
+		return "Tone quality is high";
+	case 0x01:
+		return "Tone quality is medium";
+	case 0x02:
+		return "Tone quality is low";
+	case 0x03:
+		return "Tone quality indication is not available";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *tone_extension_str(uint8_t quality)
+{
+	switch ((quality >> 4) & 0x03) {
+	case 0x00:
+		return "Not tone extension slot";
+	case 0x01:
+		return "Tone extension slot; tone not expected to be present";
+	case 0x02:
+		return "Tone extension slot; tone expected to be present";
+	default:
+		return "Reserved";
+	}
+}
+
+static void print_step_mode_0(const struct l2cap_frame *frame, uint8_t len)
+{
+	uint8_t quality, rssi, antenna;
+	uint16_t freq_offset;
+
+	if (len < 3) {
+		print_hex_field("          Raw step data", frame->data, len);
+		return;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &quality)) {
+		print_text(COLOR_ERROR,
+			"          Packet Quality: invalid");
+		return;
+	}
+
+	print_field("          Packet Quality: 0x%02x", quality);
+	print_field("            %s", packet_quality_str(quality));
+	print_field("            Bit errors: %u", (quality >> 2) & 0x3F);
+
+	if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
+		print_text(COLOR_ERROR, "          Packet RSSI: invalid");
+		return;
+	}
+
+	print_field("          Packet RSSI: %d", (int8_t)rssi);
+
+	if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
+		print_text(COLOR_ERROR,
+			"          Packet Antenna: invalid");
+		return;
+	}
+
+	print_field("          Packet Antenna: %u", antenna);
+
+	if (len == 5) {
+		if (!l2cap_frame_get_le16((void *)frame, &freq_offset)) {
+			print_text(COLOR_ERROR,
+				"          Measured Freq Offset: invalid size");
+			return;
+		}
+
+		print_field("          Measured Freq Offset: %d (0.01 ppm)",
+						(int16_t)freq_offset);
+	}
+}
+
+static void print_step_mode_1(const struct l2cap_frame *frame, uint8_t len)
+{
+	uint8_t quality, nadm, rssi, antenna;
+	uint16_t toa_tod;
+
+	if (len < 6) {
+		print_hex_field("          Raw step data", frame->data, len);
+		return;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &quality)) {
+		print_text(COLOR_ERROR, "          Packet Quality: invalid");
+		return;
+	}
+
+	print_field("          Packet Quality: 0x%02x", quality);
+	print_field("            %s", packet_quality_str(quality));
+	print_field("            Bit errors: %u", (quality >> 2) & 0x3F);
+
+	if (!l2cap_frame_get_u8((void *)frame, &nadm)) {
+		print_text(COLOR_ERROR, "          Packet NADM: invalid");
+		return;
+	}
+
+	if (nadm == 0xFF)
+		print_field("          Packet NADM: Unknown NADM (0xff)");
+	else
+		print_field("          Packet NADM: %u", nadm);
+
+	if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
+		print_text(COLOR_ERROR, "          Packet RSSI: invalid");
+		return;
+	}
+
+	print_field("          Packet RSSI: %d", (int8_t)rssi);
+
+	if (!l2cap_frame_get_le16((void *)frame, &toa_tod)) {
+		print_text(COLOR_ERROR, "          ToA_ToD: invalid");
+		return;
+	}
+
+	print_field("          ToA_ToD: 0x%08x", toa_tod | 0xFFFF0000);
+
+	if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
+		print_text(COLOR_ERROR, "          Packet Antenna: invalid");
+		return;
+	}
+
+	print_field("          Packet Antenna: %u", antenna);
+}
+
+static void print_step_mode_2(const struct l2cap_frame *frame, uint8_t len,
+				uint8_t num_antenna_paths)
+{
+	uint8_t ant_perm_idx;
+	uint8_t i;
+	uint32_t pct;
+	uint16_t i_sample, q_sample;
+	uint8_t quality;
+
+	if (len < 1) {
+		print_hex_field("          Raw step data", frame->data, len);
+		return;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &ant_perm_idx)) {
+		print_text(COLOR_ERROR, "          Antenna Permutation Index: "
+							"invalid size");
+		return;
+	}
+
+	print_field("          Antenna Permutation Index: %u", ant_perm_idx);
+
+	/* Use the antenna paths count from ranging header */
+	for (i = 0; i < (num_antenna_paths + 1); i++) {
+		if (frame->size < 4) {
+			print_text(COLOR_ERROR,
+				"            Insufficient data for path %u",
+				i);
+			return;
+		}
+
+		if (!l2cap_frame_get_le24((void *)frame, &pct)) {
+			print_text(COLOR_ERROR, "            PCT: invalid");
+			return;
+		}
+
+		/* Extract 12-bit I and Q samples from 24-bit PCT */
+		i_sample = pct & 0x0FFF;
+		q_sample = (pct >> 12) & 0x0FFF;
+
+		print_field("          Path %u", i);
+		print_field("            PCT: 0x%06x", pct);
+		print_field("              I: 0x%03x", i_sample);
+		print_field("              Q: 0x%03x", q_sample);
+
+		if (!l2cap_frame_get_u8((void *)frame, &quality)) {
+			print_text(COLOR_ERROR,
+				"            Tone quality indicator: "
+				"invalid size");
+			return;
+		}
+
+		print_field("            Tone quality indicator: 0x%02x",
+				quality);
+		print_field("              %s (0x%02x)",
+				tone_quality_str(quality),
+				quality & 0x03);
+		print_field("              %s (0x%02x)",
+				tone_extension_str(quality),
+				(quality >> 4) & 0x03);
+	}
+}
+
+static void print_step_mode_3(const struct l2cap_frame *frame, uint8_t len,
+				uint8_t num_antenna_paths)
+{
+	uint8_t quality, nadm, rssi, antenna;
+	uint16_t toa_tod;
+	uint8_t ant_perm_idx;
+	uint8_t i;
+	uint32_t pct;
+	uint16_t i_sample, q_sample;
+	uint8_t tone_quality;
+
+	/* Mode 3 = Mode 1 (6 bytes) + Mode 2 (variable) */
+	if (len < 6) {
+		print_hex_field("          Raw step data", frame->data, len);
+		return;
+	}
+
+	/* Parse Mode 1 data first */
+	if (!l2cap_frame_get_u8((void *)frame, &quality)) {
+		print_text(COLOR_ERROR, "          Packet Quality: invalid");
+		return;
+	}
+
+	print_field("          Packet Quality: 0x%02x", quality);
+	print_field("            %s", packet_quality_str(quality));
+	print_field("            Bit errors: %u", (quality >> 2) & 0x3F);
+
+	if (!l2cap_frame_get_u8((void *)frame, &nadm)) {
+		print_text(COLOR_ERROR, "          Packet NADM: invalid size");
+		return;
+	}
+
+	if (nadm == 0xFF)
+		print_field("          Packet NADM: Unknown NADM (0xff)");
+	else
+		print_field("          Packet NADM: %u", nadm);
+
+	if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
+		print_text(COLOR_ERROR, "          Packet RSSI: invalid size");
+		return;
+	}
+
+	print_field("          Packet RSSI: %d", (int8_t)rssi);
+
+	if (!l2cap_frame_get_le16((void *)frame, &toa_tod)) {
+		print_text(COLOR_ERROR, "          ToA_ToD: invalid size");
+		return;
+	}
+
+	print_field("          ToA_ToD: 0x%08x", toa_tod | 0xFFFF0000);
+
+	if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
+		print_text(COLOR_ERROR, "          Packet Antenna: invalid");
+		return;
+	}
+
+	print_field("          Packet Antenna: %u", antenna);
+
+	/* Now parse Mode 2 data */
+	if (frame->size < 1)
+		return;
+
+	if (!l2cap_frame_get_u8((void *)frame, &ant_perm_idx)) {
+		print_text(COLOR_ERROR, "          Antenna Permutation Index: "
+							"invalid size");
+		return;
+	}
+
+	print_field("          Antenna Permutation Index: %u", ant_perm_idx);
+
+	/* Use the antenna paths count from ranging header */
+	for (i = 0; i < (num_antenna_paths + 1); i++) {
+		if (frame->size < 4) {
+			print_text(COLOR_ERROR,
+				"            Insufficient data for path %u",
+				i);
+			return;
+		}
+
+		if (!l2cap_frame_get_le24((void *)frame, &pct)) {
+			print_text(COLOR_ERROR, "            PCT: invalid");
+			return;
+		}
+
+		/* Extract 12-bit I and Q samples from 24-bit PCT */
+		i_sample = pct & 0x0FFF;
+		q_sample = (pct >> 12) & 0x0FFF;
+
+		print_field("          Path %u", i);
+		print_field("            PCT: 0x%06x", pct);
+		print_field("              I: 0x%03x", i_sample);
+		print_field("              Q: 0x%03x", q_sample);
+
+		if (!l2cap_frame_get_u8((void *)frame, &tone_quality)) {
+			print_text(COLOR_ERROR,
+				"            Tone quality indicator: "
+				"invalid size");
+			return;
+		}
+
+		print_field("            Tone quality indicator: 0x%02x",
+				tone_quality);
+		print_field("              %s (0x%02x)",
+				tone_quality_str(tone_quality),
+				tone_quality & 0x03);
+		print_field("              %s (0x%02x)",
+				tone_extension_str(tone_quality),
+				(tone_quality >> 4) & 0x03);
+	}
+}
+
+static void  print_ranging_steps(const struct l2cap_frame *frame,
+				uint8_t num_steps, uint8_t num_antenna_paths)
+{
+	uint8_t step_idx;
+
+	for (step_idx = 0; step_idx < num_steps && frame->size > 0;
+								step_idx++) {
+		uint8_t mode_byte;
+		uint8_t mode_type;
+		bool aborted;
+		uint8_t step_data_len;
+
+		if (!l2cap_frame_get_u8((void *)frame, &mode_byte)) {
+			print_text(COLOR_ERROR,
+				"        Step %u: Mode: invalid size",
+				step_idx);
+			return;
+		}
+
+		mode_type = mode_byte & 0x03;
+		aborted = (mode_byte & 0x80) != 0;
+
+		print_field("        Step %u", step_idx);
+		print_field("          Mode Type: %u", mode_type);
+		print_field("          Aborted: %s", aborted ? "Yes" : "No");
+
+		/* If aborted, step data length is 0 */
+		if (aborted)
+			continue;
+
+		/* Determine step data length based on mode type
+		 * Mode 0: Check if we have 5 bytes (initiator) or 3 bytes
+		 * (reflector)
+		 * Mode 1: Always 6 bytes
+		 * Mode 2: 1 byte (ant_perm_idx) + num_antenna_paths * 4 bytes
+		 * Mode 3: 6 bytes (Mode 1) + 1 byte (ant_perm_idx) +
+		 * num_antenna_paths * 4 bytes
+		 */
+		switch (mode_type) {
+		case 0:
+			/* Mode 0: Default to 3 bytes (reflector)
+			 * Only use 5 bytes if we're the last step AND have
+			 * exactly 5 bytes remaining
+			 */
+			if (step_idx == num_steps - 1 && frame->size == 5) {
+				/* Initiator - last step with exactly 5 bytes */
+				step_data_len = 5;
+			} else if (frame->size >= 3) {
+				/* Reflector - default case */
+				step_data_len = 3;
+			} else {
+				print_text(COLOR_ERROR,
+					"          Insufficient data for Mode 0");
+				return;
+			}
+			break;
+		case 1:
+			/* Mode 1: Always 6 bytes */
+			if (frame->size < 6) {
+				print_text(COLOR_ERROR,
+					"          Insufficient data for Mode 1");
+				return;
+			}
+			step_data_len = 6;
+			break;
+		case 2:
+			/* Mode 2: 1 byte antenna + num_antenna_paths * 4
+			 * bytes per path
+			 */
+			step_data_len = 1 + ((num_antenna_paths + 1) * 4);
+			if (frame->size < step_data_len) {
+				print_text(COLOR_ERROR,
+					"          Insufficient data for Mode 2 (need %u)",
+					step_data_len);
+				return;
+			}
+			break;
+		case 3:
+			/* Mode 3: 6 bytes Mode 1 + 1 byte antenna +
+			 * num_antenna_paths * 4 bytes
+			 */
+			step_data_len = 7 + ((num_antenna_paths + 1) * 4);
+			if (frame->size < step_data_len) {
+				print_text(COLOR_ERROR,
+					"          Insufficient data for Mode 3 (need %u)",
+					step_data_len);
+				return;
+			}
+			break;
+		default:
+			print_text(COLOR_ERROR, "          Unknown mode type");
+			return;
+		}
+
+		if (step_data_len > frame->size) {
+			print_text(COLOR_ERROR,
+				"          Invalid step data length");
+			return;
+		}
+
+		if (step_data_len > 0) {
+			struct l2cap_frame step_frame;
+
+			l2cap_frame_clone(&step_frame, frame);
+			step_frame.size = step_data_len;
+
+			switch (mode_type) {
+			case 0:
+				print_step_mode_0(&step_frame, step_data_len);
+				break;
+			case 1:
+				print_step_mode_1(&step_frame, step_data_len);
+				break;
+			case 2:
+				print_step_mode_2(&step_frame, step_data_len,
+						num_antenna_paths);
+				break;
+			case 3:
+				print_step_mode_3(&step_frame, step_data_len,
+						num_antenna_paths);
+				break;
+			}
+
+			if (!l2cap_frame_pull((void *)frame, frame,
+							step_data_len))
+				return;
+		}
+	}
 }
 
 static void ras_ranging_data_read(const struct l2cap_frame *frame)
@@ -4292,26 +4752,45 @@ static void ras_ranging_data_read(const struct l2cap_frame *frame)
 	print_ras_segmentation_header(seg_header);
 
 	first_segment = seg_header & 0x01;
-
 	/* Only try to decode headers if this is the first segment */
-	if (first_segment && frame->size >= 6) {
+	if (first_segment && frame->size >= 4) {
+		uint8_t num_steps;
+		uint8_t num_antenna_paths;
+
 		print_field("  Ranging Data Body:");
-		print_ras_ranging_header(frame);
+		num_antenna_paths = print_ras_ranging_header(frame);
 
 		/* Try to decode subevent header if enough data remains */
-		if (frame->size >= 10) {
+		if (frame->size >= 8) {
 			print_field("    Subevent #0:");
-			print_ras_subevent_header(frame);
+			num_steps = print_ras_subevent_header(frame);
+
+			/* Parse steps if we have num_steps and
+			 * num_antenna_paths
+			 */
+			if (num_steps > 0 && num_antenna_paths > 0 &&
+						frame->size > 0) {
+				print_ranging_steps((void *)frame, num_steps,
+						num_antenna_paths);
+			}
 		}
+	} else if (!first_segment && frame->size > 0) {
+		/* For continuation segments, we cannot reliably decode without
+		 * full segment reassembly, as steps may be split across
+		 * segments.
+		 * Just show the raw data.
+		 */
+		print_field("  Continuation Segment (raw data - requires "
+				"reassembly for proper decoding):");
+		print_hex_field("    Segment Data", frame->data, frame->size);
 	}
 
-	if (frame->size > 0) {
-		print_hex_field("  Remaining Ranging Data Segment", frame->data,
-								frame->size);
-	}
+	if (frame->size > 0 && first_segment)
+		print_hex_field("  Remaining Ranging Data Segment",
+						frame->data, frame->size);
 
 done:
-	if (frame->size)
+	if (frame->size && first_segment)
 		print_hex_field("  Remaining Data", frame->data, frame->size);
 }
 
-- 
2.34.1

