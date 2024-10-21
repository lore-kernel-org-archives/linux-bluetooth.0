Received: from dd49702.kasserver.com (dd49702.kasserver.com [85.13.136.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3D1EF082
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.136.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540721; cv=none; b=JbR7cWQAn0MDlCH5FbZ+zBFzCFwzTdOskPe7j3Hr0iWE1yO9CWmMZWT2aD/McXXu4vqm7RnHmBdg2r8jKFCgGWTavTDSz9MPjrpyHCG5QAvDEtLw6n50Dj7ock2jrUcTM9UOZ3QT2RYJ5HrAa2e3fLeXQhNpp3GfySJ2gXTa44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540721; c=relaxed/simple;
	bh=V67Lj1kk1AWMztap7Ies8ZQi2/t40YnypMdxSckP644=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lu/J8e5vVXNCW3aGdDijXRn0JYiM7laH0sDG8jCz5wEpTn/ZPaAmisO0d5iPqSvjz/Mj64Ms7AMKR8ItmmbMcAAjsSZfTlMzmxT3sQwKga948WhcsQn5M4RN9D875v1uH9/YMkIHERUZLd8pCaPLBr/SBbwMNhaK0A4fDvDx+RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fabianowski.eu; spf=pass smtp.mailfrom=fabianowski.eu; dkim=pass (2048-bit key) header.d=fabianowski.eu header.i=@fabianowski.eu header.b=hI1zi/Pd; arc=none smtp.client-ip=85.13.136.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fabianowski.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fabianowski.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fabianowski.eu header.i=@fabianowski.eu header.b="hI1zi/Pd"
Received: from [10.188.173.31] (unknown [213.61.198.122])
	by dd49702.kasserver.com (Postfix) with ESMTPSA id 71BE65406C62;
	Mon, 21 Oct 2024 21:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fabianowski.eu;
	s=kas202409081107; t=1729540393;
	bh=xaBgBaAJZYyNFvn54nCu+4SapAEGNJf/tDMrf8eVi1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hI1zi/PdET7rCsylwE+B4IFhI7d8xUcU8exXjgq3nFLs2NMBBtM+gNRTBgDDRu+Yr
	 cMiCLwaeaeuyP4qAAki+HTcyDXsqEoyPkmvUpyS9Q5nu7d/RMJ1F1jH73Z4csCedfB
	 tprQIHaTeNULQioRMmwN0fRApjwvutusWLu4KlrehtfFbxCmX7iUEgOZyElFQBZwbe
	 CB1T9tuJpzp2R0eQEulI/oxBaMHpCTIxQEvb0RXH63EKq4Kz8Ug9Fo/ZJqr1lQUM92
	 Pi2tShLbW5O9qT3byHYQY8aDSbiSq+4YelkheZZzGkSG33nqbGASFylpTKv6jpen2X
	 HPjLngwVBoz9A==
Message-ID: <d85d9bc2-5a73-42ea-92c9-bdd5126ea527@fabianowski.eu>
Date: Mon, 21 Oct 2024 21:53:12 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v4 3/3] audio/avrcp: Determine Absolute Volume
 support from feature category 2
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>,
 Pauli Virtanen <pav@iki.fi>, Marek Czerski <ma.czerski@gmail.com>
References: <20241005214321.84250-1-marijn.suijten@somainline.org>
 <20241005214321.84250-4-marijn.suijten@somainline.org>
 <CABBYNZLQexGSfm_0B-0_EFi3MOSZDiGzEdLBWqqUAU6_jRwOZg@mail.gmail.com>
 <brenpr5jeeivae4e2zqalqctcblyq3cvoeqqte36hnmyxh6v57@efpmjykxruj5>
 <171466b0-ff00-4390-aafd-78b846a9c488@fabianowski.eu>
 <CABBYNZLrz74H0KTcDCjeXo6SeoRBXSH+6fK-3Zs_5gNpExzNzQ@mail.gmail.com>
Content-Language: en-US, de-DE, pl
From: Bartosz Fabianowski <bartosz@fabianowski.eu>
In-Reply-To: <CABBYNZLrz74H0KTcDCjeXo6SeoRBXSH+6fK-3Zs_5gNpExzNzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +

On 21/10/2024 21:32, Luiz Augusto von Dentz wrote:
> Hi Bartosz,
> 
> On Wed, Oct 9, 2024 at 3:36 PM Bartosz Fabianowski
> <bartosz@fabianowski.eu> wrote:
>>
>> On 09/10/2024 12:30, Marijn Suijten wrote:
>>> On 2024-10-07 11:56:06, Luiz Augusto von Dentz wrote:
>>>> Hi Marijn,
>>>>
>>> <snip>
>>>>> diff --git a/src/main.conf b/src/main.conf
>>>>> index fff13ed2f..b6b32a720 100644
>>>>> --- a/src/main.conf
>>>>> +++ b/src/main.conf
>>>>> @@ -316,6 +316,15 @@
>>>>>    # notifications.
>>>>>    #VolumeCategory = true
>>>>>
>>>>> +# Require peer AVRCP controllers to have at least version 1.4 before
>>>>> +# accessing category-2 (absolute volume) features (depending on the value
>>>>> +# of VolumeCategory above).  It is common for Android-powered devices to not
>>>>> +# signal the desired minimum version of 1.4 while still supporting absolute
>>>>> +# volume based on the feature category bit, as mentioned in this comment:
>>>>> +# https://android.googlesource.com/platform/system/bt/+/android-12.0.0_r1/bta/
>>>>> +# av/bta_av_main.cc#621
>>>>> +#VolumeVersion = false
>>>>
>>>> I'd change this to have the version e.g. #VolumeVersion = 1.4, so the
>>>> user can switch to 1.3 or "any" in case he want to bypass version
>>>> checking
>>>
>>> We can surely change this to parse a version which would override the version
>>> of the remote CT, and rename it to CTVersion since it's no longer only affecting
>>> volume?  Maybe add a TGVersion as well, and/or something else entirely?
>>>
>>> That would save the ugly combinatorial explosion.  Maybe the same works for
>>> VolumeCategory introduced in the previous patch as well?
>>>
>>>> also perhaps we should create an issue for Android folks to
>>>> fix their version, as it seems they do support browsing features
>>>> channel for TG they should be able to do the same for CT.
>>>
>>> I don't think this patch aged particularly well as hinted by the testing
>>> steps in the cover letter: on my Android 14 phone AVRCP 1.5 is the default in
>>> developer settings, so they might have realized that this was a problem in the
>>> past.  Don't think we need to report it anymore, and we should perhaps start
>>> discussing whether this patch is still desired in the first place?  Either way
>>> I'd appreciate to land the first and second patch.
>>
>> Even if current Android versions report AVRCP 1.5, there will be a lot
>> of phones stuck on older versions for many years to come. Compatibility
>> with these should still be very desirable.
> 
> They didn't bother backporting it? I wonder if we could somehow detect
> this behavior based on the Android version if that is available
> somewhere.

Looks like Android 14 and newer report AVRCP 1.5. Android 13 (which was 
released two years ago and is still on many phones) still uses AVRCP 1.3.

- Bartosz

> 
>>>
>>> - Marijn
>>>
>>>>> +
>>>>>    [Policy]
>>>>>    #
>>>>>    # The ReconnectUUIDs defines the set of remote services that should try
>>>>> --
>>>>> 2.46.2
>>>>>
>>>>
>>>>
>>>> --
>>>> Luiz Augusto von Dentz
>>>
>>
> 
> 

