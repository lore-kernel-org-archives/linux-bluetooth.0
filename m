Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852303FDC0E
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677466; cv=none; b=Je6Y4kdUU8XYF19+iQBZi7TmE039Iu/PXcAllvjXJpIf6joe3OU532xUPKEGvaL0x+jhvZtfLDHZtrWdbSnpy6pUkUE6IimGJ48LYTQzL1XglBmyImxW0ZNGu+kmLtZUdMs9SYmXG0Hu7irstYOTzKlgRxlC2rGCmBbg31hzJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677466; c=relaxed/simple;
	bh=SDP/HXgz4amfEH/BI3vkK16jvRVsmUt0sdawVFBJlw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwEnjo1aYIIWErj/NI1UiHp06qRYza6XacLoMEK76IW6dZwuIwL02wXLVdJdwDY5BngYkzLEUlzLC7Dj/kwHnyAXODtAylvDOtGyIdvTwfmds7+55pHDE0pn6cyQlkmGDuL3rlyz9TDfA1A31cWVcL02Tcd2S+Rl/bKI98yQ0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bMEl7vZO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AyPfjdb8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bMEl7vZO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AyPfjdb8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A9TTq8291947
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=; b=bMEl7vZOTf4dDadp
	EzlAQnUxEqs+ldnAmqhMDH0+LSqEFMW9vdihBed3ExQzkon4MXvnfTGGPIs3Jos7
	eWtw2JCrYsKPXX5g/E1/4+zJp16/bdUJ9cD9nf9YTz1kwIhe6+6vqu7t4SPZWCtv
	F2pgZkZeHIrsUXJixKP70U7Rr5iY3LK1MaVXjb/KZq37oiu3CV6tdE4DhRznd+PR
	YwtkfXTqGpdyBz6/8feSqDJxMU8Td8Cd10LNsKx8cM9vjOUxJgkytYnPvB9D4C1J
	FuJ2n3Ck73w1qmWzovubuUv+npI/LRHUpwxiYXOWAUXdR2LzS8r5Pb4JZgl21jGg
	riBE/Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dg3jf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c33f48ee4so7624081cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677456; x=1784282256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=AyPfjdb8gJ4oonHJoGgQD37xzqVfXkXKKE6nAUc+U17wn02SnfC+mUe1ffzx3SsuUj
         PL29jAQIQoDgLQSPOeLUOUMribhORls1HeaZo1SVfUICCHvngr0wDjqiKCMBV3MFde6C
         CdhU5cI44h9pFC8m5DUwZgI12+54u4xNjZfrJArk+len157zoEzEMe5L5ROXBE4WjXAB
         yk2L2MypgPf8mIPzFodzJzZmfIG33fpRDl23lL7MSN3kbxvzVfqCY0dgeQvCXMoNSstu
         96aAlsA7zKPNYc1Z+VCaGYkwz+v36RvATALCayDGXI2wKVJV8JmgH0cGtERX36XSZ4Md
         GjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677456; x=1784282256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=aA2TEL+W3N8m5FpYOL65+JVZRMDGcuNoCNX4pTtQmi2U7h12kEMwsMZdyBUFGfWhHo
         VG5coLsthim1EjKsdUIdgdTK1r2d+75h3H/oaBY0Bu43pCLi4m8FvTiH+rspr04e4jEW
         jLquLRT3hK9zDWxobw694d/Z4crOEyWROdneyZLe0c7MQhEK9sy7xAT/wXTe9VnkG8+Q
         FKsLac9qHh/PqAOMNNjbBcACTpastufEDh/IAdkBr+nAwY6Rq3AI5A+5Aa9CMOnpzfjE
         sc4jTberp8/ckHkOFaZWPwy2MN5tZkGQH/SNMpbxI0eb06mGLFcnffCV+VaGL3Ixb06/
         f+Aw==
X-Forwarded-Encrypted: i=1; AHgh+RqtD0nlpWq536uxLwhY5xHxLGE4DfcTcwJqTH+EtEuXHY7mCMbUGl3+RezFxTlbP+qJ8TAitL2q+h2EBBlqqko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXG00GyTFEucKKtviWGc1LX2YWdJNAm7BDFf5H1xpKtf7b/VC
	1nDA9yCpJaXyCD6E9koPqp9g+UugDm0QsEYLf/x8t2FTZxBxxa6SYCZZsW+RBigF9TXMvY6Pi+L
	yxvGRtYb0EfpuIFqnooKNfsAf0P1rx5HknC03PYhDS+/uzlzJD2md72LumEgWakm4x3rUN4s=
X-Gm-Gg: AfdE7cmP7WXChFUVNWcmkaLv34rvo+UgNxiwHdMCKdMX9H4qudhH8bGNIYdZpHzV1+M
	iCHPvzXOHi6d9thuxDkhHesQf61/WBa8REHirHlxgNa5Wmbb0WYwD20ciJvexuBhd3sKc/78ot1
	EcH7tyXN54FiJf/bkrbLePcoeVcSnZ8tX+IciCW5Y5ZkRcDykJdQha116oG5Px2oHaKzm0It1X3
	cmIge55FGoJthQC4O0kMqH7yx0POh5tb+N/RmnJTeqalnmM6SmeaxGjMiDQpUdrZNo032mgcCNm
	lOvMkVbY0ak9cceg3ziTLRHNfWzf0kslcNPvsHO/7lOsrTjk0Wc3CwiDyol4JLqEr/afJIm9PGN
	Pjzu+y9eSWUkzQVynMIU8GC+ouMAFMrkXvfWX0KKefSkUR+XIcFyxk2c57clhDLxGPukPARPofW
	N+9epft8UR3f11v2jAxlCecSwPzgJg85gwG6fRE64IVhmkgpHm0G7miKQ4JoN8nkl1Q/Hw6fiK+
	VpDxCdB2mlPvGtxPYOZ
X-Received: by 2002:a05:622a:4189:b0:51c:10e8:ac7 with SMTP id d75a77b69052e-51c8b45652bmr114762471cf.37.1783677455755;
        Fri, 10 Jul 2026 02:57:35 -0700 (PDT)
X-Received: by 2002:a05:622a:4189:b0:51c:10e8:ac7 with SMTP id d75a77b69052e-51c8b45652bmr114762241cf.37.1783677455256;
        Fri, 10 Jul 2026 02:57:35 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:28 +0200
Subject: [PATCH v3 02/11] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-2-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX94d32e/U1lVS
 wbHBa2w9jFj/ED8k8goOzKvuygkdQmazS24Xp/+5ckVHwR+Eh/TIdCdf5uwNT8aTX8peqfAW0GM
 Wuy2CM3an/dZSWD5rpI0lqAkXVZ7n7E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX8xWRWaJD9qY7
 xeZw6SS/V05Mg9Hv81YuWwkhG6QuEUQplweVQZRBH182L8FzbqY2kP4OGgP+QVp109SFckbGh08
 f5dkhzQkYxZHWEJ6smZbmcsioezL4qdYipRhf/ZZF8WaIZVT/MJpsxPIbMFPQc6v4xcCM3SxFbh
 79wXoCKgZX8e6nwGirFUOwdRwWzAWbBE78MWwQCtTihzVAcr8xZwXBKBsoRCVTwa3VgSZ69YCY7
 WH4S+FSrI5RhoHLh6csmxTZBfVNbnbLfi2iUqSwB9oP4TkZgnPpgM0MFycqN4OdQ2EfXAHLKMDH
 wokJm5RiGtWfDYxwmUfq3NuUZEhqgv+Q0aQh61ryDyg8DrQOQISypjaHaE7DKfNlMW3iIgBvBvg
 sb7GJhKVN84LrMdtIdSf72TFT4WfQWUGCJ5NLFc5h47QgOLQlexKoCKZXVT/lkEMFelcvGF/bO3
 OYso3h+qRsiPuWAuFvA==
X-Proofpoint-GUID: xZzNTNmNRUkuxHiEUyQFdi_jAegB1X4o
X-Proofpoint-ORIG-GUID: xZzNTNmNRUkuxHiEUyQFdi_jAegB1X4o
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a50c210 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

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

