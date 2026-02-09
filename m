Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798B338F4A
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624384; cv=none; b=LqToz1/lfCOvKk83WidUK8Pf0yJGMeMkAEgeWPp+A5gjamlBbufMR9W377M8F8SCGfBIljm0fQ3IlqwzAQwwKWShBezfufCrScJ4WAo2dOQ/x8ymTP6GoxoV1cXKSs2dKzNF51ydblROFT0i0chC+qGwULBVX9ec0/ZmbVKy2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624384; c=relaxed/simple;
	bh=WdTFhUhYNy+Qr5D7EpuxAXZZV6xccSry5Pqx2XT4bFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wh/EcTXhi/ptxpeZs2bLdXWYjmT8TLIyGZ+OAgAbaH+T/X2uBTDH+392mkaJ7e44o6Np39zGLY6Ow5ZFuOdMkMPgmuyjmXTvNeO4mE9bMhVsNYRJj/K0B86g1rn97IFOqJTVO18jYrqfYw4kg2pSRnbjVsiPb9/K8mDP0Un9nt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WysstYfu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=asK8R7gE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WysstYfu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="asK8R7gE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61940aci1656544
	for <linux-bluetooth@vger.kernel.org>; Mon, 9 Feb 2026 08:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=gn7LjEZCpdTeQmgP3hr1wdSVyYWAIYmtCsl
	/3Vz/CDA=; b=WysstYfuJ4ZcpgnwWrpR1+V/2bcn5xD7I2ZW7Wc4sfOOu+i6bxV
	7rD7f5XgEReCiGY0HQUR7m3iwSG9V1cO2advSw+SAqMO2JhD1TRVrQE4SUKCs1fv
	G09rnzshWyqyOuZaIejN4aXdPIlQyWX6mYlJoVinpadwcovZi/9IboqAYpM7v7ci
	j2eqi4CckRxYFrWc9QuFJ6MCUrYIC8uccO4T8MX3O94SW9tlBZhXVAF8QAvKSnM+
	KiCyjnLT7vSJd+0z6ZUJCbo5p/RLEOAIQsPVbRh3bpN7kQz5TaW/fbi381BJbzHX
	NjkbZczsqdCp0v1Zp0N49f3k8+fRKGeGkVA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7862rqgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 08:06:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352e214cce9so3470992a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 00:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770624383; x=1771229183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gn7LjEZCpdTeQmgP3hr1wdSVyYWAIYmtCsl/3Vz/CDA=;
        b=asK8R7gELiKq20OGvbHY9mzrMKs8Mlko3/U9Fuban5PMcJjor71cLVo988P1bYIjgX
         7gV/NnYsN7I1JOcKBwQc9GJ7cuFlhivzYhaL6n3Q/igU8kLdEtjmUvBhQgCPtDont8OJ
         GrVlcaBacQ5qyrRdpGODK3abCeW1aL5Yht4hWtzzZw9SH9pL74Z0J1tasU/UxJMMMAH7
         9V0JNvF+c+BlWQ+VDGfIEaWZ/qpFpLN41DJCwrucUGmKm+xE7TyNIZ+NpOfmBtxDeZTb
         hZm7gSEu33FaF9kAWa5JgJsB2mISir0rxSFTrwtOjB5yFqQy9NZ0qrPLhbptT2wH2QPE
         NeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770624383; x=1771229183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn7LjEZCpdTeQmgP3hr1wdSVyYWAIYmtCsl/3Vz/CDA=;
        b=TKL7tkpPjmioi00fD44gJX8k9O+zAIWSOK8EURoWe9UYTPxBM7FIoKXSdEyi4kQr83
         v2ljaxp7n/qjGRT/QsGoBw43M+kiXnEgHtH6LpUguM2eQIFG5VfHfxNfpJe1yQwR5FPD
         JhbfeMhUyxMCR2JaNodEvlq4kN4B5Qiih4aNqbhFIFzcnhReKC46/jsSI31PEwFKqfAf
         4dDUC5685bKi1MbeyhmqObJn/6451xhfzwIUV+vCbo+esR+iHTXDHF2umWjJWnldhCn7
         6eLsX1LVvTvIo4mK/mzDnH4/mdCEb39JxXu05noJOEGqxoUJLB4FmAVWl8qFc0uYoHNr
         wR+A==
X-Forwarded-Encrypted: i=1; AJvYcCU2ypa5zT/nLzXQ/B7f6J9iputfz03//RVaRg7IDt/82EtrbfYwSvWfsAR3gfSHUBEyKJug9IxZw7lQBg4Y8EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrlrFUeMB6FZYrO3MVkpZtL/cq9cHVV3gx+NdGl8nFkpVehyx/
	RgJqk9sp+lHX5b3OArhnjJE9xyTLsz9jws0A8EALiFcAqEy4y1BSY+Pt5fJp8wg/AHb2SC81Mbu
	FrfCW+Tah7bqbOvhtwh7USrXcQhPGSUyFgkiGZd6VEbPpPougXJrlehCfl7wWWqgXyJnrYf8=
X-Gm-Gg: AZuq6aJpfJWu5Inv/wmj2RFt+GEE7G+PrtUN9YQ5v3EdbtO1m0s1q3MzBWTaaYzzwpu
	7EQglrHuAd6J7FYb97wZ0QVRquyktBEOytyMN1yAMDCqdVP4Jh7oKkR48X4fW8kzpnSu7brpeR9
	ino09tAypYAYT47liKtrebhA64NmnGnsu3Rli+gvuojggXmnX2afbGhW7toWwPB0LzaHzlpjHY+
	fGPtj9VZaxU6HTpFSQTOW2ht32m5Evw1LJeOH2mMH98WyS/ntvM74ijWsdbuyF6rvGWGZnMpoXi
	EXlEXAMAZAwJq8KTbQ2bxbn1OQ9eP2OMAZiWAngmJ95aNDvBMpmMtO/Ebk/38xO5ty8rYlnP95m
	qsJhO0ilberBafguRzwrRLshygj52Ky0zn8Qio+w=
X-Received: by 2002:a05:6a21:6e43:b0:36b:38e0:4bf0 with SMTP id adf61e73a8af0-393ad3b20ecmr10910324637.60.1770624382895;
        Mon, 09 Feb 2026 00:06:22 -0800 (PST)
X-Received: by 2002:a05:6a21:6e43:b0:36b:38e0:4bf0 with SMTP id adf61e73a8af0-393ad3b20ecmr10910285637.60.1770624382278;
        Mon, 09 Feb 2026 00:06:22 -0800 (PST)
Received: from hu-vivesahu-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb4fb713sm9202221a12.3.2026.02.09.00.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 00:06:22 -0800 (PST)
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Cover letter QCC2072 enablement
Date: Mon,  9 Feb 2026 13:36:11 +0530
Message-Id: <20260209080613.217578-1-vivek.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA2NSBTYWx0ZWRfX4G1LgmHbTxwZ
 EXot0tHT2pEzgEUIuC07gpkPcarkeotB1NV8OkSt6gE/o8XxAD5kJudWMc8uw5ZhNyh2HPuAN9l
 6dCLMhFqDzZA/KppVG1aZ0899/c+plyx7HLk2WtWdO6/JOEeG3FgvSHk9w3QBTW7cFBkAd8GyTR
 faOPlH6qD2kmKSxCO0Up5K8Q8jKyb1SHO4bI5bQVRkmahvcU+ykZsbqLm6PktGJWHdiF8y6FCsc
 jOB9mWWaJXSwRu9EHR06aZ8k9wOGPDGpNRhc29GbNJiY+UMggepokfmnOXFK7QgulYTJ9AUy9AU
 JETmtArW/Kc3Hs3xYAv+cWZVFiUSQ5/fnZBuf4uIQY/oBRN39jRR/vMAt5Rh0XIj5t4KMOgtarP
 a1xjkfw7PQqytau+cw/XcbxXsJC2AzbdfIUwaD32CLD/JsNXre8vrzSlQ+/7Zk15xTutNG3pahM
 suIeM07ZPkUqOxXBIwg==
X-Authority-Analysis: v=2.4 cv=bZhmkePB c=1 sm=1 tr=0 ts=6989957f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=p80hBS5HLWMqOVl_yXAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Jj7wK3nabD1O1hwqT1w6JSiMVGNFluXG
X-Proofpoint-GUID: Jj7wK3nabD1O1hwqT1w6JSiMVGNFluXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090065

The history of the patch set as follows.
v1: First commit to add support of QCC2072 chipset
v2: resolving review comments to sort the chipset in the switch case
    and other files whenever possible. "qca_btsoc_type" enum in 
    drivers/bluetooth/btqca.h contains all the soc type which need to be 
    enabled for BT enablement on the target device. There are few places 
    where logic of framing packets transferring between SoC  and Host 
    depends on the which generation of the chip it is, refer api 
    "qca_read_soc_version". So It is not sorted in btqca.h file.
v3: indentation fix and "qcom,wcn3950-bt" is deleted by mistake.

Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>      

Vivek Sahu (2):
  dt-bindings: net: bluetooth: qualcomm: add bindings for QCC2072
  Bluetooth: qca: add QCC2072 support

 .../net/bluetooth/qualcomm-bluetooth.yaml     |  3 +-
 drivers/bluetooth/btqca.c                     | 41 +++++++++++--------
 drivers/bluetooth/btqca.h                     |  1 +
 drivers/bluetooth/hci_qca.c                   | 40 +++++++++++++-----
 4 files changed, 56 insertions(+), 29 deletions(-)

-- 
2.34.1

