Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED51328253
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724903; cv=none; b=ePbTAajKa35q86VPkLtZ3lvhm15nx4D0f+vHPAka7MG4cAJ37hLhdejtpbnME6y2/IlMsDVwxIka4rFLf0NMoIcN295/TAsm1txV6MiZwbCyTlVfRqsv88JKU45oqdYVlsM/mlsHZvjAjEy4wjPMCE0w+5N6poggC5vkFJownbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724903; c=relaxed/simple;
	bh=IqjpYTWxrm4uyR3YSpzOagusXq5h1tnHrXNAMRPwlJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPUPuO7CIECYytsD2+sZYV9cAg0ful5ggkyUOPU6CjwSQW6zm392uSZXuHOkJl5hjkimqEjgWlnnA2QTgTAN09IShoX8NnRi50Lht13CQtgY7FZDjLnAs1Y4QrTXwzfiRpaoTPTx2ssw7KMeVh394m1XhCh8CPtfaK0YIA7YHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DEtY8KqZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UxHCSo8u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DEtY8KqZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UxHCSo8u"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A6xlH2857877
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=l0lWt3RD/v0gUJzCHHWP/b5c44WkG12+TyK
	4wxyVsFM=; b=DEtY8KqZdFtfdvZ81g5M0IKjzh3lz1q9wK/nnp/TvK4mAMVFFIP
	3wKfy1ecAi9Py4df8iAK5y6h3LR4uTu59on86IwC06bnl2WTuXfJFHI511T238ph
	kIbuR8ccsmmh7546aq1EXKaGWglxuBjBhBGfWDxjQKkvnYldv6z02FVHMfHxwF52
	6guA706X9MpqloamT8/TS6SCzJZk3lOWbit/caX34HQ8O1IsHK7Ob7P94POL2fP7
	MvIF27++WH0dBIu4oWymfPhvYy5jrOeaRonxnYxoD/bz3HqdfUJ030RWPtCzXG9r
	6XEAD5q2Dl6d1w6PPiziOGiV4Agk2ONwbvQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga643ad-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 12:01:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-354c65f69edso971864a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 04:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770724900; x=1771329700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0lWt3RD/v0gUJzCHHWP/b5c44WkG12+TyK4wxyVsFM=;
        b=UxHCSo8ucKywi6Uf/iKCnExjUZYhSST+Bi890WolSW1N9ffkr5QHCCcjSYOZtKYNig
         BeE8mvXwhycDA8VhsDwz3n/90BRMbWGocrJRAJUrpTk2iv/xcjsJ9YSKObnsOGVB+Jko
         sKVfptNZk4nh3faa7TUo2xtHecu5kfGm8XTh0442nC7mXovbJVbmzBp7Sx6dgs74tRxQ
         cdxAn92Dvcm3vLDMlkr3HOiNjO6HYsR1zQzPB0zFyneNTw20YUQreaWVECE1QpxUBh6H
         yK/31qzuVSF5ygTzyu/UhDQNLEvySb/Omt4XzGZ3lyuw6amC+DZtJhfs82Sy1KQmUtYB
         NEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724900; x=1771329700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0lWt3RD/v0gUJzCHHWP/b5c44WkG12+TyK4wxyVsFM=;
        b=pDeyhtxlI2DiVHmE1gt558Jyz29q0p99oHrZDxD4ut5q65aQMWibYS63KPpVaCIRjj
         eW6eZYrC8f2jHJvc2jJIxTrCJ5WyU4/vHS7h3P+Wv6D8xY5OTDQGF+KguPrnRmunSUfs
         t4w6U/SOQq/MxPqsqW6cTQBHtA/mEvtuLki0yrSi7Kmkr5XAhYlHqKrhOU7I3BDMFD6z
         cLxlAm1uEiXeoSI68PsGHfqL0Hpb9WpQCKny9cPxrVZMvTUjeA4NfKdX/E8R44kCBF/e
         4ZDf+tHZGovfeyvk/yoNMKa5OPualbEE/8ygKx3SykxjYgujcddZFU+3poofk6QD/yAZ
         nCIw==
X-Forwarded-Encrypted: i=1; AJvYcCX5h9wHLon6XMGZCpzsp12Wwm17Df1GjVSon96B8lXckvAXRBjFRYFIxA+4vWDpe9uV2oMniip2ZYTNEcUPui0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZP4g4bAH+H8TToBI1Z3jq7KOnnlIc2jtkyjUqWNrBSdsnOfLd
	4UTCAJyq+Eu+OLH+6N8KKtgA8zH28YXa6g7plAnSLjfagwR9eOs4y3Vlo90F9ZUQQbHcCd4GDSz
	S8Qbp4XCNQIEPnbezXyB+eRFv2h7iJj+zv+PRRS6vUjpj4dJT/4WWUzHHpaKdQ4QyGQ4QJYJJCF
	DajVI=
X-Gm-Gg: AZuq6aLpFbc7JCgFrilecqvPC7zSo0FSRAil/ZTNdkUSAr8kD3Tv3NfiygztnWegwG4
	JnBRNvyNjs43n48LFKm6+RZrEe/d4sEyTr2Fbdf6csY8lnZ//4j6ccqH23Z5qEJqXc/JJgKUlRD
	kXAVPb23sroeKYAa5MhhdGjB4Y25IfE0zfcGLU885vhiLLOcjWudS2OHTWND5DNBboMKlOz4DBE
	Z6vLHT+/iZXxDdsnkj+ckk6isR1OQaVcC64mD/3A9CJ1HrZMdyGStr6SeqezJhZlZe9FswQCcQC
	+t+fzyn8JdlX7a5BLSgUNyEUELNHlC8y/ClDaDm/zpuxwT6M8SHeGho+DaQ1AxC6hzSLJKxMybW
	zk5dIxWJRXZqEbVhfE7oHQPpeqgoGI0TWnuSs45funxqSe83naF4=
X-Received: by 2002:a17:90b:28cc:b0:356:282e:7eb5 with SMTP id 98e67ed59e1d1-356282e7f91mr6966825a91.24.1770724899893;
        Tue, 10 Feb 2026 04:01:39 -0800 (PST)
X-Received: by 2002:a17:90b:28cc:b0:356:282e:7eb5 with SMTP id 98e67ed59e1d1-356282e7f91mr6966789a91.24.1770724899316;
        Tue, 10 Feb 2026 04:01:39 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e8c819sm2796236a91.12.2026.02.10.04.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:01:38 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Subject: [PATCH v1] Bluetooth: qca: Refactor code on the basis of chipset names
Date: Tue, 10 Feb 2026 17:31:01 +0530
Message-Id: <20260210120101.1046091-1-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1JQGXcRqTQ5QGO6g2l63nnyeFnDLmgUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwMSBTYWx0ZWRfX8jsVzaWDY0YS
 IYBPxw3AOalLAbXjnqPQYd341LAEWNaOhkz0Q/wHSSXhmzIzox1DCsLMebtLG+oUjVKfGtNTM4F
 r4Q6muwkHlkNNipppJW4i+lkE56PAEe8Ak5d+MHT7uguMzfW9ignbnOhuPLSiSG7K6V9sk9l0ul
 egfNJmAxYwD7R4h/I9G4nBcFNCPEaQQns4PKJLl0jHYQ5DNFJw1JnedAcAwOCub/TBTBtN/e0ST
 AZCnCyTRFWrFGYiqleg4MbvjTcFSNGlUYj7G5hOKmpto4m+oPErM0RO6bGgiM7jvpgZdHb/LwVW
 Y0bEFJcjnxlSzCjzPN0gSL8c362jMKFc1l4zCMO4LKwezFB5lfgK9558tChy1tngke3u4n7CyZZ
 pzX7zmcvqF3LZsNxBZca5hRcOUEv/8fJw5Ez1lwmj+G0c8YvXz6DGPpOCkf1pcMUnAcZhtdlP6x
 MWM07XAaKLotnAvlgWA==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=698b1e24 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=_Hwy5uYH7oNXmxhsLToA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 1JQGXcRqTQ5QGO6g2l63nnyeFnDLmgUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100101

Whenever new chipset support is added to the driver code,
we ended up adding chipset name to the last of the switch case
arising code readability issue because of improper sorting of
the chipset names in various places of the code.

Refactor code such a way that new chipset can be added easily
in the code without compromising code readability.

Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c   | 37 +++++++++++++++++++------------------
 drivers/bluetooth/hci_qca.c | 30 +++++++++++++++---------------
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 74f820e89655..9f7e13fcb20e 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -799,6 +799,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		snprintf(config.fwname, sizeof(config.fwname), "qca/%s", rampatch_name);
 	} else {
 		switch (soc_type) {
+		case QCA_QCA2066:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/hpbtfw%02x.tlv", rom_ver);
+			break;
+		case QCA_QCA6390:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/htbtfw%02x.tlv", rom_ver);
+			break;
 		case QCA_WCN3950:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/cmbtfw%02x.tlv", rom_ver);
@@ -813,14 +821,6 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/apbtfw%02x.tlv", rom_ver);
 			break;
-		case QCA_QCA2066:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/hpbtfw%02x.tlv", rom_ver);
-			break;
-		case QCA_QCA6390:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/htbtfw%02x.tlv", rom_ver);
-			break;
 		case QCA_WCN6750:
 			/* Choose mbn file by default.If mbn file is not found
 			 * then choose tlv file
@@ -890,6 +890,16 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		}
 	} else {
 		switch (soc_type) {
+		case QCA_QCA2066:
+			qca_get_nvm_name_by_board(config.fwname,
+						  sizeof(config.fwname),
+						  "hpnv", soc_type, ver,
+						  rom_ver, boardid);
+			break;
+		case QCA_QCA6390:
+			snprintf(config.fwname, sizeof(config.fwname),
+				 "qca/htnv%02x.bin", rom_ver);
+			break;
 		case QCA_WCN3950:
 			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
 				variant = "t";
@@ -912,15 +922,6 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/apnv%02x.bin", rom_ver);
 			break;
-		case QCA_QCA2066:
-			qca_get_nvm_name_by_board(config.fwname,
-				sizeof(config.fwname), "hpnv", soc_type, ver,
-				rom_ver, boardid);
-			break;
-		case QCA_QCA6390:
-			snprintf(config.fwname, sizeof(config.fwname),
-				 "qca/htnv%02x.bin", rom_ver);
-			break;
 		case QCA_WCN6750:
 			snprintf(config.fwname, sizeof(config.fwname),
 				 "qca/msnv%02x.bin", rom_ver);
@@ -954,9 +955,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	}
 
 	switch (soc_type) {
-	case QCA_WCN3991:
 	case QCA_QCA2066:
 	case QCA_QCA6390:
+	case QCA_WCN3991:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c511546f793e..d8e5957a2edf 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1850,6 +1850,7 @@ static int qca_power_on(struct hci_dev *hdev)
 		return 0;
 
 	switch (soc_type) {
+	case QCA_QCA6390:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -1858,7 +1859,6 @@ static int qca_power_on(struct hci_dev *hdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-	case QCA_QCA6390:
 		ret = qca_regulator_init(hu);
 		break;
 
@@ -2092,6 +2092,18 @@ static const struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
+static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
+	.soc_type = QCA_QCA2066,
+	.num_vregs = 0,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES |
+			QCA_CAP_HFP_HW_OFFLOAD,
+};
+
+static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
+	.soc_type = QCA_QCA6390,
+	.num_vregs = 0,
+};
+
 static const struct qca_device_data qca_soc_data_wcn3950 __maybe_unused = {
 	.soc_type = QCA_WCN3950,
 	.vregs = (struct qca_vreg []) {
@@ -2148,18 +2160,6 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
 	.num_vregs = 4,
 };
 
-static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
-	.soc_type = QCA_QCA2066,
-	.num_vregs = 0,
-	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES |
-			QCA_CAP_HFP_HW_OFFLOAD,
-};
-
-static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
-	.soc_type = QCA_QCA6390,
-	.num_vregs = 0,
-};
-
 static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
 	.soc_type = QCA_WCN6750,
 	.vregs = (struct qca_vreg []) {
@@ -2398,6 +2398,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		qcadev->btsoc_type = QCA_ROME;
 
 	switch (qcadev->btsoc_type) {
+	case QCA_QCA6390:
 	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
@@ -2406,7 +2407,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-	case QCA_QCA6390:
 		qcadev->bt_power = devm_kzalloc(&serdev->dev,
 						sizeof(struct qca_power),
 						GFP_KERNEL);
@@ -2418,9 +2418,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-	case QCA_WCN6750:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
-- 
2.34.1

