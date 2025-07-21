Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF012C9D
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117509; cv=none; b=OocXuxMB5DEKD2HoTXLHaXHmXRJHDU0zeXZsXWkK5xEpExos1b8sMjaquFB9xSjoJBfG0YquN4Mz7sKNtUZP/2hQAQcPlE1DNtmdlSuTYQCd5qWyxi3I7JXEMvYKjomxVZ7LN/D6eiWwJgFSgl8HdITJ93AEEwg/wfkqXvkguCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117509; c=relaxed/simple;
	bh=ZgTMRtbsrXwUWLeipzlLwmT3IrLUeIy9OkkDM1Mf3ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iUtpYbd0AP/nnOH/ozZ7EdMXiHfexbYv39lNjIgHuym6g6sUt7fG8bXIwS+0WYlU7qpoYLAGzu6Q5nTxaxzBX6ygCsInXmaJOuU0rEKEOdIIaNsm0lyRikZe+EgRU8MK5gMHAxCHlwAUB9y7Rysil3b3lqIrjFKsrDGAfEKafDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jkix4IPV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jkix4IPV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LGV8C9000932;
	Mon, 21 Jul 2025 17:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9YfoByJLhhATOEabRKpBvWAyCpCp65bc1KEnVhMQVxo=; b=Jkix4IPV+GqBYIwE
	+q9YUJG5XTNQhbJC4EE77PLQm8SSxqQ5YpfCXOf/ohlzPIkkxA0PXYx83ZvyzQ8/
	GbPh7be3AQ0C89y98lRMW0O+g0oOYuMP+UE77Uu7Rz0ZlRJpXWtnGPJ6bg3QNBnw
	UyaSbd7j+q4sfhKVk5ZXFZ8GH5WjRc2HVSZZcwJVD+6SgNJMzrAE4o93+pMBGF7Y
	VG79i3WJ/VHiWblNXvZM2TDwBqEB9F52qv/Ms7qwu6eERrTKM9rAWqlz9cc/caWd
	dME9ZPl+f7FvzPGSloWTY/v+iHzqucViW0GFxEuIJigP3P3FRH5Qdm4TLufwNXDG
	WC17FA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044debwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 17:05:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56LH52nU008833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 17:05:02 GMT
Received: from [10.232.140.70] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 21 Jul
 2025 10:05:01 -0700
Message-ID: <119538af-e432-47f8-ae87-4c59750cd4be@quicinc.com>
Date: Mon, 21 Jul 2025 18:04:59 +0100
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
Content-Language: en-US
From: Francesco Giancane <quic_fgiancan@quicinc.com>
Organization: Qualcomm Technologies
In-Reply-To: <CABBYNZLUK45-eBcYAn7oq9-gewhE_XLXpnPiwKXPF-tOX6JYrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=BJ6zrEQG c=1 sm=1 tr=0 ts=687e733f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=KyQ3nRb4J50PdDy-QJoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: bzpZyIj_7PXUgFVzsRultZfz6NaDy0Ar
X-Proofpoint-ORIG-GUID: bzpZyIj_7PXUgFVzsRultZfz6NaDy0Ar
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE1MSBTYWx0ZWRfX6vNh/RhuV1xY
 qcoEDL+ENp85q53SJ1yQODTTPre48nZj9rcspjNEYbqkAy6OLSj1mx7Gdl4DaAz+AE6ikVTXUeP
 8R6tbjTDv3X40UtEDxmTd6vPrN2KG2dJZ85P+oDPVxz4NN+cxsqWyPucDyPKzocwii33tBnt+Db
 6KffSGr4z/00Gn1rM7c972PQtmiBmHCG3zdDgjLAevRnscNdbCotPF6v6KdHHValVhKyZcZ2Q85
 0EicJU8H4j6cnQo/0qCOdQE6cta4Bd8EsN9sgw6HNI1HmEYefsrAICxv5wbyZjvOitwXLZb4Ht+
 hcEW7M40uaEHdntDRt6IBs6ygKTHn318v6WupxlqzOk7LKkT27HD4rIeUH05a46tCfBRehAvrNd
 jFRcsejHn6GmtmawJnq1EEmhaAdCxWF0HjRDRmGi65tYn0n47mgjlT/PU/hGM9gCUExm6/6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210151

Hello Luiz,

Thanks for your feedbacks!

On 21/07/2025 17:20, Luiz Augusto von Dentz wrote:
> Hi Francesco,
>
> On Mon, Jul 21, 2025 at 11:24 AM Francesco Giancane
> <quic_fgiancan@quicinc.com> wrote:
>> Hi,
>>
>> I am posting this patch series to better decouple `bluetoothd` daemon
>> and `libbluetooth`, as mentioned in the subject.
>>
>> I am introducing this change to make new BlueZ more granular.
>> This will allow more control on which components are actually selected
>> to build.
>>
>> Major use case for this change is fixing circular dependencies when
>> bootstrapping new builds where the whole build root is to be recreated
>> (e.g. Yocto Project).
>> In these scenarios, to have Bluetooth support enabled in Python,
>> `libbluetooth` is required at build time to be present but the direct
>> chain of dependencies would require a Python installation available,
>> thus introducing circular dependency.
>> Separating the library and header files from the rest allows build
>> systems to break the dependency loop.
> In theory what we should do to fix this is to add proper header to the
> kernel, since libbluetooth is basically just used for syscalls to the
> linux-bluetooth subsystem, btw doing that would also fix the likes of:
> https://github.com/bluez/bluez/issues/989

I see I see. I read through these issues jumping back and forth Python 
(it is interesting that it's covering the exact same case i'd like to 
fix :)).

So if I understand correctly, your suggestion is to remove *our* 
internal headers and rely solely on kernel ones? Or better, move ours 
straight to the kernel UAPI.

I'd like to help here if you can provide more details I can work on a v2.

Thanks for your time,

>
>> `--enable-bluetoothd` flag is added to the `configure` script and
>> it is keeping the same behavior as other flags.
>>
>> Francesco Giancane (3):
>>    configure.ac: introduce `--enable-bluetoothd` flag
>>    Makefile.am: build `bluetoothd` if enabled
>>    README: document `--enable-bluetoothd` flag
>>
>>   Makefile.am  |  8 ++++++++
>>   README       | 14 ++++++++++++++
>>   configure.ac |  4 ++++
>>   3 files changed, 26 insertions(+)
>>
>> --
>> 2.49.0.windows.1
>>
>>
>
