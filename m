Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A18481C6
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713654081; cv=none; b=fqRC5EYdpFRHxmbou2FvH7Ye4QlSOuAqD1jU1kU+yWO/qh+ygsSwkcNXP0tg5cDgaIP9VS6vNDq1PbCEUnpJyQtUlZulanAX4rpoWoVn1pyiNCFemXCzj6syzFleni8UHtKtomLjbXO7qtCH34h2sLgSkY0eK8OAvY1SPBThuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713654081; c=relaxed/simple;
	bh=XAkEr+z7GVWqL9tnldpCNolqZQA3KzU8wHTKTCks89Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pgv5VOWTELwNAdgqQ9iBxo1yt+qX3PQ/tihDJaYRZ5z5Fpo0nUyAxIIGtkVUfBphPHiDwnwK9Qhmk0lvft8HairG1+QNaNjnhX47P+8wnTNWe1Bl84YzfM6bSrwUuLHazr5Q4grzeslnq/PktJSs9BBMGYR0ETauNNQT01oRS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XMM/7quZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XMM/7quZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43KMs4nv029547;
	Sat, 20 Apr 2024 23:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=pM4Ew34uqts2BjrsnQzb+csi6lgKripd95C16l/d7ww=; b=XM
	M/7quZyJaabCLSeMMrsdDToRQYsgT4WEG5BsiFlAhe2BvqiCPBUeW8GEBqorkMJb
	JT7VZU/HiAKIZCdwcngyZJOUxkVB4gFbcxZ0bmgpQNXnGtOxe+sSs4skeCw2ihZd
	YM6OOWuocuzmZigzkOA9N/xLfyZT7SSFSWiBl0tv+KNY5YOwqlV1UesHFdnnuRj2
	qWrhmBQ1r0RZgvEs1D6jQM0S6ZXtevW/F6kodSUCX9rl/SKvDzrFGj3rc8FAC00N
	hjJUqgcJ4ga5RLvLOim5NuQFO1D7d+Q/0u0hL4elQNDs4Kk7+E9Wz3fAuOwR2WO7
	Bc+Jii9HFEJoPWMAQ/4A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qd9gv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 23:01:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43KN1DEO014059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 23:01:13 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 20 Apr
 2024 16:01:07 -0700
Message-ID: <d8cefee4-6880-4beb-acd9-c5779fabbff7@quicinc.com>
Date: Sun, 21 Apr 2024 07:01:05 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <bartosz.golaszewski@linaro.org>, <kernel@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
 <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
 <52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org>
 <0dca7c9b-6a97-4171-9b0c-5b806a4e8a60@quicinc.com>
 <4e4d8ee0-fbbe-4dc7-b40b-b983f9f39539@linaro.org>
 <01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com>
 <2166fc66-9340-4e8c-8662-17a19a7d8ce6@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2166fc66-9340-4e8c-8662-17a19a7d8ce6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RByq-6CWrzPMRkCaFfpNljYx2Onc6Mwi
X-Proofpoint-ORIG-GUID: RByq-6CWrzPMRkCaFfpNljYx2Onc6Mwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_20,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200170

On 4/20/2024 7:13 PM, Krzysztof Kozlowski wrote:
> On 20/04/2024 07:25, quic_zijuhu wrote:
>> On 4/19/2024 9:49 PM, Krzysztof Kozlowski wrote:
>>
>> Hi Krzysztof,bartosz,
>>
>> let me summarize our discussion here in order to reduce unneccessary
>> disagreements here.
>>
>> 1) i only revert your change IS_ERR() to my change IS_ERR_OR_NULL.
>>
>> 2) your change will cause serious regression issues for many lunched
>> products
> 
> Instead of repeating every time "serious regression" can you actually
> explain the problem?
> None of commit messages from v3 help there.
> 
as shown by below link
https://lore.kernel.org/all/1713650800-29741-2-git-send-email-quic_zijuhu@quicinc.com/

there are no v3 patch for patch serial with this tile
the updated patch serial tile is "Fix two regression issues for QCA
controllers" shown by above mentioned link.

let us discuss it with the updated one.

v3 of the updated one has good commit message for this issue. you have
given reply with the v3 and it seems you understand what is the problem

>>
>> 3) we only need to discuss how to handle devm_gpiod_get_optional(...,
>> "enable", ...) returning NULL since this is only difference between your
>> change and mine.
>>
>> 4) your change doesn't solve any actual issue and the reason you
>> submitted is that "The optional variants for the gpiod_get() family of
>> functions return NULL if the GPIO in question is not associated with
>> this device, and should not treat it as error".
>>
>> code applet of your merged change is shown by below link
>> https://patchwork.kernel.org/project/bluetooth/patch/20240208164017.26699-1-brgl@bgdev.pl/#25705104
>>
>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>  					       GPIOD_OUT_LOW);
>> -		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>> +		if (IS_ERR(qcadev->bt_en)) {
>>  			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>  			power_ctrl_enabled = false;
>>  		}
>>
>> 5) Original BT driver design agree with your point mentioned at 4), so
>> for case "qcadev->bt_en == nullptr", qca_serdev_probe() don't do error
>> return for this scenario and use dev_warn() instead of dev_err() to give
>> user prompt.
>>
>> 6) your wrong fix changes flag power_ctrl_enabled set logic and will
>> cause serious BT regression issue, hope you will realize this point.
> 
> Sorry, not realized and you did not explain it. Neither above nor in
> commit msg.
> 
now. you understood why your merged change as shown link of 4) have
problems and introduced our discussed issue, right?

>>
>>
>> i would like to give below extra comments even if these comments are
>> irrelevant to the critical point of this issue mentioned at above 3)
>>
>> A) you need to investigate it is a) the prompting approach or message
>>  error or b) the if condition error even if if dev_err() is used to give
>> prompt instead of dev_warn() in above 4).
> 
> What?
> 
>>
>> B) don't talk about how about devm_gpiod_get_optional() returning error
>> case since it is meaningless as explained by above 3). also don't
>> require a fix to fix another unreported issue. a fix is a good fix
>> if it fix the issue in question and don't introduce new issue.
> 
> What?
> 
>>
>> C) per DTS property enable-gpios of BT, different soc types have
>> different requirements, many are required and another many are NOT
>> mandatory as shown be below link.
>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml.
>>
>> for a soc type which are attached to 3rd platform, customer doesn't
>> would like to or are not able to congfig BT reset pin within DTS for QCA
>> driver even if QC strongly suggest customer config it and also be marked
>> as required within above DTS bindings spec link. i often meet this
>> scenario. there are many of such lunched products.
> 
> So where is it documented? Where is it explained? Which binding or which
> commit msg?
> 
>>
>> i will try to fix this issue due your change product by product in new
>> patch thread based on this DTS comment.
>>
>> D) you maybe ping me offline about this issue if you are a member of QC
>> since you known "go/upstream"
> 
> Please keep all discussions public, unless your customer requires some
> sort of confidentiality. Although even then I would argue that you can
> hide company secrets and discuss about hardware.
> 
> Best regards,
> Krzysztof
> 
> 

