Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBE34F49F
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174032; cv=none; b=rfdVCG8fvBINvmGzlpxJ1Z5TJIxt2aHj+4EWgQWFNyx6V2KztYZLxYojT2ozfnxz655tM+esPyvzng8ySnPnhz058I0nMxuqftBavmwyOCaUMUH1sWcaeuRedMEsfTWqL2YTGyTVp99iPJzQaaYwRFP+SIA8AYyGrTwTxPUoB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174032; c=relaxed/simple;
	bh=E40OdREOhQCxHFWzEtww1Sq2r3iCmHUm2jMagSIEQn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tcb5U0fHrjnqjQWlJgnaW3VXDIg9Jhke2cTY+SDNP0lgJPez43uhRbfjO/q7OIbH9J8gQEzuu2DHkkCsYxZubixpJCnEsGHET2L1lF3CGJDoRrvE41ZjPnn0AYsMd+yg6SO8eEv2Dw2tMGXW0eZz0xAK1IlSdYovqq7vXoKgKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KZJf1ToE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PuwNoh2/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZJf1ToE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PuwNoh2/"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647F5h5w259747
	for <linux-bluetooth@vger.kernel.org>; Thu, 7 May 2026 17:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vWxlArjgwF81NUv9FAXIv01FwU1EYTIoABq
	0GOkM3fo=; b=KZJf1ToE9N2YtmvpA/2mw2nmvxUAYvrZQ81BwSHGU37C7MebmTo
	JYbW4QpdGY8BGgQdN3tYkcF/oZrYB1cvjg6ARjCUvfuqCCKoTf8o0lircvlijq8g
	ePqnolMiwkP6JsyHOk7yWRE2nv9H4ucoTW8P+Uo1xlF+5uMwtsm2L6jxMWTG3Ui2
	kpTGFZWxRTzkriC1CWnTaEveezb65oIgtPWrvW/t08O8tFQ7H3ugVutmGMcUkkEv
	3agZgynEVwQ3maIYF7XHF/K1V2mr2vKYvchg5FIctyQxh9V11Amqc2DyRPyQpZLn
	QXXPT05nT/dX+28z+jfrsZQA6ffLW7xqDmQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8ubct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 17:13:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2eba42b8dso13151975ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778174027; x=1778778827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vWxlArjgwF81NUv9FAXIv01FwU1EYTIoABq0GOkM3fo=;
        b=PuwNoh2/D6afvpza+P6HKd8yNHXsOu2RFiqTXAElfEB+WFUUa5NZmUamDx8BCUT8KV
         ab1s+070GqDkUFQ0J09fG/gg2h8m2uDy7ZCio9Lh3KvqCTWfR7sfGYylIV44vd8vO8Ji
         9//WxIYirJ8gTAOAbKQBgLfO2cramacv9hzlJbQa8FyGZoWBXrS7/zduztx/O9FVHM++
         1A7/8iLHguKaVlevzBKVtRWIFix4+LP6Jrae246dOYAa4BDi7HZniFwv4oR9bTWQVd0l
         n50DAwDZhK96D1GOYX1dhspq9Q1/rbLEHXWbUZ05iYt9Z9TAO3whisFH1Uo1MVUHyNtv
         /6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778174027; x=1778778827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWxlArjgwF81NUv9FAXIv01FwU1EYTIoABq0GOkM3fo=;
        b=ZZerYA+G6eDfkPhCyQ31kHXW9Evq3MFlE/A7YdkJ61XPdFktgKCPxDys4N/erJ7W62
         41pBDLdwfiwDVZRFXI7I36z+zS/QmsPKSnGopxiZD4Q9ilU+BH15C2X29/e6GchcOR76
         eh68oiRwiMp3EB2g9hdVf4foBpqHwXMjKeTrFAQRHb4SLEP6/7gyb821wq/oViG8TKtZ
         0dTfQhz8lvrbk6mE45Z9ZoxjfJMfqKO+vnPRgoCcYb4dB85rm+YiveUNViXmz2wd1BAu
         0MVCb6FDmVyuGcUtCcGm7ecKalLxNkC5SlGa1lqwGti1JO77axprp5sDGjxlqKouNFAH
         jSig==
X-Gm-Message-State: AOJu0YzxwH6/2UDqZSQb7u3dxHoFmaIBhWsH3kbcFO9WMwper37QWfCU
	dERlg70hIpfvjj3bb9yTA1LOHi07GA7ltG3yX2SXQnGp120wYATDLKnamedqd0xnEwK71yfsswO
	oWhQNtgyR7970YUeg36fSJM2vlIUk6j/eJ1w0RlqYpD/hZG/5HfleOk9WYNkoMNnXzGSS6bsMoT
	KFslU=
X-Gm-Gg: Acq92OGDYDufkWdH2/AecX0Fe1HdANP98VKo/uebdkvTBoZ0QXplSA2xVMKfydFAw7D
	soIsXSEt2pTuM5oqHlq7VbsuBYrQHMp8vu2+8Mkv7UBlkbz8fRP7Faq2mxSXpT/8/XYqbUCXzSZ
	ytY1m7k9fJAPcoHuXO2MWtFItkS3PSdICvCKSlEwC5Nt8ySCPKx5F0z0bi+SYTlWOsMVEOwtftE
	OBu66evcv6zxO0C3mr57lL+HJCb52JGaRb7mabWSzMpOWTMRZ4kntDPAejbWwQJK7W5XJ02hme3
	g1uRYmbERg8jsdL12+eTHedBmsYm75KUZwb14taaK3ZdSqIWobS7xgpWXw+7rEVIgyU6DahTDNO
	TYgKt6IWrtS6VBxwkz/oONwS8wpWkAJky5ZGNNLIuRMo=
X-Received: by 2002:a17:903:178b:b0:2ba:881f:6192 with SMTP id d9443c01a7336-2ba881f63c2mr85698715ad.22.1778174027143;
        Thu, 07 May 2026 10:13:47 -0700 (PDT)
X-Received: by 2002:a17:903:178b:b0:2ba:881f:6192 with SMTP id d9443c01a7336-2ba881f63c2mr85698285ad.22.1778174026541;
        Thu, 07 May 2026 10:13:46 -0700 (PDT)
Received: from hu-prathm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae78412bdsm2601335ad.42.2026.05.07.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:13:46 -0700 (PDT)
From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
X-Google-Original-From: Prathibha Madugonde <prathm@qti.qualcomm.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        quic_anubhavg@quicinc.com
Subject: [PATCH BlueZ v1] monitor: Add parsing of CS step mode data in RAS Notifications
Date: Thu,  7 May 2026 22:43:42 +0530
Message-Id: <20260507171342.2971553-1-prathm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JbuQGbC0jY7vBOIlBcG2D2gQdnhuohBU
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fcc84c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=RTxZpuEgJeujCBl3evkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: JbuQGbC0jY7vBOIlBcG2D2gQdnhuohBU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3MyBTYWx0ZWRfX+l6bxRF+9s9H
 jUXfZjBcCiBqp9VPv02FLazYIRZgakSP3qgjlovq/8xlMXa3nDPV8Osd2D/ZrQ+EPa0q1JhVl0O
 237MvXVrGCiKzlhVTT3urKx8vdMo2gWzu1RICn0BkeMH1Fc4DVnTahE/ZeXNWqJqtDoxG22hFPL
 jgWbjGyFR9X69MbNiVDMzmxBVisEPM2mps9+5vVykIRpnv+NjDKW37ME5WluiT0cbH6SCc2KzQG
 30nBe/gkgjQ+Edt3ju5y+UC395W05yTtfsr3EC8xZWLS1aRApFwjRdTc4mODAU+X8ZzFCzACmiB
 zCmmZshDiI22Xsk2o32QTnC2ocpGtgOH9DgJut7/7MiJnk+qVDeYp2LW9sPIHkhedqIDydEl8Aq
 3ngDx1zU4Hy262vW9FmQ1M0lf0jBAoD/FD9zypgQ6h29kNsCGo5Ad2NRjecTKf8Un/5KJ//9wqm
 yPjB9GdLAiq3fOb+3yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070173

From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>

---
 monitor/att.c | 512 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 491 insertions(+), 21 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 03d46634f..a979ab241 100644
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
@@ -4273,10 +4283,451 @@ static void print_ras_subevent_header(const struct l2cap_frame *frame)
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
+		print_hex_field("  Raw step data", frame->data, len);
+		return;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &quality)) {
+		print_text(COLOR_ERROR, "  Packet Quality: invalid size");
+		return;
+	}
+
+	print_field("  Packet Quality: 0x%02x", quality);
+	print_field("    %s", packet_quality_str(quality));
+	print_field("    Bit errors: %u", (quality >> 2) & 0x3F);
+
+	if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
+		print_text(COLOR_ERROR, "  Packet RSSI: invalid size");
+		return;
+	}
+
+	print_field("  Packet RSSI: %d", (int8_t)rssi);
+
+	if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
+		print_text(COLOR_ERROR, "  Packet Antenna: invalid size");
+		return;
+	}
+
+	print_field("  Packet Antenna: %u", antenna);
+
+	if (len == 5) {
+		if (!l2cap_frame_get_le16((void *)frame, &freq_offset)) {
+			print_text(COLOR_ERROR,
+				"  Measured Freq Offset: invalid size");
+			return;
+		}
+
+		print_field("  Measured Freq Offset: %d (0.01 ppm)",
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
+		print_hex_field("  Raw step data", frame->data, len);
+		return;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &quality)) {
+		print_text(COLOR_ERROR, "  Packet Quality: invalid size");
+		return;
+	}
+
+	print_field("  Packet Quality: 0x%02x", quality);
+	print_field("    %s", packet_quality_str(quality));
+	print_field("    Bit errors: %u", (quality >> 2) & 0x3F);
+
+	if (!l2cap_frame_get_u8((void *)frame, &nadm)) {
+		print_text(COLOR_ERROR, "  Packet NADM: invalid size");
+		return;
+	}
+
+	if (nadm == 0xFF)
+		print_field("  Packet NADM: Unknown NADM (0xff)");
+	else
+		print_field("  Packet NADM: %u", nadm);
+
+	if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
+		print_text(COLOR_ERROR, "  Packet RSSI: invalid size");
+		return;
+	}
+
+	print_field("  Packet RSSI: %d", (int8_t)rssi);
+
+	if (!l2cap_frame_get_le16((void *)frame, &toa_tod)) {
+		print_text(COLOR_ERROR, "  ToA_ToD: invalid size");
+		return;
+	}
+
+	print_field("  ToA_ToD: 0x%08x", toa_tod | 0xFFFF0000);
+
+	if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
+		print_text(COLOR_ERROR, "  Packet Antenna: invalid size");
+		return;
+	}
+
+	print_field("  Packet Antenna: %u", antenna);
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
+		print_hex_field("  Raw step data", frame->data, len);
+		return;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &ant_perm_idx)) {
+		print_text(COLOR_ERROR, "  Antenna Permutation Index: "
+							"invalid size");
+		return;
+	}
+
+	print_field("  Antenna Permutation Index: %u", ant_perm_idx);
+
+	/* Use the antenna paths count from ranging header */
+	for (i = 0; i < (num_antenna_paths + 1); i++) {
+		if (frame->size < 4) {
+			print_text(COLOR_ERROR,
+				"    Insufficient data for path %u",
+				i);
+			return;
+		}
+
+		if (!l2cap_frame_get_le24((void *)frame, &pct)) {
+			print_text(COLOR_ERROR, "    PCT: invalid size");
+			return;
+		}
+
+		/* Extract 12-bit I and Q samples from 24-bit PCT */
+		i_sample = pct & 0x0FFF;
+		q_sample = (pct >> 12) & 0x0FFF;
+
+		print_field("  Path %u", i);
+		print_field("    PCT: 0x%06x", pct);
+		print_field("      I: 0x%03x", i_sample);
+		print_field("      Q: 0x%03x", q_sample);
+
+		if (!l2cap_frame_get_u8((void *)frame, &quality)) {
+			print_text(COLOR_ERROR, "    Tone quality indicator: "
+							"invalid size");
+			return;
+		}
+
+		print_field("    Tone quality indicator: 0x%02x", quality);
+		print_field("      %s (0x%02x)", tone_quality_str(quality),
+							quality & 0x03);
+		print_field("      %s (0x%02x)", tone_extension_str(quality),
+							(quality >> 4) & 0x03);
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
+		print_hex_field("  Raw step data", frame->data, len);
+		return;
+	}
+
+	/* Parse Mode 1 data first */
+	if (!l2cap_frame_get_u8((void *)frame, &quality)) {
+		print_text(COLOR_ERROR, "  Packet Quality: invalid size");
+		return;
+	}
+
+	print_field("  Packet Quality: 0x%02x", quality);
+	print_field("    %s", packet_quality_str(quality));
+	print_field("    Bit errors: %u", (quality >> 2) & 0x3F);
+
+	if (!l2cap_frame_get_u8((void *)frame, &nadm)) {
+		print_text(COLOR_ERROR, "  Packet NADM: invalid size");
+		return;
+	}
+
+	if (nadm == 0xFF)
+		print_field("  Packet NADM: Unknown NADM (0xff)");
+	else
+		print_field("  Packet NADM: %u", nadm);
+
+	if (!l2cap_frame_get_u8((void *)frame, &rssi)) {
+		print_text(COLOR_ERROR, "  Packet RSSI: invalid size");
+		return;
+	}
+
+	print_field("  Packet RSSI: %d", (int8_t)rssi);
+
+	if (!l2cap_frame_get_le16((void *)frame, &toa_tod)) {
+		print_text(COLOR_ERROR, "  ToA_ToD: invalid size");
+		return;
+	}
+
+	print_field("  ToA_ToD: 0x%08x", toa_tod | 0xFFFF0000);
+
+	if (!l2cap_frame_get_u8((void *)frame, &antenna)) {
+		print_text(COLOR_ERROR, "  Packet Antenna: invalid size");
+		return;
+	}
+
+	print_field("  Packet Antenna: %u", antenna);
+
+	/* Now parse Mode 2 data */
+	if (frame->size < 1)
+		return;
+
+	if (!l2cap_frame_get_u8((void *)frame, &ant_perm_idx)) {
+		print_text(COLOR_ERROR, "  Antenna Permutation Index: "
+							"invalid size");
+		return;
+	}
+
+	print_field("  Antenna Permutation Index: %u", ant_perm_idx);
+
+	/* Use the antenna paths count from ranging header */
+	for (i = 0; i < (num_antenna_paths + 1); i++) {
+		if (frame->size < 4) {
+			print_text(COLOR_ERROR,
+				"    Insufficient data for path %u",
+				i);
+			return;
+		}
+
+		if (!l2cap_frame_get_le24((void *)frame, &pct)) {
+			print_text(COLOR_ERROR, "    PCT: invalid size");
+			return;
+		}
+
+		/* Extract 12-bit I and Q samples from 24-bit PCT */
+		i_sample = pct & 0x0FFF;
+		q_sample = (pct >> 12) & 0x0FFF;
+
+		print_field("  Path %u", i);
+		print_field("    PCT: 0x%06x", pct);
+		print_field("      I: 0x%03x", i_sample);
+		print_field("      Q: 0x%03x", q_sample);
+
+		if (!l2cap_frame_get_u8((void *)frame, &tone_quality)) {
+			print_text(COLOR_ERROR, "    Tone quality indicator: "
+							"invalid size");
+			return;
+		}
+
+		print_field("    Tone quality indicator: 0x%02x",
+							tone_quality);
+		print_field("      %s (0x%02x)",
+				tone_quality_str(tone_quality),
+				tone_quality & 0x03);
+		print_field("      %s (0x%02x)",
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
+			print_text(COLOR_ERROR, "Step %u: Mode: invalid size",
+								step_idx);
+			return;
+		}
+
+		mode_type = mode_byte & 0x03;
+		aborted = (mode_byte & 0x80) != 0;
+
+		print_field("Step %u", step_idx);
+		print_field("  Mode Type: %u", mode_type);
+		print_field("  Aborted: %s", aborted ? "Yes" : "No");
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
+					"  Insufficient data for Mode 0");
+				return;
+			}
+			break;
+		case 1:
+			/* Mode 1: Always 6 bytes */
+			if (frame->size < 6) {
+				print_text(COLOR_ERROR,
+					"  Insufficient data for Mode 1");
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
+					"  Insufficient data for Mode 2 (need %u)",
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
+					"  Insufficient data for Mode 3 (need %u)",
+					step_data_len);
+				return;
+			}
+			break;
+		default:
+			print_text(COLOR_ERROR, "  Unknown mode type");
+			return;
+		}
+
+		if (step_data_len > frame->size) {
+			print_text(COLOR_ERROR, "  Invalid step data length");
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
@@ -4292,26 +4743,45 @@ static void ras_ranging_data_read(const struct l2cap_frame *frame)
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

