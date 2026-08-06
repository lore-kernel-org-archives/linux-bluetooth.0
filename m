Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3347A887
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027140; cv=none; b=JyZEONtUf2ZYWBUQoB43WMClHqw+A8TlNzPMSPNIFiwyfIn3jvf+eW0RjgssIU9CeGHqf+OA9ACsWkcinYWppQDWa0+FQoe1tNBZXOmu5PUQjSfMEQw3hqCSGstfIP5TkQK/UtOHsLDIfTWrIqMomVzpJwKZwgOe/VZcmV5SlWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027140; c=relaxed/simple;
	bh=NYZrwdZQ8Unx+4+MfgqEtix1DA4oaM8IOP1pJXmdN5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dV1Jy8pRGpAmMj0jdOFkrskAn4Usy7k0C6uGZV16FFQNAmbdtW5Zr9Q4WAi7NL4E1WERnVQx6XD0iNgmUCwOAUfKhuctUfPKfiOyRpb4Yv7vlx57ZJdtzTTtQ69EIgPjSfDQxTLgiwiRZErRCKeWyZ+xDbQAG7//E2nKH9pmdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KOkasYZf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CnTstnHu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KOkasYZf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CnTstnHu"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nhKE1534170
	for <linux-bluetooth@vger.kernel.org>; Thu, 6 Aug 2026 14:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=; b=KOkasYZfyawfqtfx
	kp3fH+4kNrRaDxs/Ft0qbH520UYzF8ncdN1LyjUUifvmWrKfyxhOvX/rRAIbP+x2
	PIDKDAe9Yn4/XKcQekdSfwS5rkUtBHkMZU4GlS4Inrr7UL9bSZ6wHEFdc+bfQyjC
	S5NnzLF0UjugyEN1aKT7FLwdsGmal6wmLHhCA8jWKMRe8agjDwvwcItJNnLYndeL
	vcczEhML7MZJAHOjXJeHQfgwof9syCrGNWh2/nxRhf2Ja75/eaBHUiSYLrSWu96s
	6Z0S4mz+Mjnuwl9UU/uyhlygxL1I4eRnsw4oygt65Z9qvPoW6+hRJlluuHgHwhLp
	cCchZQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvn8pt37n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 14:38:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e538afe65so265745685a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2026 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786027137; x=1786631937; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=;
        b=CnTstnHuoCPQ3CVNB+OyPox0Hx6XXKo0pInZJjKKsmaMiTXcsVDMFJxH0B6aw2WV+R
         sznVhtzhnQBPVMHqhisfpjNhnLh6KkicmWwPWsfVjfCAtD/tEbJUYa9ZoX6azEDQnPwx
         ZXFO0AMxuEK02poCZY8vZM20ZaPKSijzV/ZC57Feh91YjPlmpzfPTSIXWww2hxDHD8J7
         h7lkQILRosz+emWQ1mo6FeUjP+P9rNJJh7eA1cQM4YUYsZCDzvcXror/nUVGa7R305Hm
         I4v1HhdIKJgZXVJ4X4RQDJDvj63uZ2jjI3bOnvoyaDwNVUnAPP/2lZ6sf9rw/3FDUUMn
         TFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027137; x=1786631937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLlLllLuzegCOZuXn5+dUp09HoQyVIGVgRcx14v62PM=;
        b=Bbh+DeaNK7cgfstNAzX0CrK8mdUa6b01Y/C7zp1yZjrQK5qvBzKo65wDT0Sghe7Caa
         /L8u7ZQUgF7Mmo3cTeaUhSqCY2uDZlF7XKQTI3ziIIlelQhl+oerW8an1yJ8n+bbZZSP
         qixQ5rj6OLeX+M7tKJQz9LOchekSU4G/v52IKuRHjzS+Vimm+PIqjv/ielnK3MWdU3Wm
         4EGpNSJ8/ugFoKuvAf8QjhBZUNck0JJQhy0XA/PpTy2cx/VqIjknU0/7MabeQ6fLWKt+
         39wIr51ieD9XtTw7eJl4rQ197NE6IMFel5ZmIsnKxkkIMNqQQ+9Kp10YGICB/bqAG54u
         d0lQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpd6vmgVj9RW8XZRhKuX7KldiFoVRJdM5gG5wA/vhXAihTGXzfrM9pnYe7ZLGH3zM32yqQQhs+mTFXvzVhT8GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNP+aaC5LO7vYzW+ForBG1ofWSvNIT/9ZBSng4PeT/6rzjmLe
	zAKyNbgDdH6DZ76pJYxSM6UHjDPYgRxmEgeTSqneN1jYHP1bWMuU9uoeDHYF9Vyy5WFQ/jKPIIT
	27i9oIqRRL1Vf/pHdtUjLuCUidaH9BRwvLtgEjAPba8vjEwbrfx9Dm3GzA9l4U21OWIghX0Q=
X-Gm-Gg: AR+sD119+7M96F+SXVqa3PBHO+hLYvWARwBoyv4rucoXkVsU1hP26jA8iwCqV0Gu16r
	ExzYcWIiRpMbY8OnVC483XL7aA4xidSuYdVisioauz7V4BpKZGSLjD2lieZtX7JVhN2F5Y8aEuN
	vPNRdWVNVmCnIOg726m+ogyAIuWEbYF7KFuWqPKnSxNifdBcKaIrVC04QZYfEdThrO80/ukRdlA
	2lqmnI8K2mRWmu+FSxwVW7XDM/7K7VsS6+j6J3TEnZwlfMifta2ZoMGDSYHgDfNCUHmBMnTihcA
	IpawXvEkJFZYq2piuLZJmW8IbF8+vJjqYbxsEDzztQRSY1v45cyBp1OUv3JVbUki85Y/x/jpxjP
	VGFw4BYHTy/QZU+fvNCwZeC+QO+DkRIDyyCVdTqq+l7Gibdqk4mDtA6Aq64jKblyy6dtRSLWvu3
	qMvnBGKTGRWh8tpcD4ljbjPlVVxdSEsHvMGIBJpuhcwrkCU4uqww==
X-Received: by 2002:a05:622a:4ccf:b0:50d:e471:2d1e with SMTP id d75a77b69052e-52ce61b4ef7mr159133381cf.35.1786027137102;
        Thu, 06 Aug 2026 07:38:57 -0700 (PDT)
X-Received: by 2002:a05:622a:4ccf:b0:50d:e471:2d1e with SMTP id d75a77b69052e-52ce61b4ef7mr159132431cf.35.1786027136590;
        Thu, 06 Aug 2026 07:38:56 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([90.85.108.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2036276e58sm270552166b.28.2026.08.06.07.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:38:55 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 16:38:37 +0200
Subject: [PATCH v10 04/10] nvmem: layouts: Support fixed-layout as the
 nvmem device node itself
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-block-as-nvmem-v10-4-be598b2a5606@oss.qualcomm.com>
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
In-Reply-To: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfX6IoJvkz8X4dk
 fWLrDI4eb6jBR57NbYgX5O89MQNTY93OG1cTpFzbeEcymOyLOQ+c199yRStCGArSokfTX6x+5h0
 CLKwmN09luvK5Inz5nbfYgEyRCWl3R0=
X-Authority-Analysis: v=2.4 cv=RPeD2Yi+ c=1 sm=1 tr=0 ts=6a749c81 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JDRa4Jy4r6/BpSpxP2cCow==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=4SYEPDBQci7QR0ImIkAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: djKECUrfDHRcz9nj7on7042T1hFx4dF1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNCBTYWx0ZWRfXw4DdC4FdS2pS
 l4XIjgBkLcd8GukdY5zuZqWrVEam2J6Ll7THRqlQgeFBkuk33AaBINvsY75WonTWiE9vFgpokEJ
 iaaBiKTAhClR7PbCCgElCH5nYZhhLs0/dCvvsGrt3puWKlJZ5pf36Vw5/8zyaeM5W+2GdutMy0l
 GFcBAFz7Xez6a4Vd6JlAfqiJ6uPZx1MCHCl35nKkkxXNiGepAsK7zSHjJbf+O3IQXBmjknVEQzt
 7xxOlRr2u/0ZPQSgOEkjK1mODZ1i9MA/3nvBVzKi0nkPLOTpelPTa/M/cNDZ/UEkaPRYWXEl/hG
 HJ77iZGSntH4v65M5WnXKnfwwWwAyPcC13oHAszjspDiLfJqDOUiuAf3DPemOh8AfMy7Qr5Fr3L
 i+2WAj9ZvbR9wo3aj1LZkwOJ1VTrU0En7WPNLzB9qTnMzwN3HQqWIKwISkT5rkFNDjFRwz+HO7O
 XkUflnjxoBvWD7vmFQQ==
X-Proofpoint-ORIG-GUID: djKECUrfDHRcz9nj7on7042T1hFx4dF1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060114

of_nvmem_layout_get_container() only looks for a child node named
"nvmem-layout" to locate the cell definitions. This does not cover
providers whose device tree node is itself the fixed-layout container,
such as an eMMC boot partition block device whose fwnode points directly
at a "fixed-layout" compatible partitions node.

When no "nvmem-layout" child is present, fall back to returning the nvmem
device node itself if it is compatible with "fixed-layout", so that its
cells are parsed by nvmem_add_cells_from_fixed_layout().

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/nvmem/layouts.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index b90584e1b99eab4217cbe7ec48373e18a7caf0dc..efa631ce7283bdd6c8ecda75915911b5e3a33c99 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -167,7 +167,18 @@ static int nvmem_layout_bus_populate(struct nvmem_device *nvmem,
 
 struct device_node *of_nvmem_layout_get_container(struct nvmem_device *nvmem)
 {
-	return of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	struct device_node *np;
+
+	/* Search for nvmem-layout child */
+	np = of_get_child_by_name(nvmem->dev.of_node, "nvmem-layout");
+	if (np)
+		return np;
+
+	/* The nvmem of_node is itself a fixed-layout node */
+	if (of_device_is_compatible(nvmem->dev.of_node, "fixed-layout"))
+		return of_node_get(nvmem->dev.of_node);
+
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 

-- 
2.34.1

