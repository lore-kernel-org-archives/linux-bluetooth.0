Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A0185E4A
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201644; cv=none; b=j2FItNN3ZQkphxEAHwwEoWrh/CFgnP6Guk7VfOgiTGrOQA1xx12Z+h3vEh9Xp1NkGbNH1ZFhoMQ/s1UN85Izb101Z3dYAUXzZLKR21Mqubp62EifJZLp2SFrYskjPZRzhAaShIAMFbpqRFI4kUnUI6E6A1g+mEY2bvuzM1g++64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201644; c=relaxed/simple;
	bh=GabBbKYT47+C/UfMIgUW1AUsfG3z8M8rq8XPG3VOBOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HKRszNbI4OcFjmDSLU9sK17IuININy7/FFyWvhe/hXKGqdN6YMvwlaEmaaD5tfgqvqHCLVPQ9UuUuyRnObnfwnxVuXU8NHo33/bk7mq1hBgBv7VPudfjHm0Dqh0XNxwNiIDhpnOE0TQU90dK3LIL2NrDdiVtMXTVVWwVnQTzB3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KjXGaQw7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KjXGaQw7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MAioJV005716;
	Tue, 22 Jul 2025 16:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2HshGQC2DNtAoq03eM5kLHHKpVU1ppPRXMdO4fZ6GDk=; b=KjXGaQw7zUmTIRGM
	LaethXHD7rmnKZ1EHW1yoVC8ftpDM4/friplmuHYKGa/X5j5pXta2o2p7yn3EoSV
	xSvs4ywiw0z4anEDk7dqCCnFQo2AAj2p4yLWseZhs4vDSzO9H9NcKPVEfa8ELy7d
	hj5msUUkdtAyWNgoynMEmHZi6w4uTd9Y4AU/TR26x4sHi0M0aW6oJZarbeeoVq9v
	b2d4gg3mxR6gIN13svxqNq1OqiePccLsckqIbCVMxlk/drPRhFpLGl5zcK+++k1o
	DxUSn/XQt1gDT+UC6H0C39X4j5o5F2t931/ahqm6G+odOlvvXeidibndl35qWuVm
	uM8qMQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047qa7jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:27:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56MGRIWW017196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 16:27:18 GMT
Received: from [10.232.140.70] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 09:27:17 -0700
Message-ID: <4243f713-3bee-41a1-b718-ee0cdc2d8e9c@quicinc.com>
Date: Tue, 22 Jul 2025 17:27:15 +0100
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
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEzNyBTYWx0ZWRfX8yGQ3qn+qF3G
 DLkqfAIykQFsodTzasEOEgwksqWsGrYfaEJeIq/Aw/MFZvqX0/ghrNqdQVNX8PpIGeqUzDn4lIb
 h8/EA9A/qxici4TihyuB3u25BS1M8JVhVN1p+PB+sNavY46nuM2RASq1SdvJ1BGgAai8nb2OILh
 Qgk7vs+PkRfB6Hf1z9BzpO0aDUNqgYlw7+TBqTHylknrQvjPDaLtBjRaMnTD8xnCb/UBK2if94t
 /K+gk0rNuwht5FgwLzBlfs+SBjkk+ME0cPRc2IYaciNiRvnzNVZK97+OzKu6pFDb/FDVwBFV2jA
 dj5eQOnQ2/mb4voHmY5vvCLTmzIQ8MePYMR1ZkY5MZjxG6iX9sUZHutafUmMikJ2gnqxDeIyJ6x
 cbENOLVS9QR3CkVHkHRA1twpIWArzr6xlJQ3W+S2WmiqpUPJNVkDpvlgI3hF2aDBRZEewbBx
X-Proofpoint-ORIG-GUID: -sW0Mt_IxrFtNQyTIjq0M_l6-_JzEoy9
X-Proofpoint-GUID: -sW0Mt_IxrFtNQyTIjq0M_l6-_JzEoy9
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687fbbe7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=CckQENj0AAAA:8
 a=iP7vMvkZAAAA:8 a=HWyUvkIW5g9wiynXv50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=SKixG8JwDLmn6dAKAxWB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220137

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

The library requiring bluetooth headers to be available for Python (and 
thus enabling

bluetooth support in python) is:

https://pypi.org/project/bleak/

>> In the short-term, why not apply your bluez patches to your bluetoothd
>> recipe rather than upstream? That should also motivate developers to
>> land the "correct" fix upstream ;)
> Yeah, going with intermediate solution will sort of introduce a new
> dependency in the form of lib only support which will serve as excuse
> not to adopt UAPI as soon as they are available.
>
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
