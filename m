Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40B3F44D3
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473420; cv=none; b=XnI9ZyooyOb6faYZj9/u3TVGPK6dGTSie+mgFkkvHI6PtM2mtMNYT43gFMZPSQJEZgi/yJPN0rh/87fFtSW9P/AVZ27U9bCBtc36fXqZAK4KDSBBbTMrP2cF9TWUpB6CAXSY4rP0gAuU4YW1+ac4NuxzkpCx4SuE0rq5NknYJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473420; c=relaxed/simple;
	bh=xgMVoshPZPknzHZ+9CuinjN4yQSdGGJbwz7w1W7rtkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZVy08R9u6r6d/9AZ9kDrxkRZ+thvMgqLSq+FdCnCoKl8mxghM6/VWfSOH36v44f9cC3K5LlkOqaFgpD7pJTnywGbzzAn+vHh/ZrTNWooTHIU2LC1tO0VQSDK5dSchA8ULqX5czu99PEwvB5Mou+VMlB9z1gnU0qktaJd8DYqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W47d+RMw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=axIBzt2F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W47d+RMw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axIBzt2F"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAcTPD857919
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=; b=W47d+RMwTjTeZNM7
	xMtbtiXinzbPJz87HGvheabfsgn3iVn94I2ENTawJkdofoNGG8fc4ivtY19cieHG
	aPhRmH1F3YsHIfFuvzxwXQkPPyDiNGN8W2jG35fI9XP3rT1pIeUGG2px0zMXPSC2
	th9sHWIccMnG6MinJeG0xRFQZMlrM1GNOz/g+WJXmVurl1MnrUBxgO3zXlmwd+9v
	beu6+tllmi1dq77WYXqQqTJGs5ho8iQipCRjFcEUSURA0nMftySN8DhPJmluIFa3
	NH3Qu4TVsKkljVBBKIvwwbWTgr80/uUr4k2vyMwBCuCggR4iXVAJJZU52CZd8ibd
	BSa3mg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1p2trjbh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:30:18 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-734fbe0e6afso30643137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782473418; x=1783078218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=;
        b=axIBzt2Fb5d68M06RhfVdo/IUgL1mfbMtRgKV8UAl/NCcfhGim8T3iiwEunn/spUR2
         frwDoGgTCnSvpXMJqlm3iAHenQ32VXJLVpAlMNfi6Jp/7J97LMu6QU4dXnAfcPc1eZ1D
         86btOGFIc/8rJ2oojV9QNrgd2ym4oaCCI0M/KtQ0fWHUOV0Uhiltxvi0HYhwu2jlh2do
         np+E3V0o+cq9MvmYcJUEWZ7WMlIMi1YLTddvsuGXaRrlk3IkQmfJmb/6cbdm+EzovbAL
         uWllTJtBApw50h0m2ZsftrmlnuPlsD7jTLzE1GGkCk/WoLTyZx7msZqA7HMEIsNoQOGw
         88Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473418; x=1783078218;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TbMcTlgXVq3iWulTYE5kksxHge2wzzpefndBpLUCplw=;
        b=L69ZLw7wBgRCsIWYzHsTD6BJ3FQdSw9EhO6vAq+eXuy5LrFV5gT6WpYQkEUrRhk6ip
         WAFv6n8rGES4PYkpi6cDkTeHAqBco6ZXcE/MKLAAMSOqKNCN+knrqrbbHqD1I6YRE3Kr
         jfQ9zgrUM44h2c+cglbfSktdYP0SZoC0auw0eveiZnmyPDpF4DOuxGikSF0OV6+ojqms
         466S0TAvplvgT9bd2Qrpx83pYqshlwfHPnZ2gatPqMdIJCFCsbfrxaajhGPYR+ZKA3nQ
         HqcfyjbgbzEBK85bcid2BH1f5Hvx6COh7GkJnBJM4V6WeiJ7Q3SKyUQPW37/ad8zqsEO
         4nHQ==
X-Forwarded-Encrypted: i=1; AHgh+RphKPOL2g5uKrlzkWKYD1girQdrk35EWuHmt68NcQRVhHtw5v3vRMhSQhDxKVrJJw8WoOFqc1ppbO04bGKW17k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszXsP5WTQ7K/vGoQx+jZinGl6str43tHgelJrrWR+RKPy7hh5
	cXkOoSTwdYcbAH7SPjAUhVGucYB8E0G1iCNgn7KaL5QnvJmX0Ghp0cs+7F+/IXJ4BHx1hiQ49yQ
	NpKcs2IPidGxuQ8W4Q48Mvj6cvrmBnmITWiCCjFbEzEaLrpdykMpPzok1BlTA6j6YKJHcAkg=
X-Gm-Gg: AfdE7cnRYknwPZ6pYQZVj1AUsRX7/gAMKCUBUCbHBhT98EPli6iTJtE07Gcybgde2ZJ
	wTkQEqptJP2oBmMaKPtVTn2TgAUMw9rE1s8Upf0oIafZGE+xLGLQSCQlAqEwO0WHAt3lFtbuOk4
	SMKgHNroqt5kEImzRh5VvDnsWIU28zv1edh6GhMojcOiHzBBo9bKoIcPRiWhFc9FBg2q8ivy1Ek
	orXSQfRJj/GpMNElXi4v22MLwpMYZBkD5yYPM7VCLJWvfD7SxMWFv/5aYWM19v4cRGk7MVfB3mY
	Q494U4Q9qLTxjWbaULK7SHaaaeJeKVheLUuAtnSSMAAcm8T5lzy6eqaYnl/OufH1uayPcwwjasd
	p3BpkQgzLU2NMbEgNlEKO7ZVpuSZGo4M9llk=
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1074141137.1.1782473417320;
        Fri, 26 Jun 2026 04:30:17 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1074124137.1.1782473416719;
        Fri, 26 Jun 2026 04:30:16 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3ac4774sm2774228a12.3.2026.06.26.04.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 04:30:15 -0700 (PDT)
Message-ID: <0e0fb3af-968f-46d2-be6c-18b76c7d2a1a@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 13:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dt-bindings: net: bluetooth: Document Qualcomm
 IPQ5018 Bluetooth controller
To: George Moussalem <george.moussalem@outlook.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
 <20260625-ipq5018-bluetooth-v1-4-d999be0e04f7@outlook.com>
 <20260626-discerning-light-swan-6b599c@quoll>
 <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB673692EBED649CF6DC9833A89DEB2@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA5MyBTYWx0ZWRfX5os+IJ3Ic/VR
 6xGRcdKXx0EJ9keDFgZXV9AmXsm1krR2e4P9nqwFj0wIDp48mAyxVnm1xC6lu7jggrQLDdi8ksi
 b3i1yKS1/w1978YIbjV136ji1jwZIpk=
X-Proofpoint-GUID: VwC4Ns-b_VIZyzhlyRoSo1QLoDduFCrx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA5MyBTYWx0ZWRfXzjComVSWuSRV
 b5wN6kYJmmTq9pSBDbMqz0eeTMGG2YanDvhuDdMthT1ad9Qy3heSAGknEpUBKl1vB0CBRpRxAxQ
 y8qnz6+wpXrjo9ruBIJcNVMYRpbS4DYbNscLaM/4jTawiwuFDZQLy6wHXiYIpzxyqysTHIl287U
 PTGQf+uKa1FJtK81RbqABxd+EjLFCYmZBgx7JaYvS4hvjrJhYeiHBIdOvPs3i/teCqR+KWFcdyy
 qJssG0H2+3UFFbOKaK+K1Z/Rovx22K6dfv+qr6dkd3zJqtI2Q1zwwQAtBgQDErrJ/wK9voMsrDB
 cPk+/aVIhbcy7HL8+yHYXLnzEed+ACQLlPtZmsYF8zylhhw+slUEkxDaF9ue00MYOzwyt+r3+J7
 FPaiES3oGttiVsDHSUruhd/h3CnRqfwFpmaKcjVxKmCt283s0jLhiK7w5ECAbG6Q+Boh0jpxQQe
 jbVVPOvyKRn8bJMQTaw==
X-Proofpoint-ORIG-GUID: VwC4Ns-b_VIZyzhlyRoSo1QLoDduFCrx
X-Authority-Analysis: v=2.4 cv=IM8yzAvG c=1 sm=1 tr=0 ts=6a3e62ca cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=UqCG9HQmAAAA:8 a=Q5Orqy1XeLiTHnkJztkA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260093

On 6/26/26 1:20 PM, George Moussalem wrote:
> On 6/26/26 14:53, Krzysztof Kozlowski wrote:
>> On Thu, Jun 25, 2026 at 06:10:08PM +0400, George Moussalem wrote:
>>> Document the Qualcomm IPQ5018 Bluetooth controller.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---

[...]

>>> +      compatible = "qcom,ipq5018-bt";
>>> +
>>> +      qcom,ipc = <&apcs_glb 8 23>;
>>> +      interrupts = <GIC_SPI 162 IRQ_TYPE_EDGE_RISING>;
>>
>> No firmware to load?
> 
> firmware is loaded by the remoteproc in patch 1
> 
>>
>> It feels like remoteproc node split is fake. The property qcom,rproc is
>> even more supporting that case. Shouldn't this be simply one device -
>> bluetooth? What sort of two devices do you have exactly? How can I
>> identify them in the hardware?
> 
> I wasn't sure how to represent the HW. Should I make this bluetooth node
> a childnode of the rproc? Essentially, this is the transport layer
> (using shared memory space and IPC/interrupt).
> 
> Most QCA BT controllers are also childnodes of a serdev/uart node as
> they use serdev for transport.
> 
> From what I understand, it's simply BT firmware running on this
> dedicated M0 core in the SoC itself connected to an RF.

Seems like this rhymes with the WPSS remoteproc +ATH1xK_AHB situation
- the Q6 core power sequences and manages the wireless controller,
while Linux gets to drive the device as it would if it were connected
over PCIe/ UART respectively, just with MMIO writes instead.

Konrad
