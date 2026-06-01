Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67126341AC7
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298411; cv=none; b=JJtGvBB055PqIfifU+Gl6UmzflCoAiyW63dVzebZd6B0lpJCAlvValmlv/SNxvMpC9GdNOOtCIv9oZDXVUCS5Y1f0sMqYzBI86+RClI/ZQQnYTvXYNGC0SdSapzenpWArYuG9AX72tYFYA+JCrjKu6D8CPVnDEHRbYFSRKyEm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298411; c=relaxed/simple;
	bh=shKWeWBNqVXhBY78Tf+SHIB0H6ZMVUTB8vM7G1+QeCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp4hv40UabLTkQKZN+fQnDuOXQbooOo0p8ZhjiOJdXSEwaSZR5u3jogUBPMcZoXpPFOlX2AhJ4fetg4jx10+Wf/DqbobNjXF2vDS1i3+Yiw7lF4ALv0xgUO2guQvwr7visZvKeM7UzW7QDoOilclIRR9/6DMfghkcQYtHqTuYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nafPpfUt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=blFyrKim; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nafPpfUt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="blFyrKim"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6511GjDa772872
	for <linux-bluetooth@vger.kernel.org>; Mon, 1 Jun 2026 07:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J50RySh8GMKgXOqEW4ylYPugbxEDez5rKbb4C33+2zU=; b=nafPpfUtEhCuDlz5
	bq5pFqG1HLkseLeV/aLNDNvmMm7bdEhNaeixMXhfqBe84PdCisO2PhhUwiWqqUpB
	QL9WWQEhs2mj0BdupbqOR92Nd9lacVoKVMeuQryfE/pckDTRFxhsV3vcvuEqni9m
	p7WwZdlwdPIVdeGuXs3dwEQHvT1hZF5IkLV2/2e4WTP0pwoE1p7dUrXTH4RH4kK1
	hJTQyc/o/glDcyuSoYbKGPdev54egoOjxMAk7dH2K8n3ZQBHOF+DiwfOBq7ZqBB3
	Xjq59lvyeYxfyx5opbeoVdZQunz3cEjAqrHoaQbaKjcBJ1SLm/G6Jqav+/h1129P
	14Fvpw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efxy7wj36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 07:20:09 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84237a15547so953860b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780298409; x=1780903209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J50RySh8GMKgXOqEW4ylYPugbxEDez5rKbb4C33+2zU=;
        b=blFyrKimj24lqv90wkcSsHHOfuAmat846ekSdLrmhtkUz3d8ZFbj4UMdjsAYIYk0tL
         dn09vlh+hK3H0iUl911El1mJzz9qoO3E/4TPpGD96/ryajupZS+eHxXzmgt1ZZC8dIx9
         33OrlOSeqBoETQTmRjEY9WBlUrTTF2Bo9Hopwtl0B4mqCrY4vq0Kobi9fk9ME6kCYhEe
         9G6WP0TOPdAUKnXeUimBg+zoCI+dOrdi/4WjHm8+0AjCDkyNfnkSPp33Q79c5QPf+O71
         t/klz4sfzwtJqcv05Hvb6Rt51zMuumfFX7vsiDsfLSGLvaE4z/VVBDuu19ax3Hhj9Rsj
         +WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780298409; x=1780903209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J50RySh8GMKgXOqEW4ylYPugbxEDez5rKbb4C33+2zU=;
        b=gltp6NxuQ9t2HJHLL8NXcPjsgvK3ayOas/glX00T+hDZkPIvyQH3os7Knqc/5T/ByJ
         swAPGkOBTuPjnXCJn13Vl7YXNSS+4BlaSrYW+UJgepvqwXC8m9lO2bNgzN2AAZ/Bux3v
         OsZE259uxodfepOvScw6ZEnIP7rZMSfQrn4Hk7htkSz5773eqMu/D0Kn1UCmkrt5URmI
         gkavheXfgHAMqSjLoo23COIucEXxo0qwp6OGp9uFDtGe5La97VjE8AxqUIy1b74ehA8L
         YCLYFe5zMcQrw3Ak8eubiLIlnDuHGwT8dtmarw5kA8kPxYJOy8SXsGquK1XaLBKE0yoL
         DN5g==
X-Forwarded-Encrypted: i=1; AFNElJ9RmFNkEhUrtTfvA0UpoIZDz1PI5LqpxCQDOtHRKXVYw4gXgntmilt7LbvPRyb3rUb0xhBEePD87JMECKBgGuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7MYx3q2DTMGb0nfZ08YyBT52LxYZUH/f2p0C7xogvj1ZyT/hI
	uy92tcMv0lfNlUw5EfobnDhl4Q2u1oaYrBA/uJxG+/M5dVOOl048blA3XW1fwS4kGr1aVJCJsQp
	LYdPOXyHdObs9NniHsnujSTQC3WhOHY9yTjwjqGHIctGCPYQzlCm6KsUYDjmv9nH+kizlOWo=
X-Gm-Gg: Acq92OE7MBzIzR9CdSx5BIeARXWv375ANVregF5XKdeV2VQEXFhXOQLCRpNZ12w6ZSa
	cdzAQj3ZrehZMT6+4akYUrVvPwkJAL9D16XOPYKXdowk1zlgtWHQmKHJX5zOxD1iqwCOFkSvhpa
	REzWL5VWo0YVfnoMnIyiWaZEQCmFBYWViNtt8+mZdYHeojoQ+Xhv+nB7aAsY6MiBdhhFmN2+C3s
	HpN0VLZzsK4Clq2fHOqGGe6gdpYmUgAToqWGOhL+1n+7l7IEwDuxffvJruksy5nzuMKJqXFIBZ4
	VxzDrJ9BlgaVWNO7O1ZJGoXEIgLlEYv6JXkE9Npnhs6Auj2N7FtGgNJ+v1ADU8poou1AjgpOE4k
	hTkak69eB1O2CUiBl00Gq5cyYMb/CK10wfZAzjptoUUm9kyXbNdOQZVLyqfTU
X-Received: by 2002:a05:6a00:a223:b0:842:5931:7b8c with SMTP id d2e1a72fcca58-8425931803amr1870513b3a.1.1780298408603;
        Mon, 01 Jun 2026 00:20:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:a223:b0:842:5931:7b8c with SMTP id d2e1a72fcca58-8425931803amr1870478b3a.1.1780298408142;
        Mon, 01 Jun 2026 00:20:08 -0700 (PDT)
Received: from [10.219.1.106] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423bdd217csm4479368b3a.49.2026.06.01.00.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 00:20:07 -0700 (PDT)
Message-ID: <6c06e372-85b4-4207-9bb6-270bd654c287@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 12:50:00 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: bluetooth: qcom,qcc2072-bt: add bindings
 for QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, rahul.samana@oss.qualcomm.com,
        harshitha.reddy@oss.qualcomm.com, dishank.garg@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com>
 <20260530-funky-mackerel-of-current-878e2a@quoll>
Content-Language: en-US
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
In-Reply-To: <20260530-funky-mackerel-of-current-878e2a@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POg/P/qC c=1 sm=1 tr=0 ts=6a1d32a9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=Ey0t84Mziqqm43UOVh0A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA3MiBTYWx0ZWRfX7vTNQffITZr9
 3rsHf4Nx5eX8Bhgzq9HdFjn4bgIkAdHCDOT6Vobu5LBjv3oTV533R8eao0DUojjoTZ0JgXBTqyl
 bLe/zPsemMmfJbB+NQvGZqi7eVxDBQLybacosCdNbmimG3YdwKJ7Xv+0cOAw2PLy7yMChCkqtlU
 ZDM1h47rQP/pR62bdWo2b91V4q6PaNqvHucPOL3zixgHa9Ui5tagZqvfgS9BlZKsWo/3hdeovjZ
 XVYCl/a+1F6i8wmSlpJ877TP75Sxx1uYGg3f4VGDVz3Ao+K/Lg6JHhAV6NzZmMkJ6+YeWO4NNxy
 kEajTKU8QCKLOg8F7GmBbcdC9Ev0hUfL6ZUKXy4eMbuk1+PbGQO0NS/1GplH0iG6QXZURxnRfjo
 9CzyszyL249VstwRDhJXKq5OnrVZrYzFDr1+1205v5AGTCG6KaJuoap4br60p2MCJTbCtfjhFLF
 POiVzF/wmzaGXWm34qg==
X-Proofpoint-ORIG-GUID: eHLXxZT7S67dADLb0rZ699hli25S7vfo
X-Proofpoint-GUID: eHLXxZT7S67dADLb0rZ699hli25S7vfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010072



On 5/30/2026 6:04 PM, Krzysztof Kozlowski wrote:
> On Fri, May 29, 2026 at 11:23:42PM +0530, Yepuri Siddu wrote:
>> Document the YAML binding schema for the Qualcomm QCC2072 UART-based
>> Bluetooth controller.
> 
> Where is the rest?
> 
> Also:
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
Thanks,  I will update this accordingly and send a v2 with the fixes.
>>
>> Unlike other Qualcomm Bluetooth chips, QCC2072 requires no external
>> voltage regulators. The schema inherits common Qualcomm Bluetooth
>> properties via qcom,bluetooth-common.yaml and serial peripheral
>> interface properties for the UART link.
>>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> ---
>>   .../net/bluetooth/qcom,qcc2072-bt.yaml        | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
>> new file mode 100644
>> index 000000000000..8e2f15a75d62
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/bluetooth/qcom,qcc2072-bt.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm QCC2072 Bluetooth
>> +
>> +maintainers:
>> +  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
>> +  - Rocky Liao <quic_rjliao@quicinc.com>
>> +
>> +description:
>> +  Qualcomm QCC2072 is a UART-based Bluetooth controller.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,qcc2072-bt
>> +
>> +required:
>> +  - compatible
>> +
> 
> Looks heavily incomplete. Devices do not work without power for example.

The module receives power through the M.2 edge connector and manages its
own power sequencing internally. Unlike bare Qualcomm Bluetooth SoCs, it
requires no external voltage regulators, enable GPIOs, or clock supply
from the host, so no power-related properties are needed in the binding.
> 
>> +allOf:
>> +  - $ref: bluetooth-controller.yaml#
>> +  - $ref: qcom,bluetooth-common.yaml#
>> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    serial {
>> +        bluetooth {
>> +            compatible = "qcom,qcc2072-bt";
>> +            max-speed = <3200000>;
> 
> Also incomplete.
> 
> Best regards,
> Krzysztof
> 

