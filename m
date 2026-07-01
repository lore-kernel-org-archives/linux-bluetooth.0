Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B734BC01B
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921666; cv=none; b=JOg8+Jq4RGtCJVKjpC0ogH7J6pZexxvpKVwnfEmpUS5ixGbd8Z7YWIgPb1Y6z2eSxMrMcCG4OoJcA6kyakVUyXAtmEm9wxCD0PMdv69Sn8uUpUylvijTV+W79Qh1ZMgaUKmrp+SAfhIvCpMMBbvPZbih/P59BQiyH/AOf+cTGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921666; c=relaxed/simple;
	bh=xh4ucig5hPRkaGw1GggCAwEU1pqdfnGTPbj3vUFpt5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=du0Uir4ukmjYkVwK6xPiMZYyrhjalSl4lbdHft5dPe4IpjcME75Tk6ZWZFnZu0x/NjOkHMKt+Kj/ecIHIsKQ/SllwIuIVegy3zH1VlYUDd2IjjYnGXLwsW5gI9JlRZG56ZDypopJJUUMSVuw0wGWS4KdSf4HLQRX2y/VOSEKQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NbIMQfWk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CPXHx/yA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NbIMQfWk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CPXHx/yA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661FoDbI1468920
	for <linux-bluetooth@vger.kernel.org>; Wed, 1 Jul 2026 16:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=; b=NbIMQfWk/M75Jc/m
	JJcsFsiD2oORCimjwwYEEgLE4CCbKa8/jk6TtZTAo2x1Chq82xjvwdmFs4twAiDE
	VmDSeiTYXtYJ39ntpwwchbR4xciMLf94auLLm5dXenL6roE2PUu4b2pcjDlKN9xr
	Tmqt2K6wYY4XM7zkpb8EEBtYVMordmmk8cH//v311NIYAS4Ewqa30tp56XPJEkxp
	NnUVh1GPoJ9JUr24MaNvUObsxb/pYWhBmwiTgocSru7GcYIPCxOqTEcs6tMXN12J
	Yoiz/RgXGsjpYOtHtjdn03/y2bD6I/b9+OrJm8s54ZTFl7pmFxudXQyCt6fIC9on
	tk9Efg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3sn184-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 16:00:52 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6a196857cbbso546986eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921652; x=1783526452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=CPXHx/yA9SWZf/msCSHBnGg5vUirWSVlKMjclcdpQbz9wzcdoQZOJ3TRw+viG0Om1Q
         BYMARaWiEbNMkE/FqE27Iqny7dxlw5jiul5y9U83SnjXSFKQl5Zc3u33kb/K1k1+rkGb
         rL0yYGcZ9dBOpCcnMF3hf3fo5cT6TNKpHqnX9ByRFvJBZxbM9H6+iaMhOywGzV8axqLF
         BrvH+CTr1s2rXcnhJYRAR6Td0aoQe2zH/L+TTvkUKtZJQEoyTRDx8+EGHA2Su7O8uL30
         9GWeiHhqDGd43JNsdv+twEE87Ad0DuZFWSt+JlbK5b5lqGtYCGq6X07izwZFLY0BnNoT
         Z/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921652; x=1783526452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OF0qK3G3GFE0oahQw0gKGPhEucSp1JH1FwJoY8Lp59M=;
        b=OZgik2gXCiHRU+vaCBL1JmiG/tYeM5dRqbVbBy7nkpErSIvE+d3LougvsmdSRJtSkN
         w6TxdetT41NyI/Wyxo7c2Ai966k9Ik3nEiTSlJZSrVuEr8ZE2K/4oXY3ZaqLyt3DGwR/
         zHsAgckfLoj6rRiXlY5VJ1OjUXas7zLyuwUFXFW+bQQ+sGteEpRKtB+d/GBmlMI43tsE
         ovsFKs7OwEVdCqwMFIe4EUnm4G+L+b8UKclFCFeQnFwTWcwTPfdtUMbzuh4p/792ym+R
         koSY5dXZOJQuN3mfj86im7PM0vUBJdHakQQYsgwa1IGzwzZkoFaRtoyfLQ9iOnGKmnOI
         oEAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rL9R33P4v60YhSnNCSM5wK1BQhLqrDYGxSF1b/4pppHLWCcEXJl4A8POa8FZrs5QW68tbz4bVi3GbMAPMv6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRVmKz6OYDovUhkmS63diL9gd+W73PGa1QTDjCbPhpDDw8+XS
	6yRvyXeEdT8HDDoKa1XCBH7FBZGEhKUBsGvoihvX5oL6rayq73fJxrorc1s/An6wHuEboIPHQTA
	D/FVZFFkObbzoAbxWdirCFMNnEz1qpAyAMFgJ5b6kQA+Ahp0O2nfNZa2BiubKzaDUg3jAlYl+5U
	wE+T69qKN0
X-Gm-Gg: AfdE7cn3AdCUYguTzty3S5KHQj7XApLpqUit7Mj8ZZns6va7ak4oOn0MCPN397xJk7N
	SB4/HDmgdc5pGV8mkv2xhk1huBZ3R86sPcZRPdPXc1uNzX3spqvgDj60fRnsh5Y3Zd5rgenupHR
	84yzAoIA3al/S9sZGVK8preKAlDYxn9/3MgWCJlY6JTs991rrHKF8am/wifvkWKty/fnvdOjzTs
	lwBXO+DnEKTR4nphN2cfMMp0xcgZ+oKuBwh41lWjzJXQvDR+d7RIlZypI6qA3XzERYZkXCI6AXK
	yfpij5/wuVe6Wuo3IIBm4fyP6D5OFQQxDxSLwcobQNqaXhjfipF4AhH6oitq20Njm7XzR/7xuZD
	6SqzER88qg5/g9brvwEY8QZnW3tnxJPcN6RymhBPxnchu+lgw15TdrE/EfVrRH2HNMT5c6Obipr
	WOdDz9U+KDeUPMZ0KwpnxD9srAQ1tJCWiUNAWnu7MFqVcQ1Iz2Vvf51F/WJPX9ZWg=
X-Received: by 2002:a05:6820:4c15:b0:6a1:7fef:e88a with SMTP id 006d021491bc7-6a3099a4187mr1251804eaf.28.1782921651838;
        Wed, 01 Jul 2026 09:00:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6f02:b0:915:afa5:725 with SMTP id af79cd13be357-92e78206c88mr299831085a.6.1782921639993;
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:27 +0200
Subject: [PATCH v7 3/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-3-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Proofpoint-GUID: vM9IqzNj--Rkec2kdjpaxW8PD0znq8Kx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX236Grq85N5eB
 9nt5j1dFA5lKSJBl3PX7k98/bOLPniLYYaWD4SOK/HvPe7R/PCTAuiD351y9t5fOLJYQ+QnA19+
 WBAfG66D4sKSO3QgHAIEE47eq2h5hvBghV7zXiYFQbUVSljzcDFdMSUhw88rueOvHefTJhmDt3G
 hxnWUeZYr5YK1E01Kzt37rWNG9oZn2D7x/NAjYqShN4hfK1KRgnwt3Yg1g0CPpdf0FSPdmm8y6D
 26XJFPezLF0JG7FO00mimACPaVeRAvDyviuxOdSIYryVdR4JqP3KWPPasrZdFjJqMTleSwbvNxk
 50pf94VAG7BlduFJPa75ErXkW8jUqTkZZmjk4XPiswss/IqEYSSfoEFAMnbqXLAl29CIixU+2aB
 oxv5TwX1PZKo3usorioHClyKs5rHEZPZlQYnKuUAAhHnElvlxd4jFlGng3qJ1RChDiZcrxcycRx
 wYJw74E7ISu0DjSUzSQ==
X-Proofpoint-ORIG-GUID: vM9IqzNj--Rkec2kdjpaxW8PD0znq8Kx
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a4539b4 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jFERsaRKWwo8c2z-USAA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX6N0Pyjt07z8J
 tbFJFsXNeB/thmtvoEdVqsU1u02SutS/6mYo1HOy7QNJ9zCRpSCTeCSZcIP/Ot70jCkdCTHvrm5
 IJteMs21c8fStI8Pz0PiGRg/5vKAZ/Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169

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

