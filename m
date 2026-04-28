Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5264657D6
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386219; cv=none; b=Kr2wk2X+PUvA9DwJx10IoO844v8+RErQ4WaBsEVurZi20y53lcN1OjPgeCb03Xm1lGmy2T2vCt3/qcMtQUSdC6NUSvNzYSBNnvAT6BKGW1CoeGawOGndiAH/G6at70dxiGSbavzjyRay2qlyTYADmKYYs8HqDVATdfCnj6wRvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386219; c=relaxed/simple;
	bh=cLdgwybwmVheaxNq3A4ptASzy5fGo7sa3nM19lVmCQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQRFJwx/OBXprmAKrDqG8xIPHH5auhylVvXS/pKar9A+V1PbzXyBTMDpUbNkKuvTSprFCntPm7a0A/JNDs6Bmt12UyxnFKz/V9VDCpOYSI6rn+aniBOgHuehE70M3x8LBNK6MCJ+OX8qtgFEZxbwCkXVyxELfwl4pZpoiee2qys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQ+wYtuQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idKfXJl6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQ+wYtuQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idKfXJl6"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SACaDH2112521
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=; b=PQ+wYtuQpw3oPdCo
	Gv/gVuNnwt/v0F9FkMF60jbuMEHY4L14JYQaQUOwHFH1G3xmd8JGROy1iaQc3qCf
	xacYJ5iFZhhEvfINckpnl7pe5XdKIR8RrXz7NmcKQkcfYMsZ8670/KE+i9433HVY
	I3uzks2RvFKVhlkSnnkcQhsQxSe6Dwpsp2xugO+/dXf+pDwjajCKcGCmOEUySDpy
	Q7yvsCalSlXcw5IhBPFHJd69TWdMafW4FPvkDPWc8Wd8Qr/L/Dxn3e4F1h1+zzVp
	2Opc/mqH2z6oKmknDbAJV3AgLHGknJwt8JpiVaaMnqAYbOAWwooOJgnk7FlbifJU
	5umC6g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbm0hu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:23:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56f4a1cc334so8353842e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386213; x=1777991013; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=idKfXJl6dS8Zzp7sfP2ChRmhq51ljHlNA9yqsinQs464iNOepLrcyvtY2x+R/2fAIJ
         phjga98Pt+GpAI0TR5gTgQbkAYfScQJ2vhRxhPKQvjT32g7quORhZfB5yxAkRUQSNbqk
         Peg4thCXJf2IZ97cglEVNw0EhUuiAgngg9zqTOSA6EC+YcI7OGtGq8BGD67ejUFvv1oc
         Z2SURaOzdqLAz73lkD5/GNrFpdn08hQDW/QxwfqrxFohLIzwpd6i12bZIhvOoKx/hsPB
         Gk0sTN1qLKpCacvg+m4Joqc4PLj84kA1QPfIsKbR0GWQZ1N7XlfNUTmzG3Wwg7trSGPf
         D+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386213; x=1777991013;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oEdzPlvkzmsz9XRBy398mVsjWjXUxo2umSQ5Z50zP28=;
        b=HpJP5Tc7nK7zRXWrpTINGa35g+Lb0dmeoMqFFWceFaX0MGtCxzHZXygHKjZjHYXqec
         UIDGoZxPMkPs2f1aL8JjInwFSaAep0p4SXs3ute+BKAIkAoAE/+UI/ki6Fyh7OeJQ8GJ
         Zru+sI7X3FEdGr9U/KwwOUiKsdamkHnnxIMHQFI3Wkqdw87dV+WkT5LRjh1d/5TxaH8v
         8F2Qz8BWjmgP2wi8ZD5vke28ZVNi7MdxzRyzmdI1jujosMKxyiW3rofurgHET7YMlomi
         P6DibqUImQpWs3YiVMMBYSVSa3A1houTZZmVPu9FitL06iw/pFoGxL046fLNCxbPUbc+
         LHUg==
X-Forwarded-Encrypted: i=1; AFNElJ+5ake4LAsotjog0td9kmMR4uKxnI48HidITkA8ymbNggphLj627HoGY5VJ9fkuc38axyg1ZdJ0nUdMATCarTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFCAWVKi6kVLT6YLDzfLdH5Sz/d8SfAzjTNE4GowMM26P/7hhy
	uwwJOCgI9CiGC7WoGHHd77vouudfiTfywD00JT4mOAv7iE9m+OVr0M1RY3vmM+oKO9WCRBYPGVK
	2EYMHdpUmmRddpEdd6KyiXYIqLJJqhnKRls42ci5gApxUONCiiSpMNftUt1xzi3cK2EwRHFw=
X-Gm-Gg: AeBDieuXdCZZPjsnn9HiayalMov65EnPPVKlUVKuo1qx4Ak94j0XnRPhzKkIVo9i+qO
	CWBc6SsR7DonWihU6PzB3nCOZ8LrkRQw7CzW1hL+ogLqZZdUga9l7wH1c2OHAgfr/WPcxLMab09
	VwFYgjwsX/Nb8plYnIkr1tMLDkwm93RccNC97BR3JhsiehYDw3QUTKuAqlQAJMgwNvl/9+RETUc
	31CDQGxmIUJUv8x4kfqdt1QbQ/CFi7YWMwjMXL+8QYo4iTwYurwBrRnf+lXaZedvC1IjspYqBBt
	ICmYkaaykMvlw58i9aNClzFRagwvRMLTHQqMGZiCoXix3sbFDdAKDALgZPa0L7kz9ZsgWBwYRpL
	LT4N7nKjm84f2tfNiK+DMRvnelqmyIsJOd9zZeyKp5oAAD5v5DvQd5elpW61LtW43Nc1J5i8pnD
	PwQnZROaSElbXgdknMclrFJl8/bqE=
X-Received: by 2002:a05:6122:4d04:b0:56d:b50d:3ee7 with SMTP id 71dfb90a1353d-573a55191e1mr1867555e0c.2.1777386212610;
        Tue, 28 Apr 2026 07:23:32 -0700 (PDT)
X-Received: by 2002:a05:6122:4d04:b0:56d:b50d:3ee7 with SMTP id 71dfb90a1353d-573a55191e1mr1867307e0c.2.1777386211467;
        Tue, 28 Apr 2026 07:23:31 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:13 +0200
Subject: [PATCH 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-8-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: UZvMR4ajLST8fV_qK9JX2h3_iX8n-NXq
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f0c2e6 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: UZvMR4ajLST8fV_qK9JX2h3_iX8n-NXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX+63JNoDLwsBf
 HgneaeOXQLYbNhfuXtmWOI6rDpESNLA3V0Oh0UHgabN9Hgv4yMtiQ0xwTuBk10ZhTTOAh57Pqf2
 YbDzOefE/dAJ72INJnEiuA51455iGAGH3idnufOp/kfsjquu+tRhxUcxSz47HsB/kfkldTtzYkl
 g6i4SplVNqxsntFpJz094MDOFw4vsrJSIQRbh71ZPRPe+dHLa8D2JZksmDi3BNtz89C+KMoFp/b
 K3w+oY12QqaOCczaPy1Z7L6I2c2bCVgbb5jNUYUZTgLY9HMTQ5qOB3PUryuzNVceA+k1DCX2uxs
 NOcL4mXuzjgpojh7BU1MyMMdbq6Xsa2bmbeu4TzU98un48/UbinkO/7WUPCLhit3y9i83pBHVau
 aE2v2A+7saaFqZd5/qd4A0TAIJv5CpHGHbgAvl0sF6QxL5WbWCkB0EWNnFGlxAJ3r2dF1uc+E3a
 vUgA/hQRw0lPKtDE06Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1

