Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D39B3FC5A8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677457; cv=none; b=Lhog4wuwdnc5JG+Yu59HPm+aY6wpABEuPF7X469RL9o7VmvqglA5TXmAxHqHu6UHEOiW0Tm0h64Qz+2ZJL+i8yJjsmApTHK0zoqNjFZyucIesIS6S5HUj1lhlXhLT36wM5bpnjc6Sw1r1ov8Rk0gfceZBNfUBOZCqtVFvq6D2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677457; c=relaxed/simple;
	bh=KEpaGYLJg/HFUQ4VCnAAAa4/K+FU5Ww1paHM4mUD9UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+9Nb6GyD/lrriZy4+Od3dGSAxB7jpJTKxdAziT8d28GDNElmchR38aIvh+ZkZjSbx5hlaaI6hU6+RKrD82dc7Qn2BMRsv807tMVbNAY8sY+bonQsPezHmal2+1AoeY6J61Jc77vSucXv4sngEcdHDHF1cKjUYuYvSP4fi0t4gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imSWQRTa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PyUzAL8E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imSWQRTa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PyUzAL8E"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dsT5188298
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=; b=imSWQRTawQRpzQNc
	mwknADJeEsLPlR3YFJePXgE+g2CgMtH6PhCsxzYu6wd7US5Nx69vYJpoMoZIt7uZ
	ydQPQQXaH/36mm5o6bTGsw8RUMelB+QtP0+646R8Ysv/anT/JPfsEa0737vDafR/
	syB4JF2ODhttzmyxQ3Di+cAOryTXkiWl9jzHpF5QjWvMjYq8d18bipucQBiO4QXq
	0/z8fwx0WM/zO2yfbM64iDJba7CvX7wwnV1nt2CO7N6/4YaKABMuRBFTcfCWv6GR
	3v2NzycAq7TJgQrJlyycdYS46QCtw9/euhWSr4U6z2bMuYovgX8AoTDMyNXYr6LY
	lNmHiw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesuvrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bf321d786so8193431cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677454; x=1784282254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=PyUzAL8EIpQpen8yYLJsDoF02JJal50kHQNDPB2OcRPVu05MZE7R9bztwGQBeONOxc
         csbL2jAtLCSZInY1AxxdxfPDBd3SOQxp+qFtG2SU9oz5xPK7Yv+aehkvGTdbdbF919ka
         FEjRcHkNe6tnLvxP2XGKf7x0bz8+haiHUyTOsjJ/UsW46ByTS5OMf69J6SeRric8AziM
         rO0MO1Yspkxgdx7M6qEIUKyJJxcoKGA+7ifO8HSWmdNxE1H6ZhPmHL3NlNLUIqo1koxD
         6KNqEE/wdiRhGE9QD7yI0UzLiCQiQlmrYN0bTKO2p9xkkGgSop81JWwbMSqTzfFjrexC
         dp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677454; x=1784282254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=Wvn5yQYNVL9FA1nRQlqSYkrSkfBFfULiXy1TvD8HxAOeSa8iJ1zVqkXJ5ICtyojLMd
         v5o0pxht/05Qo23wp4sXkr4v44TtDOWyDyGc4+VIkOwKw+kVb35mVX3FomcNT0CZ+Rk2
         etzShyQkoTA/vDPQBfW4TTFab0Cp4hr5EDsmYpsiAVoDzqFHbEWDri9vhmbiWeS+jnxw
         KtVEXrcm7RLmpmSGa/xTXouE0wzq3kNzzNdNGHBDPhasGyvosHz06DTHR8GdDdSen7GD
         nPrfdja8dW/DRkAZp7loZoJ9UhX6C95Hhqb6hXLG54gp/GCDLUZPwVhvKh0h9xoyeqG1
         Ig8w==
X-Forwarded-Encrypted: i=1; AHgh+RrErIg+f+7TFKQybBqPJ+92snua82/OPPuHnJi0yRGutdkK6a7L/ZNijFC2IzqcB0U/8Bd+hzVjujSujs+PaCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCMeM2QlxSAX4attkH+bIIWRTQPcJQlOrINOnLLtHXF7BbsLY
	wF5kZdgU/i6S4DtLnyXjFS3plGmrl8KpRUgtMdp/tSeh4favPaFLe6WRT0M6nW+43Ej6leEMbKJ
	kFNBhcDQo9ofP2cN1oAYyWitGLJ0ieB1PFEnnijKpjst7KrnnGwpD6ZkES4pMKHvxxW8raI0=
X-Gm-Gg: AfdE7cmzV97tcI3njJ8g4+ZitrOefuMFl9SmI7VRfzi4T1tPOjrT34lQ7PMnb259Zhb
	lyGP26TQ0SSSkOjJoxzLBZmZwh1uHF9LhjjNWobLuQvj1NqAY4wZ3X2X++UCnA9dbBdqwltbo0W
	cvWK/gMPOO+WhI+NccdQgDvmly99SXr0w8TGw9O4IOQgd1bq2wfUXN8JFoTOCOr4Rq1mK7ZYq5v
	oiGLvPa5WMFN2vybacQ8Y/BD1gCSSD5bU2D1Q0Skqz1t7y8h+T8LVXSoNobMGEE3pDGIBBWoU4s
	OOGP6Rfpz13+uuBqwNaM8fy8EjHOz9aclAupShhiNJQNg4Qmzov+mGYOaabM8bMmyT+e7j0l0x+
	VY8zXu7cYLrWzbMo5YucxR7nFbganiAxqzEtNKySytetrhIv8RxNy17kh0TmufJ5xWEbakpr30Y
	eaMMD38IprmyQ9lHERkHBxz71kOAOgI2cHEpHdowIzNvph7JtPdCC02BvAXBpF455pgGq597jfR
	z3TApTlDfU5YgALacxA
X-Received: by 2002:a05:622a:114e:b0:517:6435:c4ce with SMTP id d75a77b69052e-51c8b3e2e3dmr114665221cf.49.1783677453745;
        Fri, 10 Jul 2026 02:57:33 -0700 (PDT)
X-Received: by 2002:a05:622a:114e:b0:517:6435:c4ce with SMTP id d75a77b69052e-51c8b3e2e3dmr114664921cf.49.1783677453240;
        Fri, 10 Jul 2026 02:57:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:27 +0200
Subject: [PATCH v3 01/11] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-1-46253587af64@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: JxCJz7o3UwWVQiV-797zG6oW4BS_7_0Y
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a50c20e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfXySYrwTfVJFYz
 5hkN8KQ2wytZkql0hIy7fQec1iESSG9JNXKO2mO6+NCG1E8W2APdWaZA4WqXbJlMcq5fFZqeDz5
 GFfqb08JKfyrS/LGoxqTkwV9fDdBMsk=
X-Proofpoint-ORIG-GUID: JxCJz7o3UwWVQiV-797zG6oW4BS_7_0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX80XC5rIo/Whr
 SRHYLhQLIKVDghrhJ77rAKQrYREbTyc2myq/tg30pPFa0TSmxudxgwLH6A3gZuv8fD/Vnble8jr
 Zab/+KqFMnhPS1trItDkLprMLJDhiCC327lVzmJj1maPHFit2mxg9lq9SEQw24jEmYxMG6tQNIX
 J0OLOh9FKRgjpJ6P97HW7FVAy6Z4QZJXsYI33/biEcXw/lMcimsXdWcmssUxxLjnzwOftqNbDTp
 6PjlX6uAu05bT1SGIKxeVT/eoVYq2xmzzRRoDRZg7liRUpmdosIFrKQ+086KsF+fTi2h9IICm2X
 NdGHOIEPy4b7+Q5G2mRFyVmuYoQ1bnHlbkEZ8X97IM0TYavrZLvXYFnhwo1NuNyzTlgQ4yHQ5HT
 0uj9IeS2ihkVZH+HFfQEBJ19x7y5mU1RZo8QrlQzi2oCbm4Wvk+0bgz55wLpJZpGOJoInvQpGQ5
 th9CARoz/e3ajaUFtGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

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

