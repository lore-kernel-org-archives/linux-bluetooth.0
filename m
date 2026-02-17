Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F32C0298
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307274; cv=none; b=h+A8A0ykMEHeEr/1bw6NeyBG8kFwUg5/T+o/XCPWoOVBuzYcjgOYp4/9RsqzuViQtvOX9d078qA34yTBa9Vuxb0UpaMooYwXNRF5AptPwUSZ83uFO4wqRDZAFZgpnmuQF8+1zdnY/YiKnOPcL+Z8j2H2cJqkVTmnuTWIC455hag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307274; c=relaxed/simple;
	bh=1Nkj3c4nAn0oMGQRVNpOh3P9yb4HcNcK6dWvfXG3dsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJna5bMhEdDrGqj3Bea/LKvYXLKFHuzh/xHZK+R+YKnLUM3XahDOXs6k6HIXyGaqU9zC9QKLLYBleXKTeusc8NqLv8j7qRiyyjjRUuMtnyTkFYbA8G1r5CG6BEF8QrV2AYFOhS4B4alKhBuFZTaLpiXNDJYuNiOtvfoTMf4Bf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y7zpzqkV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aHLUOixa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y7zpzqkV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aHLUOixa"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GGJsUG287925
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lkJF7NQO9W+
	KGAGqycP5XAQqhoM3K1UnGhPp4iZPKL4=; b=Y7zpzqkV/eifOrUZbC3DKV7hWXb
	k1rreuuQeYGn3OckcMn6dnLP181iDvXUFB1lS0HwjUV03m1vXQ0+JtiIAY+xdJSn
	bEKfPE1MgFgd0jshhPIZu3H8dnHYoKQ2vm64jXLMnhopvxR2e+BknPu7ta+s5oUG
	1ISARHTjq3+FNcsiA9T56IY4KNmH+Nl3Cya4Ze/1VnuB9O5SfamWhr5j+QnC4bET
	IAsXPP6BrRSeO/EODpmlLFgqhee2QXDP0ZphXKOFY/d21hlyB157FX8g5ELWvwOK
	aI6tbEm1a1afZH/NTX0lkwdMTRA4J3hQEMTo4pQ/geCkFdsN1Y2vwChhccg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6nrs8ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 05:47:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35301003062so20919589a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 21:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771307271; x=1771912071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkJF7NQO9W+KGAGqycP5XAQqhoM3K1UnGhPp4iZPKL4=;
        b=aHLUOixasOW956Eeidnttn5JdyHNvKznm88FPCn4z+I4IAJRijplfRVsPKECAlhg7O
         MydKJADMTvyVxaf6qGIbYAGz+oklx7DkxvmXcnEjkRqCz4uHlLA6QDUmjXRoEyyB1gnR
         jult3J474w2/gllwdYyEUxHHhV3+KFoJiBKaKD1CLj74ENjC+A3M8S+xrGXz/tiVWQhM
         zvI2myQYT1zojsJyY10kOIIxR+2opQZ5TSphkof3WCEbibQ+BdMJkXDQ10yLjh92uT1d
         O3ObLFZ03tvAoYQB1Rpn0lUhknnH8IKSQbyHfcxkRbuGe7o/htQYX4nSy0AYa2QzqK3A
         KgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771307271; x=1771912071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lkJF7NQO9W+KGAGqycP5XAQqhoM3K1UnGhPp4iZPKL4=;
        b=t2UAkb/ofUGESbnxhTugZKG5Peao/+Ror7jXnkjVI+rbsnLwCjhH/TlYtXAV93huQm
         CMuyPNzhnLKWNtRtVm+sIn6KYZrAOiTRgP2/H28OgmC5QnnUyz8Q9Zf4WdSQWVdHsvQR
         hTDi5tF81y9YekLKHXQ/jWLkDGq+dCEsYEwiqL8PriVch/Ya5fFxMipe9q7DSy1QgbHs
         yM8vts1GLiP45G7HYfBcK0HIB1vCjWD+cWUu9X14bNErTnyQUckI7UW3LXmhuJKR2nqA
         zr9D9RppFmiP/OvCSiC/KKNMHbX6ovdokfH2/6BsOJjOyUvhU7qlMCjTnevGKeEGLDzk
         quQA==
X-Forwarded-Encrypted: i=1; AJvYcCUpkecEh/eba76cOrxNFThfExxwjjEky96Gul+FC5U75wm3vw89KCxiSBR5r71n7tkq85g4TpZMCwNzfD/ZXpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDmmBZ4/AyKPPXjpUSDMtzyr5Zr8qEqGDBPL/8qwjSpJxgkPK
	slgKAvnPAffAfDo/9FnqDflkvgJ0XIDBHfObPnKEjROvgIEathC0d/IPqkYTbyEds6+UKMDKWjR
	30Ozqj+CTruNX9wM8BupJzAZ6+rM+z+NTyJ2KbusiH2WwxkFuORtSSTMCrrzQsQlo5ud+cPA=
X-Gm-Gg: AZuq6aK/WcpTQNagrlvbuBif+Dh1fpNvmgEfqeD4PdtICkm4f2G007lo4N0tbMrNhHU
	hSYLPvGBMtFf/W7tAZy+tB6w0edJEvb+gByro0muyxQa3rtNo7pc2igl+dKjXUAaYbbBwlZFjSi
	y3IE940LPY8w7YSFsfnNKnlsyrbaQofBh4dbsRDq8l7y7UIss393d99RuKFxbyBWhVmeUVBfnef
	R+ETpx2DI01qSIPzyf+UT8cwCB0C9VbE1E6pSTVRH/BxoOBNQnYbOMTHaAz1hMxn/F3+Fss/XxI
	Ip29fTazyZZ1EbQQVcY2F3cVdBetTq+5VShE4p5TbC1+uGMb3nwTs1Sqa5KAtn69IqY8x0dNh7u
	RoyvTxxHmwhyyCLBVq970iQJOBrjhwqQGdSVf7nkneI0AxCeyJ9I=
X-Received: by 2002:a17:90b:2e87:b0:354:bf10:e6a5 with SMTP id 98e67ed59e1d1-35844934717mr7841142a91.10.1771307271141;
        Mon, 16 Feb 2026 21:47:51 -0800 (PST)
X-Received: by 2002:a17:90b:2e87:b0:354:bf10:e6a5 with SMTP id 98e67ed59e1d1-35844934717mr7841134a91.10.1771307270682;
        Mon, 16 Feb 2026 21:47:50 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662fac3c1sm21429775a91.17.2026.02.16.21.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:47:50 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: qca: add QCC2072 support
Date: Tue, 17 Feb 2026 11:17:31 +0530
Message-Id: <20260217054731.3058567-3-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XKo9iAhE c=1 sm=1 tr=0 ts=69940108 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Wa8knhHJ3zZ-c0kIvlAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NiBTYWx0ZWRfXyJ+eHRlWPaGD
 hQ8QUC+/S2YcnMs67FkIHmm47ZqmBiCUsfPzbyuqmK+wmrZnJfjkIQr+JHFudFBExMsYRO9Id62
 sNOufR59jL2mtw/2HBDjez0LmYhTHId7bZD+cu5SqSp5/78XxLngJRyzkBxUCIdpeaTf0WRpQhl
 m5e9LmyH9XEI5T3kWXAfuzw0IGSRFCP8LTOxNhUYEAlF9rmt2BU2lwq0t4UapgTYB8vOSho7gfe
 we9+N1j7PCZwUkj/GW+ePPfoGTrmhtHnD6Bn3WOE/m9XB3fOwzZEFE9DaTg1JkCTWeEBgv6PCrs
 DHMySiXup5VGdM/x6z5rjp6VPfU5FllGxXJkVV1LmtodTBZADpY7e9LV4LX+rJgAXNkuuWr4BqS
 6kTiqCxcwtEVUwzDL33stPBgeYy3rG8RKW4Df/QmVcEWrp0loCu6PKZw9o7Y63UtbmWTZ6e8B60
 juqP4wWhm1gGVI8Pkfw==
X-Proofpoint-ORIG-GUID: AWod0Rz3W81Zl5u-hUdQ3VDJO0083QxW
X-Proofpoint-GUID: AWod0Rz3W81Zl5u-hUdQ3VDJO0083QxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170046

QCC2072 is a family of WiFi/BT connectivity chip.
It requires different firmware files and has different
configurations , so add it as a separate SoC type.

The firmware for these chips has been recently added to the
linux-firmware repository and will be a part of the upcoming
release.

Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c   |  8 ++++++++
 drivers/bluetooth/btqca.h   |  1 +
 drivers/bluetooth/hci_qca.c | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 9f7e13fcb20e..65c8d2978956 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -807,6 +807,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/htbtfw%02x.tlv", rom_ver);
 			break;
+		case QCA_QCC2072:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/ornbtfw%02x.tlv", rom_ver);
+			break;
 		case QCA_WCN3950:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/cmbtfw%02x.tlv", rom_ver);
@@ -900,6 +904,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/htnv%02x.bin", rom_ver);
 			break;
+		case QCA_QCC2072:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/ornnv%02x.bin", rom_ver);
+			break;
 		case QCA_WCN3950:
 			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
 				variant = "t";
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
index 8e035b7c6f3e..7786ced0bbbb 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -625,6 +625,7 @@ static int qca_open(struct hci_uart *hu)
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 
 		switch (qcadev->btsoc_type) {
+		case QCA_QCC2072:
 		case QCA_WCN3950:
 		case QCA_WCN3988:
 		case QCA_WCN3990:
@@ -1500,6 +1501,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		 * changing the baudrate of chip and host.
 		 */
 		switch (soc_type) {
+		case QCA_QCC2072:
 		case QCA_WCN3950:
 		case QCA_WCN3988:
 		case QCA_WCN3990:
@@ -1516,6 +1518,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		}
 
 		switch (soc_type) {
+		case QCA_QCC2072:
 		case QCA_WCN3990:
 			reinit_completion(&qca->drop_ev_comp);
 			set_bit(QCA_DROP_VENDOR_EVENT, &qca->flags);
@@ -1535,6 +1538,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 error:
 		switch (soc_type) {
+		case QCA_QCC2072:
 		case QCA_WCN3950:
 		case QCA_WCN3988:
 		case QCA_WCN3990:
@@ -1551,6 +1555,7 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		}
 
 		switch (soc_type) {
+		case QCA_QCC2072:
 		case QCA_WCN3990:
 			/* Wait for the controller to send the vendor event
 			 * for the baudrate change command.
@@ -1935,6 +1940,10 @@ static int qca_setup(struct hci_uart *hu)
 		soc_name = "qca2066";
 		break;
 
+	case QCA_QCC2072:
+		soc_name = "qcc2072";
+		break;
+
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -1970,6 +1979,7 @@ static int qca_setup(struct hci_uart *hu)
 	clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
 
 	switch (soc_type) {
+	case QCA_QCC2072:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -2003,6 +2013,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	switch (soc_type) {
+	case QCA_QCC2072:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -2108,6 +2119,12 @@ static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.num_vregs = 0,
 };
 
+static const struct qca_device_data qca_soc_data_qcc2072 __maybe_unused = {
+	.soc_type = QCA_QCC2072,
+	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
+};
+
 static const struct qca_device_data qca_soc_data_wcn3950 __maybe_unused = {
 	.soc_type = QCA_WCN3950,
 	.vregs = (struct qca_vreg []) {
@@ -2758,6 +2775,7 @@ static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
 	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
 	{ .compatible = "qcom,qca9377-bt" },
+	{ .compatible = "qcom,qcc2072-bt", .data = &qca_soc_data_qcc2072},
 	{ .compatible = "qcom,wcn3950-bt", .data = &qca_soc_data_wcn3950},
 	{ .compatible = "qcom,wcn3988-bt", .data = &qca_soc_data_wcn3988},
 	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
-- 
2.34.1

