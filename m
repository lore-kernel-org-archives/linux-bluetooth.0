Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B640850
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339185; cv=none; b=MTbCNlbqLEXgOMn9Uk8Ir9UiS7DH5VQnWcOu38HSiZf5kRRjRE7M3p6u2UU3wiyT0gS0UK32vVqg0Tjd22GB7YiXQEvN1WqU2JvMy04mPJN9bkGOrijPHO+Hdrf9rJ00Munbp/4I0Mu3TxWouiwOGICWdkzMpdJXlEXGxSvDG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339185; c=relaxed/simple;
	bh=949QaVPVIHO/I9VKk0YvzSZNjcZEkQ1S6xVgFSUizIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sCRJgd3kLbezMBQ7+XeOeX6MnyVRAOLTdxBE4ZPZQM8z4OsOhgeRABsOhCo9aWVAngKsjsFJV57n0oJV9B2dpfGV10+bMT2LXa49er3Sxeep6jVApVurZ2Zosk+6J655wr7oUSNNp/zr6dPUnOg+h3m56fIZK8KkLsXvwlSISSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pV2sk9xS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pV2sk9xS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H6UJmM005338;
	Wed, 17 Apr 2024 07:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gM8tw53IUsd0VqDPB26TylIwgd1OwGNVK+88ErKJiBM=; b=pV
	2sk9xSpvFGjrsy3Egqxja3I3wlYI18Ya8dsioIhbqFMRowdl4fCy9U2jFdC19vep
	5UTavoCSrvkECEmjpCaMnqVMjsUPFBn9dH0CgbPlu+iGqDbfvNF/kZxmjC5lOHnl
	BIovqd3ZkFcHeUx5lCfOf8tD1v66iWwINGLHnF7c9vIbDtvHCTfGJrSJTTbMx6Af
	rjbwzxFasGhioiPKlhEfh6bhhjNlInX8yUFfoU5En8dWh42vFmfkE1gc302G7Bkd
	SVEWTVRKbHPtU8e3hTkIU2CHFXMbanFRz0TjE533uOW4XEvQcjtOA9Vgmx8wXBwa
	0TD2mf7O5vSP3XArFI1g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj704rdku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 07:32:56 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H7WtwE002733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 07:32:55 GMT
Received: from [10.253.9.153] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Apr
 2024 00:32:54 -0700
Message-ID: <4dac0caa-629d-4b4d-ad54-f6ab15268524@quicinc.com>
Date: Wed, 17 Apr 2024 15:32:51 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Fix nullptr dereference for non-serdev
 devices
To: Johan Hovold <johan@kernel.org>
CC: <luiz.dentz@gmail.com>, <marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <johan+linaro@kernel.org>
References: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
 <Zh9saGbOl-fXP6SD@hovoldconsulting.com>
 <5e4e62c8-d17f-45fd-9212-088eb026dc7b@quicinc.com>
 <Zh91zq13nZvH3-Yj@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <Zh91zq13nZvH3-Yj@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: He84pzy76NSQLyzvdh-mAwyFrrRdsJg2
X-Proofpoint-ORIG-GUID: He84pzy76NSQLyzvdh-mAwyFrrRdsJg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_06,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170051

On 4/17/2024 3:10 PM, Johan Hovold wrote:
> [ Please wrap you mails at 72 columns or so and trim unnecessary context
>   when replying. ]
> 
> On Wed, Apr 17, 2024 at 02:51:38PM +0800, quic_zijuhu wrote:
>> On 4/17/2024 2:30 PM, Johan Hovold wrote:
>>> On Wed, Apr 17, 2024 at 11:49:52AM +0800, Zijun Hu wrote:
>>>> hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
>>>> is called by non-serdev device, fixed by null check before access.
>>>
>>> No, this patch is not correct.
> 
>> i don't think so, nullptr checking for hu->serdev has been performed
>> within qca_setup() everywhere when need to access serdev related
>> members since this function will be called by both serdev and
>> none-serdev. so suggest add such checking.
> 
> Your patch is not correct since you claim that this path can trigger a
> NULL pointer dereference. As I point out below that is currently not
> possible.
> 
> If you need this for some future change you need to say so in the commit
> message and drop the bogus Fixes tag.
> 
will add this change in to btattach support serials.
>>>> Fixes: 77f45cca8bc5 ("Bluetooth: qca: fix device-address endianness")
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
>>>> @@ -1905,10 +1905,11 @@ static int qca_setup(struct hci_uart *hu)
>>>>  	case QCA_WCN6750:
>>>>  	case QCA_WCN6855:
>>>>  	case QCA_WCN7850:
>>>> -		qcadev = serdev_device_get_drvdata(hu->serdev);
>>>
>>> Non-serdev controllers have type QCA_ROME (see qca_soc_type()) so will
>>> never end up in this path.
> 
>> i have submitted below patches to add supports for all other
>> non-serdev controllers.
> 
>> https://patchwork.kernel.org/project/bluetooth/list/?series=844120
> 
> Ok, you need it for some future changes, but I'm afraid that adding new
> random vendor specific ioctls like you do in that is series is a no-go.
> 
it is a generic ioctl, for QCA, it is used to specific soc_type. it maybe be used
by other vendor driver to set user specified info.
 
> Why are you trying to revive the old line-discipline when we have
> serdev?
> 

we usually need to use tool btattach which will generate non-serdev devices to attach a BT module to generic PC to
complete various development and verification, customer also have requirements
to use tool btattach as explained by below link
https://patchwork.kernel.org/project/bluetooth/patch/1712939188-25529-5-git-send-email-quic_zijuhu@quicinc.com/

> In any case, a change like this one would should be included in that
> series so that it's clear that it is only needed for your proposed
> further changes.
>  okay, it has been included in the updated patch serials, will update the serials to include change
in question.
https://patchwork.kernel.org/project/bluetooth/list/?series=844120
>>> I verified this when I wrote the patch and also fixed up a couple of
>>> real non-serdev bugs here:
>>>
>>> 	https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/
> 
>> actually, i have submitted below fix for this issue earlier.
>> https://lore.kernel.org/all/1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> Ok.
> 
> Johan

