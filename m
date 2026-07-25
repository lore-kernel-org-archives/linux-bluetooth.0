Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166B383329
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969698; cv=none; b=E1pwyFEF0J6W6G5irJy+sLtQr4H+K0Ks5CXtebn9tl0lbsJKz/fxahgEGanwx9YmnfhwP8S+/YBJ70HWVpHHaYG95b+mA1l1T18zibZKnF7HEla5XRr6iIg+C792sdPksgqmvmLNNUFWEZaOzHnhiCTJfhR2Ojltr8BStC5WQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969698; c=relaxed/simple;
	bh=Kj5ugJ1eZInHZaFbn92Md+qPPlJdInBfBOXBmblaynE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcc94yqqqCme/6p+fq1YxhG/QEIO8nlWR2p32X3VtQqFe8QrpI+CIkHPH2y9w5B5cA+J78pyiCU3hlMGid5zClr42jDPu2K3QEtrdVsTE8YMJ8KITfxLEDAtb/EGEK2E6ex62FKwQELQSOUr7WFuAy8jHKb/89VQ1UB2MHDXzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pEb1SDyl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=caL3DZcF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pEb1SDyl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="caL3DZcF"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P4loJi1260378
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	16Z3omNga/gMPYQsHadNiSPfd8mJyMGRalN1RzeCCMw=; b=pEb1SDylawFEK1MP
	BmxQB/r65aGFog7uz08pojPQfjRG7BB0IoXWHeS0/CBp1vfXeA8tTrMROqAW3Xj6
	/xLkHTcnNAoQnBc0QRY6jwcvkqshsl8aEo7tx37ih47G6tSXVD17rOhNeohQexvR
	Eo1/UG2VeNnOVvYeZyrpwfeNdAWcIWyaXN05L3g+vkQqTYqr+XZEVNwGUvmLShXp
	fLh+cabXZ0U6QOG9IRQ3nTyg27vCIKn+rV1JdMf+/RvLsUD667gtE7IY4TWpQkXQ
	nWu7pNvikJrOB82CLlB0Qsgvm2bJD+FQ33rAsA/WMTVJ3Z9VMMhPvBq5TU0Fw3tN
	pkl1tA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3s8pff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 08:54:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca0ed258cso4591835ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jul 2026 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784969695; x=1785574495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=16Z3omNga/gMPYQsHadNiSPfd8mJyMGRalN1RzeCCMw=;
        b=caL3DZcF23p0oDc2JBLVZoxiKbdC/y9fMsjN53/wMIb38RXU+7j7ox/loNo4jP3awy
         +CtSfWdiAokmGIoUtAVcODXUyvEGQDlwmoYTeiryb4PXTUyGupUFS135gTtrWoM20Cm0
         2OwLOjPe4fAXxdxSMda1J4DqB+UdEF5iKFitRv9/GVkQDxjNcIJXbu9zEeSqGg7Zrf8Z
         D5243gFAHe1YKPUNr1S+0nqkNwIiRoXp4qkDkc4RSDuid3X3c6Usv/UjBFt3TF1vKaqN
         n2EgxPhCMoiurj88kyZyaFGSFO+YDik1gmiKTukGM0OUCoV/WrB1LhigEAsdWueWpZLD
         K/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784969695; x=1785574495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=16Z3omNga/gMPYQsHadNiSPfd8mJyMGRalN1RzeCCMw=;
        b=j5Pd1lMqZxME6ghoUPA4pVw0NIWEH91AXr13FikVwBDiXlITSlhRuqdaOk5HMVDSmv
         GD/gtEU6gAJuu0PGeuGSeaSWNy3LgFmHCDE0nL83H6cfyS+TvrPpYs9QlmtIcb8uhRfk
         VqTEIip7CFNu7f8N2qAPHa4Aq+s7fBYLB7kojSflQqnFFzgCdGO5S0PVIKjTSuOEB3zS
         YZe2ZBM96CO6L4/+0uGKxjm+ijdgoPAJcAguWvRPGY19cjfA8qMhOd2OZki/2NGe8JhH
         jC6n7Sgm6I8O1bGclTGyiyuyck7QGWz3iKL2h923Ym7tS7wchptSoGLOYdTM69L5cNxB
         t/mA==
X-Forwarded-Encrypted: i=1; AHgh+RplrFhq/QQz8mXmYdC6BHy9HnLMI8+vxE5xhu0aHGILfDXn3ASjTbcm8V/Yg1vkd3OpUK2CJTBJHnGeqcuIj60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlLx5Rr0bhSljazWBOLPJPpXaeWsOGWRJP3/owo15axo8L3ENa
	MqbKgCnVxF77NjZqLe+7TS6OL5Ft0WstJKLSQAFToSofKaOLh8HyKv3zdep3XuiFf4Oi3FLn2RU
	GFQszZCc4AtBBAVJo8WYctOtj63BcHWglaQheHkg/dzDobO60j4qpnX+8mWH6VSKv97b5S6g=
X-Gm-Gg: AR+sD12FNf1iQd5gd6lgsayjPGaOwm+FEbkWjoLrEf27huMg7t9hsW/+YekfuwO56kH
	Iiccw/nVGohG5ybwzUDuk6FpFQ15foxxsouqzPCupxUI3GVRG9hd27xM5vaW0FnWk/iip/iv946
	Z6drX9eg931y1lt5TUW9GFEmcfpRRNIBjmmgKt58r0gd4zQyF6kEKGELiOvwP4iaP8FqNxeHdkX
	PCBqYp/G2DL/YTA7IKCTMdKmqFFkZKx1N/Brc4vQsap5edllwk1Spgg805IZIvDUwcKJGbqW6HJ
	D5ULlqEH5ZIvikW4dsuDGiNcJv+IM7b3OlLfnrlkZxBboCe+7cL4w3DUSdxOXYs6DEOScCw2/ZF
	HfVdV0/hPiQKDiy0T1mMnIk/e8cE2bRiuS2WLJ6wzE/ZgL4A=
X-Received: by 2002:a17:903:1a03:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cfde567b7bmr14045375ad.0.1784969694741;
        Sat, 25 Jul 2026 01:54:54 -0700 (PDT)
X-Received: by 2002:a17:903:1a03:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2cfde567b7bmr14045215ad.0.1784969694355;
        Sat, 25 Jul 2026 01:54:54 -0700 (PDT)
Received: from hu-zijuhu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc419c52sm7823000eec.10.2026.07.25.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 01:54:53 -0700 (PDT)
From: Zijun Hu <zijun.hu@oss.qualcomm.com>
Date: Sat, 25 Jul 2026 01:54:40 -0700
Subject: [PATCH 02/11] Bluetooth: btintel: Validate length before parsing
 diagnostics TLV
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-generic_fix-v1-2-305aec261a19@oss.qualcomm.com>
References: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
In-Reply-To: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Manish Mandlik <mmandlik@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfX5TKCayDdu9it
 Nzu/j1nRE/IcOmhN0OIaxXTXL5KQlG9EykXGPIXJl/DcvxltGxi+QJFmFEkPYVuQGhOa9Le9kZ0
 VvIzLohHN8n4tJLhpeWGexlSm1tV1l4M9lkg2oDeOEvFaoIkwh1VdiC2ipU14olz4bjlhnHaqem
 HeCXQ/ZHYc/d/x5lxtCA55B0Bj2TeG28fYt3MPhx9JdhjlfyW4lEusY0PcpPknkVZSpwPQyTywx
 mUJzygj2o+vJv/f298Cg6xLWK+22kA6XbmAfkOYHp9X0+Ylve4afnoU9UaYYaVexE+MaWpy2db8
 y9ZSKvrJy3ZEDAcvfJBDK/wgtCfQxTepzKhKGU50+habU7VDsGghJQ1p+xNxYBdgUUJVLxjD60x
 0ieZuHw8GB9bdDRfnCHjTYVpLY29yMoT3pZJ6u+izBtOKBuwyyoLNxs92IE/KrT4FbtrgBGP4fN
 UH8wvWNm3DtfkWvJkQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA4MyBTYWx0ZWRfXz5/kGcJDwMGW
 qtMUUCDkyWSR5aLt41mcqS4cj0+lU8DydmHEZ2jbluu4Xx+Ky7OD4WV1LQF3jWQjZSoctt50NIJ
 yTv8xv0u1Z96kggfDepgDiBA+PLwjeM=
X-Proofpoint-ORIG-GUID: pch0k3sf763FnOmK-mvtuqCHjMQ2aIa6
X-Proofpoint-GUID: pch0k3sf763FnOmK-mvtuqCHjMQ2aIa6
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a6479df cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=o-UwCio7QWoOg0g0fS0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250083

btintel_diagnostics() accesses tlv->val[0] without first validating
that the diagnostics VSE is long enough to contain that field, so
may cause reading data beyond the received frame.

Fix by validating the length before access.

Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
 drivers/bluetooth/btintel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d7baf1b9d852..dbcb3f138477 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3766,16 +3766,19 @@ int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_configure_setup);
 
 static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct intel_tlv *tlv = (void *)&skb->data[5];
 
+	if (skb->len < 5 + sizeof(*tlv) + sizeof(tlv->val[0]))
+		goto recv_frame;
+
 	/* The first event is always an event type TLV */
 	if (tlv->type != INTEL_TLV_TYPE_ID)
 		goto recv_frame;
 
 	switch (tlv->val[0]) {
 	case INTEL_TLV_SYSTEM_EXCEPTION:
 	case INTEL_TLV_FATAL_EXCEPTION:
 	case INTEL_TLV_DEBUG_EXCEPTION:

-- 
2.34.1

