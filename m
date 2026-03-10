Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836737417F
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183789; cv=none; b=qEIlzVP2f+VSZUo77HyboG6SP+iJGPca7Rdvdpf9HgewlXt2PfE8OIQ/0qAqxZrGqaSGB/SCgcXP3320QsAHXQf+u6nmccBEsORJlv+23OAfB6gIbmCbXjyG6IYNxaZsYkzPe3W5+6M1SFX6CEA2UqwR1eV6qJp+JhwohoCyhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183789; c=relaxed/simple;
	bh=NCr7CWtfAODxD26EjaDhYPub6MJelC/d4IOGonNL63Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npmjJnKzCB0uZQZUfxCCk/ZVLl28rpN3lZSdPr3133+5y4V+DtJSkwvmWL2CvRg4nRJ8wR7dwWA7u9jzX19LTHFkkNl6GLSq46Dy+8OkfMYRW6VEXdZEfxIc4GQIUPCyIAICPjjsIAnjcSdHmBd5Huhua2JMCZKwyw4SP10ziss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3k9xC2t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W8YhtFCx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3k9xC2t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W8YhtFCx"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHcorf2179278
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	11UQng+3pfL2wZggMDKPKaPFC6vPCY5zu9oF2jTjjxA=; b=e3k9xC2tPkfrMkBT
	SUM1ORpLnMa5V02VqCYi+ZX9j5MID3z3LDX9VRHLOD1j2fh0eGxjX0QgYv0tyhLW
	ErvS42rI7z485cXDk3PvwwP6hxvVLWkME2cQh00lC7VuH+LkO1eaRJSQa329sKkp
	cw8s/F+9vSjnhimePc+S9AplkofhC4ZbcRSSy5NmBJMcgcYVjlqn4UeqsudUn+Ra
	+8pYxNEvcEd150/l4fcSk9zoex69zJN2yvHjlM+MbRbee2dRfZxXB3kp4tca0QLh
	ehX0rvAYEinRDnPncpDNpDhlq7/SdduvMGvS5dJAD97O3f56K3bzTAVFhvjXL4I+
	xqEXSg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvss225-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 23:03:07 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ffb9a0bf22so38951534137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773183787; x=1773788587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11UQng+3pfL2wZggMDKPKaPFC6vPCY5zu9oF2jTjjxA=;
        b=W8YhtFCx3I9XXN9ZhDAPOmcLAgOnFtAkJBcy2PzJbR/PSruXOKyJUNPSs38iBScZHw
         bWsPctuyc8jEO3E3QGQAIZFcuKeNhdSYNf93B7KM5RZiJOdU1U3RgggHH45Y6+dee8Qd
         45GYvOF/OtwW+TV8eqmsro1hNLHZMsC4ZBqihFYefayaZN4cs/qzCpQJyrIwYMNr4HJM
         qcnLoT8HfGK6UpO2p5Dh7/AH/P2B7xbXaN6eutrjXnWCO7EXTyf1VoyHV90ymJ7I7lNf
         qtsqVrGkMbvELn2BD8w3J4n7x8d6z8zCJQU0/X15NrIXDS9RVmNHuapRA6KhmP0jMUvp
         CxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183787; x=1773788587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=11UQng+3pfL2wZggMDKPKaPFC6vPCY5zu9oF2jTjjxA=;
        b=q5n0Fx6WNQ5pQ2wIfTMpum/YQpT6W1pIFqYilK7x3LQ0Q3B5iToe4Eu7OB0IoVKPA1
         wmH9vYFH4oPf1h0bY1xouiQGZE2KATWqq9uukGwQ+XNeAOqBCQt71ST8Qohk/XK6En0H
         5UWWkTBf1im4/M2gagMVkXfcWsuLxKDerya9ko7/JEoqSwHcfWqX+44adsNk4TF0MSVQ
         naOwR2zzkeS6b/zaI9i7/f7tIBOvW5z314YNS9DxEHCn8l/r3z3I5VFkARs20yyKt9Dv
         tXpRby6fYZAvTOdSVGPygvUISghChkDITOwdl9dgWpWLieQ0kzkHa9qAD2CJerw4Q3CI
         KjEA==
X-Forwarded-Encrypted: i=1; AJvYcCVmmW8k3tlGbyaz/kajcLEfh/Ro6bkshXSWzzgsz3LcAmwRPlR4gsLHNmR/b3Nerld5TIIRJoPM9nhvrTnHNWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+J9pD6rAO3ho1Y4b41JSIubgSHiuWiyPlEV2Ikbl27k4hM+7i
	1//kMgOCndLRc3+U2SoSsLcYq3N4KIIrZHhDS0rQha/3pjCgAI8sJ0msYiFIqCmcxUJkPG0wuWx
	nQrUMUFqppyaUBCPqpN8CQ1ibhF9ZRTpiJ7/uMqS5mu0P0NhatL84Qfprks3RiPQDjwS3gRs=
X-Gm-Gg: ATEYQzwEdCGwry19+0VXPxp2zFG1CIl/Jmy/27/Epd7YlgzN/x3bg4lyl3XSRUjKGLR
	bneJmDHI4FTdrbtKNGLrXtBRrffGrz1bJ1gV1sCZvWiF0oKcQkRxq0ix2QBDmt4rNVLpuZ+kXAx
	OdattOvPOjjSpqt65Lx8wH3TOvQQ2NbKBPvqp+ok9lVyZFZRenoDnq54vl6ybituJu+rJpbDq8a
	XVwXFTSjlx8unrrWkg8pZPGf/TMeynj+7g3xtJ3YJ5ctcLi9TJRZym3ytKE5/W/EhJGbXMMrtC7
	oIurhbvaslwbn31C4mggkSHyBbsB/4MOFFCQ9gYNpJfIawJCKLC4hVaxOrVA7Sb6q+bcl00U2eh
	lecxJiWhj9OVwq1E5lLwY+enfQjwrC+oNL6KCG7PKOGmgAhOln7+m70C9L1oYIqC7SC0EgzKg0M
	kM9OmFfIIK8GEDFdmjI8msTHZat6kCsuv/tpo=
X-Received: by 2002:a05:6102:26cb:b0:5ff:b8d8:b40d with SMTP id ada2fe7eead31-601def30d0dmr216629137.21.1773183786709;
        Tue, 10 Mar 2026 16:03:06 -0700 (PDT)
X-Received: by 2002:a05:6102:26cb:b0:5ff:b8d8:b40d with SMTP id ada2fe7eead31-601def30d0dmr216611137.21.1773183786338;
        Tue, 10 Mar 2026 16:03:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366a74sm80743e87.75.2026.03.10.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:03:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:02:58 +0200
Subject: [PATCH v4 2/2] Bluetooth: qca: enable pwrseq support for WCN39xx
 devices
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-wcn3990-pwrctl-v4-2-70e571a18e40@oss.qualcomm.com>
References: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
In-Reply-To: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Harish Bandi <c-hbandi@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NCr7CWtfAODxD26EjaDhYPub6MJelC/d4IOGonNL63Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpsKMjTeIHDIuYj4EJzWHo0r9XJi2oSJhP2xur5
 ikqas8iuDKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabCjIwAKCRCLPIo+Aiko
 1WayB/9BC25wqOSbwMnpowA25Lvof1XPsWrH0PhtoZwzgc9ikZVapmH2m6k/MeSwVKnTlw/IXXs
 i5iXH03VkT0KQi2c7uu7yBWMmfIN1BYbAgsA21hONjqQHGZYolwoAfUPciWv3DbDH/05JMLs8te
 JOI1KHOX021NHbZ0zdtHqasKVStyr5Cu/kU5prF5uVy4P6F1ZW3cr4L+KQIlVT2l+pPQ0YUqpB+
 6c/sLth+Pln44q2x5QyUHWMYGFsMdFNWT6tg1bLgbifH6srluGefFjDjcxFtw9zqexxelqDOouP
 4r87Bb1tA0zi1Xq1yn/v3TCC2XH59UYFu+Lje+3f5IdkBBAl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE5NyBTYWx0ZWRfX3vyLpQvdt+16
 sWeBcuLFWxkBJZTJqc7gy/70kbhxGufICS1kWZJx/Ki2H2ZIATodvAqIFCsYvKX0Yh4DVQnnH2i
 DTsRs5Faccz0mKNNpRKOmQEXcvVpluV4HjpTK8v9A8s3W2lcbB1umaYwE1TDm8ogxDa6QiECnLa
 KE6lddq+MbB2KpoTI5xVVGQqCuWK7+LjaiozTFziKWmOUr9xsJeKBs26zDDSBDSX+0yXlpC5Icm
 t+GKPZPYdAzkOPa6CsXogWt/EO7b0SuB1gKppAHtBfJuNi+FHzBkQMkIDhZE7aT2Zau6iMeRTTh
 Dl+f9S3q+hle8ZzNVRuwqbmCOgEA5h4Q43s/wWf6kaimNAcQsuRiGTBYFQRC6gKHCZlmZ8RlbFM
 Da0lk8LTi6p3Gvlw2FSBHxPkXiCPIhMBHhOZQXrA+CXQAn7Iuy8oWt0P6G2e6EXpwa7zuykagrR
 PGussjbli7rsIakJ3cw==
X-Proofpoint-ORIG-GUID: BmyQcsb3FjbhMlwNmElb_jxQHbozP7gQ
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b0a32b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=rVzinPZZyXf-EJmd2kAA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: BmyQcsb3FjbhMlwNmElb_jxQHbozP7gQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100197

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of QCA devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d6e78201a675..c17a462aef55 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2241,6 +2241,18 @@ static void qca_power_off(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 	power = qcadev->bt_power;
 
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		host_set_baudrate(hu, 2400);
+		qca_send_power_pulse(hu, false);
+		break;
+	default:
+		break;
+	}
+
 	if (power && power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
@@ -2252,8 +2264,6 @@ static void qca_power_off(struct hci_uart *hu)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-		host_set_baudrate(hu, 2400);
-		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
 		break;
 
@@ -2425,6 +2435,11 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN3950:
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
@@ -2449,12 +2464,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			else
 				break;
 		}
-		fallthrough;
-	case QCA_WCN3950:
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
+
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);

-- 
2.47.3

