Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5387190498
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753121870; cv=none; b=pinJ5fuoGgzfuUJ1LR7e43j5dzsqzWMEJH41DUDhTJh2GUD78yx8+HyNkYlY3xossq17Rwfzikp5sqeKDzU/CmWkOvmLn1UXgJBaxWktirHow05/xB1Z551eqcyoH6PIMlLOqYjaTh5i+5Ln8uiBLu2+XhOrB//3xOKYEoCGShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753121870; c=relaxed/simple;
	bh=y30sLnE7qni248OaLIDXwtiWveT/qKdZ8tLUv2hglPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=atJ5Bri1pcF1o1c7KaulaDQ1kU+VE9CeMgADhniNHsPI5d4RDbXn2mhsBOXIWkppUGtN6va7SUOPbVfKNJPz1atZsAx5FI9sCqT/574ge5HPRZTfN+RnsOv1UmsVpxtB77LeLlzRehw+p3sVT+SWg15EvxQUHxelOxpWA3/GnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hPf0X4Ru; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hPf0X4Ru"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LEev2K012550;
	Mon, 21 Jul 2025 18:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5tlWd6GW3l5EeSzkbgJzP7M3Pp4iY8SWTecMSAmlZsY=; b=hPf0X4RuCZyoAnxO
	hwpkyOWSYBmwdEA+Ih4yvPe2SVGvE6IVGLQCmfCwPBHaCxc8rF9LMxxR7LSL3Chn
	XKfMDE1xJjiWhTJhi0RfjiJWMRT+5rDLofzuQA8doogLOTfV5KWov0TXsEqDIuHK
	5U5R4f65aDz49xvTvUg4rQD3PTaPzQmPh9wXHONc0p+JGYuyVN12jPDGHog2Tx+W
	jBXssVfaRA5a8fUjxRcTBrdP09iwIQ+6iK1I2P0Oec3QDxCICiwXT8S9p7bveku1
	b36P/4sfsEZ9PqeQL8Tk6ku+7we2cHMR4ncbAkBrDLPHIREUzrzhoA8GmRORJ+Mj
	jrA8fg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6h2q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 18:17:46 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LIHhpI030977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 18:17:43 GMT
Received: from [10.232.140.70] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 21 Jul
 2025 11:17:42 -0700
Message-ID: <0ad121d9-0afc-452f-bc85-36344ad4ff25@quicinc.com>
Date: Mon, 21 Jul 2025 19:17:41 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
 <CABBYNZLUK45-eBcYAn7oq9-gewhE_XLXpnPiwKXPF-tOX6JYrA@mail.gmail.com>
 <119538af-e432-47f8-ae87-4c59750cd4be@quicinc.com>
 <CABBYNZJ2EAr-H+WKiifzqpC-bnxg8L2NSa1yG-Xjccw=oe3yVg@mail.gmail.com>
Content-Language: en-US
From: Francesco Giancane <quic_fgiancan@quicinc.com>
Organization: Qualcomm Technologies
In-Reply-To: <CABBYNZJ2EAr-H+WKiifzqpC-bnxg8L2NSa1yG-Xjccw=oe3yVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=687e844a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=KhviY-9GzBrp58CSFD8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jo82SmmKTJPZziB197qN5SuvFo9GYops
X-Proofpoint-GUID: jo82SmmKTJPZziB197qN5SuvFo9GYops
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE2MiBTYWx0ZWRfXySHd4Uc9mz7E
 F4OmXgX0D7ZXxXt3s8dIaXpg9qMnK7f3md2dlusq8qGTEvouhLZbJoh4q1dUlUuWz1f9puwCiPp
 SfIvFOxNZkxQFCqEpARHJ3+lUdoM9zLRAQdyXEr9nN60aAn7aKYIowRDKBuiXypBCc8iHjpdkhU
 qClOoHJsEYrtkFJlFfRYGAzWHccE63huGTxiQNLfwaDIz8Q9YbGDyFL9GMB6HRHHsgT6OfwI9Ru
 DDJfoHjH4ZyP0W46id8x5Rt76cli0V3KjKcWEbkm5bfjnV9aAKgmo9Q+8tw2Qo3P9uYXGc21NMB
 dey6blvtksvsK6rHtZn6fcox4oomPqgjSi2Fn0VrcKuQ3SAXK1nMZ+DWrSM6Ei96VnC2tmP8h0c
 b5b8zBESPdli+GEeRNGF8YaywR6YVpWlgqtKsXBwjsYGySHfQzoNCeoJzjUhnynt4dc7dx+g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210162


On 21/07/2025 19:01, Luiz Augusto von Dentz wrote:
> Hi Francesco,
>
> On Mon, Jul 21, 2025 at 1:05 PM Francesco Giancane
> <quic_fgiancan@quicinc.com> wrote:
>> Hello Luiz,
>>
>> Thanks for your feedbacks!
>>
>> On 21/07/2025 17:20, Luiz Augusto von Dentz wrote:
>>> Hi Francesco,
>>>
>>> On Mon, Jul 21, 2025 at 11:24 AM Francesco Giancane
>>> <quic_fgiancan@quicinc.com> wrote:
>>>> Hi,
>>>>
>>>> I am posting this patch series to better decouple `bluetoothd` daemon
>>>> and `libbluetooth`, as mentioned in the subject.
>>>>
>>>> I am introducing this change to make new BlueZ more granular.
>>>> This will allow more control on which components are actually selected
>>>> to build.
>>>>
>>>> Major use case for this change is fixing circular dependencies when
>>>> bootstrapping new builds where the whole build root is to be recreated
>>>> (e.g. Yocto Project).
>>>> In these scenarios, to have Bluetooth support enabled in Python,
>>>> `libbluetooth` is required at build time to be present but the direct
>>>> chain of dependencies would require a Python installation available,
>>>> thus introducing circular dependency.
>>>> Separating the library and header files from the rest allows build
>>>> systems to break the dependency loop.
>>> In theory what we should do to fix this is to add proper header to the
>>> kernel, since libbluetooth is basically just used for syscalls to the
>>> linux-bluetooth subsystem, btw doing that would also fix the likes of:
>>> https://github.com/bluez/bluez/issues/989
>> I see I see. I read through these issues jumping back and forth Python
>> (it is interesting that it's covering the exact same case i'd like to
>> fix :)).
>>
>> So if I understand correctly, your suggestion is to remove *our*
>> internal headers and rely solely on kernel ones? Or better, move ours
>> straight to the kernel UAPI.
> Yes, moving our headers to UAPI is probably the right thing to do,
> that said we will need to figure out if we can do this in one step,
> and just start depending on it for the start, or if we gonna need to
> ship with a copy as libbluetooth and have a transition step, from the
> looks of it we will need to do the second option until distro catch up
> and start to ship with Bluetooth UAPI headers, anyway we can probably
> start with UAPI headers first along with any kernel changes required.

Assuming that we can create headers in kernel, libbluetooth would be at 
this stage a

legacy wrapper around new APIs (which are possibly the same names and 
symbols).

This would help not breaking any of the existing packages and at some 
point when the

majority has moved to linux UAPI we can just drop these headers from bluez.

As long as these changes do not land into kernel uAPI we cannot change 
anything here.

Question: where would you drop them in kernel? I assume it is 
uapi/bluetooth to keep

same path as libbluetooth includes? (Internal Linux kernel headers sit 
in uapi/net/bluetooth).

>> I'd like to help here if you can provide more details I can work on a v2.
>>
>> Thanks for your time,
>>
>>>> `--enable-bluetoothd` flag is added to the `configure` script and
>>>> it is keeping the same behavior as other flags.
>>>>
>>>> Francesco Giancane (3):
>>>>     configure.ac: introduce `--enable-bluetoothd` flag
>>>>     Makefile.am: build `bluetoothd` if enabled
>>>>     README: document `--enable-bluetoothd` flag
>>>>
>>>>    Makefile.am  |  8 ++++++++
>>>>    README       | 14 ++++++++++++++
>>>>    configure.ac |  4 ++++
>>>>    3 files changed, 26 insertions(+)
>>>>
>>>> --
>>>> 2.49.0.windows.1
>>>>
>>>>
>
>
