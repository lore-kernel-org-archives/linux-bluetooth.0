Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E94342C80
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771589137; cv=none; b=tXASWfm4KkJo++MAso9Fsedj3FLrhIUGzUMCfPWRbNjtIkkt8XoVJ8zTebj2UBsgxkbuXfJHT8nOhaHp6NhRw21YKfFxW5ZJXYU5nll4Z/YEP8NQHh3RlOJ/+3/GxIh17TEcHjWlQkJs2nEjAbI9kvV3IrDe95MWH3mufnWdYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771589137; c=relaxed/simple;
	bh=5589XGveaJrFKM4G0yJEEpKgPGLdvmNfSulvySaX48E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kk3CXW7fywy/c+R7okKsF56mBR808KOU/tYI9YSBIJa9gtJHckIUdzlRJt6HPumquLi5zXh8mCp38KEmyevwtDS8XTkRZeebjotDCRq52ldrksaW4s8cXqiJKJmlFrAsVmrD8qUyl70N/OYwxVN0qqZ/I6G+2fWzciwh7pCBmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJfMgScC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h2YacQR4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJfMgScC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h2YacQR4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K5SUTl3864333
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 12:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4AnohYpFd1eVw3fRCn/zigCbPOyIedqoq/xhotPnpRo=; b=iJfMgScC9lLge0T1
	Ys7GRai8CsZdJ61P77O48Q7QYtxDCjGNfCSz/3KSWXQAVASzFH2EkHo4XBhOo57g
	gt0z1xriQZc+z82YiH1GhuzlNxXFslZfnh0+BjDIPYxY3OqFjUjG/z3Os5QG2lsL
	SZ2LXbUg/ilzbuoDhqTSPU24NVPsxXT/rrx7F6suJXbOSIUXKkqugzSlbIWSDLQh
	vV1dMjr4MuJ4xdhETVGCZu0qJZrFluEPeg7c4Qi8myL8e2Da4H4aLK7+pbjaBxDB
	tlBbrdBpOK0Q/5oqDmBZzsXWsKUUt6+dWic99FbDPqf6lQgJssaYexhUqXimCYcH
	A6n8tw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce2ghunaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 12:05:35 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67992287096so29907396eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771589135; x=1772193935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AnohYpFd1eVw3fRCn/zigCbPOyIedqoq/xhotPnpRo=;
        b=h2YacQR4F/Qc6WaJOzkLJ/26uQUa1KklKuXJdFgF59fRBp4mExL8S/esryo3tFmeUc
         hDcwSK+G6RINO9q6NexEiYY9W5g3al4mrQk/i6cPCo7wtdtkb//kL6jERhuZjzFGi1qN
         BQvRPFmhT1/pZQniCJUXMR5YYKK2ULxZ9dEYvRZEoybHswiWmT7BEjvaPxaFtjl+UXL1
         7kIgmpYjihJtewaEUfZpBNfU4T8WVCmlUZCwLwUbH0XvUkUblO6VBOC9TGfhMmVU6JRN
         QbszHPHElu/HKk4IIMU0gP9VfTqDLro+hz67WUFX2pNPWLFIblCaHCtK5whv8CV7j+QO
         y63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771589135; x=1772193935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AnohYpFd1eVw3fRCn/zigCbPOyIedqoq/xhotPnpRo=;
        b=iqIEgqjNI9HxhnTNlwIHlXJJ3PKk59uxMWc6JqW9PooX1K4JClDvESs3EXvowxf/5x
         EyBhdvjNR+naBBD88e7zr5PoJAz0E9NVtV6e7NscaOtpKg6IAW/PDZnWNU+PJmgF34vZ
         uwA9jn8yNwLH4w+q48phGjTPe0kKVxPQsf4zPfqEpGu/+y3D1IK8errMOWsgN3jrTSDt
         +bN3fAMtqWwly5jUrXJqpznti4TPCAckGnBFHPdOU3H/ifLvW9ITrhxJ4kSO2EltwL3F
         QkJTc/FF7A5QN2tdBb5zfMVTnRSymXSSXzu7XzMkFtJQ+F/9hwU5oVtPUHthuJkQXjIy
         5tGA==
X-Forwarded-Encrypted: i=1; AJvYcCWSmk96w8uQ27ocrxRxEnCt7eQl9NIbn35HYNTOJQ2ZyuApAwEY8mg9UbdPWLsWUxwvsJ+QkmCu2Vg085eYY2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY3oPaZHa/uIrtjQMpV4JGrDA3reKUcDwBaLorXZVMxkiFjyZb
	7MT6ocxl7uQ+qic17FGtGwvYUfE+fVYTto0+FCxinXCsnq2IedJZQjS6hoBwLPO3dvkQz23Itc9
	Pa9SPL7SCyYbqizp9mi/k5PfjtJFC+ONjB1d9dUs/vOrcJc8TIpc8e0zS4kY7LMXC8eFTf3A=
X-Gm-Gg: AZuq6aIFRCc/g39dqgxqKolRsoKJwuBze8sErLpQJaAI7bQn76QpAklIC1REJHmOOL6
	PKsgkwuU0bwW2f+qcFMEr6HJfR3uWJmwTjmTFDIPCllXGD6wIypKDCqyxfDipnI4jIPKc8RqGFG
	0xGmIPnHG1f9QFtXzGmtoYaxnpmoFwpsMlMAiS5zy/MwXfM+rnMIkwc0ezaENXOq9ub/vBlWXSQ
	nT3HZaTN4SeOZfDgHaaIhX9gYzmhlDAdpZR3M0XnS+bAy3lNqSjLrR3DqpA+ceaIJrbrvZ3eXDU
	B8jYPhpGonnQXm0jyAdYNe4XDHjOHjCX5m1t8DqOpcO/bTnEJYYSJOuOx7V2woFmi7ca5c57ark
	iXuts6U07F4H7hDnPl2yjuogKNZ7nXsevpHy8Degrr9Z+1uhSt4s=
X-Received: by 2002:a05:6820:129:b0:679:88ee:e3f8 with SMTP id 006d021491bc7-67988eee8d2mr7916324eaf.68.1771589134921;
        Fri, 20 Feb 2026 04:05:34 -0800 (PST)
X-Received: by 2002:a05:6820:129:b0:679:88ee:e3f8 with SMTP id 006d021491bc7-67988eee8d2mr7916308eaf.68.1771589134515;
        Fri, 20 Feb 2026 04:05:34 -0800 (PST)
Received: from [192.168.29.235] ([49.37.133.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6799801b2cfsm8075610eaf.15.2026.02.20.04.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 04:05:34 -0800 (PST)
Message-ID: <55b6051f-dee6-4f05-96ac-e24752030d4c@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 17:35:24 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: bluetooth: qcom,qcc2072-bt: add
 bindings for QCC2072
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>
Cc: quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
        janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com>
 <20260218114955.3970974-2-vivek.sahu@oss.qualcomm.com>
 <af950713-4a0d-43ec-8000-3400f546acbd@kernel.org>
Content-Language: en-US
From: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
In-Reply-To: <af950713-4a0d-43ec-8000-3400f546acbd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mG7RP4dOs9z5giksbr6Ds4ffKVJqtLwx
X-Authority-Analysis: v=2.4 cv=dqzWylg4 c=1 sm=1 tr=0 ts=69984e0f cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=b6EVmk5gcm51ODEEWK3PtA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=2jaMIRPpbWfr_bONL7wA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDEwNSBTYWx0ZWRfX7k8c0h4ZbkVT
 nJLN7Q/LpcPMXobkPaDrO6NPFa6CuUirXvR+zRiGJmtChYwvMuMJ0zLa6pMN58Z3kl2HNefXk83
 ehTxHSpUMZlG6vDy1DlHrepquzYMdXt2hV2S24famgb+2UBE8VzT7/RIM+kPtshizBKgAgNGjv+
 w2nf5nZQPf6gqqvUymyR5hgrHv0nperAuj9zxU8jHWN5wYudYRCaec3B9icJ5dx4T5gn2pqdirX
 zOm94ask+OfeTRudmmc516hWPuJ7uL4H3dQZ9IsS6IYTC+qBf1kr+f5mY5beRGQBvxjN4zn10mM
 pmOB39N6oy6wL1v2fHvHApa7hTe3izjylN0L4J7q4mac/uXc2nkMLWlxtwm9s9uUbNZTnXmTGrJ
 is0yGpVcmYa/FOirtKzjaOOASVrUWWs6YV9PcUs3WrYNnoWd3wyc29bH7640xDfJr0uPFElMW8C
 a2ecd6CLlGOUrULemfA==
X-Proofpoint-GUID: mG7RP4dOs9z5giksbr6Ds4ffKVJqtLwx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200105



On 2/18/2026 5:23 PM, Krzysztof Kozlowski wrote:
> On 18/02/2026 12:49, Vivek Sahu wrote:
>> QCC2072 is a WiFi/BT connectivity radios which exposes
>> UART as an interface for Bluetooth part.
>> It requires different configuartions and firmware, so
> 
> different than what?
> 
> Also typo configurations.
> 
>> document it as a new compatible string.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 

Different configurations like interrupts GPIOs, firmware binaries, 
compat string. Commit msg, I'll correct it in next patch of this commit.

>>
>> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
>> ---
>>   .../net/bluetooth/qcom,qcc2072-bt.yaml        | 47 +++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
>> new file mode 100644
>> index 000000000000..7b27c2c651fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
>> @@ -0,0 +1,47 @@
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
> 
> Where are clocks?
> 
> Where are supplies?
> 
QCC2072 exposes M.2 UART as an interface for Bluetooth part. It doesn't 
require clocks and voltage regulators to power it up.

>> +  enable-gpios:
>> +    maxItems: 1
>> +    description: GPIO specifier for the chip interrupt.
> 
> Interrupt? No, it cannot be interrupt. This can be only enable pin and
> then description is redundant. Look at other bindings.
> 
> Looks like matching QCA2066, except missing clocks, or like other QCA
> devices with proper supplies.
> 
> I don't believe that Bluetooth device works without power.
> 
It is an interrupt to the HOST. I'll make it more comprehensive in the 
next patch of this commit. QCC2072 exposes M.2 UART as an interface for 
Bluetooth part. It doesn't require clocks and voltage regulators to 
power it up.

>> +
>> +required:
>> +  - compatible
>> +  - enable-gpios
>> +
>> +allOf:
>> +  - $ref: bluetooth-controller.yaml#
>> +  - $ref: qcom,bluetooth-common.yaml
>> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    serial {
>> +        bluetooth {
>> +            compatible = "qcom,qcc2072-bt";
>> +            enable-gpios = <&tlmm 19 IRQ_TYPE_EDGE_FALLING>;
>> +            max-speed = <3200000>;
> 
> No firmware?
> 

Firmware is required, it is just I've not added all the fields in the 
example.

> Best regards,
> Krzysztof

