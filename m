Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24630EF6A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771415418; cv=none; b=lPgDzvr9sH3AbXcCN17vGeAIySu2yceqDSmJ09+TsVoPOy6V8QFiKEabUPhxVswxGYQf2KqGTbbTQ0oPmXxFw0edhY/4LZ4OtySoAbAwzE/xsRPYx/+jvtuD4WXq9+ZTOPDPxROcNuExOja2KWN6YmxYO9OYjQUWQSEs1KG8zkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771415418; c=relaxed/simple;
	bh=4ORTcY4FBogvyIPAgOzFGg6Gij8ZFXVUN7JVbbdURy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OH5BmElvJgNw8ZfBmO2og5j616FRKQtyeBZLAUT4avXF5KqoqrJHlmY7QFtPIB9UcGTUxvqMV/gLchCwwmADB2i2Go/1dEKob9GntBNxPVDQd3Yxi6MWF4OBowp6JtpnBljlVei+/SvonxhsHbksLXBaiiJurvZqFQbm+dpZSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6rSto+J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I9YSkRkF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6rSto+J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I9YSkRkF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HN6OE0413996
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fwrGMwdsAhD
	mMDYm8X+2Xe9hSXXfRJYHc4APBbsaMnk=; b=C6rSto+JS2oRQeTIP4T6irT464C
	Jrp9rAyr4FZgL/WJCu0zlTSUpEaTy8SKbPtG9v507GatduzaPal7eruZpubgnnVs
	rw9pyLALk/PRDi9lFAPNho6U5jqPCLSEVqvLzN0vDzto1tDDf/hC3I5Dn4BOfClB
	am4MFwnMNO+ncD9tuo8L5K761/EvPzPwBnW5667WBOH3RpGRVZ52o6SxujYBDgdx
	8a3juIUx/fc9Dk7X9RmO4eDBKqOhR8DWhmXdD4p1YcQOYCdeLJ0mQ6UzAde4JNTW
	bBDifOrh6xaKww+keTGUiia6XBE+ihPzbnFB31N0cGCzt+vgVxzt0AFQOeg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd1q6skwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:50:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6de06e6c08so3823490a12.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 03:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771415415; x=1772020215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwrGMwdsAhDmMDYm8X+2Xe9hSXXfRJYHc4APBbsaMnk=;
        b=I9YSkRkF8CVtl12kJ2E4oFXsswCP5VXtHWJqQuc/ZXg5LN3O4FivSaPnSNnAVoJ1CI
         rKOMGrNbbmfoymnFwUG5Qot0txMCQV/e5sEOyubW3mK79QGoK6CRvE+UzAQLWttUnYqn
         QsLDsx+P+3wXTs68LmYPiySVzqv58MJOyd2qbSNl/IrdNPt6wHpfcqVDIjTr0BtVgSjE
         SzQaTFvi89zNjKEXJgB1o6iGtGeyJfKvff/if8IWHbLE8yt7jA8ckhg7KtvKokm6w7U6
         x1RgYCqacF6af6lD52rVH6NIgpTVODkXigscQ2g5ux9wN7+aInJA8md/7phHteG1b5mq
         BhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771415415; x=1772020215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fwrGMwdsAhDmMDYm8X+2Xe9hSXXfRJYHc4APBbsaMnk=;
        b=PiDRxcbseuxzccmR6JgZ5ZI7tl/WDTstGMYq3UVrTX7IbajaLbphCEfTd/DBaYVsPp
         6dthdSfd/FiOwfqK/4pRIyxdmiNYvGj9DHGEyNH7BSsBK4pdJqixEHSfYbKov9YDbfEF
         7IzbPsNjiCygVYEQceeaJCNn86w2qlbn5CZItdkukXHJcRy0mIttNcsMKdJ1ZzJ64dRX
         UpBVgaMVAoH3oVYJrZ1mfTwk2wuuatPEnRm/eGfMuoI5gXW0nNId1DEFRZ1tm8grX2Ku
         3aSDlZ4POdlzseM5D9HfnTi/9uNhc2Srq87WdSCxgrJbW22cEnIb38Whu54jIxSFEQPI
         /y8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyU6jIQseWyCVnXynp+hCQV7nBVyGftEgXnOJQC0MUwH3NuzMB2g+UqDkUnzWynP6rpyd+hy48rpJQYDllTvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqaoGake9B+TUQUjq/s1zM9vVyB3le6NynzFRxq9XW+Y7L4Mx
	R8uCd2dxqAJvTYKMC5NRy3okhXP0d8XmNTchzjMxHgIn17HwTOYmlTORbacAa9YXzbi8XuZ0KMQ
	XMSBgOoAWJDt6VCFUlpd4mVgyJEl0EQWNlsSXN8L7O0b58hGTXdq3dMabs4jL3Q2tGTJa9SE=
X-Gm-Gg: AZuq6aKe4eWQofGm785Za/Rn2rjN9ZBDQllcIQz1A3qnvXUMLFe+O08kXuR2Y87lm06
	k/opptHlSN4vGVFxNeI8qiJbDiStYXAmzKwuvq2hyfLl+11VuPGHnZlBQzK4b+0yFTPG5PGFTT9
	WBydlB8z4/RXirTEKubRqeHOKyrTOJWy1RA2Gj9XOWPtaoL9hiQMWcSKp5ozOEZEFldaBa9KnKh
	1wxmRn8kD9VndlsDB0Eiz9JbjKwSrgl44UDg90as+UgczbU+qGBBdOKqp8xIG6nD1gj/SWuhnHi
	Y9tF3RqALm1AfhbeeGQLNLYrgukEtAL99nzSFrE0UglpwwZR5n18ULT3/5HWRNNgbHjrXWnpAnF
	Sd8wL6eWlrWLGCoA28TBqBx3mB0OV1RxV5YQZDNfIceO/gLoTQxg=
X-Received: by 2002:a05:6300:614e:b0:394:58eb:48f6 with SMTP id adf61e73a8af0-394fc1f3e7emr1671236637.33.1771415414918;
        Wed, 18 Feb 2026 03:50:14 -0800 (PST)
X-Received: by 2002:a05:6300:614e:b0:394:58eb:48f6 with SMTP id adf61e73a8af0-394fc1f3e7emr1671220637.33.1771415414467;
        Wed, 18 Feb 2026 03:50:14 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e52fd08fdsm12459222a12.6.2026.02.18.03.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 03:50:14 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Subject: [PATCH v5 2/2] Bluetooth: qca: add QCC2072 support
Date: Wed, 18 Feb 2026 17:19:55 +0530
Message-Id: <20260218114955.3970974-3-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com>
References: <20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K60v3iWI c=1 sm=1 tr=0 ts=6995a777 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Wa8knhHJ3zZ-c0kIvlAA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: tsYw962gzFkTudxvAFzknLanADOvJh10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEwMyBTYWx0ZWRfXxP24DCyqtEi2
 +IexPh5Bk867VRPnutkEAZr/g/H/UQZ/HB+izoxpKpxpAXhLoje7nBb7wCE+DWl7IApY8gGp9OU
 OydTkN0nbkn0hmS99VjHRFctULNMgbBIXOK+0UOBXoLcwVPuwqi1CSZzHMSGfUvsx6j128baLJq
 EIoC8UFeTBLZ7cqv1yL9qeKQ+bZXQs6m43FgjuwqJAkXN/OHXQUbX+2R/1NMKdNoECfWJ9AqzP5
 MyBK4bp4XixoPOAu5pS3jWZpZ+EZJcYEf5E7u/YR6bup+HGPJ2wzMMkGfoOsyzwNkz/njiCC/xx
 AFQFD0rUmtyrHTNX8f9SCBH6llP42XPxr3uxbdj+fP9gajZVQkFdufjqUOMTbHyS7TRsFaJ3Sue
 +bdSUqkvh4/mYIBYRQxg0MWyJ9YhFNOkyYj1HW1sJBlAFyv4Z/9FMwZQzr4sHUZGpt09JHV09GW
 bUUcnQ3jyGccpSPUUUw==
X-Proofpoint-ORIG-GUID: tsYw962gzFkTudxvAFzknLanADOvJh10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180103

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
index 8f3c1b1c77b3..77c393c1be0d 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -155,6 +155,7 @@ enum qca_btsoc_type {
 	QCA_WCN3991,
 	QCA_QCA2066,
 	QCA_QCA6390,
+	QCA_QCC2072,
 	QCA_WCN6750,
 	QCA_WCN6855,
 	QCA_WCN7850,
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

