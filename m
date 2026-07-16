Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93631A9FA4
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218712; cv=none; b=nejsqkSx8FOK2z1o5t1qB+AOg0RsfcfsgSd8bkXGu2TFMXWGPM07TvQvqtQqRx2cttgoZxiQo9eVTo2BH3NbFKn9LgtN62V8kZIg5zBxxiVTuB9y2L7iI61NVouRKqQp/TGRyJNYd0npf1odCVhoX4GHDG70v3WgvBzyN55SmCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218712; c=relaxed/simple;
	bh=KEpaGYLJg/HFUQ4VCnAAAa4/K+FU5Ww1paHM4mUD9UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haeONhfS4Z0wTy0ZAGO3N7d2vgvCayIQ6FaYaos1FCIKTdORU7Vn/HJ7V9x6azG1NaUeK5Mf3N8r51JuEHCKYZkK0P5c19cBxZP7ga8r0L35jl7ZBG5kxXP0aueB6dieYjrrAVZ+3ysbkfn0YzT3kBmk1TGEJJKIQPpTWHEjKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jOXqOVLZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gAzxOuzu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jOXqOVLZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gAzxOuzu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDK3IY2959573
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=; b=jOXqOVLZC6BBHj+3
	XLMie+g+71G9u/wYEPDYrJ3KKe4zYFaauBBV8N/SmJsnKitT5CT2VUecq1mcCWHd
	um/6RrZ6wvAw4iTGGChmed0ie0RpdXigKmiabE+7Lkp3RnzRArloONiBnbL/JLcl
	GBHQ+mtFO5m81hFdr8wH1JH88pDI+0FWeVHV/3A5AUvynHR6ULBhxjLxBwMhz5/H
	gScdlUkHFPFMBUToCkgWmH9i/dt8bwP311Qm4zuS2mGfMRxTPhOHAbYVJW5CSQXM
	VxCwHmYkPLvmDoPrVJ1v8iRkIE59KJJzcQ3eFWtBhNI3osy2GrpBfn0t8vrH/kyO
	zjl0gg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feym1904n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so73408681cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218706; x=1784823506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=gAzxOuzuXgVrE2WxsjQyQGxnU6sKbjC6yCuSrsXogOxf68BZwF+psvgBI4jMpa3tkk
         bvuIGIeGvOG2puIc7eJMjuSENfWZPmwaXwrufCDPEw7DWARmGw5nul7IFeVqUZ95VzaI
         dly4Uv3PiLOqlnMYaSBy02WwNRd5ab3CpCQiyCC9XCCn9AfvDe9CuBfkVhMv4TMVGOlq
         pk3n5EPID2ipOoAya3E0249bJhFVEG1ky0mAwDDKQgv5LI8hfCmi5750UdMlYmKG0qAP
         EAdGvRMGsIxzNCrEXJ8vXYOSLoopVScZPoSAOrRyGZADrtiK9uLMz2/U5f76OVrurn6C
         GkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218706; x=1784823506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=N57+5kac9ormLFLSHdSOaHRpxGw7egDoyW77oyKlAknfqOLPs4lzpXmfm4QIt1fdF0
         lpz4XtJu8vcVvVCcwhsvSkvREaS1deRcGZx3PCJJLJAxNvaEmF4rFJQS7HrA2c5EZLVe
         niO0DWDAfFO3WPwDoohAPNYqDILSColF51W68cq2QIYZPeZpaNHLtjUvgr7+c/5or0kF
         Z+7zgpvuo2ncWdMpPk2rBpZP6MMBgRsoFTdXVSg015ZkWyR5itThm1JDsqUULGI7ejm2
         X0i58ZGBz/O6rODv41GW3r4+Xgb7q63QBacs6iEnubk5tvQnbAJkOYq0Ulabzq8ghuH+
         kYgg==
X-Forwarded-Encrypted: i=1; AHgh+RqvKAerCuJ1WFzWqD0dNBqYPQdhJcWqjCmVMnvHRhMrb28TwMxP8RgxX4kHcX0mf3m0XI4qXR6LTml4zfLpsKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgEb0e/gI13IeuK85z6sgj8XjZ3j8xk97q5r/6APAm8i5PY42
	c+RhBlQOq+AWWyWSM9Zo7rYdeTp19HCBbrW0ASHusrq8CljWknGDeMSHQIzpUnVb5VaIqmdSjC3
	R7PMo8mAT6BhL+qLnQ3+/PYG8SVS/+/RFhffrRcb15HtQwk0yA08ZC176v/NfnKTQTHK0T4I=
X-Gm-Gg: AfdE7cnNPRZ4NWesJ2zkcKP/1b5vIU0QTqsfbUYLmxWYgkXp6scViG//f8ih/vBovPi
	4Xga74gayYxs6R+7tWILSvJCOv2YVopZ6cx1nYfnPjYTzsaqh/5J8ksGl/9n7r4NTwDSAN4M0KT
	LvsaFLqnuCG2CEzURMXU2qelhc/8PmrFZfyloaTJ8cSFOAfX0P8Gjk6xl4Pj3KN+RrrP468mqB0
	0avgAc/YEf1y76sMVg2xHbCLeJmgkO16dZ4dsaMs69GNzQfO/DEqR8MAUQPLaaP6cQzJg6uGbjB
	BcsJ40W/2ufeI2JOcnaFNEK1i4mAxNpHID/GlAiuTpwC9wAFPgihSuBJCZbUj8qONDxhzUrsmgA
	toJSTinGfZtns/7ZyKPHJfaf44P+xdKT97YgGxZhxx7OvHwHGEPcmEVwkaeYmC/PdcurnpZheuZ
	IAvop40oHeaT+HTff/k1T2mBMRmb0bcItcda/UO0eadg04ZxKOrRc=
X-Received: by 2002:a05:622a:a888:b0:51c:43d8:8604 with SMTP id d75a77b69052e-51e42453df2mr108398121cf.51.1784218705497;
        Thu, 16 Jul 2026 09:18:25 -0700 (PDT)
X-Received: by 2002:a05:622a:a888:b0:51c:43d8:8604 with SMTP id d75a77b69052e-51e42453df2mr108397371cf.51.1784218704675;
        Thu, 16 Jul 2026 09:18:24 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:18 +0200
Subject: [PATCH v4 01/11] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-1-9b02e6f549d7@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=KPRqylFo c=1 sm=1 tr=0 ts=6a590453 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX9AUfCSARVZcU
 PAX6cVy/3/3g4mqVARLQ1WuiuwuUh2TEV55D5r7OrlhIWwae5wyc3K8vY+g2suNJNG27esy9wd2
 f4ANTuvqXB2bsGdNUJXX75etJp3a2sD8s2+lknrhreP7/bspKxDU+Y3K0pSczg7CbdndpKch3PJ
 +WZ7h5NEwiInYb8hu+UFcQq3e9BOanSHNkkspB5scpH/f8ZDNzoKMVONAB/AWgQo3babPQ3t5Tf
 QBOwT+t/UQUhjKEMG+yB7x3/L+8Oa99kHFPJezQauMSE/NwkvLSlRu8F2A+NzTkLAoDdUM1NR4d
 YaJW2DNdsJspPXr9+73kJoSt9BICZQq8q48MPKdSrmRgMA0AKWRviEmoYkV7rLp9Mlbw9jY6rWU
 01bxS9KTW1KGjvzHQxON+IBbNQpJCH/4PX05FmZ/WdlemcjC6JHoHvwZGYe6qelGlytnszkQDMc
 l7yO3DsMR1oQbk20ShA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfXwgCfbHl/40oN
 1fMKjHtOZwd1mdPhgVHGd0NiLCmGvQMofG4tFdGgOPoIqoXApk7xSK/H8Li7q27WulEisVJ3ld8
 XXXguXkagBQBPFVfYd8MYprMZosPC7k=
X-Proofpoint-GUID: 4zFs86OoBMAM8mH-77HtKECtmjNcT4B5
X-Proofpoint-ORIG-GUID: 4zFs86OoBMAM8mH-77HtKECtmjNcT4B5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160166

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2444471956197bae62a1c4c3a776c5591780ec02..135c79e696aefe2b37ee7a7a668715360a1e2d75 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -26,6 +26,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2445,6 +2446,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+		/*
+		 * OF graph link is only present for BT devices attached through
+		 * the M.2 Key E connector.
+		 */
+		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								   "uart");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+			break;
+		}
+
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the

-- 
2.34.1

