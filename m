Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4215357B
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802297; cv=none; b=nR2tW43cNLTeOAWKG/N1/T3CzzpCkF8kY35e/W7711dkSzvyf8LvRSgWCDFxh+CUdQu6xfwuP9YzhUUEK2UdyKHIIOdV0k8jvhpN3ziWCeS0HBWdAtjW8KN6+JJ/Bmv/ArPTEF1v4eMAEEUrsFJaDUliFCr6GunIkFD61W1ug7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802297; c=relaxed/simple;
	bh=CBwFVnRsUy9jr6pOLW/Mv0Mxi+8DKBzM4IVIVUBnZaA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:CC:
	 In-Reply-To:Content-Type; b=HY8MdZqSMCWFzIA4ksImxYrv6priyGcOqB7ERt7PKEBUDCgtc515RoJxpPigfMtjWmAfdFAozSbBaBmgSyuU8YmxcvK9Riwhzgms78E58QdQNbNkkl5fgqYjbzVnQL1wHB0hqBccUYdhpPbA5ybl16vsnMwo+6dqyEMJnNzovTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dJomGZSK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dJomGZSK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MBuBTO003937;
	Mon, 22 Apr 2024 16:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:references:cc
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+WwebWCpXvbM8c0N+lcv6MXeXfw5p1UciOXD85iy8GE=; b=dJ
	omGZSKXjQxYn9z490X+eaUfI9H17xfoH35VBbukYcwcUxVjlIh54l3LzS9SKJdCJ
	SqDyhDov3xfbrK5vIvXBct1aWjtFN6zQ/GL4aBTVkTyXsUC/0I0nf/D1T51eW7J8
	ynBYERSWv7nQENHFrU7hYwaib7UlS+B/2IQyEDL669w2Jf0eJ9+15styyszSUoMa
	/egJJnSWS4z2/hvZ6vAaa08ohEPGTFCEpWDQPLvQe/NMBfr1yhGA8aCE4IGdInfN
	1wq/rBDRe2LgE6EK0Kec6tlvAKo3XK0ld9iprqI3KlN0FZQ5KntZ/thnLQ1jRLE2
	abJyUQ57ttqbxurNxH5A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82h0um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:11:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGBVQl004148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:11:31 GMT
Received: from [10.253.37.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 09:11:30 -0700
Message-ID: <6d7ad8d2-7b5c-440e-be3b-a64dce65d788@quicinc.com>
Date: Tue, 23 Apr 2024 00:11:28 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC for Qualcomm Bluetooth patches
From: quic_zijuhu <quic_zijuhu@quicinc.com>
To: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "marcel@holtmann.org"
	<marcel@holtmann.org>
References: <8fc41e4b-5c63-478c-8e32-098961c60878@quicinc.com>
 <PH0PR11MB5126FC832705A93BCF5C169AD3052@PH0PR11MB5126.namprd11.prod.outlook.com>
 <aeb3cf09-af53-4f68-be47-1704e00cf956@quicinc.com>
Content-Language: en-US
CC: BlueZ <linux-bluetooth@vger.kernel.org>
In-Reply-To: <aeb3cf09-af53-4f68-be47-1704e00cf956@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TYRtv8tTMgWFp2RAt6Zi8gaUDNQcjx5S
X-Proofpoint-ORIG-GUID: TYRtv8tTMgWFp2RAt6Zi8gaUDNQcjx5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220068

On 4/22/2024 11:30 PM, quic_zijuhu wrote:
> On 4/11/2024 9:58 PM, Von Dentz, Luiz wrote:
>> Hi,
>>
>> How about resending them?
>>
>> Also we are getting pretty bad feedback from QCA drivers:
>>
>> https://lore.kernel.org/linux-bluetooth/31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org/
>>
>> Do you guys ever test your drivers with more traditional Linux distros that actually runs bluetoothd daemon?
>> ________________________________
>> From: quic_zijuhu <quic_zijuhu@quicinc.com>
>> Sent: Wednesday, April 10, 2024 11:02 PM
>> To: Von Dentz, Luiz <luiz.von.dentz@intel.com>; marcel@holtmann.org <marcel@holtmann.org>
>> Subject: RFC for Qualcomm Bluetooth patches
>>
>> Hi Luiz, marcel
>>
>> could you have comments for several Qualcomm BT patches under below link.
>> https://patchwork.kernel.org/project/bluetooth/list/
>>
>>
>> A)
>> tile: [v3] Bluetooth: qca: Fix crash when use tool btattach for QCA_ROME
>>
>>        the original v1 fix was firstly posted by me at 2024-01-11, and Johan Hovold <johan+linaro@kernel.org> recently also
>>        have a similar fix with title "Bluetooth: qca: fix NULL-deref on non-serdev setup"
>>
>> B)
>>       Bluetooth: qca: Add tool btattach support for more QCA soc types
>>       [v1] tools/btattach: Add support for all QCA soc_types
>>
>>       these patches make tool btattach support more Qualcomm BT controllers.
>>
>> C)
>>      [v2,RESEND] Bluetooth: btusb: Fix triggering coredump implementation for QCA
>>
>>      this fix is for QCA controller with USB interface. the fix for UART interface has been merged
>>      by below commit:
>>      Fixes: 6abf9dd26bb1 ("Bluetooth: qca: Fix triggering coredump implementation")
>>
> Hi Luiz,marcel
> let me list my changes for QCA controllers with priority from high to
> low for you to code review and pick up. they are listed by tile
> following change link
> 
> 1)
> Bluetooth: qca: Support downloading board id specific NVM for WCN7850
> https://patchwork.kernel.org/project/bluetooth/patch/1713340174-1304-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> 2) the issue you mentioned are fixed by below changes
> [v5,1/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
> https://patchwork.kernel.org/project/bluetooth/patch/1713771497-5733-2-git-send-email-quic_zijuhu@quicinc.com/
> 
> [v5,2/2] Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after
> disable then warm reboot
> https://patchwork.kernel.org/project/bluetooth/patch/1713771497-5733-3-git-send-email-quic_zijuhu@quicinc.com/
> 
> 3) i also have mentioned below fix as shown in last mail.
> [v2,RESEND] Bluetooth: qca: Fix crash when btattach BT controller QCA_ROME
> https://patchwork.kernel.org/project/bluetooth/patch/1713796702-22861-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> 4) below changes will improve code quality.
> [v1,RESEND] Bluetooth: Remove 3 repeated macro definitions
> https://patchwork.kernel.org/project/bluetooth/patch/1713797510-24495-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> [v1,RESEND] Bluetooth: hci_conn: Remove a redundant check for HFP offload
> https://patchwork.kernel.org/project/bluetooth/patch/1713797194-22982-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> [v1,RESEND] Bluetooth: btusb: Correct timeout macro argument used to
> receive control message
> https://patchwork.kernel.org/project/bluetooth/patch/1713797830-24600-1-git-send-email-quic_zijuhu@quicinc.com/
these changes which will improve code quality have been merged.

Hi Luiz, marcel,

hope you will take time to code review functionality 1) and bug fixes 2).

thanks.


