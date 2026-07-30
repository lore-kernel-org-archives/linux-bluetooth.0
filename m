Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C14483AF
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427254; cv=none; b=Qi0oT6hCEFK64C6Mipv11Ysem0C53BB/ltcnGv5e/P8+Vp8xl93zyfcpG0WrkctW4sypA68/PNeXHUsBnlGCMBXLzCtyvb75lf4Wj+3zsbOzHXMIhvph64PpNBKkp66DAG7kCdfzKew4kAFj8G9k/bAeyNWi7YqkbUzX6IqbuSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427254; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLylWOx++VkS07YYWixsTaToglyWcZU1dC4O6yULOHG52kfJu5+3MgyhjetUt327ynvhZUUG9HDcmoHqW6uPn7Jq0UT9hnpO6FBDgnjmO8bC+grnafmntakjG9f4ZA0oomy8WifHN6VvxW6Amp8k9f1eeO95PU0oLJtwXpJEcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mdc2lZTP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQRgnTWw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mdc2lZTP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQRgnTWw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UFQodh2401514
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=Mdc2lZTPtt0S03NT
	RZN2LLYKd+6xXhFCtur9/pn9KUxEL/qAs2gSangnk3Eojs3/CX2/U8oIu1o6fKhC
	XroQfXn6jyxAvPOItfTXBxB6a8IEK4aVhaevupkro8jYPxWKsqEiumETD82FoNCv
	zojIrPoVqqom+od2/ljgKcP6kfMDX5SNaauAqJvwDWm2OmxejTT88jaqRV8dhhuA
	+pBxJQKtP7NAOOE4f5RoZyu1f2FUpYzK3pNhCbkmi4s+mx5iJ+i1z3qg4IrYqyDX
	v4V16C0fVnXQTebHonIJ1OlzTzv7K4oWtrb1v6u6WZahOxMwVdixSMnVEx8rgQet
	SXIImQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8168mxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:00:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8db414c7so34147731cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785427251; x=1786032051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=KQRgnTWwe1CbIYmLmPAK+BJyEitOPEm8qtFynyuT5s6qCnayK+ItFTqc9Ceoz/Pccs
         2AU+KWhO7ncGbXY2IEGSqO9ZJ6Jyufa0eUSuD2Pw0LyXIMcDecXjb69O8qIWF8RH+enP
         vrshkCWk2uLYGuZGbsewthi/Xa6K0vvp6DPgB4JtPW6+w/UsXZB6gyR9YItvLb+6Bx2T
         zxzrOLu3Bo+6fDy3Lvhd5xZUDH3E7J7gbMnhdFmlRLUt5xjQbpklubjyc7srQVskBKt2
         nSGuNOpeFE4gzLNREF2EwJz7cRslpCRokMGA02OXUxh6Dt76h8wR+9xzjEg0qWnMirAX
         5EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785427251; x=1786032051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=tIkCSFWkssztVGqsoUciRDjiK3oqyjk3gKnYJ3b2eGlL1nXuH2bUTi7qQLaGIwUt9f
         HaBONG8SVxlK4Dw0mfOisiyvsPRuzFgGklXfQdXcXrnsXHINkjP5Wl1bEZzv1kGDoEG0
         K2JxDUb9G6BblqpwK49nshLIDuKcyLs4DTdgRPF2SJJeRMqbqQMkD/sYL089zryUMnlz
         9Nj9sAwdBTVFNCQ0+15ZL0xcKB8+0YN2jaYZBwmaziKibg5W1MJypYimQrIkdDMZV2Ax
         7RjGkY02zJnxDFsH2T8/yUa+JPrJ2Hd3v+1fzWic1BJgsqC5JLc5g0I0beqvoUD6QNSF
         UFGw==
X-Forwarded-Encrypted: i=1; AHgh+RpqmOEo7/PFQcUL0Xfno5SqU70ZNoWkKytFOtF1BsnV44xmMy769ARICJedswUrEoj28uXocWc0X1xALYFQqko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS2pQlsJrBniAk57vGoTpkOmM9ybDR4lT4/8jUbZUZdDiwX/Ap
	dd3wFhHPzRRcRm/21DrvZZGeeykmQzEvnOZlwuWz5hjiTwQ9YmgyfS5cRvhN602+IpndymdYK8/
	KHDdSv87QteldYr5OtQM6s7urVeNBHGYwR1MswK2OHp705VAJPdc21YttMMLktUQ636WLcWg=
X-Gm-Gg: AR+sD11MQPJeO5VM0LU9zmPc4PfHYT2gNsd/B6KkLZUnc5nti6SkrQ1TBjPbfITIVUK
	RxY+4lZ9P2KjyMafxr2+DANSpBlm6DbJtjSrJ8yNvOoeYuTlGg8krNoKnoXr7lYOqs2FzlC9F3s
	qWvPxfRDCjLx1hosAiE2/nr96cvisTOJwFsVDF3hGBY93MyYhYy9cZJ+Bl3qOyWSO5A+udEPVEQ
	Qcs2SzFmpcq+t5l8BJnA9cIR4jAuPhFXwz2l2aN5xNlTnhuR4+EhtjZqMs9uB/6kyXrFnpR1XjN
	p8IKdkOPGjJFr9BVnP//Dl2M/inDWDEGA+5Z25pq+Rmr3+AftRQvK0Ii6ieCg8oHmnWae46OuZh
	3dx77QvlDkIoVDS2G7C513EQHDm7oMXUDdYQl0PibJu5KoWK4qQvraFJup0XeJa4SGSmq43WaAM
	ujGG4dAjxOSy3u5ra933w5zhDvX67yM/6Z7h2cs9suBycLQvxOK9hQ
X-Received: by 2002:a05:622a:1e12:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b384c7d14mr37919731cf.27.1785427250148;
        Thu, 30 Jul 2026 09:00:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:517:736b:e0c2 with SMTP id d75a77b69052e-52b384c7d14mr37914671cf.27.1785427247300;
        Thu, 30 Jul 2026 09:00:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8bb6deesm85168066b.53.2026.07.30.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:00:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 18:00:33 +0200
Subject: [PATCH v9 03/10] dt-bindings: bluetooth: qcom: Add NVMEM BD
 address cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-block-as-nvmem-v9-3-f72935817dbf@oss.qualcomm.com>
References: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
In-Reply-To: <20260730-block-as-nvmem-v9-0-f72935817dbf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX8RzGyfFoRQJe
 sMtNRicVmilNxGtZ+4KxE59fOJb5apCg6dwiITpzOXutYS6L7Ey1gfPpICBYik71solDkD+dgmv
 UV7NKkXKBMy/D/qrIwFP4jN/D98v+MuGggcDIphm30NrI6tCP37d8BenaCzug6+3yt/YLYJJL0O
 PaTYgLDqpqSQ6lktBilX0O2hSx8OHPGMKcSv98kVHqRweVr4u4E2SAuph6jyBf2PIbltBeHk+A8
 GTnvANfWc9ASNtyCxIHMghS9qXZXNdDmxEYUeYc6DozFZ9LGUwxe9fBKWr6cXM3Iq/dQEuxbkkw
 lyeN70HvkZiXa9hLizQTQ9VEyFaigUsDzECFP087OwVv7bTdu7tGEvH9rb+czK/j/sjBFwF/HsU
 2V24UHDY1ptNfioJpQGfchQstWySHvMnQuDUKmh6NVOmYx+ioIqltclkWmdfvgGOZHlIAOqmqHX
 sKa8xK4flrjtsjgFW3w==
X-Authority-Analysis: v=2.4 cv=LIlWhpW9 c=1 sm=1 tr=0 ts=6a6b7534 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: AUzXqW7zSXyxf3K3nw9Wbz4Y_w-z6O58
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMCBTYWx0ZWRfX0Pv+Q0tZtmAI
 MUBZdRxC21qZ8ARF63N5bnENBEgQOpwHiRd0Zv2RU45CcEgczYwhLU899mM3rTBJnL0Nk+5Ihd3
 230bkE/RuZC4bzDJ9yu/cnYR38M6sKc=
X-Proofpoint-GUID: AUzXqW7zSXyxf3K3nw9Wbz4Y_w-z6O58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300120

Add support for an NVMEM cell provider for "local-bd-address",
allowing the Bluetooth stack to retrieve controller's BD address
from non-volatile storage such as an EEPROM or an eMMC partition.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
index c8e9c55c1afb4c8e05ba2dae41ce2db4194b4a0f..7cb28f30c9af032082f23311f2fc89a32f266f17 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
@@ -22,4 +22,13 @@ properties:
     description:
       boot firmware is incorrectly passing the address in big-endian order
 
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Nvmem data cell that contains a 6 byte BD address with the most
+      significant byte first (big-endian).
+
+  nvmem-cell-names:
+    const: local-bd-address
+
 additionalProperties: true

-- 
2.34.1

