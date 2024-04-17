Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AB5394
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336711; cv=none; b=egFghGuNhE8vjsux9SNHMTBXMlv+Tb2codGIqjJX8BqnEpzyc/6AaAqC8L6edEQSsDe3NMK1TmdVZquD2Z/u9tr9n8pmEmhWZub5PTNVYpnjcu5kH+/LFxWYFHibgbxYvna2l8yZ2jQcnC+PRRXhTH69nKsc/v76TDD8t6eAAjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336711; c=relaxed/simple;
	bh=P2TMOMtAdWQ2y8hRW4JdAHaMIBDjWhs0DWcn/SYyyac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LMideGh/j0qufW9JlQtOz5vD3t2YMB5PXxOQWH1aK3k44M6w6q+/rh57XFoHXfXHkq7FjSqLtVIZIhrijMYnNHoAwt7LUPfNAmJHZGzjlHa08p88IUan9GCWh/TA/+BCaNbfU6xpTcjMSY5CIyny/tiNTVxna5KoUhiW17qy0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ATTZmClN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ATTZmClN"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GKQlpB006244;
	Wed, 17 Apr 2024 06:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hnYqp9m3XbjOvSIv4SjGhrTk/9j2s4BVJ/XM0Pt7Otc=; b=AT
	TZmClNJnXlgZNTvVXO87KhDX6dpg5tb2k4GQ0aN4C7bqGmqPQzodpBXLmcew1rnx
	vyqr4i1x5neuKOX5CRt8T7gmyIWDc7ahJ4ks+NsDpobD2BY6l6665Kal0oKbow+/
	PiQCEfTIRIyHlMOjff/Iy2RpyU2QaVy6dpqZ9OigD1jKyLWEmr8h1+SobFlc1goY
	dtqXWGtyOdGmXAb2llLbke31VzZvUW6qR/iri6w+1wu35rn5GKTTlHdnQW28va9r
	Dc/qSnrKfLSxEyicaIMg6Ofc5A/xAwARmWjRoNyT6CzBAKD19/GgwlvQ3uM20f3s
	DJ8eh1hBvkcT+Z1On/9g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj051s7aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 06:51:42 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43H6pfOI021997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 06:51:41 GMT
Received: from [10.253.9.153] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 23:51:40 -0700
Message-ID: <5e4e62c8-d17f-45fd-9212-088eb026dc7b@quicinc.com>
Date: Wed, 17 Apr 2024 14:51:38 +0800
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <Zh9saGbOl-fXP6SD@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B7Zwi6SPICDpYaH8-ytmrx9knJjvyhsm
X-Proofpoint-GUID: B7Zwi6SPICDpYaH8-ytmrx9knJjvyhsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_06,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1011 suspectscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404170046

On 4/17/2024 2:30 PM, Johan Hovold wrote:
> On Wed, Apr 17, 2024 at 11:49:52AM +0800, Zijun Hu wrote:
>> hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
>> is called by non-serdev device, fixed by null check before access.
> 
> No, this patch is not correct.
>  
i don't think so, nullptr checking for hu->serdev has been performed within qca_setup()
everywhere when need to access serdev related members since this function will be called 
by both serdev and none-serdev. so suggest add such checking.

>> Fixes: 77f45cca8bc5 ("Bluetooth: qca: fix device-address endianness")
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/bluetooth/hci_qca.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 92fa20f5ac7d..9c6573c727e1 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1905,10 +1905,11 @@ static int qca_setup(struct hci_uart *hu)
>>  	case QCA_WCN6750:
>>  	case QCA_WCN6855:
>>  	case QCA_WCN7850:
>> -		qcadev = serdev_device_get_drvdata(hu->serdev);
> 
> Non-serdev controllers have type QCA_ROME (see qca_soc_type()) so will
> never end up in this path.
> 
i have submitted below patches to add supports for all other non-serdev controllers.
https://patchwork.kernel.org/project/bluetooth/list/?series=844120

> I verified this when I wrote the patch and also fixed up a couple of
> real non-serdev bugs here:
> 
> 	https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/
>
actually, i have submitted below fix for this issue earlier.
https://lore.kernel.org/all/1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com/

>> -		if (qcadev->bdaddr_property_broken)
>> -			set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
>> -
>> +		if (hu->serdev) {
>> +			qcadev = serdev_device_get_drvdata(hu->serdev);
>> +			if (qcadev->bdaddr_property_broken)
>> +				set_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks);
>> +		}
>>  		hci_set_aosp_capable(hdev);
>>  
>>  		ret = qca_read_soc_version(hdev, &ver, soc_type);
> 
> Johan

