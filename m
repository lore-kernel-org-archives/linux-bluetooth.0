Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50614205E26
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713591567; cv=none; b=GLQBE689WFQSwZFZXw0CNaHyZ5SbtO9yyTPIQpSxKSswhbyvXHSmU9Lx8vXnturV6zxxY+hvaOO18VdfDoANq3SP0dkWSvyzvnwPNXrWViQUwDUp9zSWDGRLU6JaPGCqGp4o3XlcVhukSmrcn+DtQRO1pBTc481hqvoaPs9j3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713591567; c=relaxed/simple;
	bh=BoqPsMjCXHWYo3OnPwQvc3pieaMld7xvEcCeywVnZf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fnRlFccrLzWTFoydpxDYyeqD6llnqkahXP1vdYplRvZWpR9y7BdwmmldGI6EsB4Gdwwj3sQaoqrilOOLCCJf1/i1/bD+qfmpq1udammegoXZKxZ1jpBKDorikabyqvJ0/1SsgYlfEpejRVJI9z0xlF2FLALZsZpyG2VOGXHBhiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iHKuWqF/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iHKuWqF/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43K5JaOK007423;
	Sat, 20 Apr 2024 05:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=saZAIDfIZFWCRSMlz2+POxON2lTASroliJcSzhoNZFM=; b=iH
	KuWqF/RG9ryRZc92rqgCMMii6+Lq0vMJWWJgiEG5vAhkD025+TBfDTAsCabh47Ww
	iZsm0hjto/cd1DMrE/RsZe82bBThe5Lw5X0PoUSu02sYXAP7LvKZqO7FoK2YO1A2
	c1sbZeM2JjNtlcBFj3mGMtQq1PsqTM+62ziWGiaV88eS1XvoA4D7KR6ju62+qLGR
	qLf6yRdEmGYh+LZ6eR+XI+IlfzxzctTlubS6pOXNj8Ff1GRJmhUK9/a1xSYjvmfv
	URw3H+fVBH0/0e4/bMhKb0NoaOcK2Fb0IpnBYuDOT6BvgL56YGcfu122iOJ6IUH5
	acpcEHRa5rQE0mmTQeUQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm63a047r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 05:39:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43K5dHBQ004404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 05:39:17 GMT
Received: from [10.253.76.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 22:39:11 -0700
Message-ID: <7c5d3318-b68a-46d5-934d-9c596e9c9c68@quicinc.com>
Date: Sat, 20 Apr 2024 13:39:09 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
CC: <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <wt@penguintechs.org>,
        <krzysztof.kozlowski@linaro.org>, <kernel@quicinc.com>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com>
 <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com>
 <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
 <d6aa48e7-ab87-4014-894e-5b6da4d42687@quicinc.com>
 <CACMJSesFObL9V9toRvnH7d4KNi5pnfzpff+7gZnrq68ZgP7vLQ@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CACMJSesFObL9V9toRvnH7d4KNi5pnfzpff+7gZnrq68ZgP7vLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y00AkViijc8DWfBOZn5giFSIwZkolcSE
X-Proofpoint-ORIG-GUID: y00AkViijc8DWfBOZn5giFSIwZkolcSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_04,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=780 clxscore=1015 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200039

On 4/20/2024 5:27 AM, Bartosz Golaszewski wrote:
> On Fri, 19 Apr 2024 at 01:36, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>> On 4/19/2024 6:42 AM, Bartosz Golaszewski wrote:
>>> On Thu, 18 Apr 2024 at 23:43, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>>>> we will fix it by right way if EPROBE_DEFER is reported.
>>>>
>>>
>>> What?
>>>
>> will fix the issue if anyone meet and report they meet the error that EPROBE_DEFER is reported.
> 
> No, this is wrong. Anything other than NULL or a valid descriptor
> pointer returned from gpiod_get_optional() means: an error has
> occurred and should be handled accordingly. Please improve the driver
> by bailing out in this case. Or wait until next week and I'll send a
> follow-up to my patch myself.
> 
i think we don't need to focus on this point as commented at below link
https://lore.kernel.org/all/01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com/
> Bart

