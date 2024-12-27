Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ABC53389;
	Fri, 27 Dec 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296410; cv=none; b=opB7gPc6ANmNldtyKBd53KP7cN0WDBQAJ3iJJv4ndLri+C4z6VXg0mccWcK07J5Pj7+Q+FjI1ptbDHKlCY9LnOkYNJNuQJXYetbYftg02JVIa9SSD+U4IMnxo0mIwFJu867iUxqAG8uBae5IHUq1wEFh35yxX0LqPOwRM+E0nLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296410; c=relaxed/simple;
	bh=JquROV4pDFWLUiB2zdzoqLhzOf1r0FY8d5JbnZP7FpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H0Fc8vgZF/MYdpBKUHKN9aiUiM28Tmu9OnWpo51Ckq/gnPN9qa4Uj8x6d2+dhgrHhcSF7FieUc7V1RTY0hUvo3I1WlC7gRM3TSGxYMz5ZOaNiC2vBmw/maILcbHwDLL2V1b3K5PWVd1tTMKiCCv9XXnz53mY9MUR2qtM1S8U7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=isW1LHuD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="isW1LHuD"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BR8HXOc016239;
	Fri, 27 Dec 2024 10:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LXGdG9AgBX4AVDFU2E+Vofan9uWcvYli4EiAbqpajJg=; b=isW1LHuDdDc+xXM/
	XSbZGZvxC6EBylRgYZw5VPPXcMVHrMVIw+lD5tVjwFcoUHH3JEzC/bIozkRtbl4N
	1WAWMFT/DVLjeXbGtCTnwb2ydvrIptuwKOPwCqrYktkm54yG812v1GLhUZCmnHcr
	/1R9rVqzDfdfXmQCLI7hjAO5ZBqG5ktHA8xmvVXgEZslqR803qgbJAUprutGoQuN
	Gjyr/1xNlYbHSBXDV11HmFi2GBAsJzMsARLu8L/bNFVf3niZvVtHee7QnyR6vWS0
	HImzQWiQ2SSPgDm60+r4CtK1wwg4vRt3+7mTemgKaTgkyz41dZq9u93OK5MN620d
	Xp4QPg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43srkprwev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:46:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BRAkZGq012272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Dec 2024 10:46:35 GMT
Received: from [10.219.1.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 27 Dec
 2024 02:46:31 -0800
Message-ID: <d3bd97d8-43fb-452b-adca-ad03eb628031@quicinc.com>
Date: Fri, 27 Dec 2024 16:16:13 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] dt-bindings: bluetooth: update the wcn6750
 required properties
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Balakrishna
 Godavarthi" <quic_bgodavar@quicinc.com>,
        Rocky Liao
	<quic_rjliao@quicinc.com>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241223135700.22660-1-quic_janathot@quicinc.com>
 <20241223135700.22660-2-quic_janathot@quicinc.com>
 <mzfad53v2paz7cawaepvaqeht2rr5spxyctqrlniiqgyfyyqlv@ixhxcksd3guz>
 <c87b12d2-06cd-4982-838d-ecaa97572369@quicinc.com>
 <31ddcb1f-4606-4c5b-893a-179718ed6339@kernel.org>
 <d7b75672-4885-491c-9797-906261979e15@quicinc.com>
 <bfa6c330-6ba0-4361-aa6d-7ab7a61eb7f4@kernel.org>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <bfa6c330-6ba0-4361-aa6d-7ab7a61eb7f4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H8Q5aTHqgTDgHzogxbcX9IDqO3Qh-sn4
X-Proofpoint-GUID: H8Q5aTHqgTDgHzogxbcX9IDqO3Qh-sn4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412270087



On 12/27/2024 12:35 PM, Krzysztof Kozlowski wrote:
> On 26/12/2024 07:11, Janaki Ramaiah Thota wrote:
>>
>>
>> On 12/24/2024 6:57 PM, Krzysztof Kozlowski wrote:
>>> On 24/12/2024 12:51, Janaki Ramaiah Thota wrote:
>>>>
>>>>
>>>> On 12/24/2024 2:46 PM, Krzysztof Kozlowski wrote:
>>>>> On Mon, Dec 23, 2024 at 07:27:00PM +0530, Janaki Ramaiah Thota wrote:
>>>>>
>>>>> Subject: everything is an update... say something useful, e.g. use PMU
>>>>> abstraction for WCN6750
>>>>>
>>>>
>>>> Sure will correct it in next patch.
>>>>
>>>>>> Drop the inputs from the host and instead expect the Bluetooth node to
>>>>>> consume the outputs of the internal PMU.
>>>>>
>>>>> On which device?
>>>>>
>>>>
>>>> It is for BT module wcn6750 attached on qcs6490-rb3gen2 board.
>>>> will update same on next commit message.
>>>>
>>>>> But anyway I have doubts this is correct. enable GPIO is a pin going
>>>>> from the host, not from PMU.
>>>>>
>>>>
>>>> Yes you are correct, enable GPIO is out pin of host, but here updated
>>>> the entries required for Bluetooth node from PMU, not from host to PMU.
>>>
>>> Hm? No, you removed for example enable-gpios, which is input from the
>>> host. Sorry, I don't understand the reason behind this patch and commit
>>> msg does not help me there.
>>>
>>
>> We are migrating to powerseq for the WCN6750. As per Dmitry’s
>> suggestion, we are now using the on-chip PMU, which necessitates the
>> removal of some entries that are not mandatory to avoid binding errors.
>> For example, the enable GPIO is now handled by the PMU with property
>> bt-enable-gpios, as shown in the patch linked below
>> https://lore.kernel.org/linux-arm-msm/20241209103455.9675-3-quic_janathot@quicinc.com/
> I don't understand why this patch is separate from the others. Entire
> context is missing and nothing gets explained in commit msg.
> 
> Best regards,
> Krzysztof

Thanks for the reply Krzysztof,

* Initially sent the below patch which enables Bluetooth for the 
qcs6490-rb3gen2 board.
  
https://lore.kernel.org/linux-arm-msm/20241009111436.23473-1-quic_janathot@quicinc.com/

* Then Dmitry recommended implementing pwrseq to enable/disable 
Bluetooth for the wcn6750 Bluetooth module.

* Then we sent the below patches with pwrseq in v5:
   - [PATCH v5 1/4] regulator: dt-bindings: qcom,qca6390-pmu: document 
wcn6750-pmu
   - [PATCH v5 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable BT node
   - [PATCH v5 3/4] Bluetooth: hci_qca: use the power sequencer for wcn6750
   - [PATCH v5 4/4] power: sequencing: qcom-wcn: add support for the

   [PATCH v5 1/4] and [PATCH v5 4/4] were reviewed and got merged.
   [PATCH v5 2/4] and [PATCH v5 3/4] received Reviewed-by: Dmitry 
Baryshkov <dmitry.baryshkov@linaro.org>

* But we got the following warning messages for [PATCH v5 2/4] from Rob 
Herring (Arm) bot:
   New warnings running 'make CHECK_DTBS=y qcom/qcs6490-rb3gen2.dtb' for 
20241209103455.9675-1-quic_janathot@quicinc.com:

   ```
   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 
'enable-gpios' is a required property
     from schema $id: 
http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 
'swctrl-gpios' is a required property
     from schema $id: 
http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 
'vddio-supply' is a required property
     from schema $id: 
http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 
'vddbtcxmx-supply' is a required property
     from schema $id: 
http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: bluetooth: 
'vddasd-supply' is a required property
     from schema $id: 
http://devicetree.org/schemas/net/bluetooth/qualcomm-bluetooth.yaml#
   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dtb: pinctrl@f100000: 
Unevaluated properties are not allowed ('qup_uart7_sleep' was unexpected)
     from schema $id: 
http://devicetree.org/schemas/pinctrl/qcom,sc7280-pinctrl.yaml#
   ```

We got these warnings because the binding file `qualcomm-bluetooth.yaml` 
was not updated as per the new bluetooth node entries in P2,
so we removed the entries from the required property for the Bluetooth 
node and sent it as v6 PATCH-1.

We will update the commit message as below in v7:

```
[PATCH v7 1/1] dt-bindings: bluetooth: Utilize PMU abstraction for WCN6750

We are now using the on-chip PMU node for power sequencing to manage the
enable/disable functionality of Bluetooth. Consequently, the inputs
previously marked as required under the Bluetooth node can be removed.

For instance, the enable GPIO is now managed by the PMU node with the
property bt-enable-gpios, as shown in the following patch:
https://lore.kernel.org/linux-arm-msm/20241209103455.9675-3-quic_janathot@quicinc.com/
```

Best regards,
Janakiram



