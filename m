Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2C27A904
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200258; cv=none; b=DPX8MUHyD+5Y1fTkNHOpJFpcuNBJ8a8RVTkYYYUX07YaqqS5Z8ZVu07VRY7SjPzxuvFp7S04Duf7G9G1g2QwJtqMMVqTwIsZ63pxzjsp2tfaHFlNpnFCJSHb1nXtbNxD40lo11VO7sdAu99R5nQuxEvKY9x+PLJCZsIsZpq6W4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200258; c=relaxed/simple;
	bh=MioameQ0Pu3SfmsI5rvW3+DypwOHF+WifPx4+FSfTjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q3kMEWHTg7EsODgrGBf8sSpZgDOTaXPLRnnklpiK+u2ZDG6cmibDJDgs1/EoqJqiodnZgGhji/PMpXq+ryTo10htrDfOly1EAWoWZDfjXShNp0jpaaNR8pV8cvqa48/EZfyLAscglLZt7iKRAORzRQbXY7ZISYJol4Gr9a7kc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HsRsqi1g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HsRsqi1g"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MEqwk9020141;
	Tue, 22 Jul 2025 16:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WDL0+nrYb6uIrLk9PyVBlGAf0XB3IJNnIMe+emKrCoI=; b=HsRsqi1gbBAiV6PP
	QruS4sF96GFjrsKyxScLA+gzxR5c4MslPtSNHaRhzEQ1Y+/Cp8ptEDX1vX2x4wUq
	dN4ihDPuyTIaJwiuSlqxSAOek0OmxTnEGTRVXI18GBNMVbwSm7KAwmcNsn7mX4eM
	xTB0jCtXFr/TF6NtWFJGaukQv4mDrIi90aignTsPfT5nVHOWNPumFWdGnj6NsRcj
	5Ljh/WFpvEBXtKVrgPxIW+5d/tuF40CDXLpmkCvELrZjiSnA8/mIZ6IsTiuxM8HX
	03G8Kblz5hd3oeDV6/V7jDDZjiH+tRUCbGwf93OKW6fEnlgOkSkzqHn7l+oriUH/
	/YoLaw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na0g04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:04:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56MG4A5r008130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:04:11 GMT
Received: from [10.232.140.70] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 09:04:10 -0700
Message-ID: <a12032eb-d618-4c47-9a85-7486a5946b24@quicinc.com>
Date: Tue, 22 Jul 2025 17:04:08 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bastien Nocera
	<hadess@hadess.net>
CC: <linux-bluetooth@vger.kernel.org>
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
 <cb652fe10b31e3b8421df5a85a9151839598a3f0.camel@hadess.net>
 <8ab1a298-c519-4013-b808-e707ff6f1a6c@quicinc.com>
 <863117cb7a91e2ed7460f24b1b8b25b8b031829b.camel@hadess.net>
 <CABBYNZLNTBinoOgaeZ3+i2D6tRXmuB=KGXxCrhu=3wOsPxFyrw@mail.gmail.com>
Content-Language: en-US
From: Francesco Giancane <quic_fgiancan@quicinc.com>
Organization: Qualcomm Technologies
In-Reply-To: <CABBYNZLNTBinoOgaeZ3+i2D6tRXmuB=KGXxCrhu=3wOsPxFyrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ull_Bf0x9aqii7wQy4u__BMOW6xEhX7_
X-Proofpoint-ORIG-GUID: ull_Bf0x9aqii7wQy4u__BMOW6xEhX7_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzNCBTYWx0ZWRfXzjMjjh0Krf++
 tTQpkdrPGEAlFkVQkTGe/SlF93dSiZZzqTNzEGijfJkfZYBji7948zW9lY2XJZKpqhP8TTmUOMs
 trIRnNVKvIUIRoh1ya/3fTV5TMm9vYlIu9MPhgNbHM2wIGxIaTxqcgY0/LtYzDWAIBUIMAtkvGf
 Rar+HS4OmrPvGr9zotDmwg2XwRuQw6IJn8fp2eT8YgxFb19QVlu6W0FFovxuhdBS1tukmr3XoK/
 JXrA0XJbP0Vi5oKLwlGPpgyP5mv0TPG82n4xTQUzRdZhIgaxD8YHvd8YlYhWQHAHTnFw5SmRKrE
 eHwZhl51X0ny3rJ9Ign9YPkEB+xLzVVNGJIfWFsvPcTfqZrEhf1NH0vlkWiEG7pZ6KO2T5wyIir
 44ZNrMdlp4s33K47hsO8ILyemE14g5pSsOSr64dsMxnfH2xQmy9DBTIeQcf7DJNcnDOBCADT
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687fb67b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8
 a=iP7vMvkZAAAA:8 a=BOGCRh57UV751jSzGEgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=SKixG8JwDLmn6dAKAxWB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220134

Hello,

On 22/07/2025 15:21, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>
> On Tue, Jul 22, 2025 at 10:10 AM Bastien Nocera <hadess@hadess.net> wrote:
>> On Tue, 2025-07-22 at 14:26 +0100, Francesco Giancane wrote:
>>> Hello!
>>>
>>> On 22/07/2025 13:54, Bastien Nocera wrote:
>>>> On Mon, 2025-07-21 at 16:22 +0100, Francesco Giancane wrote:
>>>>> Hi,
>>>>>
>>>>> I am posting this patch series to better decouple `bluetoothd`
>>>>> daemon
>>>>> and `libbluetooth`, as mentioned in the subject.
>>>>>
>>>>> I am introducing this change to make new BlueZ more granular.
>>>>> This will allow more control on which components are actually
>>>>> selected
>>>>> to build.
>>>>>
>>>>> Major use case for this change is fixing circular dependencies
>>>>> when
>>>>> bootstrapping new builds where the whole build root is to be
>>>>> recreated
>>>>> (e.g. Yocto Project).
>>>>> In these scenarios, to have Bluetooth support enabled in Python,
>>>>> `libbluetooth` is required at build time to be present but the
>>>>> direct
>>>>> chain of dependencies would require a Python installation
>>>>> available,
>>>>> thus introducing circular dependency.
>>>>> Separating the library and header files from the rest allows
>>>>> build
>>>>> systems to break the dependency loop.
>>>> FWIW, I'm currently porting bluez to meson (currently stuck on
>>>> porting
>>>> ell with its gazillion of SSL certificate tests), which would make
>>>> python a pre-requirement for bluez (if meson ended up being the
>>>> only
>>>> build system).
>>>>
>>>> What part of Python itself has Bluetooth support? Wouldn't it also
>>>> be
>>>> possible to make that part of Python separate so it can be built
>>>> after
>>>> bluez?
>>> Python uses autoconf to detect compile-time dependencies.
>>>
>>> They implemented Bluetooth network management with standard socket()
>>> calls.
>>>
>>> This code path is enabled at compile time only if it detects
>>> bluetooth.h
>>> header.
>>>
>>> So for python to support Bluetooth in std library, libbluetooth
>>> should
>>> be already deployed.
>>>
>>> With this current patch series I posted, you can build a "lite"
>>> version
>>> of bluez to ship just enough
>>>
>>> the library and the headers so that python can have bluetooth support
>>> (building a full BlueZ package requires
>>>
>>> python too... hence the circular dependency).
>> Right, so you're trying to do:
>> - bluez (lib and headers only)
>> - python (with Bluetooth support)
>> - bluez (full)
>>
>> And if meson were the only build system, you'd need to do:
>> - python (without Bluetooth support)
>> - bluez (full)
>> - python (with Bluetooth support)
>>
>> I guess having a minimal uapi header upstream would allow to do:
>> - python (with Bluetooth support)
>> - bluez (full)
> +1
>
>> Definitely the best option.
>>
>> I think it might be best to only migrate to the upstream kernel uapi
>> the minimum needed to build Python with Bluetooth support, and extend
>> it as needed afterwards.
> What sort of Bluetooth support does Python have built-in? I thought
> that would use D-Bus like pybluez, etc, but perhaps it has some HCI
> and SDP functionality that came built-in with libbluetooth, but its
> usability is very limited without the daemon, in fact it probably not
> really recommended to do HCI or SDP on the application side nowadays
> since we now have management interface that abstract HCI and SDP is
> sort of legacy with LE Audio catching up with BR/EDR that will
> probably be deprecated at some point, so perhaps we shall work with
> Python folks to drop the usage of libbluetooth completely once we have
> the UAPI headers.

So I am no Bluetooth expert (not at this level). I was helping a 
colleague running

some Bluetooth applications on an embedded chip using Python and 
basically all of these

scripts were broken because of missing HAVE_BLUETOOTH_BLUETOOTH_H symbol 
(would be defined

with libbluetooth in place). Some time has passed to if details are 
required it may take some time from

me to recover them, but i can do. I clearly recall we were using 
bluetoothd in tandem with this python package

(which allegedly, required built-in bluetooth support to be enabled).

For reference:

https://github.com/python/cpython/blob/main/Modules/socketmodule.h#L116
https://github.com/python/cpython/blob/main/Modules/socketmodule.h#L282

And perhaps more interestingly:
https://github.com/python/cpython/blob/main/Modules/socketmodule.c

>> In the short-term, why not apply your bluez patches to your bluetoothd
>> recipe rather than upstream? That should also motivate developers to
>> land the "correct" fix upstream ;)
> Yeah, going with intermediate solution will sort of introduce a new
> dependency in the form of lib only support which will serve as excuse
> not to adopt UAPI as soon as they are available.

Got it, let's go with the upstream approach then. I do not see any 
blocker besides kernel

discussions here. I am fine deprecating altogether the libbluetooth 
intermediate effort.

On the other side, since you mentioned, I can check which specific 
python libraries were using

libbluetooth and the above code path, to see if they were using already 
the legacy approach or

if it is however something that must be supported in Python.

Thanks!

>> Cheers
>>
>>> Francesco
>>>
>>>>> `--enable-bluetoothd` flag is added to the `configure` script and
>>>>> it is keeping the same behavior as other flags.
>>>>>
>>>>> Francesco Giancane (3):
>>>>>     configure.ac: introduce `--enable-bluetoothd` flag
>>>>>     Makefile.am: build `bluetoothd` if enabled
>>>>>     README: document `--enable-bluetoothd` flag
>>>>>
>>>>>    Makefile.am  |  8 ++++++++
>>>>>    README       | 14 ++++++++++++++
>>>>>    configure.ac |  4 ++++
>>>>>    3 files changed, 26 insertions(+)
>
