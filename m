Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8A26657B
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197854; cv=none; b=rPWGOc63iKavU+2EN606tc0W5jC493DI2dsWIBhGbCZnxV3QZJ1znhWa86cQ0+PRWOkN2+VI5U2N/9thkXv/uVZM0o+lmF2WsZWdQpAzcmnGghOFuAZwScYSfUpjB+ilodAC9FLvLLboyhzt55IdL3NepUrfV+EO9fZCw68pefg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197854; c=relaxed/simple;
	bh=ZKCdsoLCQEHISgMi7WneGjgRdUIQ/uX7aXfgWbqLziM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NppPQOOAubFImDuUw4o4xv8UfW/x5jNIaqXcHsFEOPSTXFVeXMIo6M7payTu863And//zhvzpiuTa4wBykzH6HRuYJzhKOFJNlpmzW1Itmfk9xG7O+bKm9A8oSY9tpIYSAmoXhnzFwyefYbrbuejrCtmcAPGjlWeZl+HmPVInHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o8w2Vbdk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o8w2Vbdk"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MFDY1Y031292;
	Tue, 22 Jul 2025 15:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iL8JbZcl0vPVyjyZDBL36iBAtaBBp9fMnGDPrkL6ntA=; b=o8w2VbdkBK512fzW
	lQpT9pgAL3c+p0kfSZ3Y0fwThT2Q7p1A11wnRGQ85iRLoAwsP0g/B1csJllugcl1
	qPKCFNbTv+U+S9O8nyJQQdlTg7UrS7VsslgD6iIFZq5rtsmjXt55fOrM1RXhutOc
	Bzm27Z09sT4SwNpsLqjWpiSjav1TpBDzKEFaJyr1hx4CUjgeurKBlHvkO3oULCW8
	8+UG19MCKQsXtPfEV/8lIsgw2caCRLO7fZOb57PXkk0TnsoE6bGfHnizuU5TyzeS
	IQlI2f0oBTT79enBVYUMaSVbPuMfkW12+3LP0kThip5pn9w5OFj81sQTRx9ImKRj
	9eEMWg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482d3hr10j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 15:24:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56MFO8Wn028219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 15:24:08 GMT
Received: from [10.232.140.70] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 08:24:07 -0700
Message-ID: <096cf252-0878-4913-82f7-8d701ab04585@quicinc.com>
Date: Tue, 22 Jul 2025 16:24:05 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
To: Bastien Nocera <hadess@hadess.net>, <linux-bluetooth@vger.kernel.org>
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
 <cb652fe10b31e3b8421df5a85a9151839598a3f0.camel@hadess.net>
 <8ab1a298-c519-4013-b808-e707ff6f1a6c@quicinc.com>
 <863117cb7a91e2ed7460f24b1b8b25b8b031829b.camel@hadess.net>
Content-Language: en-US
From: Francesco Giancane <quic_fgiancan@quicinc.com>
Organization: Qualcomm Technologies
In-Reply-To: <863117cb7a91e2ed7460f24b1b8b25b8b031829b.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=G8UcE8k5 c=1 sm=1 tr=0 ts=687fad19 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=FrudtyktitOrFSKTdacA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEyOCBTYWx0ZWRfXw4uRr0ryW3AY
 SS6jn9xlqXVdDqNm61yTVaew+NN5eJrajmp4WzWfYZARk21A/WmqqctpgMB6MgmlJAi4iBysNUJ
 Lb61vDvCWLJE8hsY4pLMuzpCCJmutwASW2oKmLb2nlO58IsF3aKbs/gqIKX4hceB8/OVF7t/YhV
 uql2pco56SI8ip0tofAPrRk4ljInfWJQEofrjIkFlkC9VHmC4mKyLtEVS5iH/3APT6Jk6VfzjD9
 JJRuZwOD6/7C21dQJ5mBNEBtqbcAwyMLlzNA61saw5DKEXSV1q4qF3/RABTLp0az+cURYSwfTUX
 CW18wcIHKdNZNz4iusxeqhTLdnPiwONPpO8nBPbGl3xW/ComN2W0MMlrt8E/QKsz/kOypn90wGr
 tASxuS6Xhau3iqaOrpBnSYvlm9XW0BXpkdpDzRLpJaYZUDsp+e6TsZHjLzX3WUeBHGRyzmid
X-Proofpoint-GUID: 6yFhhR7PEz2jGxj4NJt-FmlI_mr-6O9H
X-Proofpoint-ORIG-GUID: 6yFhhR7PEz2jGxj4NJt-FmlI_mr-6O9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220128

Hello Bastien,

On 22/07/2025 15:03, Bastien Nocera wrote:
> On Tue, 2025-07-22 at 14:26 +0100, Francesco Giancane wrote:
>> Hello!
>>
>> On 22/07/2025 13:54, Bastien Nocera wrote:
>>> On Mon, 2025-07-21 at 16:22 +0100, Francesco Giancane wrote:
>>>> Hi,
>>>>
>>>> I am posting this patch series to better decouple `bluetoothd`
>>>> daemon
>>>> and `libbluetooth`, as mentioned in the subject.
>>>>
>>>> I am introducing this change to make new BlueZ more granular.
>>>> This will allow more control on which components are actually
>>>> selected
>>>> to build.
>>>>
>>>> Major use case for this change is fixing circular dependencies
>>>> when
>>>> bootstrapping new builds where the whole build root is to be
>>>> recreated
>>>> (e.g. Yocto Project).
>>>> In these scenarios, to have Bluetooth support enabled in Python,
>>>> `libbluetooth` is required at build time to be present but the
>>>> direct
>>>> chain of dependencies would require a Python installation
>>>> available,
>>>> thus introducing circular dependency.
>>>> Separating the library and header files from the rest allows
>>>> build
>>>> systems to break the dependency loop.
>>> FWIW, I'm currently porting bluez to meson (currently stuck on
>>> porting
>>> ell with its gazillion of SSL certificate tests), which would make
>>> python a pre-requirement for bluez (if meson ended up being the
>>> only
>>> build system).
>>>
>>> What part of Python itself has Bluetooth support? Wouldn't it also
>>> be
>>> possible to make that part of Python separate so it can be built
>>> after
>>> bluez?
>> Python uses autoconf to detect compile-time dependencies.
>>
>> They implemented Bluetooth network management with standard socket()
>> calls.
>>
>> This code path is enabled at compile time only if it detects
>> bluetooth.h
>> header.
>>
>> So for python to support Bluetooth in std library, libbluetooth
>> should
>> be already deployed.
>>
>> With this current patch series I posted, you can build a "lite"
>> version
>> of bluez to ship just enough
>>
>> the library and the headers so that python can have bluetooth support
>> (building a full BlueZ package requires
>>
>> python too... hence the circular dependency).
> Right, so you're trying to do:
> - bluez (lib and headers only)
> - python (with Bluetooth support)
> - bluez (full)
>
> And if meson were the only build system, you'd need to do:
> - python (without Bluetooth support)
> - bluez (full)
> - python (with Bluetooth support)
>
> I guess having a minimal uapi header upstream would allow to do:
> - python (with Bluetooth support)
> - bluez (full)
>
> Definitely the best option.
>
> I think it might be best to only migrate to the upstream kernel uapi
> the minimum needed to build Python with Bluetooth support, and extend
> it as needed afterwards.
>
> In the short-term, why not apply your bluez patches to your bluetoothd
> recipe rather than upstream? That should also motivate developers to
> land the "correct" fix upstream ;)
>
> Cheers

Thanks for these inputs. I agree that long term extending uapi is the 
best option,

given this scenario.

I was not so much convinced of keeping the downstream patch into Yocto 
recipe as it is extra

maintenance but I see your point. Showing there is already a workaround 
in place can be further

motivation to approve the upstream.

>
>> Francesco
>>
>>>> `--enable-bluetoothd` flag is added to the `configure` script and
>>>> it is keeping the same behavior as other flags.
>>>>
>>>> Francesco Giancane (3):
>>>>     configure.ac: introduce `--enable-bluetoothd` flag
>>>>     Makefile.am: build `bluetoothd` if enabled
>>>>     README: document `--enable-bluetoothd` flag
>>>>
>>>>    Makefile.am  |  8 ++++++++
>>>>    README       | 14 ++++++++++++++
>>>>    configure.ac |  4 ++++
>>>>    3 files changed, 26 insertions(+)
