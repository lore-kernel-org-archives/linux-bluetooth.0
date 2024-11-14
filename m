Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFF1EBFE2;
	Thu, 14 Nov 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731567475; cv=none; b=DjoIzXjYiF2ur5M5udeAapZxRI6OFCyI8Q9DLfwFSquDYnyh4n0NizcCRl8tF5NhLdUDzGU3Hhog7WpkzFBP/AstIQLyWDfqu/9WPZop3VNJEdDAw7P2gEEb49VvZZW3Pc1FMZqKmByC5ktlA0IF0pBUQJO+W0Yk2UT8n7ln2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731567475; c=relaxed/simple;
	bh=l4H+hQPO5b4/NrVCRCWuW2U0+ftKonNXrijL/aD8d00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aN9qbAZZEWXiFbRaFnmRmVL3KQsR3M2I3hEobzZIyzejjNjzu3S3us7lgY2/vcHkM11pj+5CISfwRMk1QpC2r41cl27w5/lcVMBHs6IzkCCoaSHoqiqPqi8HrY7JLeovzZhH4HcffuWTT+M/eDcrOlTjQ88BbXgwXUXtt9dGezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d1w0PsgQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d1w0PsgQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE6AGWG015430;
	Thu, 14 Nov 2024 06:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VEovP3YhphlNBRaWvDDlKMCS3rTWbug4MpaSe0edN0E=; b=d1w0PsgQtkSquWAS
	zBKaKIMD8CA0G00fgPWt31DIy4wDrmMc0i4pFu3jNySp4JzyHhq1Yqahc0Diazdo
	uZMNshwiVQH2oJO2UvKGpVslhB/vZvRjiqKFzsEmsFD3H763DUeSOZ6l2hll3iBk
	P6QHHN/xFf8obZ469hNUZ4PxZtRgtR/rVKC4R/7MLMdBSawNj+cq6B/j7lTRd1A4
	6HXZuvVE9Imm+X8bzf4UFpcx49eHxv45StuYcin6MjAbvjOUBUdBEGfwP1nbAy9n
	7aAWfgCh2Rs4PIh4I7WHb/t5yxSNORsJ9RiWA/hP1KHWMTC6TCswjUIZbAmYcIKz
	YDKlMQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vsf33dqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 06:57:50 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AE6voVZ005550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 06:57:50 GMT
Received: from [10.253.78.176] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 22:57:48 -0800
Message-ID: <5549d7e4-06cb-4305-8cec-10e93e5fbbff@quicinc.com>
Date: Thu, 14 Nov 2024 14:57:45 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA NVM file for the X13s (WCN6855)
To: Johan Hovold <johan@kernel.org>
CC: Tim Jiang <quic_tjiang@quicinc.com>,
        Janaki Ramaiah Thota
	<quic_janathot@quicinc.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ZjNxfFJmCgIyq8J6@hovoldconsulting.com>
 <5aea3149-ba44-400f-acc6-1a3eca8a7e72@quicinc.com>
 <ZjOUWqor4q1Efy0W@hovoldconsulting.com>
 <f1b45d7d-27e0-4ad7-976c-670a0e0d136b@quicinc.com>
 <ZjOfdK41yLwkH25T@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <ZjOfdK41yLwkH25T@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JDmExshAwx5bB7S0aaPyjtLukzQ63iqr
X-Proofpoint-GUID: JDmExshAwx5bB7S0aaPyjtLukzQ63iqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411140051

On 5/2/2024 10:13 PM, Johan Hovold wrote:
> On Thu, May 02, 2024 at 09:46:38PM +0800, quic_zijuhu wrote:
>> On 5/2/2024 9:25 PM, Johan Hovold wrote:
>>> On Thu, May 02, 2024 at 08:56:12PM +0800, quic_zijuhu wrote:
>>>> On 5/2/2024 6:57 PM, Johan Hovold wrote:
> 
>>> It's WCN6855 but the Linux driver currently uses the firmware you pushed
>>> for QCA2066.
>>>
>>>>> The current Linux driver is using the generic NVM file (hpnv21.bin) for
>>>>> WCN6855, but connectivity is quite bad and I only get 2-3 meters of
>>>>> range.
>>>
>>>>>> Switching to the board-specific NVM configuration (hpnv21b.b8c) that
>>>> it seems hpnv21b.b8c is a wrong NVM name.
>>>> is it hpnv21g.b8c?
>>>
>> hpnv21g.b8c is the right NVM for the machine.
> 
> Ok, thanks. I'll try to find some time to test with this one as well.
> 
>>> What is the difference between those two?
> 
>> i am afraid that i can't answer your question due to company CCI policy
> 
> I understand.
> 
>>> Exactly. It's a Lenovo machine that comes with Windows pre-installed and
>>> we're working on enabling Linux on it with some help from Lenovo.
>>>
>>>> need customer to make a request for their requirements if the answer is
>>>> yes for above question.
>>>
>>> Lenovo has made requests for X13s firmware from Qualcomm and pushed it
>>> to linux-firmware [1], but they have not yet been able to get Qualcomm
>>> to provide an NVM configuration file for Bluetooth (I think the problem
>>> may be finding the right person to talk to inside Qualcomm).
>>>
>>> So I was hoping maybe you could help us with this since the difference
>>> between 'hpnv21.bin' that you pushed to linux-firmware and what came
>>> with Windows appears to be really small (e.g. just a few bytes).
>>>
>> let me try to find out the right person who will push this task at next
>> monday.
>> there are some other internal procedures before we can push BT firmware
>> into linux-firmware.
> 


have up-streamed 22 NVM files which come from WOS into linux-firmware as
shown by below link, both hpnv21g.b8c and hpnv21.b8c are also contained.

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=77a11ffc5a0aaaadc870793d02f6c6781ee9f598

(^^)(^^).

> Much appreciated, thank you.
> 
> Johan
> 

