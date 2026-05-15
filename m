Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D513E4C62
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831015; cv=none; b=q3cEtc4GWaMTisA7mXYZ9+YbCrdtEGCwxpGY5ipH1ieK8RaqfNCbzXiL50Opj/AAq8dXKndoi/ONuVTDPi/P512dR6J7hJSSXHlangwIaWXrFceW2qnWbbGzpgjuoG4nq05JbaVIy/4Q0We2GT/B2JLzStCxtEcjplIp0Va2IaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831015; c=relaxed/simple;
	bh=+4ePIhu3O40dHWjlCdwyhUEUNi1zHfIgpYolXR3DEio=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KDGoWRWM5y97RMGzA0OiR0h/CsUnzJd0MMmai6x6ryy3yRmEGzk6qb0bYKk6d/bWfk5EW0ScrHXzhfsZeOgDV3CYNtTInoA8STF+6VHCtt8tYKEexrfnbskY4VLX73XwdgwnWHuNNFqt0E25kVWvyqMnRtC7eQP6WrvMi1IutgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1H2e7/Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=azro191K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1H2e7/Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="azro191K"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5AOZ81848051
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Z7LPMBLyHHjy4yfGUUaKmg4n9iqRPbm6MK5swWzLHA=; b=N1H2e7/QC46tHRD3
	i1B48ip1E/cj+Z9QoyCDebJgoBkH1zNCXClrOju29al0KbywunZp+ckWbhL7rVSV
	IoAvOGwT+4jS5POzf953rQZZqCimZb1YtyX/KZ9fm5o23jakW+sTB5YXp27EYrWm
	nb20YVfSCmj5HWYII2G/XpVHiLFn7gWDbY08A4+J0FD73edPqm/ymuIxuhh60dxx
	88ucnnFDssHDNRVmBgS7KXTNuPmxZWeXJ81x+hOEIIauGNAZP+Nt/OrmMVpOHWjJ
	0i2xqPmEGbrz8icV5G5p2XzCIH5H7/ZIsg3mUvQK+qPcOTeVbkL5K/o5xmrWJ4j6
	iNF1YA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1t26gw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:43:32 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-95cfe3d4c16so13717543241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778831012; x=1779435812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Z7LPMBLyHHjy4yfGUUaKmg4n9iqRPbm6MK5swWzLHA=;
        b=azro191KDfIaQm0EmsJsrxZjXeAhyomnTxVYP/1k1k39Y7p8QTdNz5HFnBAfLXQIn8
         Zz4BHzQepMGos2wpudZENR3RIQJpV08MxbbxX3OGgPh73BRkJWNjNi3nl5RnsHMKW1BS
         RVA/1Twqmq8qf0DFXIOQHbOG8SrPwxpPW9quJhz2HQ48PInUxAxRq2tvmUYqBKezAXnH
         I06VTSYloio36Dtwh71BRIznWqJAapR8PdqP1qbuQ9xZ9+8t+pSVQAYWbvsTCn+RIdJF
         RCVrZn/UpyY5+jWH+WyU0STGQcLvCQctfQGRsxbDZm2opyAWOo86w8+I09Xg/IGfzBoF
         RjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831012; x=1779435812;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z7LPMBLyHHjy4yfGUUaKmg4n9iqRPbm6MK5swWzLHA=;
        b=jvGTt5VkzaGI+gb1PCrCIKNeilH7gFzqOaHmhSc81xIjEcg5U8ARY+KWNLt5uQvSPT
         Sk0tbxKxnKUjSML5c5NxmF0Ka1Q76zUINrGPIhM25c8pFfk1s/NFxuCYO93f5JZMaBeA
         J+tgiNH5sqoA75qPwjrIZiRnT9G7XP2y6nckJM3L6KjkUGFkAlmSqqK1yWGRpJFKrbrv
         SSSd2UqzheBHBhJQtvg7VSK/1GYN5585tLIY2KlVMlzPvsplG9vk6pcKWsocEOhbMJnd
         PkdrZdpntnOaqcm4n7RHcUa6kRiudRP4GyFoCJqPHPtVeSRQhHDAeHJP87N1z//5mFPw
         ODcA==
X-Forwarded-Encrypted: i=1; AFNElJ/I/5TdpmwfzJZhqdTVH8dFzSKtYollr5FyH1Dcz6mv1aw7WUsKCv2L4Ch4gthyW868l7RnzR5NrkQaBmDYZQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+/FlFKRxBtAO+YvHtEaVPfhiDkqDLirzuv8h1oQ0Hp+cbiMi
	Hvgihv1/TF4yNl/rae81BGDlzQw57pTyNGgorb7A5ShtS4zsGo0Uk2HUxLuqFSsBiBbvv4t7e1y
	NqwLNwxTOQicEozCM7njSSRbC/TxK1hTV6OMYXwVtkfyE+w4tfF/KLRzxXVEeKgG6NYhKvcg=
X-Gm-Gg: Acq92OEcGbWf1c5/GlDyJDlhTQXLEoQPabCq9gMsfseeFRhc63iTJA/ioeMFiFMlmsW
	LQ6J6ng250x/rj9pNhfLhPAxwsaEM7yQNToskLG2sUt1mTRaKKvjapl+sH/Mk8dds35M7VGz+MN
	UNyehWRcmxu+YxLppGDnQ/N9AlLrpco6CpRvjCwfc2kA7ZLbyPT304IrftCDJ5KIBtYx6sQRUgH
	BCtVxTGg/eAHpG2oCjlJuV7NMSlMovHHbyczVJNpLghw0/pl2HbKZUhfakwgfxFfXAQe0U4lECS
	3q/9A7EGW/4tKZLUnSS+MVrm6w1P5iG+tDi2HwaMqCVF8OugzOl+tM1JYF8KSwn11C5ABY85rpQ
	eNZybOblhkbJ938NyVk7GxJkYBdDtwUQ49qHRUPisU/VWG9KW0nrUzUzH5n786N4A3FFTHozmlk
	MKBvo3reWYkhfn7saXnrF+LYl4njKS8evFzZKdfYd8kR6RDG2qEBcB/CK5yNWHCvt4HTrH+jlwZ
	UR0oYyDbUgYdwNS
X-Received: by 2002:a05:6102:50a9:b0:633:c6c4:b321 with SMTP id ada2fe7eead31-63a3ea7d313mr1297693137.18.1778831012087;
        Fri, 15 May 2026 00:43:32 -0700 (PDT)
X-Received: by 2002:a05:6102:50a9:b0:633:c6c4:b321 with SMTP id ada2fe7eead31-63a3ea7d313mr1297679137.18.1778831011680;
        Fri, 15 May 2026 00:43:31 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd2f5csm187895966b.3.2026.05.15.00.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 00:43:30 -0700 (PDT)
Message-ID: <7ba6b4ee-fd2a-470e-951c-2c69961b977a@oss.qualcomm.com>
Date: Fri, 15 May 2026 09:43:30 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: Linux 7.1-rc3 regression (Bluetooth)
To: Greg KH <greg@kroah.com>, August Wikerfors <git@augustwikerfors.se>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Pauli Virtanen <pav@iki.fi>,
        Mikhail Gavrilov
 <mikhail.v.gavrilov@gmail.com>,
        markus.suvanto@gmail.com
References: <f652d5d9841a9b7c100dd19ee97c86099f580724.camel@gmail.com>
 <01ffb0cc-dcf6-4e60-adf3-fbb96e0666d0@leemhuis.info>
 <51b55b97-615b-4f5e-b454-df646f4058b7@augustwikerfors.se>
 <2026051514-scorch-ecologist-5e7e@gregkh>
Content-Language: en-US, nl
In-Reply-To: <2026051514-scorch-ecologist-5e7e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D7Z37PRj c=1 sm=1 tr=0 ts=6a06cea4 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=x5eH5QKNjoUSqzY6eP8A:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA3NiBTYWx0ZWRfX/bgcuG+ESvRO
 Gw+KAyhxcrQ+Mg97EaDQM5x2GMFfh+1mFGhdSWnqIx60Pg4F3d02zHVR4F1F0BhALjFA2QLOHUS
 K4DtZKrW6kXrovXAsu5UWKguurmiiXJZ50hwlAkldwD7XPgjOQUUhe4vz2xBh7r7TP1x8h+Z81Y
 QRQfRQo0py/7+5FpnsU7MVjSz9StqMR7TLedcFP4jS4GYXKRPdZYCXTqw6T7AkpHZtB+5yM5vtc
 YY8SUWV2PZXjP6caGvxXe3HID0Jm3nTTz8kNuh73Z5kj6kOJJi06N4Sk0zz0KyACImWKWaTKz7r
 UlqnXCSlkuZTuDouHaFyYJIysJteM53wB9/Ocuc6IS+hLW7mkHfqyLpI+Z/pBuOByjzzAghs2tW
 SNVTytyCfYxjZSuvvHUPttEG9FHN52oJbmYVgT8kMn6cgFAiRqwQ0ahZOS8eye5u+dchB4iTc8R
 E6mpExrx8ZdVKKOwchg==
X-Proofpoint-ORIG-GUID: WRVITitxZpHUfTD3qwRS4z-dHCUsa-Qw
X-Proofpoint-GUID: WRVITitxZpHUfTD3qwRS4z-dHCUsa-Qw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150076

Hi,

On 15-May-26 07:37, Greg KH wrote:
> On Fri, May 15, 2026 at 04:26:38AM +0200, August Wikerfors wrote:
>> On 2026-05-11 08:30, Thorsten Leemhuis wrote:
>>> On 5/11/26 07:17, markus.suvanto@gmail.com wrote:
>>>> Hello
>>>>
>>>> I upgrade 7.1-rc2 to 7.1-rc3. After that bluetooth  didn't start
>>>> hci0: Failed to send wmt func ctrl (-22)
>>>> My fix was to revert commit 634a4408c0615c523cf7531790f4f14a422b9206
>>>
>>> Thx for your report. FWIW, there are two proposed fixed for this change
>>> floating around:
>>>
>>> https://lore.kernel.org/all/20260508173121.27526-1-mikhail.v.gavrilov@gmail.com/
>>> https://lore.kernel.org/all/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/
>>>
>>> Given that this is the third revert within a short time-frame I wonder
>>> if we should fast-track a fix (once ready) to spare more users the pain
>>> of bisecting & reporting.
>>
>> FYI the commit that caused this regression was backported to the latest
>> stable releases (6.12.88, 6.18.30 and 7.0.7). I encountered it after
>> updating to 7.0.7 and can confirm that the patch from the second link
>> fixes it. That patch is now in the bluetooth tree as e3ac0d9f1a20
>> ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL events") and a pull
>> request [1] has been made to the net tree. Unfortunately this seems to
>> have been a few hours too late to make it into the net pull request for
>> 7.1-rc4 [2], so the fix might not get into mainline until next week.
>>
>> As a side note, it is unfortunate that there does not seem to be a
>> process to prevent patches that are known to cause regressions from
>> being backported to stable releases. As far as I can tell, this was
>> added to regzbot tracking [3] a day before the culprit was queued for
>> stable [4], so such a process could have prevented this regression in
>> stable releases.
> 
> You can email stable@vger to let us know to drop a patch, or when the
> -rcs are released, respond to the offending patch in that list.  THat's
> why we have -rc releases!

That relies on someone actively intervening in the process though,
I wonder if it would be an idea to have some CI which checks patches
in stable RC releases vs regzbot tracking?

This assumes tegzbot tracking includes the mainline git hash of
commits causing the regression (if/once known).

Regards,

Hans



