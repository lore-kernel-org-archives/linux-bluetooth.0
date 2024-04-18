Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C64A20
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713481467; cv=none; b=nFMnYBskRfzQvO3d5c3BX/qrQB/CuNv7LrA0yo+Kc+ae7D7f08ckweXrCYxYnejbcQLrOtSzFP8RLt2sgw3RAiMAd6ZQg7ZwIAcHYXfEZDdSQYjxuaiA4efsI0LEuhmGAXCXNU3MVL1jlC+DGbW84gEcyps6zcUhD/MfkQrl2dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713481467; c=relaxed/simple;
	bh=J+4vm6OOg0/rGJ+6h6PorAtsgdOpSGYE0VajhbVixJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hCTs2R+K1DAf6qpd75vWX4IpS6UW7cksCT4g1Be7wvY/W0NTUFv+LW2AfkMR5bhFLDpUI+uAiv8H9UYfOYcHVVpI62Vz/zgoIQ/4Z8QB+edUlNq578NT2uqeCEdn/LGSNWX0siJfVSJ6Wdbb6O727RsZpZVPVj0iR0fwozL57E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FxWXG2kK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FxWXG2kK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43IMPfOB001965;
	Thu, 18 Apr 2024 23:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nfk41/oOakmv8uKbheo7zSIoXIDMpuKTuCJB2PDo4CI=; b=Fx
	WXG2kKlK76/uIoZURN102PS10xXVjwdzseEvfzH1IwRKaFoGqMNuSa/g74QTUsb6
	orbK+owvzq3EZnpQHr7weW4339KUBcrzYeX9LX2n2MbM8v6AgPkGpwtgu3HCEGCP
	l2yWTX+L53wa/akakDbvj78jhARG9JVVP/M4FaUto4NH7zcoP9Ij36x3D+jrBN4O
	WqO4hZ8ll6V0oJ0q3Bw1JewDOWHMJc1bq0NEgNvJEubaAK8L+kYqi8ehSI0e0FVC
	lJolzEO54xbWGeSoCci8VmZsV4xPGfFyEjoh0niATLyLAeaQ5FPwVQXsFH9Mj3IJ
	J2U0lS/9UB6+BEigCRNw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk06n1ukf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 23:04:16 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43IN4FI4019978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 23:04:15 GMT
Received: from [10.253.9.141] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 16:04:14 -0700
Message-ID: <fbe5722b-1e45-4ccb-a050-20a473a823c8@quicinc.com>
Date: Fri, 19 Apr 2024 07:04:11 +0800
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
 <4dac0caa-629d-4b4d-ad54-f6ab15268524@quicinc.com>
 <Zh-JNzlskY6ZvsSm@hovoldconsulting.com>
 <4313bcc9-8fbf-477d-90f2-013681cdebb9@quicinc.com>
 <ZiFDWeW_-PpI38GQ@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <ZiFDWeW_-PpI38GQ@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Kmw4f-QZZPGK7xGtHywERxpBr7hIBGWk
X-Proofpoint-GUID: Kmw4f-QZZPGK7xGtHywERxpBr7hIBGWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_20,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404180165

On 4/18/2024 11:59 PM, Johan Hovold wrote:
> For the third time, wrap your replies at 72 cols.
> 
> I've reflown your reply below manually again, but you need to fix mail
> setup and habits so you can communicate with upstream using the mailing
> lists.
> 
thanks for your reminder. will do it for further mail.
> On Wed, Apr 17, 2024 at 05:38:59PM +0800, quic_zijuhu wrote:
>> On 4/17/2024 4:32 PM, Johan Hovold wrote:
> 
>>>>>> https://patchwork.kernel.org/project/bluetooth/list/?series=844120
> 
>>> In it's current form it's a vendor specific hack that is never going to
>>> make it upstream.
> 
>> 1)
>> ioctl()'s designed purpose is to complete such non-standard config.
> 
> That's irrelevant.
> 
>> 2) present ioctl HCIUARTGETPROTO which is not exported is used to
>> specify which vendor protocol is used is it a a vendor specific hack?
> 
> That's an existing interface, that's ABI and has clearly defined
> semantics, unlike what you are proposing.
> 
> Those protocol values can never change once they've been added.
>  
for new introduced ioctl, who use it will define semantics and ensure it has
unchanged value as HCIUARTGETPROTO.

for QCA protocol, it specify soc_type and soc_type is defined clearly.

hope i can find some present usage or example from kernel.
>> 3)
>> hci_ldisc driver don't touch user specified settings and pass it into
>> vendor driver directly does it has any problem?
> 
> No, because the protocol values will never change, unlike the random
> data you're shuffling into the driver.
>  
for new introduced ioctl, it is not random value. it is soc_type.
hci_qca driver will check its availability.
>> 4) for tool btattach. it does NOT get any board config info from
>> DT|ACPI compared with formal BT driver. so i introduce a new ioctl to
>> supplement such info when possible to make btattach work.
> 
> I understand why you want this. I still think it's the wrong approach
> and in any case the interface in it's current form is not acceptable.
> 
do you have any better propose for how to specify driver specific settings ?

>>> For a start, you don't even make sure that the types becomes part of the
>>> ABI, which means that passing, say, type 5 can mean different things
>>> depending on the kernel version.
> 
>> it is specified by user and ONLY be parsed by vendor device driver.
>> it is user's responsibility to specify the right value. 
>> so i also don't check and care about its value and it don't need to
>> change any code for further added any new soc_types.
> 
> That's not how Linux works, sorry. We never break user space so your
> type data would have to be well-defined and can never change (you can
> only add new types).
> 
>> moreover, tool attach is mainly used before the final product phase.
>> namely, its is mainly used by developer and customer's evaluation.
> 
> Also irrelevant. You still don't get to add random new ioctl() that
> violates the Linux ABI contract.
> 
>>> Can't you just retrieve the device type from the device itself? If it's
>>> already powered, you should not need to know this beforehand
> 
>> 1) it is the simplest and lowest risk fix
> 
> No, it's a quick and dirty hack.
this solution maybe look ugly. but it actually is the simplest and the lowest
risky fix.
> 
>> 2) different soc_types have different responses when read its IDS as
>> shown by qca_read_soc_version().
> 
> I'm sure that can be managed. You claim that these device have a common
> protocol (qca) so it should be possible to probe for such differences.
> 
>> 3) the way you mentioned will involve many changes and it also means
>> high risks for many current soc types.
> 
> There's no risk as hardly anyone uses the line discipline interface
> anymore and it can currently only be used for the old ROME devices.
> Just make sure ROME still works after your change.
> 
no, as explained in cover letter. tool btattch is very useful,
vendor and customer often need to use it even if it still use ldisc interfaces.

vendor and customer often need to attach vendor's BT module to generic linux
machine, then use tool btattach to enable BT and  complete many tasks. as explained
by
https://lore.kernel.org/all/5bcf5034-fea4-43c6-ac7d-db6f24b88512@quicinc.com/

so i need to add tool btattach support for many other QCA soc types.

> Probing the device type should result in a better user experience, which
> I'm sure your customers will appreciate.
>i agree with you. as you known, soc type is embedded in everywhere of
hci_qca driver. since i ever considered auto detection soc_type and it will
involve many of changes and perhaps introduce high ricky broken for present
many qca BT socs. so i drop the solution. let me try to go back auto detection
solution.
thanks
> Johan

