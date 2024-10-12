Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4914286
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Oct 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728702082; cv=none; b=UbMJNYSNeppJB/dMiEV8DLoGCLvIhTnvM2hV8EoW6wn28Zc3mLY5XOTSyNA6I+mTZDO/6TUPbL6yC/ZPa+B38lgSqWTMXvin+zvNw9NEZBiW56yrubdcEraTwdLhLF7o/4nItv6Jo9Ix0gzyaMVLlfvNPgY5NkNRj1nUoNvSXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728702082; c=relaxed/simple;
	bh=cfOZKe+CfzkZSnXUYTSAXVtblTVJfDPdnKhT3qz+Gng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNcopbcoaDHSZvGlxshDZvyfRGt7IMYjvlfIIulealMbGOWu9J3vn1UAM7UpxyJ6S8q8CpEbK87a5C/cFeEGUhOVd+yXz9O/uxByIsFteyGio4xrWFKwGA2hhq1X6Gl0dEg770Ozcpd7ujPejFNtD4UvJtBPuCmSIb9021Tp8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=i6DyPQD7; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="i6DyPQD7"
Received: from [192.168.80.133] (unknown [207.7.121.250])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4XQStk4gByz12wS;
	Fri, 11 Oct 2024 23:01:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1728702079; bh=cfOZKe+CfzkZSnXUYTSAXVtblTVJfDPdnKhT3qz+Gng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i6DyPQD7LZP/+d0w0SmLOh+7po388PLyJcaV3fNnKH3RfGkhUJFyyPwGSy1sXobt9
	 xW5iuDo+E0qjVApnNX0vs+h6/TKuxO1ngbaS/qxw5rvs3ahL3dXZr/FgB0PJ+hGvCW
	 I2GZrZK3ZXpKJKKHgqGJBGndyXsuajJ+8GJDzEuE=
Message-ID: <e158d058-1c94-48b9-ad4f-dd6fa54dece9@panix.com>
Date: Fri, 11 Oct 2024 20:01:17 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit 610712298b11 ("btusb: Don't fail external suspend
 requests") breaks BT upon resume on my laptop
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 Me <kenny@panix.com>
References: <6c599d9b-a000-48d8-ae88-ff424bf5ec38@panix.com>
 <CABBYNZJoUJCowqdPHyajKfV420bWGpOqqUO34Ooh67onZGQy1A@mail.gmail.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <CABBYNZJoUJCowqdPHyajKfV420bWGpOqqUO34Ooh67onZGQy1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


I'll try it without the PM calls and let you know (unless you get to it 
before I do).

-K

On 10/11/24 19:57, Luiz Augusto von Dentz wrote:
> Hi Kenneth,
> 
> On Fri, Oct 11, 2024 at 9:58 PM Kenneth Crudup <kenny@panix.com> wrote:
>>
>>
>> I'm running Linus' master (as of 09f6b0c890); resuming leaves me with a
>> somewhat-broken BT, but rmmod/modprobe "btusb" usually fixes it, at
>> least once.
>>
>> Reverting the above commit returns BT suspend/resume back to normal,
>> however.
>>
>> If you need any further info, please let me know.
> 
> Thanks for the report, looks like this is related to Fixes:
> 81b3e33bb054 ("Bluetooth: btusb: Don't fail external suspend
> requests"), we most likely gonna need to revert it or change it to not
> call hci_suspend_dev/hci_resume_dev since those are tuned for
> system-suspend/system-resume.
> 
>> -K
>>
>> --
>> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange
>> County CA
>>
>>
> 
> 

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

