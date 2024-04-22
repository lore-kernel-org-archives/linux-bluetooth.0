Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E202F502A4
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774107; cv=none; b=gNO+e3f8L4morb//TsvgOlh6xmSzMSR6iVl16bF5wOLsvh06dsH//45x2FqALqWN2+frG5dgVAoORnKwhBtg2BpjRXm1H+guq7KvnwnyT2jhLzjGTXkB2BvthGtAtMNsQAEV74gaPMkP3G94MR4fVRy+WrbN4nK37HHHhb3l/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774107; c=relaxed/simple;
	bh=IXJ+3/V2na/3VQVBrmHPdRzxDZWevBLI1qsr17nLosY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wxm6wKaHH7vQ4qDXRxCoaW3nmRTuuCLySLMoohfM8Nva7a949oPGZY3Up1NRKmeQtDWk0pdJzxPid1JEeUhmsktI7pb64mB1xdBrLmJdRsTddRWlutLfLIuFV3rPX8yqL0cBYsGRFiC11HGqoH5RmYZqbK0jcC58NQq0YIcmRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T/ufbzbS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T/ufbzbS"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M6OD8b022775;
	Mon, 22 Apr 2024 08:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=67zVCJ5NFdmZSWg0h2fvqC7+7+tJSOX7Ys2zxU/19ow=; b=T/
	ufbzbSh+4/K0dusBXeqoNKPs0+vz9bRmRxupIeBPsld9lI0gGPIXJq2gGD4wCvmG
	9sDZchyiPb4msN9V3Mux6/axWFYyul8ZqBGJEU8MJVSO7pS7EWpR/EfwDvR9hK6H
	aADb6iMkzpFSIyk5oTjyQVzX4eKmsIuv/9xfvaXa1fD+krngLE09YR7xQWR8KHej
	EIgeJEsD3Al7Z/5rb26CkoTDBf1fDI92OJ1RuPYR4OETtf4r++p+OpTVRSE3Lgfn
	L+zzs8Z+IvHnDpht9/6py5nQc6bpro6+MtDnzhNXNv5c96guHeYuNqQyck1o9Y4m
	8o/CgMqsimHBz5vj9C0Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6vrbfen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 08:21:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M8Ldds010202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 08:21:39 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 01:21:37 -0700
Message-ID: <3b0db71a-8473-4bb6-849b-04b647bc5b25@quicinc.com>
Date: Mon, 22 Apr 2024 16:21:34 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix two regression issues for QCA controllers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <luiz.dentz@gmail.com>, <luiz.von.dentz@intel.com>,
        <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, <bartosz.golaszewski@linaro.org>,
        <wt@penguintechs.org>
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <3ab33f9c-206a-4c77-816a-471769591b6c@linaro.org>
 <8e2b0731-fc0e-446e-af83-478e6e86a7ad@linaro.org>
 <04211e34-5a6b-45ec-91f7-60aaf0b6e2c5@quicinc.com>
 <8b767a0b-5c5e-4128-9daf-7aad6378880b@linaro.org>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <8b767a0b-5c5e-4128-9daf-7aad6378880b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: waTvmQNQovEVhefBljcf_ZWoKWkLZgs3
X-Proofpoint-ORIG-GUID: waTvmQNQovEVhefBljcf_ZWoKWkLZgs3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_05,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220038

On 4/22/2024 4:11 PM, Krzysztof Kozlowski wrote:
> On 22/04/2024 10:07, quic_zijuhu wrote:
>> On 4/22/2024 3:44 PM, Krzysztof Kozlowski wrote:
>>> On 20/04/2024 13:01, Krzysztof Kozlowski wrote:
>>>> On 20/04/2024 00:03, Zijun Hu wrote:
>>>>> This patch series are to fix below 2 regression issues for QCA controllers
>>>>> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
>>>>> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390
>>>>>
>>>>> the links for these issues are shown below:
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>> https://lore.kernel.org/linux-bluetooth/ea20
>>>>
>>>>
>>>> Provide changelog, either in cover letter or in individual patches under
>>>> ---.
>>>>
>>>> Do not attach (thread) your patchsets to some other threads (unrelated
>>>> or older versions). This buries them deep in the mailbox and might
>>>> interfere with applying entire sets.
>>>>
>>>
>> sorry, not notice this.
>> in order to send vN patch sets.
>> do i need to --in-reply-to  v(N-1) cover letter or v0 cover-letter ?
> 
> No. b4 or git send-email handle everything correctly. Read go/upstream
> before posting. If you ask such question, I doubt that you read it.
> Eventually get someone experienced to help you with this.
> 
actually. i have read go/upstream many times. but b4 is hard for me to
use. so i always use git send-email to send patches and use thunderbird
to reply mails. we get someone to help.
>>
>>> How did you implement these two feedbacks?
>>>
>> actually. i don't understand that two feedbacks so ask above questions.
> 
> You did not ask questions. You ignored that feedback and kept sending
> patches, pushing for your point of view and responding to review with
> unrelated sentences.
> 
i now understood your feedbacks and concerns about format.
> Best regards,
> Krzysztof
> 

