Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F553FDBE8
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677471; cv=none; b=F5JX3ADlanFZLglQEV01kTLTdp2SslfJ3J1cr+GQOiSZGYHj4de+6WOgI607/pOb/XG2QedXiAfg+FEDNNZtgvQ0SezihipdEg77+7sJ9HzdTrDyRyfLOQw4wIZTLWrNAPKejwqEKQpbGU5TaI+rWIw8vgQ7R1z5M7BgtTfqr4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677471; c=relaxed/simple;
	bh=drfMTyafP5O0WHcutG+g8kfep1FgBIKDYHEt5UAf2t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZ3PEMt5HLVve4HpPeQFj9ZQI9l0wEuukSI8iS4FQjVkSvTVD7wq4ygg4JPQZdoGJ1RwbB9rMCXayzdpcuHPFXzNMDwwOCK0+VjcavvPTCfzjOzw0a/cbpfsPKFmSmVgYwTnb6fGStKnTa0IwZHULN7gXLijg+YofxT4bfcMBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KUYNNWBB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V+PbbVCi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUYNNWBB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V+PbbVCi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7egBJ092390
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uq3021KNWN1PDY5vGnxhuGlTpLYyxahRYp1yr2wnYV8=; b=KUYNNWBBIu1EkpFH
	sc98aZnmd3FGwpsVb3JlSf8DLXQXYQrd631LN26YnCa2tS9qFqzIglrGQ49aZXec
	+ePnCODA1M9s1OAy/Yevh9PrNTjXVzKKsgqt5jsNo2WN+5XVAOhjjOOzwd7Giid1
	i+JyBrX6FkO5Ny5CyDPVWXDJ1U6m98+DPAy3jnSm9pZzRmpmfIQ4p+OcLV4eZu1G
	+kr0F6r2I5tvcdHANh+7PLbS8o87koqOYUXL0whjbT71XIZD7502ueJcVDkAKwTL
	HreYLWKSAD7eWN8vanlwCRFjQtf40F6kAqCoVLK0b1Y28ekbx7uY6YDo3vs1nARn
	J/0QuA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjc3ur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 09:57:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1b4d961dso7516391cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677463; x=1784282263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uq3021KNWN1PDY5vGnxhuGlTpLYyxahRYp1yr2wnYV8=;
        b=V+PbbVCilWBSNFW45+Wvucm0WozUVfvAebh523qBewdhauoh0JFqCyFZEMZAxEx/RK
         G3Pw6HF5q9NZBKDduCoMPGlr8RDhu7VhsPUf1hXIpw2iAdkMhdaNM1TT1Kk5D39WQ4VR
         58ei8eRLhmJDyFBFRtPdAIciVSOGT4VCM0KoQwM4N7h67nlxqByvG523Qfz+geCjfH71
         L64FN9XqSo5hWTYPrpjmf7S8wn4/J6sFgWtszdOkB4S+592kRpE4ZG1Ina6ljRY+A/PU
         S/o/LtZchV9GrZwLdzLNevT9Vf1r5yaTJWyHwZXL3W5r3zOkDte10rkgnK3vYSinl0Q6
         +p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677463; x=1784282263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uq3021KNWN1PDY5vGnxhuGlTpLYyxahRYp1yr2wnYV8=;
        b=BHjYtPWfFm6dCNT/kofGHHinSLC7TA6pDz2FPfLx7z6XxO5J51waO1zHeeVjalJZN3
         xpdGIBRu/GWdvx8x8dOarnIKwj7oJzgn/xpuL2/DdWyR2Gvzji6H4eH24IdtzgUnVqvJ
         jEJ7sGL028sKuYM+m5fJ7gXhmb2CjXw6cSsI9U6NspjHLAwmakdKZKUxZHGAJmKOa5vt
         hOwckGP63DRYJVxZLg76UrRIXZGayREYV+HqhqfxgCcKK2jhWzer0UhKdj965Rh05ERs
         qxzQHPE6Hv9tiCt5e6S7QTRxAZXPxVQgszZh2KlRPbwj97QUubjraW+9LzSBQ7gq26+y
         2TCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqVOO31C2UmSLmZRV5LSl5t7zPN6TTnPrzAfHN9G1jsogyXiO6v5rQw/fPs3rwD/TpATSab4h+26/sb2Vn3v/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9X7hgQJQtaGjzGjLmj1Qq9BiaVzeCU/x/5SgdCUtQtIskqUb
	llDlUVWdbTAoMEjtkSAanpWpvmDfrsCGeI/lO0gvwwhe5rlqrOYFuGqtlxFLx45EVnq6oyPZVZB
	BilKZ+OsXxBb1yM+FIfv8ioce5H9zUb3+tt3pIrgAUnKGLS40cYW0PNX1hT1A11etTuHPhaw=
X-Gm-Gg: AfdE7ckHiX6TXP8H80SCN1NK8T4SHthY/q7/6kGDU79hc7rvdYGrzuBORJi4qaXaNDa
	vRUj4ODwfcL5lWGCZobRHod+dObs4NwIK16KzsP6BGbWo29oFenptuh9oBz1am08sjD+1Kor0bO
	w8BjojWv9IP7ycD/LeFs2AMC90MjGcFW6waa64XmaheIWKZTHgNy2Caj8BdUXAivRk2idbrNs5f
	K2js1tUE5VgPZGIN8DV4psFYkt3F5GF4k7yL4UGaD8nsSR+LHvtrau2YZnXuOkpknHljLZ8JnnL
	7VCivh5j0kXZm9UzyU3KCyS6yFZs2G7M8Ymr0VPlgPDnpOECm8QZOnU0r5yqeB7ED/YSnUXJooj
	Vj5jEKmrQn7iho+m/uKbABvONS7AxSwhcwHiaKgqf4omtjnOb/FHOOhdFF8JGR6/GzJ9vh1M1th
	oExmkVkVhTR0IgzXscPyENLuUfPrcFbbb/xUVpB/+wVj/MMHi+yWY8YOTRPOqZbrzm1QQ1whpO4
	KtNQE1IZNDwi0FC8ixi
X-Received: by 2002:a05:622a:1192:b0:516:5019:d27f with SMTP id d75a77b69052e-51caa0b5790mr27855911cf.18.1783677462744;
        Fri, 10 Jul 2026 02:57:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1192:b0:516:5019:d27f with SMTP id d75a77b69052e-51caa0b5790mr27855781cf.18.1783677462351;
        Fri, 10 Jul 2026 02:57:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:32 +0200
Subject: [PATCH v3 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-6-46253587af64@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5OCBTYWx0ZWRfX2Ql5Cc8PPSJU
 BQ1Jn8qG4s65MfpHpln1Qu0ceUrGHzgdAbkdlHH525u6z2VOPBKK5vmwqGwGdg1KLBvH8Spaybu
 WcIPWlVUhs7DZrPTKRmEGu3DNDQE1/Merx1ws3KR4gIRbA3GTCwP3Gf199UaG+mUjEHjxR47LRF
 CunL8rW575fk2Y7RFLz2WSRR6yWSaj6aUmwYj71ULbyKBf1cgW5z2u1/IWMA0q2MIRoHNDlGnQX
 beQOj1vYyyqA6MgjKbFmS8p4KSnZnYG8AfLJA0bgh4t2GbX86dcr8p7bHgylr5p55rePH/QiQbq
 4PvFCb0gacv0PC4k1lmDRBv0SaH9vu1FjAoTvEeraqzH0BfHfYW3/2WudhmO9WdXJng7g/KHUKw
 FeFsiuWIeQB/pURuKgi0rQX+tCFCVaCBToRLTZwtkBKpIIdogwhGEVCKfZCUtgnLS5+BmnX94CF
 AVsImKwnTPH0WVieK2A==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50c217 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=kStU6zbECEpzgAoP-VAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: czQUWP1hN5Y5xR0Rj-YcbPUmDj2vQRva
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5OCBTYWx0ZWRfX982/N5dXLC02
 ONnNoDTRu7Eb7huMq95i7bDLPSsP7sspDBys97ACMfTSNThahxyrQAey8kkB+klSyEckbeZP4ai
 dCQyxh7hSNADVLlPkMZkZGBXEdXpaak=
X-Proofpoint-ORIG-GUID: czQUWP1hN5Y5xR0Rj-YcbPUmDj2vQRva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100098

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_power_is_controllable() helper whenever the BT
power comes from a sequencer, regardless of which provider it is (M2,
WCN, ...). If the power is not controllable, clear 'bt_en_available' so
that HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 17f436484e1e74d1dd690ada22134315abb767c4..4a1ef316e715f4f1f0c8f7deafa971887af040f3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2549,6 +2549,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 	
+	if (qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_power_is_controllable(qcadev->bt_power->pwrseq);
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

