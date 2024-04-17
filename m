Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEB8F516
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346918; cv=none; b=EIiGEDsXS56gr7kDYDzdsAjfy+7PmJJWyZclvZsDF8Qn9X9+kg8k7zv3xjZx4J8xMJaBbTdFWh4g7JhcwuxO/k1tf3GLfWY75QM/4xIj/MgfGCTOu+Mz3sn0fqdAREMT+5trx2nqxrzby3TJDGYM9/d9Q0aYHHyQrpaMYU8tn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346918; c=relaxed/simple;
	bh=nvlyARm6xais6hQNzrSH+DcBkgDtUnC3FwUUhvdjiqo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=FhYFApE09vb2+jteVSCHNpRs2p5rf0cOPrkifyObj/WvkJGWPB6k5NaTPLL3yta/yNFo80z07blZVav6aelJUFKxxBIwuzFTNkXhhdFrLSu9s9eQi4rEs9v7kYE1FcwzCXlDeVf2S5uPeEn8kRpzn17QDQMvn+L+AyTCuIiMf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iQ7puri7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iQ7puri7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H5Tbq8031801;
	Wed, 17 Apr 2024 09:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3qqd2mqC7XL+hgBKSWmVBItIlB7gpEskxSDXUmBlFGM=; b=iQ
	7puri7ZcCvZlKR86Sqv9zs7wCN3LnfiFffiKFUbHDcsoQYHE+kWSQjRkLQbybWZy
	vCXO491F47nSUtftffJGaywDZIX0iMtEk+Y7iPzgb4WCsZa21BGfE3ONbtT5gAj/
	bPGCkwAyr+7hBT12SCefa7q/+gayzuOWodmPbdgeMLpCbm6+tfyZL0l0ttDTtLiO
	c4j6dfIx9YY4rcW6o8VnijrxSCyRJLPJCO7xtHsTEv7gGGGmu9XfL3tgH0Z2NyBA
	y68dlxpEfELeszSnznf4kta88gOw7nMoOpFmtkqHVoZXryILZnij3hsS33psEurq
	AeezFqzoJkHOYokLZeoQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj8aurht1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 09:41:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H9fm9I030611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 09:41:48 GMT
Received: from [10.253.9.153] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 02:41:45 -0700
Message-ID: <1657fe63-20d6-4617-813d-99eae7e674be@quicinc.com>
Date: Wed, 17 Apr 2024 17:41:42 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Fix nullptr dereference for non-serdev
 devices
From: quic_zijuhu <quic_zijuhu@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <johan+linaro@kernel.org>
References: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
 <Zh9saGbOl-fXP6SD@hovoldconsulting.com>
 <5e4e62c8-d17f-45fd-9212-088eb026dc7b@quicinc.com>
 <Zh91zq13nZvH3-Yj@hovoldconsulting.com>
 <4dac0caa-629d-4b4d-ad54-f6ab15268524@quicinc.com>
 <Zh-JNzlskY6ZvsSm@hovoldconsulting.com>
 <4313bcc9-8fbf-477d-90f2-013681cdebb9@quicinc.com>
Content-Language: en-US
In-Reply-To: <4313bcc9-8fbf-477d-90f2-013681cdebb9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f6BP5uGixGbuZEZJlGekV_2BeqIk6rdY
X-Proofpoint-GUID: f6BP5uGixGbuZEZJlGekV_2BeqIk6rdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170067

On 4/17/2024 5:38 PM, quic_zijuhu wrote:
> On 4/17/2024 4:32 PM, Johan Hovold wrote:
>> Again, make sure wrap you replies at 72 cols and trim unnecessary
>> context:
>>
>>   https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions
>>
>> On Wed, Apr 17, 2024 at 03:32:51PM +0800, quic_zijuhu wrote:
>>> On 4/17/2024 3:10 PM, Johan Hovold wrote:
>>>> On Wed, Apr 17, 2024 at 02:51:38PM +0800, quic_zijuhu wrote:
>>
>>>>> i have submitted below patches to add supports for all other
>>>>> non-serdev controllers.
>>>>
>>>>> https://patchwork.kernel.org/project/bluetooth/list/?series=844120
>>>>
>>>> Ok, you need it for some future changes, but I'm afraid that adding new
>>>> random vendor specific ioctls like you do in that is series is a no-go.
>>
>>> it is a generic ioctl, for QCA, it is used to specific soc_type. it
>>> maybe be used by other vendor driver to set user specified info.
>>
>> In it's current form it's a vendor specific hack that is never going to
>> make it upstream.
>>
> no, i don't think so.
> 
> 1)
> ioctl()'s designed purpose is to complete such non-standard config.
> 
> 2) present ioctl HCIUARTGETPROTO which is not exported is used to specify which vendor protocol is used
>  is it a a vendor specific hack?
> 
> 3)
> hci_ldisc driver don't touch user specified settings and pass it into vendor driver directly
> does it has any problem?
> 
> 4)
> for tool btattach. it does NOT get any board config info from DT|ACPI compared with
> formal BT driver. so i introduce a new ioctl to supplement such info when possible
> to make btattach work.
> 
>  
>> For a start, you don't even make sure that the types becomes part of the
>> ABI, which means that passing, say, type 5 can mean different things
>> depending on the kernel version.
>> it is specified by user and ONLY be parsed by vendor device driver.
> it is user's responsibility to specify the right value. 
> so i also don't check and care about its value and it don't need to change any code
> for further added any new soc_types.
> 
> moreover, tool attach is mainly used before the final product phase. namely, its is mainly used
> by developer and customer's evaluation.
>  
>> Can't you just retrieve the device type from the device itself? If it's
>> already powered, you should not need to know this beforehand1) it is the simplest and lowest risk fix
> 2) different soc_types have different responses when read its IDS as shown by qca_read_soc_version().
> 3) the way you mentioned will involve many changes and it also means high risks for many current soc types.
>> Johan
> 
BTW, it is the simplest and lowest risk fix for tool btattach
