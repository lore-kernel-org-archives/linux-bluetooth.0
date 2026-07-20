Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A43D2FE6
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534671; cv=none; b=Okf58A7/FtZ5k9XYlZJR7DvahvkEp3xsAARY8fdvOVV8EeMVJMKIrYNiYuZmBW/lXzjizelX6u9g0YClkMNr6/ayNxmYPdUXv41pe9FRpIue/syAwMzLqmlLSHCFMxy/dfceTR+MLqiEQEORTMEz0FhBLVMF8LrYGb9d4s4na4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534671; c=relaxed/simple;
	bh=Zf1cAa5b0bNP3c/K70OfmcZ/HBkFtBvo/OVNOd6Dz4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9+2h6ezCIsB9BcT/WOGJHoRha328h1oM5vvl8cXbT7T+Nwk6SwRF6yxJs9kMRvcfeLcWZMCHbssx4rFD+2JHe/xIb4TNJAyoXIWb7NAD174GPiX+UPciF+Kq4ou2AEemMpLPGITWEA9M2xi31FkAYmu4Bcl0ITUMCNtuiTA6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCaHag1j; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RtWqlTRN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCaHag1j";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RtWqlTRN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RY6A1420324
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=; b=VCaHag1jvVXQ2BOH
	uwzG4mXIJwSoR2dCt1iFW90dEHbfRejWBmRx91BcorV3V6Lzdj2MXQWZ3004v4mM
	sWwUu9BVSJiRGAs91ItKhGYM46qxuy+oolDkqiwnBVP9tdkl1XlXu20ywic/CU/3
	zdreB3C6EEHTkFQIO8u62CUeYfmZW8VSsgme0yXTKLmkgGVtDQORxZ89DIl1YbbF
	1x+8gTjhlhlUvBih5DD3hGiZM0eYKHHzZjGPhi8XPvEHxCQm74lAhcltqvUPSRbR
	U4ce2CgkNFPsb9E9oi/zebGnahunvDEaepT2DnIPSKcslhcW65EuVOlxfV26Yyuh
	F/TE2A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7w1bg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bff5c7035so85402831cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 01:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534668; x=1785139468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=;
        b=RtWqlTRN1Y9Lejq8UtOzJrNhqa+5/th1Bb+FuxE2GVRwyyfyZDFLUtbNgbyCi3hG2D
         G6gOpm2x+ZDk4pf8h/JBTCn7t74E28XPmWSt3vAZIBEPNRLgSAU9lTt/xYn44ytE9ZYz
         8oYp9tjo2nph+9yw0OOR6gJdDvP5idG/OaPUXKoYtb4vWYYlQjf1I5yQw58iwkT5qbSD
         yd6F11yuB2xkmJGMhLfB4cUOp68QOuwv7iNZG6KtZVuXQFOWkc77SrJvhI26t6se4l4V
         pNUBLdwYPoEFLqv3nTEVR/rzz2BRnxrD+H4/bB2reEz4I0GpRqkb0gnTZwCmDGBwvnVR
         4DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534668; x=1785139468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=;
        b=HXwBbfPUSt6cSaJeDkGrMdr3NDmHRtdSQkzS5zgPZWCKF1VtP1Rc7ekXabdzI1jvOw
         lhozOSRsjx8FBrPvUmvPn+6RTh83AzYJw8oghh6xksIlfGkWk6d+DslwjU16wVki8uSw
         O+C0yOZKGyQ571IMKTNCEVFR/reKpr0TlHmTGsahOj2qpdIAu+apFeUQVKCHxjtvfvlA
         4oFYJ5NbGgu+4yQAr+WpBPmmXJJINYm57DrTo0phNzF/+JxPL9TWKCbTYLvH+se8hDCO
         QcoVDbsUDgzu62Q9hMhFxeCk/IG7Ie18m3bqiQPklkqrTz1t+g/soeZvafYIiT6f3DMz
         Pssg==
X-Forwarded-Encrypted: i=1; AHgh+RreR27r3NVP42HlZxXqae19u967xidiK5GSItrTzkPqW5EV3pHGRr0rbpolS2cT37xGmkWocYcivuE/VExIKys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/H2QEDkR8hG+t6qVjtZwhxoeQLoICXwgtxTI4G2crYA9zhNv8
	ScxUwg7znRxGYevud7kPgqz7OgRBibIPdCzlWW0u1glWzKKx6lX/nKtvtsccJKKHc+/9/uwq4LZ
	2sQbEPCUd/Szd57IV9WGizR5qM3XykX0+wdkoYaC0Ou5zyob4XHLARJuGSWSlxaeqgwzLWr8=
X-Gm-Gg: AfdE7cmPfKjnFNLXVWP6bIWMdrAZPotyrkinS6oGL8ayOco/Y6/KRpvADmNl8TC1ZOt
	OjOpT4iwhkUqh+dYjS7IZhkQB9Cvoe00UvhPhA7KoJc4iMiw2RstpWtelHt4nF7Buzt8cgHS6y5
	ipycYfSvfbRQx/35FJYi3bUKlad0q/N9q2AEVp+MNuUL8zWsuab2wBHioQqX9MJPv+TUG+8AyhU
	ig/zccQOMtuEBJDGJmBd/6DIIwyZXsFwnUnwSQMtVee2pTZjqFGlR83hqSzCPSVGnYZ1GbQLG9N
	4K2kJBROu1mJA4fvGPtkjVxGjNPeu+mpbNP00/PRd1fmMJJ8yzJ4+Do52/FXkmQr3EQDRc8QnE+
	CG33S0eUuE93gM4YljgrWCnLGbyG+/tQGgzAmiwF2wHglSq3QRcBuXvvBeaB9p1TM2f/dr2VBMg
	qdFXEVF6fZzBvutsOPG9bugSxmqmz9fck1e5Bn102mErJeuq2k6e4=
X-Received: by 2002:ac8:7c42:0:b0:51a:6feb:dc8a with SMTP id d75a77b69052e-5213a384365mr116966571cf.18.1784534667898;
        Mon, 20 Jul 2026 01:04:27 -0700 (PDT)
X-Received: by 2002:ac8:7c42:0:b0:51a:6feb:dc8a with SMTP id d75a77b69052e-5213a384365mr116966311cf.18.1784534667416;
        Mon, 20 Jul 2026 01:04:27 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:26 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:12 +0200
Subject: [PATCH v5 10/11] power: sequencing: pcie-m2: Add QCA2066
 (QCNFA765) BT serdev ID
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-10-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXxIq/IZpv9+qr
 B/czwDURZRzG2MsNdLFZNbtK1lVYGN7J4lppUUQTSa4juUpNpRwKGizWYj48Lg+PPAHT+5HFSQU
 h0aTFwdh4DC0yxHRlISMx+KFo0uQRNnXUy0+3AxgSZ2ba411C5hbKS26zmhWKm/139rcEiGbK4j
 nOLsRzQFSYl2QTdDWX1IZ4lqwsSHwTgW5aqeSYPzVWENhhDBAMB2XFOBAp75mddYMRuzuTZvE0B
 xh49q9QlEtUufN7/aWIgJqdkwUWIgtnVZJ5zvAtpFTY6NcaMynQFIwuZKppcCz0tSAq6bk/7BOe
 Z+gx+A/mTrZXn6oDHGBNFpHa+9oBeos86j10cRUY/poEP5//Ic8uCeKrN9C8Pwp0sOW12xeZ9CO
 25dj3plM1E4tKWAwmnxZUAXGkFiQOfkbO6JtUKCdPQDToImstjyB+BjVZLbh/7WkFW+o73uv/3X
 chDAppt0lQf5ZJPMJqw==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5dd68c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hhiJJhbhXc7jC-Wm4KYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: ge5GHGhc9bjhnSzpOPmVhQMTEbpUxgwi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX4YUaV2HD8nLd
 Kt0YM8xIIU/beBB1ABPSVVw5o7VIvzF28C5RpPZLwpcLes492eO57rewL0rzNYsnz4b8wQY/VYw
 ZKZf4nHC+dJrDbVUZ/0x2Pa5EBO5Myg=
X-Proofpoint-GUID: ge5GHGhc9bjhnSzpOPmVhQMTEbpUxgwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200088

Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
mapping it to the qcom,qca2066-bt compatible string.

The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
the WCN6855.

This allows the pwrseq-pcie-m2 driver to automatically create the
Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 8e4cb778e31f66aa171ad9831d4213e17d2e6145..741bf593d1716d55494cae99d4452600555e53b3 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -216,6 +216,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, 0x3003),
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
+	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),

-- 
2.34.1

