Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D063EEAD8
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270466; cv=none; b=BpCXL65HjGuIg1TWK67qS+G4dKd4cDXdzVydY81zJBdQrokwmKGr1H9EghNf/M5CPK6WtcehwG+GBAJeBd3rNiT/n3XivmjZac5PSMlPYLdZSqSaqfx5qdGRovHkT4qCFxdfNRTVJ5wCtVVwxNqNUYFuQEIAsNv3wc+tTssvjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270466; c=relaxed/simple;
	bh=ND8QCWihnx/5SzmAjMX21FeKkkTEai7fgVEY9yu2Gdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K000bOOHhphgjQSvYxFKycBtCuduwEJoPzwfbMyHE5zYy2kZaA84ZJ/pI5z7Pl1uzhwkh6U/4sLivHFvUq7Wi4byh9GmHuZ+cLQv/WeUvUHZxRPTEUcMtgeIqSaXlN0VNkE8w6Nr5WKiteJBX9iZqPWYS2LCwuH+jp2n0qjoEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ih25a15f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+y7On5S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ih25a15f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D+y7On5S"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCj1UY3617555
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=; b=Ih25a15f7iXbpzty
	m5yjqdwpdGC0IJlGeKlWrAQFy2yLuxPcCWLUN8imPBgtPjAN2FeWU+7FvlYmF7Aw
	WDhZ/Fh5xxkRuZ2G47GesuXjMjrqPzEO5eLNJlUJ+6d4EQRonYXjTUutDr23Ilkx
	knHZSte48LpRQMBNP8oukwa0eyryq3WWcYPVFsJwTXnnLFOljrMZ/kLSuSDH7Jfy
	Ap3/z4CFWrtBu6m+1szEDiF81RrHgu8D+65N+qeR9NQ3LtBmF0876KMYSU9+7elW
	ET9ZNqVwygbI9ivhL5dBV63/0R2CpY6zAWMJcecJ2+Mjwd3wLtxpZN6ZoqtoT+/C
	BpPZ9g==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30gawwp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 13:21:02 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963da2c73fdso171705241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jun 2026 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270461; x=1781875261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=;
        b=D+y7On5S4Nd3LyiHl3/maoqli1GLJc9ThwAccgTjV/KmliIy3NLBAmI053ixl7qKH/
         2nGKAz1+r48Ry5zKlf/jrqpIo70G8IqvapLgzjM+m38BzVV50QDjAdtX9Shv25AbWfrg
         LerPPdQk88gCezMxOgAk4ULfEh4OLVZzDZE0isjnAmZXQSW9EqKbaMOBN0O+HMY532Gj
         WYLpo3XisfkThqqj55k17mc7q+yqPQWLhwLoWT+FrwplbTn83Vsf21RE5DVEZk5xMch6
         aXLBFVeCRY63wosn2GZ1Ex3mIk+EXTihRgS/TU7VO5l76EKdz0kQU1E2E4SeqYrzrdmz
         5QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270461; x=1781875261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=leied0AaOznatkz/yNwlsN4mHUViLaKycB742NpUAE8=;
        b=V3qX7rCe1bXo5NrFgFCOXD7tzBbHkWB3MUfDWjDqZqgfnTY5xuT7kI82HrGDMUDi5k
         XlThfMQPW2XJbcWOJniC6MwkPcctfuzduQwLAcVbZ1dToFX3R8MXGyUdfXaNICvmg12p
         aztR6+FP9Kbaq8fACbIldRKqc7SSHm8jMRDtYtOglmun04mucMGon4dmJqw2LRY3GLwH
         IxCxkOffCW02wqQh590bxh9wOgOVlV99syR+G8W6/pg0SNxb/m9Yfxllqh18d4YvA5RE
         xjNKKKYfckr5U6ZSY3/MJ6449N49G3GRoZwnFSmeQNvJEZbfnf+2apqiPjKXNPuTNspu
         1xIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p1SoFWJ+Nq/SeITrjQKcLtN/VnD19yo59aJHeoywyUWU/nasAxvxm9dc/6YrdH+SZlRByP5J9erWOkn65m/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43+/fH6eLH2VrTuUi9Nc0//kIKF9/baHoU2kqCZtZc3E7dEt8
	bnWgDvj2cBMfunrfYO8rHzuds9En2+UwMxMTjv6M+GGCrwjAEW/rWBouT8wLx3L2ZyzmuORCK/o
	fdwRTrlDj+ZmhJRjQCiGi+1BUw2wxdID6NmrVLsH9WYoYaeAg/IMFDyb5Se4ypTfYvjh3yXM=
X-Gm-Gg: Acq92OE7oUsFrYOCY9lP8qy/WxXN2/l2nQl2DHuiHNNAHxVapKKtxXnqFUSM+bm8Wyy
	QKcY13Wn4hdXmP/SqAGauk2jXA9yraM0iqaSYunlaF2Wo27Nl7A33u4z4VP3FAjKYgVohv7aMqm
	YLcszdfzpqX/7VB735oKG8AsC60+M9ub2/G19bv8LI0GOPieOsIYHH3a8osSuqut6XMwaF3v8mw
	S9MdfCy9nGmpOqa/guMPsM481JKLMy8x+YxKa3wVoViFwljG7+U/Fwc5NywHlnKWbEGndruG9Ck
	acnbcxxLSRCoApc7lnaUN4t7nvuFsKxUygXLhPCb8jM33nFdpsGEk+Za/zFVmDbRn7Iliagn6FB
	lEs7SsjAldfBpgK1kJ9qr1Fz12x9Gixxkl8NGEH305ptS0uL3RqhEiivGJkHf75vDvv0JGBM5T6
	WqzBMYg071aMROE5UOTkjd8IyieQUvE6hMe5TBUQUW+SWJCZ8TWFL0Xvmt5dxD9sRw9tM9Nv6I
X-Received: by 2002:a05:6102:2b89:b0:611:61d3:819c with SMTP id ada2fe7eead31-71e88b2a46bmr1202676137.10.1781270461457;
        Fri, 12 Jun 2026 06:21:01 -0700 (PDT)
X-Received: by 2002:a05:6102:2b89:b0:611:61d3:819c with SMTP id ada2fe7eead31-71e88b2a46bmr1202596137.10.1781270460929;
        Fri, 12 Jun 2026 06:21:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:00 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:53 +0200
Subject: [PATCH v5 1/9] block: partitions: of: Skip child nodes without reg
 property
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-1-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX6pDXtPEruBLv
 gb8lR4dMlnA0FL3RRh7bzSodCJGf4XfOm8Ma+4Z5+xjE1KzLJ1n7LJWx9bKvbn9cX/1HgT3giVg
 2yZ5bzJsc+zZHuAA/t8TtRaWQ5TCZ8s=
X-Proofpoint-GUID: 7DrAvstAj8BCtZzPjoB-Bqnvhk63xwTU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX6Nk/trg3XzYU
 CFcnwvAKQ8sPZ4GbrKoo6gDF8CSgeSrO+vEsoalOsQ7PA//MRmjManu308uDjR6z8IBs/+Pm6Lz
 qDCEGQrM5voIZw73zlWHgGN3SIrO9foUzMI4PKTxTmWdVkS+tPnJck9H/DqOgxSuGrZIVVo9RV+
 AdLOlSzS+b95nWE5l8mCm/T+TA4BYXsXFZ++TtlMqfuBou5jXVmi4ZZYVoAsG01fvzEc28FgC31
 1kq3TSQ4SFUS2uJ2/zTUkxehW/DlpM9RLz83O1SEMM+Gc0+FytyUoglPW8H1x/AO93pSPjqPK6z
 1j0L4VapqPHrF5nf5dzV5MVLgWl47JSBQmgxRAOsBRsd2DBtpblhSMq69zxo9Qm1X4OPHBwgPBi
 HXZVtcpjCtPfbwD+V45Qaduu0yRUh8CqFZj9fCKpaQfh4IiCrRKcsOuYoHc1KhbONokQ4DGUolE
 3tdT/mK+v8YU3DwRRaA==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2c07be cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=e4y8cmn4OwqddjlM7QMA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: 7DrAvstAj8BCtZzPjoB-Bqnvhk63xwTU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120122

Child nodes of a fixed-partitions node are not necessarily partition
entries, for example an nvmem-layout node has no reg property. The
current code passes a NULL reg pointer and uninitialized len to the
length check, which can result in a kernel panic or silent failure to
register any partitions.

Fix validate_of_partition() to return a skip indicator when no reg
property is present. Guard add_of_partition() with a reg property
check for the same reason.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/partitions/of.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/partitions/of.c b/block/partitions/of.c
index c22b6066109819c71568f73e8db8833d196b1cf6..534e02a9d85f62611d880af9b302d9fd49aa4d46 100644
--- a/block/partitions/of.c
+++ b/block/partitions/of.c
@@ -15,6 +15,10 @@ static int validate_of_partition(struct device_node *np, int slot)
 	int a_cells = of_n_addr_cells(np);
 	int s_cells = of_n_size_cells(np);
 
+	/* Skip nodes without a reg property (e.g. nvmem-layout) */
+	if (!reg)
+		return 1;
+
 	/* Make sure reg len match the expected addr and size cells */
 	if (len / sizeof(*reg) != a_cells + s_cells)
 		return -EINVAL;
@@ -80,14 +84,15 @@ int of_partition(struct parsed_partitions *state)
 	slot = 1;
 	/* Validate parition offset and size */
 	for_each_child_of_node(partitions_np, np) {
-		if (validate_of_partition(np, slot)) {
+		int err = validate_of_partition(np, slot);
+
+		if (err < 0) {
 			of_node_put(np);
 			of_node_put(partitions_np);
-
 			return -1;
 		}
-
-		slot++;
+		if (!err)
+			slot++;
 	}
 
 	slot = 1;
@@ -97,9 +102,10 @@ int of_partition(struct parsed_partitions *state)
 			break;
 		}
 
-		add_of_partition(state, slot, np);
-
-		slot++;
+		if (of_property_present(np, "reg")) {
+			add_of_partition(state, slot, np);
+			slot++;
+		}
 	}
 
 	seq_buf_puts(&state->pp_buf, "\n");

-- 
2.34.1

