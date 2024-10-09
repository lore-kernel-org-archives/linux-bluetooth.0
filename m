Received: from dd49702.kasserver.com (dd49702.kasserver.com [85.13.136.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9240849
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.136.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502934; cv=none; b=MzPqUo8z92uYGSqcueSQDp93czHf+m3d2cDc15MdQRDcuY0rNEmRGBU+OeLmw+RyPsCpnI89F2LJbImYEjna8kQj19IOluE+RdLXwIwZM7wwKgB6IbN/WHy4wdzJVufY/jARM8AcOoXOAymMBNwJhk72pTJAGvfgx/4Wbs/Y5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502934; c=relaxed/simple;
	bh=ooJN8K2HX9OgxuGC2F3kUiA2AETzH6XaEBz8IgHM9rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpCX79NEbGOIwRwNiKx9LJwSlQhP7hP7Ks8R9cI6DSQsJnGfDq1Mrk9dnZhQvmAkUuSODAGaLW8qZFWBZXin6pXHPAVGmsz1brqwaiwePixR57gDB7RuypZvezeXXZyx4qCQqG1BOE7tRBbYvNK2DozLsl7hOmhV44uA5MTDhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fabianowski.eu; spf=pass smtp.mailfrom=fabianowski.eu; dkim=pass (2048-bit key) header.d=fabianowski.eu header.i=@fabianowski.eu header.b=0ra6AQ4/; arc=none smtp.client-ip=85.13.136.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fabianowski.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fabianowski.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fabianowski.eu header.i=@fabianowski.eu header.b="0ra6AQ4/"
Received: from [192.168.1.189] (p50857882.dip0.t-ipconnect.de [80.133.120.130])
	by dd49702.kasserver.com (Postfix) with ESMTPSA id 3C21A5400439;
	Wed,  9 Oct 2024 21:36:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fabianowski.eu;
	s=kas202409081107; t=1728502614;
	bh=snLzXRTPhNErvo7D/GGPzuLXwsEZenTqIJNPaUJR/hQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0ra6AQ4/UZx4NiNLQ0V0pUn/zlViX6w7a0k7yNy/ITb/Yb6zWXchpj9lBKMPm8XM9
	 QcOThnNuXlla1waFaOIKsczbHrxisv+UVvSqzKIveGx7gbADiRl/hQGepLjTYeYOnm
	 JCuWh47z465KEtDcDbm5q24L92el6tM0QBiNAj80q2p2GahDVAxa03lXqVJXluvB4f
	 5QdUmF2un1IbSvfd9rHg2vlUknhJAtdwy1gLK3HAIRb8wZOuLMei+NH05KQkLC0BuR
	 +wpD02MJRS8UWlMPRum6cEYCY3dKkZjsACushZGMyiaPjXScG7CmAqeRCId78FxpUX
	 3YWDNHnqQWXZQ==
Message-ID: <171466b0-ff00-4390-aafd-78b846a9c488@fabianowski.eu>
Date: Wed, 9 Oct 2024 21:36:55 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v4 3/3] audio/avrcp: Determine Absolute Volume
 support from feature category 2
To: Marijn Suijten <marijn.suijten@somainline.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>,
 Pauli Virtanen <pav@iki.fi>, Marek Czerski <ma.czerski@gmail.com>
References: <20241005214321.84250-1-marijn.suijten@somainline.org>
 <20241005214321.84250-4-marijn.suijten@somainline.org>
 <CABBYNZLQexGSfm_0B-0_EFi3MOSZDiGzEdLBWqqUAU6_jRwOZg@mail.gmail.com>
 <brenpr5jeeivae4e2zqalqctcblyq3cvoeqqte36hnmyxh6v57@efpmjykxruj5>
Content-Language: en-US, de-DE, pl
From: Bartosz Fabianowski <bartosz@fabianowski.eu>
In-Reply-To: <brenpr5jeeivae4e2zqalqctcblyq3cvoeqqte36hnmyxh6v57@efpmjykxruj5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +

On 09/10/2024 12:30, Marijn Suijten wrote:
> On 2024-10-07 11:56:06, Luiz Augusto von Dentz wrote:
>> Hi Marijn,
>>
> <snip>
>>> diff --git a/src/main.conf b/src/main.conf
>>> index fff13ed2f..b6b32a720 100644
>>> --- a/src/main.conf
>>> +++ b/src/main.conf
>>> @@ -316,6 +316,15 @@
>>>   # notifications.
>>>   #VolumeCategory = true
>>>
>>> +# Require peer AVRCP controllers to have at least version 1.4 before
>>> +# accessing category-2 (absolute volume) features (depending on the value
>>> +# of VolumeCategory above).  It is common for Android-powered devices to not
>>> +# signal the desired minimum version of 1.4 while still supporting absolute
>>> +# volume based on the feature category bit, as mentioned in this comment:
>>> +# https://android.googlesource.com/platform/system/bt/+/android-12.0.0_r1/bta/
>>> +# av/bta_av_main.cc#621
>>> +#VolumeVersion = false
>>
>> I'd change this to have the version e.g. #VolumeVersion = 1.4, so the
>> user can switch to 1.3 or "any" in case he want to bypass version
>> checking
> 
> We can surely change this to parse a version which would override the version
> of the remote CT, and rename it to CTVersion since it's no longer only affecting
> volume?  Maybe add a TGVersion as well, and/or something else entirely?
> 
> That would save the ugly combinatorial explosion.  Maybe the same works for
> VolumeCategory introduced in the previous patch as well?
> 
>> also perhaps we should create an issue for Android folks to
>> fix their version, as it seems they do support browsing features
>> channel for TG they should be able to do the same for CT.
> 
> I don't think this patch aged particularly well as hinted by the testing
> steps in the cover letter: on my Android 14 phone AVRCP 1.5 is the default in
> developer settings, so they might have realized that this was a problem in the
> past.  Don't think we need to report it anymore, and we should perhaps start
> discussing whether this patch is still desired in the first place?  Either way
> I'd appreciate to land the first and second patch.

Even if current Android versions report AVRCP 1.5, there will be a lot 
of phones stuck on older versions for many years to come. Compatibility 
with these should still be very desirable.

> 
> - Marijn
> 
>>> +
>>>   [Policy]
>>>   #
>>>   # The ReconnectUUIDs defines the set of remote services that should try
>>> --
>>> 2.46.2
>>>
>>
>>
>> -- 
>> Luiz Augusto von Dentz
> 

