Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40007379ECD
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218716; cv=none; b=ioEzB2wDmxovN2mGT3bgP5pM/11g3k3/fHPRw/Chw1jAZymlMuYyh9eNIygydc+hCmfgoTZzL6YrZbQsjF8xF/Ws9b5riIVRIF0bzLjB+F3DCoudC0paZuFiN52SziJ5DArldWBgUaNwCPQVbGBKm1f+vX6bTLqHh+WNFvrJBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218716; c=relaxed/simple;
	bh=SDP/HXgz4amfEH/BI3vkK16jvRVsmUt0sdawVFBJlw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBJMAsMCTSE7lDTGX313U8kv5LH16ku2++3FrKtxjBuo1wy9FeYiOI/z9eo5HAPxgrb3pPoZ+L69aqF1VIAGQFN/4P6J7bnO2d19+IvVEVSg7T3xqAqrAJLmL8jEV5MDnvLTapngiNNLCp4BQLiHHA/jzoTYhwVGsMBHnlyLHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEdaw8EP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iOuJR0ng; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEdaw8EP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iOuJR0ng"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJnTl2897721
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=; b=AEdaw8EPUB0um5rn
	QvxNivBNe7znLZRvXMtDnqg4K7M/EeM7+28mptmwZ52lT68O4tU3NvYuFaD8TU0t
	cdk/W9RXG/4wbGVYUkPEetDFYJAdXBmPZd2dmkgdhyJQ/FzyuS96LvrErh3nrjAd
	89TVSLvm1TzuueCvM1fpvkzmEzfM+txsnLJfJHx5NN6jDU5KEUbo4U5kW0cGcRbi
	7IuIgQa/6a2/BAoELavwshaDfmXkU/yzFLxCoOFZ5QwlRqF9U+PTRyRYY+RzInoV
	3IqMsl80hi/DrQd6+HnhPJzJxeFlq5dBa29+d7Z2imRpaEQRJSaH5T29AaRfAF/g
	wqRG7A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feve1syr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0199faafso76922071cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218708; x=1784823508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=iOuJR0ng3Wtog2Gw2u6eZPxhMyUMgJ50TUnmXRwqKVHWErn5PJzDUwOqvHlbfjc3KK
         u+SZRpCKEQeGdQH9px5Rqrdupj7MB6ZH9jFhad6jMd1/NHbJFVE4eG3LrnOjibG9tmgI
         9BHnMM6xKRZPUKQg4jrf04qK/aD/iZ1QFtUJaIm1FraQgtTnOFiSzntLx6UN0WAZTJGd
         sMznq6yF7mPSEwv1E6zQaRKbESx4UeSRuBuI6+QN6WSs/f6QYGnTHlEcUHCgViCryvey
         N4YvlH1V16nFcMQYyRHrx3kD7zyOrnpD67mH6/Jw+o0rhig3NDioa6MkbCIBWhOnAfUi
         oVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218708; x=1784823508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=SsWsAQKox2kcIaPAJH0XnT+g3JbmHKiTL5ZV8bitfSVMw6vJXU4uJI5dpOASP8DVTa
         Kulsg5C91KXwCQrd9KaBtYvBhcaSsvJ4E2tdYrlHtECgf1phi1v3lIGa8WqnoGcUu1jV
         auM957UlIti1d+NAZKhN4CPeBCT76g4DpcFns3FSJIp82wlJf6rOzmS181ycv/e93mFf
         oor6pRMzWM6Y2TwzNcZgyk20n8CzhKlh5B86YYQBBuXB3nRDACKrxbxy7t7VIQrcnTqH
         LNNoAD4f21Pc7VC5hGVdZJYqJbMwR+DfBuhG92/eJQFso8oEOJ+ZUSFcirsxWKqq5xij
         mD9A==
X-Forwarded-Encrypted: i=1; AHgh+RrCpWXy1Yyq/L3i5jhr8qB8SpKzbRYB+qyOG1HmUCZuGo9M7XtA4AsNR2yiuQfKLcjz+2sK4d9qboZ+sVPBvmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNPc/fZAJ29kGGiXlf4K2NbLgDGlEZ1VO24KsBMbGEm//jvLW
	+5shggbMsfyfl8Sr+nJBGanl60tP/CXucKDkMLqY4/8PqvB22ldaZXbhRDoksVs9M5PXgTnBxwR
	F4MIBUIowHYd1Tm7s1LuLDxMYRoInCXa9sauY5YFtYLeSI2h7qkqonJxXLkCAfyO51zSX6EA=
X-Gm-Gg: AfdE7cmFjeKWlvcLYTKrURFxj6B360IYb+5S1ol9L65BNl4TgLQwUxJWOCCiGmq7FjE
	51Qm7WeXpan7WNbMSY9vTWGdfBF2KKKmZ0gOPzfgKlUdsRAcLmQWel8im3rZTKMTqreFgpXMr7U
	MegjLkjVIC/x5JEUf87370KqZng3rVm+F3bMfrbbSGkn9f++bbz3OGucTe1Dg7Xqnmk4zxd+i7q
	rNLSilvo41+Xd86jJJh2et8mk77jDKxSUbvSmmnxF/g+UpoVJeV2uT6n/lRdOfeNI48+wWLLRP7
	uvO7JlP+MB8O/VLLeDE0z/9AUTO4lQLfLNH6c191vD658/p6JwAF8Ubws4r4mb8TJYMHgMKXNoN
	br+sjTv6eewlnVJVobvVsjqrT8/u8MeoCaDgVWn+d1E3yQAyE1sK/91vZxnI67XrCQdi5lMQtHN
	KQZqdqhOVqQy5lpH2Am9R2I4IXKhmnxAyZGxQ4YaaPCF9fwKb6m18=
X-Received: by 2002:a05:622a:2c8:b0:50d:e471:2d1e with SMTP id d75a77b69052e-51e4239fd84mr117365971cf.35.1784218708344;
        Thu, 16 Jul 2026 09:18:28 -0700 (PDT)
X-Received: by 2002:a05:622a:2c8:b0:50d:e471:2d1e with SMTP id d75a77b69052e-51e4239fd84mr117364701cf.35.1784218706689;
        Thu, 16 Jul 2026 09:18:26 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:25 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:19 +0200
Subject: [PATCH v4 02/11] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-2-9b02e6f549d7@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX8rf8dLCGp32P
 vu9CSj6w2RNzAkYOxwb3ISjksJhSCZoNQhcD++hlpmKfIbhEw5CpCMX6qPR0g1fxdMFdCQdOscW
 KTjU8rHRpgyt1Fybq+gdAUKMZp9ZI2hpToxi+IC2eB1H5U0i9WvojDZcWYkJTutV4rxEdEE7ZrU
 rLsReT+M+VI6CRytBus3zWDj+bSe1QVMJ5jVCqiYlcjBoUI9/OnECyQ4FGf5oljIah3oazvv8gL
 IsoYomPktCZPXMboc0s4xYsDPIF14Nf8X4CWBox6FRSV7MhJ2Kzdl5zHNY5e3tJERQsadSGKToP
 j+w0H72qvHOpxzApl3m/9ST1xiv7IHVtOvqgulfuXVAvTh5+6gTIEPY7d5yOzSKJzTWg9jyQYBY
 B6JiQo4G0pPG0ymVyrPY6dUh7JqlfM6kmDdjqSaKB/cgiRtrFbwmFlkVBTPgRqfDcSPiVS3jy0j
 +2MELCDoPC8w9/vi3bQ==
X-Authority-Analysis: v=2.4 cv=DvpmPm/+ c=1 sm=1 tr=0 ts=6a590454 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: DT2EDAQWiJUGKkJ0OPgRWJ6xPHHPn0H7
X-Proofpoint-ORIG-GUID: DT2EDAQWiJUGKkJ0OPgRWJ6xPHHPn0H7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX2NXD22/slhgS
 RS5HPvS4BShx+tE3olz97TuGk2NkfZWCpPmqIU6Yhkh+a+n4HsP2e5aqR+dgZtb7LV6wMn+0IFC
 Ogn0wh3TK9Qbw4Uc12a0qwVpoXFpgls=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160166

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
GPIO in devicetree. But the naming causes confusion with the new pwrctrl
framework.

So rename it to 'bt_en_available' to make it clear and explicit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 135c79e696aefe2b37ee7a7a668715360a1e2d75..17f436484e1e74d1dd690ada22134315abb767c4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2393,7 +2393,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -2501,7 +2501,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2539,7 +2539,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2557,7 +2557,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

