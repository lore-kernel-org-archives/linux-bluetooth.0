Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0166376BF7
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778218726; cv=none; b=fCyBSrn3yZrrHlirUECc221tYfpj8d7aGUM5ylc+qtxNvXP3MyKy4iVGPlOXaBN65cEMKuTBTXWzeA/67y63VMdt4+L0+mA7RIZ6MF46ipJg8697Anun8vXazq9fMku5muDOryJQFAvlF/Hr917QxyOXVZKt4TWusb9Ptnl7q5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778218726; c=relaxed/simple;
	bh=S/h/udLmRaPAx8ZS2ugePY6nm6kZU5N2hFDwb40K4cU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2rv1xkiLoEs8ozTDDxpNuGBBJLTvHEuKrOHbRiVEsQeyo9ctfoD6QPL7L8wANHuHEA4Q+O6vWtbR90WQ4muZjM9CDiNfIQM/Lq0cHN/tXabfOSrk6xAqkRH1ubUH+LLyQZV9kfQIfblt13MQuJd0ZUKod5Aek61qYDW9fY2m4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=as4dV2F3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NlgKEEX/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="as4dV2F3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NlgKEEX/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648508Yl2183134
	for <linux-bluetooth@vger.kernel.org>; Fri, 8 May 2026 05:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sLN8VSyuwbB+m+idKHtlYlqyPiQXExlNqlf
	cNfM31bQ=; b=as4dV2F3jvUEc3H/Mpr5548TpsxpDUWCbHsnq0CK+FidSwwJWj6
	TqjIm/BIhbVzXoOB3tLBtQNLbEd15UXgN3t5YzwBzJATq/JoUIyXI7mj91L2iL6k
	/P5EDuzkHyx8CtCLMavKrUV8qxgZK+MunI5Zfto0FJyij9qHblpg/pS72yhCqS/H
	tucdkw0j7aOKKQ3w+S9rzoIwQ5MLHRle4tHF0iWiKZU7O21rzUJXazQUSLuWcZtu
	Y1snMh6I9DVH+6nlEgAFVh0gdhw5fLiBFEOJBiCaz6HWJ+wGqY4Oh9/+2EZV+Pgs
	/psuKmEMgfRA/X08lxFreqLb0zUhnCNsWqQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e10py9tmb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2026 05:38:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba838c5ff1so34952795ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778218704; x=1778823504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLN8VSyuwbB+m+idKHtlYlqyPiQXExlNqlfcNfM31bQ=;
        b=NlgKEEX/GdXHlNAKHZNKt7NjeHtxVsYc+eIDHXD3c2w+uOyuI6MtbYLQxJKjIGXesa
         LwvdnHJRip0jfpKRZCSHw1QW0WSnplW4hmlsLLmjn5dM02GJAQVQSVedRFCbt9yamF32
         LBl8Dk3XVsv6tY7gLm6rqj2/1BnFUlPpHT/qN1WzjqTamMw/+rV4hvlUAu5sPQclZ0QK
         MOPYdR5TvRczCGvkRLrBj6gXu4dUyxSs3U5bAFvwAov++iWeNLowgp/9EdGhiyXnI+hP
         m5gSFwm/Nw3TSEaud1iP7GC9028bU49ial7KzOKa9NpIOGJ0lnXNgMX4T0s8tH9wWdg2
         mzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778218704; x=1778823504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLN8VSyuwbB+m+idKHtlYlqyPiQXExlNqlfcNfM31bQ=;
        b=IjjK3N6vd9rHazLWhWOwE2TwLZndWFOHmZcB/6j3Yc6TchCNmBo8cQ4zcfoGGZAxLW
         G8E+2aRBDe42RK+PiytZzWs0XNov4WTqB9pXsOpM2cwjN/CMC8gAkv1xwj2QXKmV/gXm
         zE+7VZ882DHi/INmCGrvYPcb6aUYTYz/OaXj7AENG2ZXKrSGrtK+DEeMRRgQo6rbtkgN
         3fbK4xJ/bsQIaWSgTxOwzbAwPB6S0vx14Ts3K4Nmsrtbbwh7kBQFgT0C+9NYlZ1/Aq5D
         s1jRePUyu6X1FO8Vsj4ojJrIXmnNuTLuVpGafH+BnwNml/stf9GJrg2Hau4Yf9KV8IZb
         RFIg==
X-Gm-Message-State: AOJu0YydIfgqJ6+q3BJQ+efziLRhRwUrgv8fX1Jo5NFwGGJJIyeDaN0p
	iodOuQ5AdhglsdqUPOgoQFg83B2HrOWShCh7YQ6LNXPaaGH3h9kWb/VEdet0WqzMiEINywYcnIm
	eKSxQD1drJwMGC731+c62AGk86WSSVf1wT+MKLpCXl0G1SZ2nKWSnYo4OYO0jzrcu5mGsj84wMT
	E4BHM=
X-Gm-Gg: Acq92OELOPrfSSEqL4Vl9k07zldrqzRPb7sWsmRroTKE63kxrov0bKcwWLI1oIoE21Z
	jX1ksynZL1t/31SCPXisRn+op2VJF94ymE3GrZz2oCGW34f4kafy19lxJ3+bDSV3twJjHqIeCw9
	2d8z3aQiyPgZGckTCu+x/nQW+UaWmBknXoJVzM6pej+ftbYNVLOMNydjt4dSI7RzAWNMtl04Yie
	lOT0TJkyhOY8Cri2wB85HDi+q4SVWjb6fhoq9HPgSlDNQ5ZFtjRu0Z4DoBAuX56QQqAlkojDziK
	z0tabVbBLAu5dhb9YM2FsuPnXj/IXNB0+rbiQWnCVmbZZwHqy3RaBxZQQu5wr1B8rPSHtvTvrWA
	PfPv3dv9V015rt+QXQakFB5egk7+TRi76zm+zwhBc0KE=
X-Received: by 2002:a17:902:c112:b0:2ba:11e2:6c1e with SMTP id d9443c01a7336-2ba7a3771eemr80001095ad.40.1778218704237;
        Thu, 07 May 2026 22:38:24 -0700 (PDT)
X-Received: by 2002:a17:902:c112:b0:2ba:11e2:6c1e with SMTP id d9443c01a7336-2ba7a3771eemr80000775ad.40.1778218703595;
        Thu, 07 May 2026 22:38:23 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d2700dsm7944375ad.2.2026.05.07.22.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 22:38:23 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v3] monitor: Parsing of cs step mode data in RAS Notifications
Date: Fri,  8 May 2026 11:08:19 +0530
Message-Id: <20260508053819.3424918-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DZUnbPtW c=1 sm=1 tr=0 ts=69fd76d1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=W8hmDp5Yp52U6Zyi-J8A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: LTEgMx48Q4x-YILlMKKBQhVqi_ac0axM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA1MiBTYWx0ZWRfX45z2UH95fhtE
 r7k5XP4IrgEyGNDZI4NEVmnqmkhYORIkhsoVbB8duvV8tW42dXQJR+ywKwP37YljtTtbMHsPL0e
 DKnvxlO8GG1CZJN2cMNyuDhq246Bs8hy4OELMK5JAw4M73hMs3V2sH6E6Hzmf1VgZ+J+Zirkbtq
 n4xwa69f6BRx0uhAap1Ati2WBq27ZDiw1EYpoQIo7kDA+lPyuHh97vOAAHAl+GuvVC0PBtZIqix
 9U3zjSeWTFsdtBlTkAx9VHkaBM3k36JpUEXOARY2dZjHBSqyateXw71Ojv84vX7+FiAyxZc/GtY
 wfUfZfQfLMxLZWst6Vq5ds1z3G5bLK0pmwVomZGrHzaFDKHG3EiqPxvKS+YjrdsC5ypQge0Njj1
 g1TRUUrSPCrmw/AHmrVEptJ3Jb4pLGNJBCAhlOZoDqtLVPgvSVTcDm06SzF29H0z6LT98P5ccG4
 X5ZXGda4uyyB0F3JoGw==
X-Proofpoint-ORIG-GUID: LTEgMx48Q4x-YILlMKKBQhVqi_ac0axM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080052

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

Sample Decoding Example:
            Subevent #0:
              Start ACL Connection Event: 406
              Frequency Compensation: -16384 (0.01 ppm)
              Ranging Done Status: Partial results, more to follow (0x1)
              Subevent Done Status: All results complete (0x0)
              Ranging Abort Reason: No abort (0x0)
              Subevent Abort Reason: No abort (0x0)
              Reference Power Level: -14 dBm
              Number of Steps Reported: 58
                Step 0
                  Mode Type: 0
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet RSSI: -52
                  Packet Antenna: 1
                Step 1
                  Mode Type: 0
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet RSSI: -48
                  Packet Antenna: 1
                Step 2
                  Mode Type: 1
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet NADM: Unknown NADM (0xff)
                  Packet RSSI: -60
                  ToA_ToD: 0xffffff45
                  Packet Antenna: 1
                Step 3
                  Mode Type: 1
                  Aborted: No
                  Packet Quality: 0x00
                    CS Access Address check is successful
                    Bit errors: 0
                  Packet NADM: Unknown NADM (0xff)
                  Packet RSSI: -54
                  ToA_ToD: 0xffffff53
                  Packet Antenna: 1
---
 monitor/att.c | 523 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 501 insertions(+), 22 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 03d46634f..278ac5675 100644
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
@@ -4273,16 +4283,466 @@ static void print_ras_subevent_header(const struct l2cap_frame *frame)
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
 {
 	uint8_t seg_header;
-	bool first_segment;
+	bool first_segment = true;
 
 	if (!l2cap_frame_get_u8((void *)frame, &seg_header)) {
 		print_text(COLOR_ERROR, "  Segmentation Header: invalid size");
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

