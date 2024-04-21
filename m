Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335610965
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713692435; cv=none; b=gbUJBC7k5CI9ucm82L/ERnuZcLV5wGWXOPru+FT5RfZxGJ0kC5ofEIe9s8yLGvDbyCy7I1Ys1uGvm7pynAWMiPihyJsOwHzeVZFWHivNQU2lowD3djVLD8AnY0YCPWDYNql48U2wXT1Uu/nIJNOBm8wFQVIavBtfljuDDkzwLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713692435; c=relaxed/simple;
	bh=uTDk0T+lz8Wm9g22jATKdSJGpnSpp9St0Wghq2EeHuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cz64j6RbGa+xPXz89TFsFngkXtoSs68wtRDKp1u2bWh/z915rbGOF5D5xNqo1o6+aL5QIzEsHi9xjLjc/8OIVRIEbowJ15rKnxvoDRvId4FE4FUALLKRl6f2qhutU9NxzuObPIIv5QBQulxhvZAzpkI/kg3+LXy7XbbYBB6DySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i9bkXRt2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i9bkXRt2"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43L8o9f4016776;
	Sun, 21 Apr 2024 09:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N5iqUVGRp9PcTf7Eyc0M/mbCXlvZGwtBSf2FEZHzajE=; b=i9
	bkXRt2MZzrTauLGOP2MR1zCTtFXVqEnreplqeDttSuSz8oZ+qAoaurQ39UXM+qWv
	AgSahHkW7+Z4cmnEQixF1N+e93mWPQTunR+BrqNriyB7W11Rwl6ZK/k2MjPCr46q
	XeDLazUrlVuPtg3q+zguJAFy6c2AwXeMLMmcdLun8feF5TWJi0wcZtDAho5kGPed
	oJBk+f0X5wgTfGnZH1VzCwWC6+ZNRVnGgBCHftQIonE5z5NDP7nJGpg26lKU2oXp
	38U6G7wOgDOgSTeZaGVf9RIxZlzKmrwAHiloBeh3qTmRAILiobRSrKfESrZQvxk8
	a0J9SMZJEnwqC+KvrQGw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm5sx20fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Apr 2024 09:40:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43L9eGWa022769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Apr 2024 09:40:16 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 21 Apr
 2024 02:40:14 -0700
Message-ID: <cd6539e1-3d6c-4174-96cd-838fdaa9288c@quicinc.com>
Date: Sun, 21 Apr 2024 17:40:12 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: Wren Turkal <wt@penguintechs.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
CC: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com>
 <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com>
 <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
 <5c9a57ba-d516-4d3e-85e5-bba299ee97a6@penguintechs.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <5c9a57ba-d516-4d3e-85e5-bba299ee97a6@penguintechs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DsYnwDQjVOOzs6CagvQChpPAnG1iLcgf
X-Proofpoint-GUID: DsYnwDQjVOOzs6CagvQChpPAnG1iLcgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-21_09,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=969 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404210062

On 4/21/2024 3:14 PM, Wren Turkal wrote:
> On 4/18/24 3:42 PM, Bartosz Golaszewski wrote:
>>> 1) do you meet the case that EPROBE_DEFER is returned ?
>>>
>> It doesn't matter. It's about correct usage of a programming interface.
> 
> In case you are not aware, this apparent correct usage of the
> programming interface breaks real hardware. As a kernel user with this
> problem, I am just wondering if we expect a fix to land before v6.9 lands.
> 
> If we can't find the a fix that has "correct usage of the programming
> interface" before 6.9 closes out, would we be able to revert this change
> considering that it causes a real userspace regression in that the BT on
> some laptops simply don't work now? I guess I am asking if this
> theoretical correction more important than breaking actual currently
> supported hardware?
> 
> Real users like me are hurt by this. In my case, I am using a laptop
> that was shipped in 2020 with Linux by Dell that included working BT
> support. I now have broken BT hardware that is barely usable at all.
> 
> And as a kernel user, I thought the kernel had a no regression policy.
> Granted, I don't know the specific details of how it works. Does that
> policy include support of widely deployed hardware?
> 
> Just so you know, I am just trying to understand what to expect.
> 
> Also, I want to offer help. Is there anything I can do to help y'all
> reach a resolution?
> 
> Thanks,
> wt
per QCA6390. we have correct usage of a programming interface.

as my reply at below link, we don't need to take care bout
Bartosz's question since it is not relevant with this issue.

https://lore.kernel.org/all/01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com/
