Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868F37EFE2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218725; cv=none; b=LIhJgBT7teUx/Dw3lATB8gqVyBFqD/Ge62Uz6gzpbMa+XbgHLB+muO3nxUuXO9AAaStreb/dkVjhg+5naj2fWhqQXCugNIb6ZrpIOui2TWyErfyWm08hRdBDrGFR/8aKTlwbmBpnvCKnZRuGHUJqGc/9LwjcakEsirj/wEJC0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218725; c=relaxed/simple;
	bh=USfleaUVsPGQXLVUjbre3lqCswipT+fDSdHAw6xnKWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEHBEyrJK2l03bC4T8/1Oz+iIPA25O2x+h5Ki9K3NIz7lfCr5AfTaJgMD073F7Hhjs2ViMWdfHaU/B1P3zwyx3IogzXnOibNDjgg/bLAfpUsC19uzBoi4n/XdoxDbx6U7qb+KSv/bPBDRG30HeYQrKOZ8+qH6V1gV5O7lA8Yoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eF7HNDpK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YC+lqfyR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eF7HNDpK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YC+lqfyR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJuif2735070
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=; b=eF7HNDpKPmRuaZx8
	4/5SO3m/WN8rIxWyJyqRFTfL9lRHETXR3kVhlb8C5ztZX8WFv2SBm/TlzxayYyYZ
	TlfMWnXUpU3HZrgPVsdvRLFQUwkU1xFcdnGbXvP/SfM8ZVAolffTKbtAdcpEvNdQ
	vugk7lwawDpVEjYSSZlZhk4vb0OwXs91STcWn/L1NlrFLDUJI3clQdfeQB8rdj1q
	iSQcFURn8OKp8qPFzVBS9JLjcQiefrQttOxtBpoObeSrOZcjYqEuelyiFNZq+AWH
	QY5OmoHodAV6VF3CnnsqjILym/2UpvhfnReqpJjgSPyUnAxp7+4Hi79vSAiS9XSL
	NHhXUQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv1ug3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 16:18:36 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f1e4e0eac1so89775736d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218715; x=1784823515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=;
        b=YC+lqfyRPr+1/ocKvubWH+dlHQnxyk8QyXOFmYpNZQsYLlrMjFl4GEqEYHOaw8HLRj
         Is6v3g1u25bRb2iin5Iy10VpA53F68i2ydF0GA8PNBJDujE6o0YkyKgavciTj2bCH5Vm
         GYARibBAYW5EIFx7GwuGQ2tWOeEY1CGhwqcxvRwAfWarGtkOq9hnmt4QBQSM3ZUgVIt6
         jKF7YT/D8GPyTZEDLjcszL/bM497C46ypNu+V1wE5M4jD2Vs0JBTSI8DJC9zBs+28Fqr
         qtPZ8m4Xe3NhesWFANhyQtyoKwY4gKtmkD7CCf36KVhFudWK6WeUCw+vvO2k1kj33jK1
         7Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218715; x=1784823515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=;
        b=qEV4F6u69Fvf9ClWq5lufvj5FgsVo5DHRX6A8d0/WWTd0eVotoZn21wqrmJCvxhfrz
         Tk3M4JH2VoeFbTY7wCK5ZoT938xAI151Aw5GSb09re07NIxHX7osJAKbdY9anuJkdO2U
         PbmWbp6WOnrlPgfMioS6sPZktzUZVorqDcAkQyjn5rOuloqlLD5fRMgDf1hEm1ipHqbQ
         xW8zxIxT+cacuwXTS2ZWWcUVDap2B1rlhAglzzs7aD+cgEcapwVB9iramfg8Qovm5tdN
         GrkTEhj+aJWLtU1oF4jWLwP06lj85GVop+yA0PCAAH2qXvBiPLh1h/UeBOS/2kdzdSIj
         cm/g==
X-Forwarded-Encrypted: i=1; AHgh+RrRqiCUFLSiM2RtoGmRkupOC3YDime+P+dZctC62thJ3MDSPapvwmEQXq7wXGH6ebcrcJCuTDF2FPY085MEeWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWbbyjAqnAZXD1ouZaxmmU46wdQ2gDdvbmDptlKJUi725igjT
	N1fk9bS1feOLmb3bs/MTBNOigEmqlR0ZG2kUJLrjkSW2RxTJtrigJ/lhl5CTueCv9Gj72YrqSYm
	khjGE2birJzgg5HhA3n8+USkSid8fdKmrLnjCOj2ZGBNAV312BNGrtu6DKz5re3nRjAQ01AU=
X-Gm-Gg: AfdE7cnfT3YAQz+KULkbXdWqnBQ5uU//6xgSFWa1o4Z4tezd+ryEq3vknpU8aeAeauU
	nswLwz0nYLGdtwjcIAdZQmW23GOsMAdDMU41L+aSAyePd/XhfcGMBW5hYia3BjI4gMjPBMzBwfJ
	FlKOoThqvBTMgYxPiCUTxOr2bar1lEE8OuySUiJBok5AmQbgIeUEGEDD/wyqRVdj4mC3dz5Aish
	v51tQ8RUv3g8a2tMRPg8D9tJ8WD0Ju8mDRUKJVoA49Aq+nYf/82//AsyhyxU90R2UmiwhXS2PqU
	wba0QEm/ok/2sx1JsUuVOEY/ng4ITwrKRInLVKbSefRBXSbgM+SL0/23c0InMsQfGA3DSG+GCvc
	LxmTVkrL6IzL7fGN9zxzj5e9zXt1aGtxvs0/YhLkhWH/AEGy/TAx861ov8YZ2UfVX6BiMu/zQnm
	/9KhZyytG8voqv0NHH+a6MxVhFqSagIeKd5d6EGdJ82pz7TwTqd2Y=
X-Received: by 2002:a05:622a:190c:b0:51b:fde4:cd4f with SMTP id d75a77b69052e-51e4237cd7bmr114630451cf.30.1784218714761;
        Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
X-Received: by 2002:a05:622a:190c:b0:51b:fde4:cd4f with SMTP id d75a77b69052e-51e4237cd7bmr114630181cf.30.1784218714223;
        Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:23 +0200
Subject: [PATCH v4 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-6-9b02e6f549d7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX8Cf5v4R7Mpa1
 Fa3J4fRhnFq7h80RjSMMs98jceopXETGgNf1do2ga3Dl7klABbtgzBrz+GRvcFwcoCp98jSc/oo
 rtCLYvefzNfar86GFx22QyC25IKVvLNT7uAicOcOysJ29ToE/Xgi7j88eJuv49e001DskotHpPg
 SHETERW6OF9+FcmvNAv4DYPBHZ6Nmt8PgQkIQahbgAF5PETZa3RceO9DEWJP6kRQyqdtVZlc7j7
 q0T+XFnEXV/UUwDvcashDOJFJ3n/rAEaaG//FnI2125E8PcqGgB5fWUmmX0vt+hLuaoA4tLEjpd
 DxkFN6rFWrqVuCmAbgQx3zARmT5tpYrbneqT1jxMqwt1nDfQOqmatBpnLLguVb5LWBDofX7i9Uw
 JdRu5drRIxvxOB9XDCEtQ3Y4uzrt+4tGR7/CCSKn0FsBGwjFXfTgtoYQCfELQMzbHxhWyy/ZY68
 SPh4+UpuU8pKTEQIleg==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a59045c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=kStU6zbECEpzgAoP-VAA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 2ghlbMFHnEZ1ClKrhroovLe1FVNMbvJq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX19+dd/icQAzb
 X0kC9embsUkvHVNXy2FWdu2XLJIAht3UsjtNU8MixbnFPIc18Lgv6EGZeCusIvAK8TT4XV4AAdC
 Lik2ENREsQVxY7dEksCyGPsula5A8Xk=
X-Proofpoint-ORIG-GUID: 2ghlbMFHnEZ1ClKrhroovLe1FVNMbvJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

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
 drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 17f436484e1e74d1dd690ada22134315abb767c4..41e8c302abc2a820022d1783f1fad76b358ae67c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2548,7 +2548,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

