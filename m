Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B83921F8
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125388; cv=none; b=dED75DL+VPWc7DCZy6cTux5Hns5xs//kpiRnaaGVgPU/QetdtF4m+F796a0Iq5Fl/abItt3o0TdAwRsgeoQHf0tUgQrZ8jUi6aeGmjdwNcQnY2AKgFlwUj2U4n7KBLdCoP+vG+VSRMxSZgT/Mf5cCzbOQJBrGRyZ/JTzkb5bTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125388; c=relaxed/simple;
	bh=OpqgetGLI9elSjz1+T65ROJUAXPi20HI3b24Wr6039w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=fdkm3mH8mL8jxOTA1CANsWUOIcmq9iMvhyni2DaS89oFa5ndQiqR9HfQ76xl5wK2g+IH0WTrN8PWQlv5B8uxSFBH+i+/6xf/MV6ES1oNoCosxLLLO4WD1Fp0KqrHDCdAG3ZydU8bnVQfDQ1ur3HGOzo3+w0JB3n30HlbKTHDDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3CFF84C2C37D5A;
	Thu, 02 Apr 2026 12:22:28 +0200 (CEST)
Message-ID: <42befa05-71bd-4a5e-9f8f-269ad532a234@molgen.mpg.de>
Date: Thu, 2 Apr 2026 12:22:27 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] rtl8822cu: BLE disconnects with firmware 0x0673_0EDC
To: Hilda Wu <hildawu@realtek.com>
References: <bug-221309-62941@https.bugzilla.kernel.org/>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org, linux-firmware@kernel.org,
 Josh Boyer <jwboyer@kernel.org>, regressions@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <bug-221309-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[To/Cc: +Hilda, linux-firmware@, Josh]

Dear Hilda, dear Josh,


Hilda, unfortunately, you do not have a Linux Kernel Bugzilla account, 
so I am replying here.

Am 02.04.26 um 01:57 schrieb bugzilla-daemon@kernel.org:
> https://bugzilla.kernel.org/show_bug.cgi?id=221309
> 
>              Bug ID: 221309
>             Summary: rtl8822cu: BLE disconnects with firmware 0x0673_0EDC
>                      regression
>             Product: Drivers
>             Version: 2.5
>            Hardware: AMD
>                  OS: Linux
>              Status: NEW
>            Severity: normal
>            Priority: P3
>           Component: Bluetooth
>            Assignee: linux-bluetooth@vger.kernel.org
>            Reporter: i+kernel.org@schimpf.link
>          Regression: No
> 
> Created attachment 309794
>    --> https://bugzilla.kernel.org/attachment.cgi?id=309794&action=edit
> stability log after downgrade
> 
> Overview
> 
> After updating linux-firmware-realtek to 20260221-1 (which includes commit fbf93476,
> "update rtl8822c bt usb and uart firmware to 0x0673"), the RTL8822CU USB Bluetooth adapter
> (0bda:b00c) begins dropping BLE connections every few minutes. Each disconnect
> lasts several seconds before the device reconnects. The adapter itself never resets and
> the USB device remains active throughout. Only the BLE link is lost.

[… Linux 6.19.10-arch1-1 …]

It looks like, the linux-firmware commit [1][2] caused a regression. 
(Also linux-bluetooth@ wasn’t in Cc?) Could you please look into it? I 
recommend to revert it for the time being and cut a new linux-firmware 
release.


Kind regards,

Paul


PS: Josh, do you have a pointer how to reach the commit from the merge 
request?

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/900 
shows 
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/1f806c75e479fea9f222579deb6e69d285b614fc, 
but I do not see a way to get to 
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/fbf93476.


[1]: 
https://lore.kernel.org/all/20260202115751.1056277-1-hildawu@realtek.com/
[2]: https://gitlab.com/kernel-firmware/linux-firmware/-/commit/fbf93476
