Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199F3CC32E
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534664; cv=none; b=PxpbzFgQRet4e8X8C8xOxc8FuiklRn6pnuGLZ9nx9msgvJaJoI03WJstH7gVDqV/hVqZV/706QVMv836rnzRWbOMXeysgDLLUf7DuMVDmR3Kt4C3ylaJWhloxTBUv4w4AafJx+TMc3v9z8kjJlXX69wSK/MpBHm4mROMMJyH7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534664; c=relaxed/simple;
	bh=sBKai7E3Yd6U51Yiq12cr94RwHoduXZSxDW+t2dOViM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5myPoNN4r3G5WoqCM7K5Zn2Jl2blSfYeJOpW1hUxFPQQj6GE462Pj/3YscpWVPFdfdMYPqp7GO/kd3sbtC6p68w7Gmu/D8WQNeuQ6xXjL8ko6ulmT0mh7DcfBWTxm9wGgZkawn0/HHOz8XTvs2km34KmvrGuBiBNK13DPBfHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAdJsA0f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XqoVZd71; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAdJsA0f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XqoVZd71"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K76v5Y1896141
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=; b=SAdJsA0fXMRisTX8
	gVuhsMg2w0YDyNaqQFdxPmzW1jq66viAnkO93uoPrM0Y8UTQ09WR9bub79dYGoLh
	XLitIgyuQcKQQIgpWiYZGJ9b1g8uXShmvNu0wE9YWD7eDRExrLqhY8YoVoM3UP7b
	xgZbzWJE4vuvOEJ9OkbPPrk2WqJXfMVBU4cRFCID2DgIdSr/MtHQ3XdyqztecKCh
	9JIr1nW/2IceKShX8NAMj5JAZ7C+5yUiRTcWK41qSs0M1g0xK77ErlbNOOd/+pPs
	Vh/yNKINmNUkituC0alpfbvkP8ikq9KnwIyOgtOXhGdHy9wNz9u1EF/zHst6nLtt
	lXQUDQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0kr73n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 08:04:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1c7f135bso135217051cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534659; x=1785139459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=;
        b=XqoVZd71deCAMJlT4cnAVgd2FabGJv/Yx3oo7cDqR82VavkfqkUjRnghXTiu5n1eHx
         F9UePf5kDwgzAKViZRn9Q4nt1SJD3nojwLwC+iD3tWla7RsSRhPewMli2RJp7EAqBsIw
         hW5AhtRnBl9C1+kdKPG3PG6hZwOUhKpsS6jAJFU6AeG0BOSWxk2txQt7ixxOdORF2FXC
         BLTgT4SeLakWdIrWQYXHlNG7r4CCPm1ReXZFhXkXzZ4XqSl950Cxtuex+Oaphmycq7y6
         vEDf5eVcMeo2iM60IM28WCQN6gHt8GLRLVa86tmLIGqlPfdnokenyh5TmIdOMpdFJ9Ip
         9TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534659; x=1785139459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=;
        b=fhZBSSPX3qwc7/b4ACyEKovmCdaxeVMKs3qtd4QAtdh//HtEjHrhQZuWF5JeeVQyY8
         O0QQyfi4c1reI0pDIh7FNh79cVTIHIgYC31QK8NuHfG340BU82GKBxmTgQlJ0/XuPatw
         tyjA+p/W+vzp2zJlFs9r/Bs8RNqtdLCYRpdyun/6oMVoVFHjcBT2Z/0vtGXz+Cg9tDuG
         NGxpaCoJmHeWSix0FPNFZ9k0dxQt59vlz9+yBFqZujNJ01sVnQxKBOKgffCx7WNBUKrg
         iptSQyRLYcuBw0xdjlo46fwHXl8wMj2pxS4Zn4dxUqSXgMGPtL3E8WF8pulo0gWCOPlZ
         gk4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpVqUuHzS/GcoyfOMs4NXRNsq7o0wia6HCczF0sgyCj0vL5WUuh96nhaY3XoZpCcVJ9UVESNInGei/URJ5BLE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkQlHn7vJCKz67tt3yzJ4beREzLOkyYA0PrtrKSuMZKRbsX2+
	mCzmiI8A3xvdlIcjeFYAlKK1M/Jn0pfVOtHh1WYdA6NMz6YL5LM6X0UAreaPI8DY3IoDGY+n2X3
	X9QbLqCVusaPbjSAdb5rxsUmvBJfwACAAb0kH6zvvPYLfkxHOm8V4N2Aju3vQd10ZjWux91Y=
X-Gm-Gg: AfdE7ckYDq06TcTIJVwzNNMOt4jrNR6B1zf7zW9Zbv4ntZ0a+u7f/gf7PKPs87c/6Iv
	np8LeCl7gP1W9b0wBHT1JZiCP27DDtdWsgPlXgoChzckjIopQfFxNgbvwqQAfRpiuhj/MfNrXo4
	OcVQx9RPsLpt6MGzG59W3wDkjNtHBQ+ux9BW+yWqNUkD/FfAHxfdTn7hB2q94+ecWjBZAKMEs9H
	CVcoT4JrVz8aOc0uDFMdx/0v0EmKxpMWZPIduNCk9Bqbik9jSJEt8dFAS1fYc9m7L5kvN2J/0Pp
	uWmLDvu2mPfCsA3C/UwfX/3oe2T25UdHvXgn9domHmZTvi/Mswhf4/V2HCCjm76+tNtB+Fbyzoa
	DfGm/QziUn3wIYEOqwk7CtAxKvdEXaqDDSObuaj0WenC2NnOgWZAN8Fw0Ivojtq5/hU+MwP+eck
	uk3iIwuch7wDOWmcL7SyJdHUXqy6WOhkkNE+8rm8Yrtwx116R3grs=
X-Received: by 2002:a05:622a:302:b0:51c:7b12:120b with SMTP id d75a77b69052e-5213ff50014mr113828001cf.73.1784534659405;
        Mon, 20 Jul 2026 01:04:19 -0700 (PDT)
X-Received: by 2002:a05:622a:302:b0:51c:7b12:120b with SMTP id d75a77b69052e-5213ff50014mr113827921cf.73.1784534658991;
        Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:08 +0200
Subject: [PATCH v5 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-6-69ec6743543c@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: fbZ90kQrYd2_7eh962tTGPnTpntD7bHE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4NyBTYWx0ZWRfX7B7B1SkBhlgY
 xyQg5+cZyCbLst4mRobTHRujAr+/vhm5gP1EtZivJoMmih0Fy5tuoUO55UJT4KzZhq34W4atDxl
 njuwMNNhouTv44DPc9Ggn/oeEJKM5Qk=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5dd684 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=kStU6zbECEpzgAoP-VAA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4NyBTYWx0ZWRfX8zMNriLrmHUP
 tzA7DWsXf79tbIkeq6P9nsCEYJYVPVTyaZ6B5u23V1x6DOkTgXDdDI8HNk071Jl9PvnQMtzAH5n
 z8Id8DXVSDcUVVXefi9vceQ5an5uYUMdj7q0oqqbqkrrJJXjjwOrHlqzLRoxvXBTjq+XArwFBeT
 vmUSm47lHiDDjJ1kHLcIDRDiO+aKxm6GieTzuxxMi1OxlxASB063PCSPwr7ueECjSugOeeON4uL
 pGWk31xFaFceMb53aPCLzAZjAyeQTYoy52KGc3bGtT975Je/+uE14opiwP6ADCupw0EANp02wVJ
 JWYe1dWKa6QG3sUiSQwDVxVuQ8E4JPXBdLmoR4JusYn0Z1qUlr6DUVZ3QYDIqNAYcKenn4wJlOR
 X6lT4Et3NZNvA7KkQ3/VinRYM7HY61WT23KkUq7HeFBFpuqVxChvr4I4G6r6cQGFPcJqMMRSpxw
 ytsDKNqxWQGII7QL4OA==
X-Proofpoint-GUID: fbZ90kQrYd2_7eh962tTGPnTpntD7bHE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200087

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_is_controllable() helper whenever the BT power
comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
If the power is not controllable, clear 'bt_en_available' so that
HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 17f436484e1e74d1dd690ada22134315abb767c4..81fa41915363ce577ad7c6f25fe1b0a69536d462 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2548,7 +2548,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 * The descriptor itself is still released by devres,
+			 * so dropping the handle here is not a leak.
+			 */
+			pwrseq_power_on(qcadev->bt_power->pwrseq);
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1

