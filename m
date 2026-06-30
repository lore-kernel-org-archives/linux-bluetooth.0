Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0840B362
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821556; cv=none; b=HA2i1GTYyPNRMX/EzRoaJn0z13NmL45ZHcnC6NRWbMThdVKlzrUCkPNVCGkJPgWNM2goXiW1qSzcistKDMZhPK683ZsrkzLBWOECcxABMiS6RLC8EPaq31bnczzYYCKx1AfCHXdCbFdANfsDRCI4zrIxi41kMvv8UIdGmV4t3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821556; c=relaxed/simple;
	bh=ICVFc88cteRkFnOqK2r8PitO/adADtUmJP+OvcK0+uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZB0cFkr0esEIxuJGVy3PdsxcgeLVYKij8PbYgirY8yOH7ip4m7uitMQXgwDwmW6/0KpDB18nknJNMUx5RulaO8U832NZyGX6LTJlJpC9g3JjxcwY2dqw8TGuJTCkW3tzjPZox1gj6gl284R9Isoqc03Df77xzpZ7lPBot8XGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DeBXoe+w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ah0gOdKn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DeBXoe+w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ah0gOdKn"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n97W1605952
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 12:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=; b=DeBXoe+wzRpw33/s
	CVnrtcqbVZXPgn6aEIn1wWBJ+E1acsLKn5JktQBYJ1c3Vx7v3bJeb6Sfff2LGCRb
	P14F9T4XdEDtgEHXToUs+n0tBfDwT6HkTBpS+QWhTgmMGmu+GVWZSKiKs/perO6v
	cnSwjD/3ISf8pOGupOwNoTC76boV1cEYQaRMzBaB9EPqLjF/YQflZlMeHBRR/V3U
	nHZG7oo43lc+J2bi2nMueoNK4Lq94vHJyWnHgDyQYnlMMhtiNY6J5ARy269uCuzO
	tduh69GbdE5Es0Th+848ztOGIcU9ec7BQmfZXeNtwJb35A3jhiKormSghdh0rA8q
	EFEcLg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f45k5t8tr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 12:12:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe75b7dbso2903931cf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782821553; x=1783426353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=;
        b=Ah0gOdKnMfe1KlWAJWpaONApMSV5WXsghEC9jjVxWmMaz61UNPo7qpGw1mmrdSLd6Y
         qmiQy19dnISlpwXlvCsWoy6Xt2yh4NhusRwMS4G7SFLRZIeQcR3AgseMs5rhaLX2t24x
         Q9O2DQdyVvMxxPS0h/Alb8EtN1qjYxW84s1unN61wRVNrtfw9yeJhx6w1GA19s7j1CkD
         25SLVfXDzJbtSSHgF8isJ+C1ChfsYGcCMtzbpvJKDYsMKnoQn4hEfW9BQTQSVD2Dzb4T
         zOOzSHaQjaooztYY+rThD/t2O5O6Ion1GqXm5doD5YUp/AJ0d7tdkgmJfQZV9TRf8shv
         Wzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782821553; x=1783426353;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Na8DXEC9+OEr/ZtUBG0C3IcLUMUb05YDkSUa6mm357s=;
        b=ZhenCmF9olHQl+Eyo3gkSuKwuoZw7f5rWQSmjZpO9fBZkifZwMxdJ+6cEwH9IrqZis
         eGztlocGwEAFFD/ucvj5RLIr7e1ZSWiy2KdoomI1Rjpvx3bjC/xZyivIzy2zYrbbFjVr
         02U2NwH+gdluV1eIfzvRg7LGrxVeVUyERD9WjOzXIkv1BqhURq2GYn3Z+CPTev9NbJ+A
         5gXFGXVHK0yCsRgXRoYHyqaYdnmx1gDk8qGEVOZqFaD2IM/BM7KfbCm9+xZAIXEI2KO9
         8KtjZx9ORD+u0/uwQ3Z2SrRN8NCZsY+YVlueWcZ8HOvKFqUV+HD0oF1OHi7blIyVUpBA
         1xcg==
X-Forwarded-Encrypted: i=1; AFNElJ94Id7F/E1HOiKFi4+xIxfu/7uyDEuD8MRZxypY0ZwK1LpYzEaEtf4X9eJh58gVKt4QZZ+HkQg8ERn4JrYSeW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhbsJDhg6G83WIcrgmQkCaC/xrYsbI7QFzUOu0KqxQFgzctDvT
	t6dZG/fiukdct/99CC3ZqEqoFzOFJh0w+kpqtwheSHkW2EKEId1Cgrxv/KVl+6X2/m54QpsTk5w
	UrKlVFBekWV3RjcaQ2Gr46fd4dnuqDrHY1yH5r32gLuBshgJOYxKVBvbwWLtVHTJIPHHbVYA=
X-Gm-Gg: AfdE7cnVT2THFBRx+icthM4qkQ2aDW+0kyXySjmzeVCuJ3QmvlrV6eUHsPwyktOSuG+
	ycdwpBhlXgxAQq0jW9x8lSYafLLAqjCfgd69I3GyUwVUkEdT1ttu8Yv2mPhjVr93yQbojv4/4jJ
	uMIKdW27x4OdtGA9jtXta2PXPS3/Zynt/BsEpdSbbAjInMpa6Tiukf3rIz/s6QusLmzD6bR06IY
	wnx2ushFkbfT714YjlKr2LvvDEjVTIEBN70bpg4LzItY27aXZ8IwLgNwZ4A9gxUah1tewAGP6Q0
	3AWj3BdEDnjrceRF118av+U1pHUQg6Vofzcwd2nZHACCPNxFVkQE2VpCeuCgwKbW/XA/gD9+anR
	r6DS0aW6P9vROVjtoGljQ4E2GCMiNwisTMVo=
X-Received: by 2002:ac8:5e4e:0:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c108dd78bmr26922801cf.10.1782821552753;
        Tue, 30 Jun 2026 05:12:32 -0700 (PDT)
X-Received: by 2002:ac8:5e4e:0:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c108dd78bmr26922291cf.10.1782821552071;
        Tue, 30 Jun 2026 05:12:32 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f0cc57sm113884166b.40.2026.06.30.05.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:12:31 -0700 (PDT)
Message-ID: <7d937088-fb52-4a5f-9aec-b5e2409f3cc4@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:12:27 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: ipq5018: add nodes required for
 Bluetooth support
To: George Moussalem <george.moussalem@outlook.com>,
        Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>,
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
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-5-02770f03b6bb@outlook.com>
 <f3c79cb4-02eb-4e4b-b5b4-9732876c075c@oss.qualcomm.com>
 <SN7PR19MB6736F8FEB36D52E867C000E29DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <SN7PR19MB6736F8FEB36D52E867C000E29DF72@SN7PR19MB6736.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=6a43b2b1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=UqCG9HQmAAAA:8 a=M9FTrHVy_WBJAQrZl7sA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: EtFqTgaEv7GhFavbVZd7yRJdzA8bZ6fO
X-Proofpoint-ORIG-GUID: EtFqTgaEv7GhFavbVZd7yRJdzA8bZ6fO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExMiBTYWx0ZWRfX1k/U6t2/vB5K
 Wtg0DFN5mGx4kdImIBK/l5w8PNFcWxOlKFZDOO3jVp5g/73BOLrflaPc6C75lKGr2xhaRXLCsQ6
 m1C14be6Ss0TseGmDs6R3MrtYeAJCh1UddLMbnmoc/+Ezz/maU4hWqW6yjRqhC2SHU2ZSJ2dvnl
 D/2OM0ifRdEvW/Z6sLamvH4eM0DjgpHaTC6I6M7/+v0gCUgZEgu8+BnLfdJApkdPTVCCESXE9Y4
 frJxyTmndSy3UHh8g2kacNFG/JiHx77a0qw9H5yxlXaaRh/0E1725pCLIEwDOAE4EmQ9x/aO+ue
 TcfC0BkKQt6mSeVXiJXqSTnZ2hPE+/AQmBB5pBy7/ER9PXddbDQ6XbcAGRxfl+SYDml5+2AkvTi
 +G9nkCR/76fbB+yDoMcSkQsfXYRkcq1/V4NBmge7EMpuBVZOavyVdaQyZpo8gnzsEyjYU4YU0xc
 H284U5OCHydkAk228PQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExMiBTYWx0ZWRfX2MzvFbLq2X5H
 ztQvqDm3KpxhKqyqsQaAPSJYFMJ9pCMxxrN69A5+fLqhyC3BvTQaXx50XyM1lq1bMSRW7B10YN0
 o+njJjcjgPNM0++F7WnoYaB4o7Uy45k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300112

On 6/30/26 2:09 PM, George Moussalem wrote:
> On 6/30/26 15:40, Konrad Dybcio wrote:
>> On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
>>> From: George Moussalem <george.moussalem@outlook.com>
>>>
>>> Add nodes for the reserved memory carveout and Bluetooth.
>>>
>>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 25 ++++++++++++++++++++++++-
>>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> index 6f8004a22a1f..65a47ba7d3a3 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>> @@ -17,6 +17,23 @@ / {
>>>  	#address-cells = <2>;
>>>  	#size-cells = <2>;
>>>  
>>> +	bluetooth: bluetooth {
>>> +		compatible = "qcom,ipq5018-bt";
>>> +
>>> +		firmware-name = "qca/bt_fw_patch.mbn";
>>
>> Is this fw vendor-signed?
> 
> I've just analyzed the mbn file (and the mdt + b0x files): it only
> contains hashes for the mdt and b02 segments, no signature/certs at all.
> I've used your pil squasher to create the mbn file. Here are the FW files:
> https://github.com/georgemoussalem/openwrt/tree/ipq50xx-bluetooth/package/firmware/qca-bt-firmware/files
> 
> Perhaps you can double check?

Using the not very sophisticated but very quick method of running
strings on it, there's no certificate identifiers indeed

Konrad
