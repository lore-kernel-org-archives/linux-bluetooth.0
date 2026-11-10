Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276031;
	b=bEBADSf13KjQe00jZcoENm9rtwRolzM2JlsJWoAcgEUROW67JPXppahYj0/GVbezu1PA
	 oVIY4wHa9YU2pEfPJ33KDCNbs6aOhTWLNt35HKU2OvgM11O7n1XlRoO6oV/O+OZY6YWLD
	 B0GdLIRiQUxcLEidTGENyhYwQerpKER1VoDjqcW6UHBiAZlhcio54XH1i1ybWoWFlVYNQ
	 dvZyicgdQHHTbzYZmax9bRbEw83O1z3T3CVqc2hOdz0LFBt6A9Akcv8Ib8L2MM/yi/yi0
	 5CgCvKn21rAZeFMiY1Xp3vEgFcmfiClEzHEpmTUld3J//a53chm1KJFEgBKZfhXqBWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276031;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NyTexdlkgtUeYi/KQTWk3X7kWVejCvBbrcPiF+ZMHjM=;
	b=w+6cV14ufLAxCMTNWK15tE7PDSOKKP963jqfixqZ1xI4tLMWHGuQ9o1+oOrWSzpwrlZs
	 7w+8N9rXEUhvxN98c6hVRXTjvia27GpYHp6QfxTvLKMM9NCJUBTd9NOcuhIaUggVXvZW5
	 wxo7L2+16VcVr4bBv9sdabHNAIiGvvMPX9IRNiSjKN8Y1fhrdwkbGy9NH9NSFQ90o9J20
	 xOtrqlItynNdozVxgsMnbyir3dMgRHNlWB3cncm1yLLCSGVza/+BBdBWn644rrjDx2ITp
	 z/mtHyKYIoLTU67KP+oUNKPEYV/56rUVTCQ0LRiE38E4cEZUhqItSvx8PXz8hlCzVaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QnrO5j3u;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dlQ7rv79;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19073606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 02:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19073606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QnrO5j3u;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dlQ7rv79
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0irmf887512
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 02:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NyTexdlkgtUeYi/KQTWk3X7kWVejCvBbrcPiF+ZMHjM=; b=QnrO5j3uQcFjWGRT
	GqKXn9xPGO0B08gQosIkonHNenl9VjJ6Pu+vv+QfEHBeAhstfhCQmI40paZilhrY
	lU9FrPmSWs7rxfsXH3meVOdhACJilaSl9cP0cuNvVzWk+ShgORJ0SLrAMU8V8siN
	B9PSaB4uwX1eR7j84KOyiSI/J2jj3VmeU+xpLcSwwDLZKJ8yfNRbkXlsWV3SxOug
	eBkSCt58G/a2UZcN46+rQ6GBex/5C6lXl5+k6RA7oraX/sEHRvQmPlxcR1GTg1JB
	Wsvu91heqI0Iw0UIAcMftCFY11bUjYgOpy0vf1eOrHBDc7GCYsM4DrpUaURyVu2f
	kMbaDw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcjaw6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 02:00:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f479b9819so2815667eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 18:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794276029; x=1794880829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NyTexdlkgtUeYi/KQTWk3X7kWVejCvBbrcPiF+ZMHjM=;
        b=dlQ7rv798Z4CqJuKkqjubeDo0EVGlOaylGMVI8CwjSXe1LW2bkmIM6oapy0PhIzso8
         3hQSAt6uUE5nFSjwIRJaBbpp6FAzAsP28VN17NhwgEDT+FEEC/Q6zRO3IKFOfC5FEZxd
         OO7+vOpV09vlIVi6MY1Iqe9E89urPm4CVaTEgI7lG9dNGGgoej3FB93ZD9GNGhp+8VCA
         ehtbjCI8r78qtxBSi09f17RWFTy5BDuO1ORRER9+Tc0l68r2nMTK6ozjMnKz0G6Q8SWc
         x/xqw7jIIpMb36csF86KGlb+7kqCvpg5rtoQgR721JD6/jot/vIh7FoigZ2rq5p2/0oP
         vZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794276029; x=1794880829;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NyTexdlkgtUeYi/KQTWk3X7kWVejCvBbrcPiF+ZMHjM=;
        b=M3WzJHqaIkAvkCCY1lf1MIcpr2/OR1UaMa7yQNwq3vh+mwhMD3Z0PF/AJiRcSy0dVY
         Cnbe2kTFqQzc9vKAkq9FVr9ZKQKZk+7J4k6BpRVHROii/yNtus0W8JRU6ytbd0hynVdT
         OmEu+ILNTDsEXgXn1C8ylvQ21mvOSMjpVwj/HMAstjUOqrpJEg+RARHT1Dy1o0n8tLI3
         aTZB9uo7VUXfg5btKI+c5IlQs5Ot7sL6/d1OBZfcmccEbkRfvDCkkccpZnzenHet0dUv
         XufSfcsWnwwmH3VpfDYiR6fuP7x13snREsDr70dK6uoIBN/40Q1VnYCzPmEUvaF8yAtT
         lWAA==
X-Gm-Message-State: APuU4Z9Fp6MxaAyUZoTTSh9v5N0N+BKNHAAkGRum+jLCO7DN2/EDEyxH
	jmbRhmWvGZUXW5Hh86M/YiLeJURtm5N/0SMiwtlwbitcEGFcfpiHkthGABQOFhXPOnoOv7HkaBM
	/VWH6JqbZ2Ia1QeqMq7uo0NhzZP42E/M1OSTXq+XMUwfKpiMe0qksJMjaa/6/aQ9LnjAABSQ=
X-Gm-Gg: AYBFou1Zs4K2sqMBpQRNtmd2oybdu3nWHw7mY3KeH7ac5IkU8QJja7Wsa22YZc4WLa4
	UCLIzeEBNZAm8wz2Ba3/O+BjWhdxNsLmN767fhSpzZM+38kHoccTLiLa/Gf/lMyXkOfzzdXrG/F
	mK9qjBqXM2PkVzlvXQpht01FeW7GQNYJLWdDuec/JizucD/LnVel5R68E/g3/WMiyqDodJC8JCV
	DkR7K2RtIu3I88iQ89BxxKD6siXL52a7b4pHzIJkvRKzoxSNmD5S8oEsW4vHHIQjEh9vnFDQ8im
	/DAM/Xo1TCk2/5fBkRexHKKFfb6TzmaBot4L8hviRWAJRLw/MSEkr0rUxnDNcDPhgeP6jZpJ3N6
	MYfaogTBmiMLVWUoJMGXfX40YuzFHfnlBaWiz8XH6PtiRo8wZPlihGpqveHKZS/NhdQv+8PQY4E
	xvleFby2FhcdzDqh2AVXJvzDnE
X-Received: by 2002:a05:693c:80cf:b0:36f:2677:fc09 with SMTP id 5a478bee46e88-37520217bddmr1305690eec.18.1794276028761;
        Mon, 09 Nov 2026 18:00:28 -0800 (PST)
X-Received: by 2002:a05:693c:80cf:b0:36f:2677:fc09 with SMTP id 5a478bee46e88-37520217bddmr1305524eec.18.1794276026141;
        Mon, 09 Nov 2026 18:00:26 -0800 (PST)
Received: from [10.110.31.117] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe3261csm2118150eec.4.2026.11.09.18.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 18:00:25 -0800 (PST)
Message-ID: <230bb084-a63a-451f-802b-aab0ed205d7e@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 10:00:20 +0800
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: obexd/pbap: Update PSE support from PBAP 1.1 to 1.2
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com
References: <20261104083429.4111632-2-jinwang.li@oss.qualcomm.com>
 <6aeb639e.87c3a088.228e9e.5ddb@mx.google.com>
 <CABBYNZ+6c45s-+_X7s8qE9DXihX5O7xYFTJnJmvnKT-sy96Ksg@mail.gmail.com>
 <192181e7-5935-4f0c-8d4d-b54218d99a05@oss.qualcomm.com>
 <CABBYNZ+E-HjcBxjsoH6c42B9W1_GFc1h=7JMQMdhYxcht_BBqw@mail.gmail.com>
Content-Language: en-US
From: Jinwang Li <jinwang.li@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+E-HjcBxjsoH6c42B9W1_GFc1h=7JMQMdhYxcht_BBqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LB8aSb9JxlunqHHp68alBcM02ue2Hrao
X-Proofpoint-ORIG-GUID: LB8aSb9JxlunqHHp68alBcM02ue2Hrao
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af27abd cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=hwfcwu60Y3JgHVHtvw8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwNyBTYWx0ZWRfX0tuysuBsvQOd
 rzznsS0ifFYLqb0jKtunDpvikntfzWofXneOPgPQ+lTzMXnKrq13QGV8+Oi/ZKFe3npGcy74Qd8
 fJ4zh6Fx7QnyYQQjGr1WxXv1V+lCfpA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwNyBTYWx0ZWRfX2k5sTjapc/JZ
 XFRIWa6nyQxYvxd1y4is6bRYPO6oYfPueDdFTx4W5XECoOBfcodLiZvuodBf78mjFlEYZwGMKnF
 07bIpl0XzbnUFKdUd5bhhErN48ZAKrWB/oVc8WlIy4ruPOw8B0KKDMSZ0iX8cx+WY789HhPMLJZ
 PcyE+kn4ygG5PNERxeY052xlSPr+BQQX/1NCE0U6DXGRqfy5P7LwF9yibvLpJ2QCQwdllypNAVf
 eO2BIefeUD5KxS463RtND0DxQe0NPEF5Wm3883IvQGNcRrb9f3ctmTOHuxo3LmWSnpEEh46/RVt
 6ZVyUs5oJSEIeW0I+nDD+WHEW8mqxQKRiuCfnFIyALgRY4YRypA2DLgdkB0I3mGpdOxJrTkPxFN
 Q9vNNlsGgjJjunPuWAyRXQhOi2NpPEM77sjEuKo9xmj2m6yj/Oj0puFNfC75GEk4ZXG7rDTovAn
 5ezNoROnTscVref6oSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100007

Hi Luiz,

On 11/9/2026 10:31 PM, Luiz Augusto von Dentz wrote:
> Hi Jinwang,
> 
> On Mon, Nov 9, 2026 at 4:34 AM Jinwang Li <jinwang.li@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 11/5/2026 11:37 PM, Luiz Augusto von Dentz wrote:
>>> Hi Jinwang,
>>>
>>> On Wed, Nov 4, 2026 at 12:14 PM <bluez.test.bot@gmail.com> wrote:
>>>>
>>>> This is automated email and please do not reply to this email!
>>>>
>>>> Dear submitter,
>>>>
>>>> Thank you for submitting the patches to the linux bluetooth mailing list.
>>>> This is a CI test results with your patch series:
>>>> PW Link:https://patchwork.kernel.org/series/1201470/
>>>>
>>>> ---Test result---
>>>>
>>>> Test Summary:
>>>> CheckPatch                    PASS      8.55 seconds
>>>> GitLint                       PASS      4.70 seconds
>>>> BuildEll                      PASS      23.33 seconds
>>>> BluezMake                     PASS      197.66 seconds
>>>> MakeCheck                     PASS      13.22 seconds
>>>> MakeDistcheck                 PASS      105.32 seconds
>>>> CheckValgrind                 PASS      164.16 seconds
>>>> CheckSmatch                   PASS      173.53 seconds
>>>> bluezmakeextell               PASS      69.20 seconds
>>>> TestFunctional                PASS      885.71 seconds
>>>> IncrementalBuild              PASS      250.73 seconds
>>>> ScanBuild                     PASS      687.43 seconds
>>>>
>>>>
>>>>
>>>> https://github.com/bluez/bluez/pull/2760
>>>>
>>>> ---
>>>> Regards,
>>>> Linux Bluetooth
>>>
>>> Copilot flagged a couple of problems:
>>> https://github.com/bluez/bluez/pull/2760#pullrequestreview-5775992507
>> Hi Luiz,
>>
>> The first three comments are valid. v2 will fix all three.
>>
>> I would also like to discuss comment 4, "Clear JPEG image capability
>> until photos are normalized."
>>
>> The Default Contact Image Format feature is mandatory for PBAP 1.2 and
>> requires PHOTO to contain a base64-encoded JPEG of at most 300x300
>> pixels and 50 kB.
>>
>> The three backends currently handle photos differently: Tracker uses the
>> photo URL directly, ebook passes through inline data or a URI, and dummy
>> forwards the PHOTO value from the vCard. This series only advertises the
>> feature bit and does not change these behaviors.
>>
>> I don't think obexd should perform remote network access, image
>> resizing, or transcoding, as that would add unrelated networking and
>> image-processing dependencies.
>>
>> Without those, I see three options:
>>
>> Keep the existing behavior and only advertise bit 9.
>> Validate inline PHOTO data and omit non-conformant or URI-based images.
>> Read local photo URIs, base64-encode JPEGs that meet the requirements,
>> and omit unsupported or non-conformant images.
>>
>> Do you have a preference for how this should be handled?
> 
> I don't have a particular preference, it just needs to be spec
> compliant and pass the PTS testing. If each backend uses a different
> format or method, perhaps we need to converge on one. That said, I
> don't think the Linux desktop cares too much about PBAP so perhaps
> this is just to exercise whether PBAP could be qualified? In that case
> I would just use the dummy format, or read it locally and then check
> if it meets the requirements.

The main purpose of these changes is to pass the PTS tests, as PBAP 
1.1.1 is scheduled to be deprecated on 2028-02-01. I'll update the 
implementation accordingly and send a v2.

> 

