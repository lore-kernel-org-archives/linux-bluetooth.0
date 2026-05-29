Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264239A4BA
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077520; cv=none; b=LIhhkyZ2IJKEbek3WATdrxOayP3cdEwCnBCqgrAZi+UVndWIogu33ohKn3RCK4wN44MHC2h69GmyhUHJoIatmeZMkouJv4PG8rR2F6xQSOzJ0QDzuagh2IablkL72IwCI70Qov9Qqgu61dhD5G7BoPHOswrvVGCZ1CAS588TDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077520; c=relaxed/simple;
	bh=oqF+0wKnSACN4Mk0/HilssKdEOq7Nb46uq6l5mdKFFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z5Q9k8jMcaC4KfND8ITsEOIdiWy6ybbYQFtq9mdDujk6JkUFmRWu1QzORZC89x0dRJuB3+BenlRhHYDd9oQO3YLxCbwtziUFuoArM7JimHFM+Hj+4DGveQBkgwMExWdtb8h7zN6yS5xsFC9zDaN7euQxVCs7xQBXl6tg6lMLVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MPeDkk87; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A9/EVFiP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPeDkk87";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A9/EVFiP"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TH8ViR375603
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=l0KJ+Y6GrS7a/JzhAhCe6resqVsrmTE4dI9
	bPIpx9BI=; b=MPeDkk8725N/Now4+JgVaLAYnGPu1Y30LIyS/CIBDw6+C6fCbmH
	InXeLBJgyewc8qvnFZhoq7E3jpOf0UWC7j5mI3jz4EF73t0BNqLdZN+5C8bJYM1r
	gRN8k3DVLkkQF12E8eyJIDO5zCt8Ju27Ymw9mw8EwF95Yj3FYw/4UIQbCl4jMfyI
	dOc5gRKJRZZTmF1hKgIxpxL7m5N9V65v6kLDZSNHBzVTYS+SBqqBJH/vg4ph9mMx
	g3GE0JYsDtzymP3WejfUkM8iBNggP6geReYvZpGmsbUO3YXduFHmwDRTRWwmKbw/
	ze7vvXbugY/FyuXXgkdM6NAPMBu3/a+Ie7A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efechgkn9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 17:58:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8281d4cef8so6898828a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 10:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780077513; x=1780682313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0KJ+Y6GrS7a/JzhAhCe6resqVsrmTE4dI9bPIpx9BI=;
        b=A9/EVFiP7XmHImwhc2Hkg6nj3fIzppNDjipYNzf5Fda6K6yZ6hZ++29lHSainTUHxM
         qHcIYtDWvmDPxd1JBvXP1YeBAODvam1YnJrVqTRUdLcDd5c3uGCrSDVcowBKrZHwG9hP
         HF20vyMwzIUceGbY5+lPpkMed7/AD6jY+BFH0tOGiDIN+bZTwXEZk/hBuKDKF4V45Pyr
         3DdoGj3/MafQxoEuiEemrNbrS8OQhLUr2s1FPi1Vad3uti/Foc/P0aSX0IKVTxkdHeWE
         zpM34vNK0+pE6Q6fSMEll5org0/2xE99xPg60H6aWYZFsM1kuvKlwDXUg0xzgAN3avNG
         stGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077513; x=1780682313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0KJ+Y6GrS7a/JzhAhCe6resqVsrmTE4dI9bPIpx9BI=;
        b=pl3IHNNEc8QWwXNe8q+Gr1azElSK/4RwazKUd33lhapmNJY2krxcst6ZXGmoUf/9U4
         mnTwPFazfqG2w9puaqpHXlhBkN7L2QLPXp0u30E18EZcCIkDRdCilsJH0p1kNGO+/TXh
         oMq/JkEp7eD7vpxwqVAQIdW9Ww03X1+IWjCZdsQpoZqslJAbaJIm3nRnjIzHWgfAHq90
         8m79+ZL4TfnL9mdlCtwVzEi+1kpSbCRIGm6EAdWR2qUa9tX5od0FbM0rXubX4yY2rKFB
         ZdGysQ2dTuV+1O7ECD7bJIgrHOHIpYhBWjtfsaLqo6/YR+ZRmndGdTt+STGOYKl+y1nK
         8U8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+8iFcGcVfrEIjJf+t8sghbStx8pYOWUHU4+G9mMdDQP+fhpan1vC78Mo3SCCG64zJoyXK9hLLcvw2g72jMDhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxISnp/lG0vaquVcTcgLwHle0B2NRMmTQXMrwJH0Y/4GBccS9pI
	oWZODZik8aC9XFTdUjBDCRfZNPTe2NPmxUMnwuKU7g2TyIImWAIIwssw+T/zPkY51SEbR8oObMq
	SbdfztjlEzj5VMMgbrzITzInvKrqwRWTgkCUlRileCK1/1eFsOXQV5bYZtgKaIHwFFWA3msU=
X-Gm-Gg: Acq92OEMgR9G643pIttqDtcn1wd5d6powxwNjJnjo0qaUVVxoFBkTm88EXKNct1VxES
	dVIGSXy5AL0WMCVwZJtQxS0LZ66uWGb9tvGpjNSN2nRQw9MW3voJy0qSMyN0z3pPO8X4KVjO3iA
	qy/fufV7YR+MCRPVvMUbZCLgYNl3SEodJ0S/VK/XkfKaPJzmYGQOiw6VxzJcX8tXDII9IQfygqH
	ZD9mlZ7M0KtFKqNBELuBFf2AxbHpDLr/YUEDiWrAh1vif8sorcL1wM633aPyCOIBbXcwQbywYEt
	FvsWN/LhnCbh6mHjm/OBxD6Wl1yKQQX+d0nyPBBx7soDZRXY69i0dqyV4vwpH8rCwD9iBtrg2Ct
	fP05cmBJdTVmTc1xFVztQ/uxtU/VLZ3rSmeDFHF1NpePQHeIJj4LNIAKmRmu82g==
X-Received: by 2002:a05:6a20:e20f:b0:39f:2dd0:65d5 with SMTP id adf61e73a8af0-3b427fb8a39mr291567637.39.1780077513488;
        Fri, 29 May 2026 10:58:33 -0700 (PDT)
X-Received: by 2002:a05:6a20:e20f:b0:39f:2dd0:65d5 with SMTP id adf61e73a8af0-3b427fb8a39mr291538637.39.1780077513012;
        Fri, 29 May 2026 10:58:33 -0700 (PDT)
Received: from hu-ysiddu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772d7342sm2437320a12.26.2026.05.29.10.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:58:32 -0700 (PDT)
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        rahul.samana@oss.qualcomm.com, harshitha.reddy@oss.qualcomm.com,
        dishank.garg@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Subject: [PATCH 2/4] Bluetooth: qca: add QCC2072 support
Date: Fri, 29 May 2026 23:28:22 +0530
Message-Id: <20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kHsccTVjae1QkCOyHhEIXRwDa4EkeERY
X-Proofpoint-GUID: kHsccTVjae1QkCOyHhEIXRwDa4EkeERY
X-Authority-Analysis: v=2.4 cv=U6Siy+ru c=1 sm=1 tr=0 ts=6a19d3ca cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ffrZGZ3HEtUVdBMj5k4A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE3OCBTYWx0ZWRfX6sfcmVr8VHhD
 nFwZWAVGEdPbakW2WpCNqc8omRcngQVl97xSqtsLfr9a4GJcpR+tZxcOugEVEl+rM15PhbW6FN7
 r8Ibmxvzup9AwCuBNII02z89uZFetLVNHsLXqf7iNWZGbBcyFCXkTVM7LBmCVwggGPvt3EL/nz9
 0ZYf6c8RqNaUaONcYmZa6AAXVWdPVyypFvuZcEXpWZbzQ9Re1Su1/Cpk/gFeHNxxy9LONNBfOpX
 sX2EBZqbGzn7j4GlIIOZ8Q2TIrEmR4ezqL2DXz/gBQSQBtLOJwuGy8U9zTTb3RgMcDfPxgVWISD
 IYIctGgFKwme7OrAUqjUWWDjvALzC5sJoN4pTEdboCGflFGaTJFEmtQk/yaT5XNwc5eSDNbgPIv
 EdNRLpzp+fYlbPxCb3+/FMAtvNpG/MDpypVXwWVDeRAXd+6Amc6g0LrOrV7PreIBH2MGoRznJhS
 3jrNDbNKjTSa+sxLnFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290178

QCC2072 is a BT/WiFi combo SoC that uses different firmware
filenames and requires no external voltage regulators, so add
it as a new SoC type.

The chip supports the wideband speech and valid LE states
capabilities. Its firmware is named using the "orn" prefix and
follows the standard rom-version-based scheme:
    - qca/ornbtfw<ver>.tlv
    - qca/ornnv<ver>.bin

These firmware files are already present in the linux-firmware
repository.

Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c   |  9 +++++++++
 drivers/bluetooth/btqca.h   |  1 +
 drivers/bluetooth/hci_qca.c | 24 ++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f..0ef7546e7c7a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -843,6 +843,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/hmtbtfw%02x.tlv", rom_ver);
 			break;
+		case QCA_QCC2072:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/ornbtfw%02x.tlv", rom_ver);
+			break;
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/rampatch_%08x.bin", soc_ver);
@@ -937,6 +941,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
 				 "hmtnv", soc_type, ver, rom_ver, boardid);
 			break;
+		case QCA_QCC2072:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/ornnv%02x.bin", rom_ver);
+			break;
 		default:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/nvm_%08x.bin", soc_ver);
@@ -999,6 +1007,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		/* get fw build info */
 		err = qca_read_fw_build_info(hdev);
 		if (err < 0)
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 8f3c1b1c77b3..a175ac31e7b2 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -158,6 +158,7 @@ enum qca_btsoc_type {
 	QCA_WCN6750,
 	QCA_WCN6855,
 	QCA_WCN7850,
+	QCA_QCC2072,
 };
 
 #if IS_ENABLED(CONFIG_BT_QCA)
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ed280399bf47..fc67ba0e4984 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1372,6 +1372,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 
 	/* Give the controller time to process the request */
 	switch (qca_soc_type(hu)) {
+	case QCA_QCC2072:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -1459,6 +1460,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 static int qca_check_speeds(struct hci_uart *hu)
 {
 	switch (qca_soc_type(hu)) {
+	case QCA_QCC2072:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -1510,6 +1512,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN6750:
 		case QCA_WCN6855:
 		case QCA_WCN7850:
+		case QCA_QCC2072:
 			hci_uart_set_flow_control(hu, true);
 			break;
 
@@ -1545,6 +1548,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		case QCA_WCN6750:
 		case QCA_WCN6855:
 		case QCA_WCN7850:
+		case QCA_QCC2072:
 			hci_uart_set_flow_control(hu, false);
 			break;
 
@@ -1861,6 +1865,7 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		ret = qca_regulator_init(hu);
 		break;
 
@@ -1957,6 +1962,10 @@ static int qca_setup(struct hci_uart *hu)
 		soc_name = "wcn7850";
 		break;
 
+	case QCA_QCC2072:
+		soc_name = "qcc2072";
+		break;
+
 	default:
 		soc_name = "ROME/QCA6390";
 	}
@@ -1980,6 +1989,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		if (qcadev->bdaddr_property_broken)
 			hci_set_quirk(hdev, HCI_QUIRK_BDADDR_PROPERTY_BROKEN);
 
@@ -2013,6 +2023,7 @@ static int qca_setup(struct hci_uart *hu)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_QCC2072:
 		break;
 
 	default:
@@ -2166,6 +2177,12 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 	.num_vregs = 4,
 };
 
+static const struct qca_device_data qca_soc_data_qcc2072 __maybe_unused = {
+	.soc_type = QCA_QCC2072,
+	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+};
+
 static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
 	.soc_type = QCA_WCN6750,
 	.vregs = (struct qca_vreg []) {
@@ -2268,6 +2285,7 @@ static void qca_power_off(struct hci_uart *hu)
 
 	case QCA_WCN6750:
 	case QCA_WCN6855:
+	case QCA_QCC2072:
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(100);
 		qca_regulator_disable(qcadev);
@@ -2414,6 +2432,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		qcadev->btsoc_type = QCA_ROME;
 
 	switch (qcadev->btsoc_type) {
+	case QCA_QCC2072:
 	case QCA_QCA6390:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2434,6 +2453,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_QCC2072:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -2484,6 +2504,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (!qcadev->bt_en &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
+		     data->soc_type == QCA_QCC2072 ||
 		     data->soc_type == QCA_WCN7850))
 			power_ctrl_enabled = false;
 
@@ -2492,6 +2513,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
+		     data->soc_type == QCA_QCC2072 ||
 		     data->soc_type == QCA_WCN7850)) {
 			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
 			return PTR_ERR(qcadev->sw_ctrl);
@@ -2570,6 +2592,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	struct qca_power *power = qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
+	case QCA_QCC2072:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2779,6 +2802,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
 	{ .compatible = "qcom,wcn6855-bt", .data = &qca_soc_data_wcn6855},
 	{ .compatible = "qcom,wcn7850-bt", .data = &qca_soc_data_wcn7850},
+	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
-- 
2.34.1

