Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045D219A95
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184947; cv=none; b=VOa7H7bWAca5HIzq88BFSNCHSVaRYJZFWfRSDEuFVBxET41F/2B7FttEGai7RwZ0rf61Ei8uEgkVsNvl6L7fqJCmGEGuiOVlbstMInMUWvPp35TUmAAsMNL9+u19eUWmJRRV2KKFSc8bcv7/74FvIQ9wA3yQ4PQ7a/f8Ybzx+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184947; c=relaxed/simple;
	bh=/z1Auw5bW0iKaByiOGgQEcnQgGQixB+9wlKuzW0JE6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OchdQ9Y7JSAx1NnHszgzii/jvCfEFTlxFGa5v0XTYPN9YAmSY1+8ND4CboL2U+N68YKn2zTQmDSSI4DMLtlWdyDYHQghktJnWNeBdNtOAF4HEWRIfKDVmy+6R8BrLLessATEpUilcCu3Rg18yAqgd27w9yJZonuwybx9DOCBLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a3V7vOKT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a3V7vOKT"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7LsHA012850;
	Tue, 22 Jul 2025 11:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	22LrCP/3fZq5YTKUPWXjvMKxZEsjIMBXi8PQkPwzkkw=; b=a3V7vOKTl1XTqwTM
	M604Hl5CLxkOGnvULmF9uRPzxQo91EumKb1jFnaRnYZSkuN586NXrN9lvDzvlE5a
	sgZO/s9CJ9NXwkhKjBq/vDamiAv8dUMDRjlIluh40X+kIgboXxE9eBLr6YbFJ5Xj
	5FjieO452XPn3H0jIrK6ZB2bL2LAeM88lJf6/2PHsOvL1GCpaptSoCfWf7qe8xYC
	pUerCvwC61dR569+vm+9L7TYk18K1liEmMyeVSV0+fT7gSqE43pZ+usBFhvZXICh
	zLRgA6PyzZEqh2jtMu7TD2pZ8vsizXw+sSW5nIhRDut7whV6kDVVk74bZVwb6lPS
	Fr1hrw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3em3b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 11:49:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56MBn28j024028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 11:49:02 GMT
Received: from [10.232.140.70] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 04:49:01 -0700
Message-ID: <26cfbcf5-4d58-49b4-a87a-fa10b7096ea8@quicinc.com>
Date: Tue, 22 Jul 2025 12:49:00 +0100
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
 <0ad121d9-0afc-452f-bc85-36344ad4ff25@quicinc.com>
 <CABBYNZ+ufuBAR9ONNBaNU=KHNUVNtAGeHWE1uzHLT=7xab+hyg@mail.gmail.com>
Content-Language: en-US
From: Francesco Giancane <quic_fgiancan@quicinc.com>
Organization: Qualcomm Technologies
In-Reply-To: <CABBYNZ+ufuBAR9ONNBaNU=KHNUVNtAGeHWE1uzHLT=7xab+hyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F-HsG7AIa8158U-bxv_kvUCsWp-Hk9-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5NiBTYWx0ZWRfXw6gM+UqsNekq
 oMn8L8En5vkUIWmtZ5S0OMzCrndtrYo/cFmkaNtotsZPPGrgjNvAEOlC5Inn/3EIqB1QuL1ufga
 Lh3p+ehkIu3uS4xFSlT8ZIo5xiurYSrfBoVqoET5A2ijtitihEzd/REwstO7fUPjNIAshEkZ/+h
 S+5O95WowHvXEJUzpxoU8J2I8JGxH8zJi8pakj2bbxF9VsKn6l0FKzYRl7L+h8kyOGL+p1eyNsp
 +rKFdyvW4RspdlabfqCwKvEJ+O5bzmWtDOz7G2V69NhfAT7yV/x3bcPq2NrAhkBd8mbVG5QhNMD
 LlVC1lnA9LVPcZA219jmbyLxBb3cU0zzQPwVPLhgPfh/iKLFO9mk7P6et+pVEXo1wVo92nKAKYU
 WEZz47b/FNW7uM/Cz+3LO+l1o0//niDZRJ03q58tkICKnOYGWmQTO8h529zU6NY6EfnCdFDV
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687f7aaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=Ymbm1U2QAUvsR-Vj1UoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: F-HsG7AIa8158U-bxv_kvUCsWp-Hk9-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220096

Hi Luiz,

Thansk again for your valuable feedback. Dropped some comments inline below.

As a final note: do you think there is value for the time being in 
merging my changes now,

and then eventually removing/simplifying them after moving these .h 
files in UAPI?

On 21/07/2025 21:22, Luiz Augusto von Dentz wrote:
> Hi Francesco,
>
> On Mon, Jul 21, 2025 at 2:17 PM Francesco Giancane
> <quic_fgiancan@quicinc.com> wrote:
>>
>> On 21/07/2025 19:01, Luiz Augusto von Dentz wrote:
>>> Hi Francesco,
>>>
>>> On Mon, Jul 21, 2025 at 1:05 PM Francesco Giancane
>>> <quic_fgiancan@quicinc.com> wrote:
>>>> Hello Luiz,
>>>>
>>>> Thanks for your feedbacks!
>>>>
>>>> On 21/07/2025 17:20, Luiz Augusto von Dentz wrote:
>>>>> Hi Francesco,
>>>>>
>>>>> On Mon, Jul 21, 2025 at 11:24 AM Francesco Giancane
>>>>> <quic_fgiancan@quicinc.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I am posting this patch series to better decouple `bluetoothd` daemon
>>>>>> and `libbluetooth`, as mentioned in the subject.
>>>>>>
>>>>>> I am introducing this change to make new BlueZ more granular.
>>>>>> This will allow more control on which components are actually selected
>>>>>> to build.
>>>>>>
>>>>>> Major use case for this change is fixing circular dependencies when
>>>>>> bootstrapping new builds where the whole build root is to be recreated
>>>>>> (e.g. Yocto Project).
>>>>>> In these scenarios, to have Bluetooth support enabled in Python,
>>>>>> `libbluetooth` is required at build time to be present but the direct
>>>>>> chain of dependencies would require a Python installation available,
>>>>>> thus introducing circular dependency.
>>>>>> Separating the library and header files from the rest allows build
>>>>>> systems to break the dependency loop.
>>>>> In theory what we should do to fix this is to add proper header to the
>>>>> kernel, since libbluetooth is basically just used for syscalls to the
>>>>> linux-bluetooth subsystem, btw doing that would also fix the likes of:
>>>>> https://github.com/bluez/bluez/issues/989
>>>> I see I see. I read through these issues jumping back and forth Python
>>>> (it is interesting that it's covering the exact same case i'd like to
>>>> fix :)).
>>>>
>>>> So if I understand correctly, your suggestion is to remove *our*
>>>> internal headers and rely solely on kernel ones? Or better, move ours
>>>> straight to the kernel UAPI.
>>> Yes, moving our headers to UAPI is probably the right thing to do,
>>> that said we will need to figure out if we can do this in one step,
>>> and just start depending on it for the start, or if we gonna need to
>>> ship with a copy as libbluetooth and have a transition step, from the
>>> looks of it we will need to do the second option until distro catch up
>>> and start to ship with Bluetooth UAPI headers, anyway we can probably
>>> start with UAPI headers first along with any kernel changes required.
>> Assuming that we can create headers in kernel, libbluetooth would be at
>> this stage a
>>
>> legacy wrapper around new APIs (which are possibly the same names and
>> symbols).
>>
>> This would help not breaking any of the existing packages and at some
>> point when the
>>
>> majority has moved to linux UAPI we can just drop these headers from bluez.
>>
>> As long as these changes do not land into kernel uAPI we cannot change
>> anything here.
>>
>> Question: where would you drop them in kernel? I assume it is
>> uapi/bluetooth to keep
> I guess that would need to be moved into
> include/uapi/linux/bluetooth/, I took a brief look and there is also
> the likes of sdp.h, sdp_lib.h, hci.h and hci_lib.h, these header are
> either exclusive to libbluetooth (SDP) or partially exclusive like HCI
> helpers, anyway it should be easy to identify what symbols comes from
> the kernel and exclude them from libbluetooth.

Do we need to start a discussion with Linux Kernel RFCing this proposal 
and asking for

more guidance? As you said, posting 10+ patches just dumping whole 
headers would be

probably NAKed.

>
>> same path as libbluetooth includes? (Internal Linux kernel headers sit
>> in uapi/net/bluetooth).
> Usually the uapi start with linux/, for example to include uhid we do
> #include <linux/uhid.h>, perhaps we can do <linux/bluetooth.h> and
> then for each socket family <linux/bluetooth/l2cap.h>, etc.

Ok, I can proceed with this approach and rework UAPI headers to include 
kernel/user

headers. Guess we can keep "private" headers from libbluetooth there.

>
>>>> I'd like to help here if you can provide more details I can work on a v2.
>>>>
>>>> Thanks for your time,
>>>>
>>>>>> `--enable-bluetoothd` flag is added to the `configure` script and
>>>>>> it is keeping the same behavior as other flags.
>>>>>>
>>>>>> Francesco Giancane (3):
>>>>>>      configure.ac: introduce `--enable-bluetoothd` flag
>>>>>>      Makefile.am: build `bluetoothd` if enabled
>>>>>>      README: document `--enable-bluetoothd` flag
>>>>>>
>>>>>>     Makefile.am  |  8 ++++++++
>>>>>>     README       | 14 ++++++++++++++
>>>>>>     configure.ac |  4 ++++
>>>>>>     3 files changed, 26 insertions(+)
>>>>>>
>>>>>> --
>>>>>> 2.49.0.windows.1
>>>>>>
>>>>>>
>>>
>
>
