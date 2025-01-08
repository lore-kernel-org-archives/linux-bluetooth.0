Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEC158858
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736303210; cv=none; b=f/ztrPx6xX7rChbkDRqKi4rUUPbjVSEXhIRABFH+y9oZB8ypA1WRQ9x7K8j1Y26s1gC4hvFauY5HwhtsxFHF0XzLlCKOnvyC3+lfUBb1P4W8JCW4jFiz0uVwfKNwygLl0oqbunpKuyPpuXDr1TJnhS46sMdP6CIoDc+rojKhrMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736303210; c=relaxed/simple;
	bh=WXsawqsT8F5rVQE3duy+lLUd3KzRApai+62ocCe40sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cDASJj+rCvcufH6vKRKJ1LPiBQRNDCgXCVBNU8Ze4Qgdq8coIKMTsMACnqqy/rtrY0cUvCq/zIkfNwVWHrcCgC9M1DrfgokzZsz1QUg0EPUbkhSOkWC3eZZZo1I79Opy7O2RREsFrvjqOYFl2M9gUM4pATbNDFySduudCUZpOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j4c85od1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j4c85od1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507KFclb028286;
	Wed, 8 Jan 2025 02:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GkFrfUS8qfWLwuNaPSTfpl0f+o6J1+T/yd8p6TEN+wk=; b=j4c85od1kn9JSYxR
	B8HrmJfmYNQNoaNCaE/I6kEwyBVdh4Eg77jCeI72RNYDT3+7QLFN/UxPrbajb55o
	Wr5h3g1s9l8saa32EJFedatJkOjwlFRoP0mzgP+ajDvcV0hUNPPJKCHNB2lLF2lQ
	wiG0MTZinBnV8YBPQ0YVzZs+JxeqWwvK+/SYq66K7EV9oOVk3GTV64A3qpPZIgAV
	pk0VWxH7/tkBqid65dne37Ui5pBE6B13IveGG3wmugJJMFU8FFPqIoXNPbNQT1to
	FeEtS716+Q49QYq8kZ0DqH/HaXmQtpEj3dSymFMPUWdWujSxnDh8ZGnKkkkEwcXR
	eeRE2w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441b588nh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 02:26:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5082QgeW027763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Jan 2025 02:26:42 GMT
Received: from [10.253.75.79] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 Jan 2025
 18:26:41 -0800
Message-ID: <a2622c66-8495-4086-81ce-d63846ec2c91@quicinc.com>
Date: Wed, 8 Jan 2025 10:26:38 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] HID device not connecting issue
 fixed.
To: Mahesh Talewad <mahesh.talewad@nxp.com>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Devyani Godbole <devyani.godbole@nxp.com>,
        Sarveshwar Bajaj
	<sarveshwar.bajaj@nxp.com>,
        Vinit Mehta <vinit.mehta@nxp.com>
References: <20241224142424.10572-1-mahesh.talewad@nxp.com>
 <20241224142424.10572-2-mahesh.talewad@nxp.com>
 <CABBYNZJ8To9fm4j3bcGsmPc6ChJO376yAN-Wr3Se9hs_3GpJoQ@mail.gmail.com>
 <AS5PR04MB9754DA009526DC605DD32C9B89112@AS5PR04MB9754.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Zijun Hu <quic_zijuhu@quicinc.com>
In-Reply-To: <AS5PR04MB9754DA009526DC605DD32C9B89112@AS5PR04MB9754.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pR57NnScDE4F4pa1fPZJGFa3YdFOqwSs
X-Proofpoint-GUID: pR57NnScDE4F4pa1fPZJGFa3YdFOqwSs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080017

On 1/7/2025 8:05 PM, Mahesh Talewad wrote:
> Hi Luiz,
> 
> We tried with option - " UserspaceHID=true" in input.conf but HID Connection did not happen.
> 

i ever met a similar issue. you may try to set UserspaceHID=false or
enable kernel option CONFIG_UHID as below
https://lore.kernel.org/all/902c26ff-0fe7-4976-9dae-290e9afdaafa@icloud.com/

> Thanks and regards,
> Mahesh Vithal Talewad
> 
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, January 7, 2025 1:24 AM
> To: Mahesh Talewad <mahesh.talewad@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Devyani Godbole <devyani.godbole@nxp.com>; Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>; Vinit Mehta <vinit.mehta@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ v1 1/1] HID device not connecting issue fixed.
> 
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> Hi Mahesh,
> 
> On Tue, Dec 24, 2024 at 9:24 AM Mahesh Talewad <mahesh.talewad@nxp.com> wrote:
>>
>> While connecting BT-HID device showing br-profile unavailable and
>> connection did not happen.
>> Steps followed:
>>         1. Pair Ref device
>>         2. Connect Ref device
>> With this patch HID device is able to connect and HID traffic can be
>> observed in btmon.
>> ---
>>  profiles/input/device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/profiles/input/device.c b/profiles/input/device.c index
>> 8cf8e5ea7..a6047998a 100644
>> --- a/profiles/input/device.c
>> +++ b/profiles/input/device.c
>> @@ -89,7 +89,7 @@ struct input_device {  };
>>
>>  static int idle_timeout = 0;
>> -static uhid_state_t uhid_state = UHID_ENABLED;
>> +static uhid_state_t uhid_state = UHID_DISABLED;
> 
> Well this would contradict input.conf:
> 
> https://github.com/bluez/bluez/blob/master/profiles/input/input.conf#L18
> 
> Perhaps what is missing is the detection that if uhid is not enabled in the kernel it would switch it off automatically, that said it was intended by the distro to know whether to enable it or not, so we don't have to play a guess game runtime.
> 
>>  static bool classic_bonded_only = true;
>>
>>  void input_set_idle_timeout(int timeout)
>> --
>> 2.34.1
>>
> 
> 
> --
> Luiz Augusto von Dentz

