Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001952628D
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190795; cv=none; b=Q5mM5jbIUr2sOQe3BDlDyQHFw++iQJXBSpxhx7j70qdRkw164KmgJlR/Z4Tmtohzv72+Tq10SakJX7muEoi7sTY6okir9ataN9KRrhh1Y+FcVllJM+kl58Y/wR/BVZzlVMZCilrh4mMqOkssbSXEOeTYeG+C9KcgsFY8ZeSTm5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190795; c=relaxed/simple;
	bh=bBVu6geUNWQbVAXc4f0PEaMebq5rfH2y+8zzjWOqCXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rGJuBbp0T6tIT1KtasDZoAgPSc2WSGcUqzhYv/JDxVlDfSxY5FgFMtSi+RUiNVmsMGhQ9VWQmJ4ec8+i498Mzx8gIjKQsnQfOPSZ1xPF9t9B4nQU2KnmoOifYV9KOTwFjGH+apv0Bl/KsxlTPC7kv2L41VwHYvw1o4SmWqHHU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RaCCqn66; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RaCCqn66"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7Kkwa015650;
	Tue, 22 Jul 2025 13:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CDPdNZS0J1ZxpDB2KjHKqOowEuUKH2vFSgt2A1bS1TE=; b=RaCCqn66ProODHHT
	p95wwLjHvVsDkiWPt/IIr/J6woMDacOf4war8r2r0EhKn8X2lRV6TOSE+F5r1VGf
	FVCL3gmkRn9Czw1OlHRELY+sosK7z5paWjazIN4l67OukPCbcayXJyoLlDq7Wov1
	qJdGr99sU627VbJfap1LATYEKyPyycC806QE1P+1oZjk9+F+Kvwvgg0ptYc4RFk/
	TC76G6YMk3xqABV8SY4Z0Qu2SLFW2qBa5Ji6M59f+/+HxBAHV7tWbJdqrPWtvxRw
	BpuZ9d5l21dKUyvB1oJ5M/tSqvZtfWS55z4eJCuHY1Jsm7E3zYJ1UF95chrXweaM
	7EdehQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w2p96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 13:26:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56MDQU35002169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 13:26:30 GMT
Received: from [10.232.140.70] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 06:26:29 -0700
Message-ID: <8ab1a298-c519-4013-b808-e707ff6f1a6c@quicinc.com>
Date: Tue, 22 Jul 2025 14:26:27 +0100
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
Content-Language: en-US
From: Francesco Giancane <quic_fgiancan@quicinc.com>
Organization: Qualcomm Technologies
In-Reply-To: <cb652fe10b31e3b8421df5a85a9151839598a3f0.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=687f9187 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=jXOuRB2cUAbXuQJjaN0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDEwOSBTYWx0ZWRfX6/CQSrN+Txlu
 9sq/XWF+HAYdkj6LAP05beUq4uKKpB8sR9i5slCr9Ue/Et4Aq+VH2F/U7ftCfnAhFuSo9ItgGen
 Ubl/IaUX4XMT25GViZ5kwvTGXUmR23WZOKAfGXUBa5D0iWgUd+I7tFAk+/O/6i6unHW4q7G5dt5
 ifbP4yd7+7oBvqb+Te2C79atLhAS/8Mru0SggKMQUdW91SEqaCw1qi/Ej7VtzvF4aSoDd7YEmiB
 LF9Ck1zA7BtI9HEnWtv/BT9s9lcig+RV6RzAWHpdvHWaK5HamgcqjJPjpMukkYa26QGGQYdCKuC
 biXddbicnK0ApYaaepti7QrKf66ow7t7085Su/ydBud05BeFX7GdJaStfUaLpbIhn7DvUAMlgXe
 T37zPu0AJ1FZPvJAE2eZwA63o0uOh9L8ef07qWjqVMqSERx6jaS/IC3KaK0hBvs7fYPCc80K
X-Proofpoint-ORIG-GUID: V7KX6SOwBCFPlVUBaq_UxCd_G_PM9z_c
X-Proofpoint-GUID: V7KX6SOwBCFPlVUBaq_UxCd_G_PM9z_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220109

Hello!

On 22/07/2025 13:54, Bastien Nocera wrote:
> On Mon, 2025-07-21 at 16:22 +0100, Francesco Giancane wrote:
>> Hi,
>>
>> I am posting this patch series to better decouple `bluetoothd` daemon
>> and `libbluetooth`, as mentioned in the subject.
>>
>> I am introducing this change to make new BlueZ more granular.
>> This will allow more control on which components are actually
>> selected
>> to build.
>>
>> Major use case for this change is fixing circular dependencies when
>> bootstrapping new builds where the whole build root is to be
>> recreated
>> (e.g. Yocto Project).
>> In these scenarios, to have Bluetooth support enabled in Python,
>> `libbluetooth` is required at build time to be present but the direct
>> chain of dependencies would require a Python installation available,
>> thus introducing circular dependency.
>> Separating the library and header files from the rest allows build
>> systems to break the dependency loop.
> FWIW, I'm currently porting bluez to meson (currently stuck on porting
> ell with its gazillion of SSL certificate tests), which would make
> python a pre-requirement for bluez (if meson ended up being the only
> build system).
>
> What part of Python itself has Bluetooth support? Wouldn't it also be
> possible to make that part of Python separate so it can be built after
> bluez?

Python uses autoconf to detect compile-time dependencies.

They implemented Bluetooth network management with standard socket() calls.

This code path is enabled at compile time only if it detects bluetooth.h 
header.

So for python to support Bluetooth in std library, libbluetooth should 
be already deployed.

With this current patch series I posted, you can build a "lite" version 
of bluez to ship just enough

the library and the headers so that python can have bluetooth support 
(building a full BlueZ package requires

python too... hence the circular dependency).

Francesco

>
>> `--enable-bluetoothd` flag is added to the `configure` script and
>> it is keeping the same behavior as other flags.
>>
>> Francesco Giancane (3):
>>    configure.ac: introduce `--enable-bluetoothd` flag
>>    Makefile.am: build `bluetoothd` if enabled
>>    README: document `--enable-bluetoothd` flag
>>
>>   Makefile.am  |  8 ++++++++
>>   README       | 14 ++++++++++++++
>>   configure.ac |  4 ++++
>>   3 files changed, 26 insertions(+)
