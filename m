Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2C37E5F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218727; cv=none; b=fyuoAbE8iz6vOgW5AHMZKoiyfqoL+gFdfoIA4b/6LzDAM1Ud1dtwTyWrixcfoe/U0Zgp62mEy3MHrGhA5m8t4LJnOMCnfu7fHskULXbCG8kKI+ydh3orOdsfBEn0w4k/TPoupfH9xwUiHKPstQuLRCCtr3cl1aNrZhrZV948Xng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218727; c=relaxed/simple;
	bh=xM69rdwj/4s4KU6DoN0jDrVsnH2NCoFH3DVoSAMRnTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhH0XD+1HcgmnVjgU76UU1qyiW15gsBUdk3JC7xDOTD2W7E7fRAQ6a6bOR/xUXQFj1gJiHHp5M67x/0ZXkVHaxEXP4xf8xc7Qxov33QTVUzW6lU5dARXy3I0kc7q/hfSzLV6GsFiXBqSkM7SA+95FLuzC11ltxdAf7dqwPAVuUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UxjjV5cA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E0+fa3h8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxjjV5cA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E0+fa3h8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJkGx3988184
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iA2Yiw9uzbXh2h9O8pkl6U4Hyg4t6O2C/nSL7Zx+AZM=; b=UxjjV5cAYc4dm11p
	NTuTvZnrsFOqxPZILMOsJaFgQDrpoZYqim40h89ov7KLgMxLtsmx84PtEqDHsS4p
	yPkK2R00/3fnKa8bpxFqjLnYKESFx4ZsWq4LNefkhOYMm+IzYtUjTtn/N4qCA36I
	4zaBEq6R5wCGQ9llAKuZwcRRsNBvvI4Wa2iTAL47aEihx2W6oV2PuGVOOeN7Nb04
	kOsGcgArOHBz8nQXJ70cTp119vMJ08++1Fy8rv6gwnjDQXpMnW+/eXwG8pZotkOM
	Wo/HCysdfzirKxO6uvYQ+tcXFhw6AE/9jKb4hoENi7bmWn0erKneee1sIXz7JsaG
	NO3kjg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pk72h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bec738909so58678021cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218717; x=1784823517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iA2Yiw9uzbXh2h9O8pkl6U4Hyg4t6O2C/nSL7Zx+AZM=;
        b=E0+fa3h8gJW+XiHdCPbBsnWK8Z5NR83kIOCRdvRRg3Ne4y1/hC9bhd8kSrGcJE7GoE
         mFf4vVjiCEc4BlD+xy677TvhMGE2jbK390RKwyGbQwI3n6xVBo+HJQJIuBr/qsiCmeWd
         a3auqgW/HeZIcbExhBhuDkD/TsgHO5IfBDHjPPIkdeMquBQVD4HSZdCi9coxwRDpWeJE
         CfzhoUfjauhGeCd+k/ifWpQJaWvAwdZ4b/rUYFwXlEmGVufuRqLhrtkn3VJZAJGkeuYH
         tzJL3xhmlgaTeFq1OWqBBYNhl+zsnz4X0YO9rRPp4KG/U6epvFiat4Jz8U1wcghlJKmF
         I9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218717; x=1784823517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iA2Yiw9uzbXh2h9O8pkl6U4Hyg4t6O2C/nSL7Zx+AZM=;
        b=LGf3IQhfd3hE+R4B6/2dennfq/m5NREJbp/9INJXv8WGw3D0MSRjlsS992uS+e4hWU
         Ks4Y70etPww0b/kUuhGzLVaRIPiyawJulZ/vWvJbHSHD7vj8imzhzq5winbvIqEHeF+C
         FFeZJ+x1PrMWZodTvunsgYpXgkecXnc+/DupWzLtc/KgPG0KbNvOd2JKdRnZvS6b1pBv
         KVgshXDW6eaMAzv+XNIJq8C9at0aETL/JqrCWstTVUuVvjLyXUWxGCShzC7kuGVy2KfV
         AGhK6ZDy/okC/D30OLWFisZc/zGx3fR+gk/tZ/sulgj+seTJ+BY0Bi0tZb9eEH/rjH2D
         Zuzw==
X-Forwarded-Encrypted: i=1; AHgh+Rrw/3jXBLPIucbL8DCuUNRBe4L6j/TkA57qR1QQTAteI4F/CwJ0L5uvVQpV3mS7d0BtoUqhGTcQJ7g+cXCDWiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ELfiJkqqaZYAf/PZIFC9r1jkfk95rC7ns+bywhxggx308Lim
	afbLYNv93v1OShSzfwqusQqsAO3uMYWRSxRVNT6jI6cW+rngMH2UgT5N9nhbUONgF04F2kL3wS+
	3x5YhSrV/1pWecpgqfPrGIF+/+HEBP6RMkqw+zNoq5yDsa3+4TFAnTp82b79ZCZZLW13Hi9A=
X-Gm-Gg: AfdE7cmz14cf1ZIG7+11z6j0z2NdjbZfFUfuY5qRz12xOAd9LhBo7PPkQg1QaLisjbC
	VEIGEVi2ggwEkVVFTf4q/XoG+noldl7le8RLYClOF2lpKc0+bizEH2HOSXqZWR5keO3on7/kEfv
	P2xcB8ksldQ4xx9WJCo4Q7jNAJuXrHQ3DA5PStZyixXNGgMQB5waJtiIWFiiSIzVzdYcQ+7cb1G
	nuDao0coEy0n6RTvru4BJ0X1JFU4Z3r8j8ACa5Wr9HQCcYLyfrcFW6w0bqm6b6Znv3atlg2WAT9
	JCXTYgCk71bqWU/vEQtz89n/l78cRm8sR3u2324S2Un62mPemzNVtVk7LlgC+fSAKJ84A4mGaLF
	c7Vna8gU6fQruLDgDaHYdveXlRjZ0V4NPVBN/dh1fHtYnvRbwKmQOV/3bvb1Hf+IVlXcqcA9nN0
	q3/+Y09iNGHUTAtrlrpxDlz3u6NTA6/zfL47OUONVrfB/2TAqAQz0=
X-Received: by 2002:a05:622a:4c0a:b0:51b:efe9:27c0 with SMTP id d75a77b69052e-51e42497dbcmr119476361cf.71.1784218716945;
        Thu, 16 Jul 2026 09:18:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:51b:efe9:27c0 with SMTP id d75a77b69052e-51e42497dbcmr119475821cf.71.1784218716229;
        Thu, 16 Jul 2026 09:18:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:24 +0200
Subject: [PATCH v4 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-7-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: yars1WsZ6HOdOB0X5CW0giEmBXc1LPT-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX4L2OIAezBxKw
 wYa+fqOhg+RggHDNY0p/m1+Ki/Xhe3foG5XYnz77axonGAfrU+ACaAUFitY1DYaWT8uszr1LVLX
 O23y75EgtShXYRBV/Lkpt+oK5doHmcE=
X-Proofpoint-GUID: yars1WsZ6HOdOB0X5CW0giEmBXc1LPT-
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a59045e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Z5-lucBUan0SmjtTDS4A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX1FSek3R7PKHQ
 llm2ij8Vjv1Nn9qmeN0njSt88S8XxvWIQsR5IzLXPY8omnXzNSlBeYRN5S/6b9seBv2tQtpN9mc
 Di0xmYsLx+tSLo5U0lUaFe2JhAslj+5rzlKYoMH6nVweoumCN3asHVMMbsOuB2Sy/7/1CTN56zD
 LV9c28C37qBWdjkGwj24sSeagGDQqOKcU6dWVyYlixHEhLGsU7kCuuMYdPPdUEvaQVvUB9FuRAu
 U7e6WgGotnWVcjdl/Wf86NPX/yLLMIN5aB6FVXMZ4UA9MrVHEVAXn19J+OfR1/H1tBWR1wl4UTt
 t8D9VSLk9BmGUi5yTMNv5Wr5PyiL6JgwO7IEL2g47eHeoNke7eSKyrP5Q0bkAsreT6xOVay7xg+
 X98YLV+ShRWCXyhcMybkwUs3Wgpz4F8XrvjAr2Hs/SLWPFh75taGn8RCQp4vLTi7gOq8IRqjYbl
 VlIDdz6MCVj+oXleChQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160167

'bt_power' is allocated dynamically only for a subset of SOC types, using a
switch on the SOC type that mirrors the one that follows it. This is about
to become pointless as the power sequencer path (used by M.2 modules) is
independent of the SOC type and needs 'bt_power' populated for any type.

Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
allocating it separately. This drops the extra allocation and its dedicated
SOC-type switch, and removes the need for NULL checks on the pointer.

No functional change intended.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 41e8c302abc2a820022d1783f1fad76b358ae67c..25c4387136245fca25e375951f960d7240116781 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -226,7 +226,7 @@ struct qca_serdev {
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power *bt_power;
+	struct qca_power bt_power;
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
@@ -1776,7 +1776,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power->vregs_on) {
+	if (!qcadev->bt_power.vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -2242,7 +2242,7 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2256,7 +2256,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2313,7 +2313,7 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
 	if (power->pwrseq)
@@ -2345,7 +2345,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	/* Already disabled? */
 	if (!power->vregs_on)
@@ -2417,26 +2417,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
-	switch (qcadev->btsoc_type) {
-	case QCA_QCA6390:
-	case QCA_WCN3950:
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
-	case QCA_WCN6750:
-	case QCA_WCN6855:
-	case QCA_WCN7850:
-		qcadev->bt_power = devm_kzalloc(&serdev->dev,
-						sizeof(struct qca_power),
-						GFP_KERNEL);
-		if (!qcadev->bt_power)
-			return -ENOMEM;
-		break;
-	default:
-		break;
-	}
-
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2451,10 +2431,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		 * the M.2 Key E connector.
 		 */
 		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
-								   "uart");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								  "uart");
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				return PTR_ERR(qcadev->bt_power.pwrseq);
 			break;
 		}
 
@@ -2465,8 +2445,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
 
 			/*
 			 * Some modules have BT_EN enabled via a hardware pull-up,
@@ -2474,21 +2454,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * through the power sequence. In such cases, fall through
 			 * to follow the legacy flow.
 			 */
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				qcadev->bt_power->pwrseq = NULL;
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				qcadev->bt_power.pwrseq = NULL;
 			else
 				break;
 		}
 
-		qcadev->bt_power->dev = &serdev->dev;
-		err = qca_init_regulators(qcadev->bt_power, data->vregs,
+		qcadev->bt_power.dev = &serdev->dev;
+		err = qca_init_regulators(&qcadev->bt_power, data->vregs,
 					  data->num_vregs);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
 			return err;
 		}
 
-		qcadev->bt_power->vregs_on = false;
+		qcadev->bt_power.vregs_on = false;
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
@@ -2522,10 +2502,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	case QCA_QCA6390:
 		if (dev_of_node(&serdev->dev)) {
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				return PTR_ERR(qcadev->bt_power.pwrseq);
 			break;
 		}
 		fallthrough;
@@ -2549,14 +2529,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power->pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+	if (qcadev->bt_power.pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 */
-			pwrseq_power_on(qcadev->bt_power->pwrseq);
-			qcadev->bt_power->pwrseq = NULL;
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
+			qcadev->bt_power.pwrseq = NULL;
 		}
 	}
 
@@ -2594,7 +2574,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

