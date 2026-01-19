Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9353191C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842485; cv=none; b=RLN973ZRle+61hyrSnwap1s8hJ/gDEHHsRR6ijxZzFKjyj4pXkKKaE/jPfagc20cJeO8pb3+96sPjmqB4yTSg3PrCYdRIX+H7B0SgP28daJcKxRykeVTCxwb76+GPyK1OGQzxqs43eTb2iHhDmzws8RVTlYpseeJv9xjczzDhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842485; c=relaxed/simple;
	bh=8ro0A6tVVAR8N1a3EJt6gZeL+nfKC2FamuLo+mTTcgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmGwF1Xgi5UXNM7IrTtTWVhkhIDLtta2hhoA1hi7Qn7Cdgt2R+4kVza/xavTyYmmxbAk9hHHjQL0toXA9Pv/yXxU3KUcnNdbfIGE7DPVeeemje0ZBJBYDSkOfMkgGCU76ajzmOYBfRsmhhDgu41+wDTI0kOhERVHQsYCOgiSgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Phequo9S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ErKzXl4T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Phequo9S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ErKzXl4T"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDMk61440838
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=; b=Phequo9SA/a/PCp6
	NlJTaZczZwRqq5IeMCtKydM+r4rs+si1FNopaHWIet3RsQT+eS/jbWhJJh4fyxQO
	vQXM0Hw4lqk1857DMIpaXnUu7ev9iFLv/J5BqPXm3ENvNSCnP509TEa/l89uiQP4
	z5LO2Db6QVmS+wvwIG0Q1efI2idKPV3YdotGlQ3o+skN5/LP+9pp9t5i9vfA3pvE
	9Fi9E2QDq0GPHSjbtgrpE3BPCE4hqTjlJTQilOjHxdfwJHUYv1ALyfhY6FVP0C1X
	IeuoGR6RPRPKAkDHRAgrv+8ozc3DifumhNmTn+Fckove1eazGIRhNp3V7ceZYNqp
	uE+Eqg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bskj3h0x7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 17:08:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c53919fbfcso1096988985a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768842483; x=1769447283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=;
        b=ErKzXl4TS183wABo2WNvKRUHu1NLG/ziSXeZfABxMdsh25zM/sTJdG/lquAPVhCooE
         kx+xlIXdYyT+9WGOGvvZSu/2koRM9qat+bGKIBejlOEaoYjNd+TVnz0dsaSo45S8U8Cr
         RDM6/htR/RypSb4T61cSucYdp3gCvjQl0f2hI8VSdtR//mq81lfReqWfbGCTjZO3C2x7
         RfA7pHDheFivgjSP6e81pAj8zOzv6FTsi93bmsaaG2puebn6WpoiZgfyA1DTqHaREAx9
         QZqz2eVKhhiWNNXVAiWaz0wUnOFPdfOpZ+7t99yAZZ1QcxRI0/xOOOnuWkAat+PPe/Zq
         BjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842483; x=1769447283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SuVJjvlCTXRFYAFx0rLVTZXUOY4TgeWGafNaZ/GaNBM=;
        b=IZXj1aWO+8VhjUCCDdL2hXqAa0hrk/SE2a7rOmZ1kQ1C4Z6ivNi3xCA7pP4lG1wKNd
         FDWCmQuYxjurFgaKctwzGdMPT/YXaeEqGBuNHxs1lEunjAwkqbeBiEsToVyRVqdGwWSQ
         xI1lFSMnf23UJxrbV/x6QTGbWApJsWfR7UE1WKQ1SOcqo8y2HR9U3Z7v+ehLRRNpTo4r
         JDGpmq3kNJpgFPNVKQU1etLuICaVBI9S99F9L3J4+1e5NO5fqWpeebJIAh/YIFeKpYTo
         IYf8mCOflMqDt/v/YJ0d3zH8SnfGGkiusYdsS7+3UPNpplnfbwIBEWp5XoaPoM6Ix8KO
         Tj5A==
X-Forwarded-Encrypted: i=1; AJvYcCV93wMT3y+awXBefzlUnTns7gjDCmaIdToaqeWDaZrw9sRLQNgJknLzD1u/399/O0Nrlrve1fCB2WCJ0JW+lmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5JnSeKyJfhisMga8XNq5YJDOPup/TZTq5JzEMYdsPyi0Zkma
	x3Jr7zmUdqx+l+rGWtib+0A/ZOOdMMUKHTeNGxcYkoYgUdLNuhjXyFu46bfwn3sRXE4eXDIG0xf
	ZXi70jJcfE8gluVGKprglMIgEHf8617Kx+T2pFLshzEFuggQaS+9dmaQjkQEceZ95Ia1o7P8=
X-Gm-Gg: AY/fxX66bx3VpeFSgjL74vIWcpktj3Y99NhhV1vz17D/lfuwJwGSsvn6KqWaeR1Q920
	8pqD2Zb9mBTp1Io+jElto1AUIkA+cy32IuBt3LU9XwpZF6T/5ZwijPONy9ETN1ycohvZvTSY/+d
	NsvUWh7jmaJXAKrzesR8c/dTxcusGSKvoLXrltD+hxnGHDGbSeEVe+tMPkGmA3JG4eLqPIkA/7E
	mTpxvISYz4DQc85Pr+cjO84gb2hM/XCiLNT459MMDimXCvx15XPBoMtFnkDGMTF/nD7ezf3JkPS
	30A3yxNaVxhBSjHjPXCugGoabmPALjx6QdA8L+OFlQopb3BTi7/vcsTr31il24tRS9iCiZQwGe3
	4JlTmZ/W8hvk6JYAyGx6Kqmga1D8BIw2CGpL8RHOOYZWZ8H2ExS6VHkjYSKyD8ulH5fqlYhzgOw
	+CQU/xDX9kX1dUp63tSYeA1bs=
X-Received: by 2002:a05:620a:31a0:b0:8b2:e6b1:a9a6 with SMTP id af79cd13be357-8c6a66c833dmr1553065085a.17.1768842482477;
        Mon, 19 Jan 2026 09:08:02 -0800 (PST)
X-Received: by 2002:a05:620a:31a0:b0:8b2:e6b1:a9a6 with SMTP id af79cd13be357-8c6a66c833dmr1553058985a.17.1768842481942;
        Mon, 19 Jan 2026 09:08:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38384e790a9sm32661211fa.26.2026.01.19.09.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 09:08:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 19:07:55 +0200
Subject: [PATCH v3 1/8] Bluetooth: qca: enable pwrseq support for WCN39xx
 devices
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-wcn3990-pwrctl-v3-1-948df19f5ec2@oss.qualcomm.com>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
In-Reply-To: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8ro0A6tVVAR8N1a3EJt6gZeL+nfKC2FamuLo+mTTcgM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpbmTtJkjq8QRehFWdJgm9SxyOHvINLBQgHL/BO
 cfn6uEaosiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaW5k7QAKCRCLPIo+Aiko
 1dYSB/4mAIVY1Uxgf8lpFuKOsE8xM/V+Rh7rNNYEBCcBFyqY7YknsndW1uZpnqvilai7bnfI/Op
 nIxt8kq+/NYZJbRHnSlbUFkqCBgOfzIxabuLUwlljRP28UvhPnIcKmvYzcHsx0/1O7vql3olS48
 Rx6E+Te7MXS+JhR1nrjfchlvXIxv3ZBIJR7zHMHfh47GMNJ7qSKkKmWM27Jr2glV9rskj/gYjLC
 F/mOIczZumwoeoKoWIXqv85nKT2P6BzJCeT83mPZsp53Fgpp61D6nn07ZRvR/mv+o1FpbSRVqtc
 6ErJ+ElIWpYIknQPzscQ5kNNhH4dp2bX58K59Ooi0UUUoofS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=ds7Wylg4 c=1 sm=1 tr=0 ts=696e64f3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WNkeAZsnUospxCs8hJ4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0MyBTYWx0ZWRfXxdET4wZx3YKw
 qlzKQUVYjAHPZgHCt2C5s0+gf/PYh611KSG6cr9iA5iAxxcqj0BUbebCC0qcJ8BdvsUl8+Cxba/
 YrPnlO3JOffAF+1Xjwx13IAbdnGDQ4q6xp7NZ5Do5gkgWdOps4j49Y2GtC2DbE4peJNjY2IF3oE
 7uf6gkf2hslaEeo/ArUYvH4hM587UHsieBKe9ey5UjqwOb2CDT5oUNlVogaVZWyyu6tEBK1AXtB
 JL55WqQFd27N0OPRQKpbD47y15LHOIBeEvR7j4aZ9egz3g3cafFBOLXhMqvaluiH+pv2g+iZaJz
 M4zuawRmxsumiMM6XMhUmNcVCHuHM887kUWuF3eHYZr9rvJrAVbQ62b4qZULBCwPAsiQpbD3UBB
 wdAKNG15erBnzs8xLPVeufMO5ZxMF+kQek0MtyhHEhJ3JiapySe8bvrKBE+3rFjteNqzqZ1zbLB
 1NA47aTMqJfFlvd1pDQ==
X-Proofpoint-ORIG-GUID: ROcDrVP5eAdlaYk37HD4tc-pDLl7Ecsi
X-Proofpoint-GUID: ROcDrVP5eAdlaYk37HD4tc-pDLl7Ecsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190143

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of QCA devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b54350317a43..d1402a344063 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2230,6 +2230,18 @@ static void qca_power_shutdown(struct hci_uart *hu)
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
@@ -2241,8 +2253,6 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-		host_set_baudrate(hu, 2400);
-		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
 		break;
 
@@ -2414,6 +2424,11 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN3950:
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 	case QCA_WCN6750:
@@ -2438,12 +2453,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

