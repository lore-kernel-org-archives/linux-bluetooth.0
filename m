Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH] Staging: btmtk_usb: Add hdev parameter to hdev->send driver callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131115212936.GC14897@kroah.com>
Date: Sat, 16 Nov 2013 07:26:30 +0900
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devel@driverdev.osuosl.org,
	Johan Hedberg <johan.hedberg@intel.com>,
	Yu-Chen Cho <acho@suse.com>,
	"linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>, jay.hung@mediatek.com
Message-Id: <6C5AC1E9-D9A0-473A-B47A-345018DFAC3C@holtmann.org>
References: <1384517231-1605-1-git-send-email-geert@linux-m68k.org> <D32EAC93-D2DE-431C-9DCB-885C5AA10A3A@holtmann.org> <20131115130820.GS5302@mwanda> <F615BA13-BEC1-457B-8002-BC6C149039EA@holtmann.org> <20131115212936.GC14897@kroah.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Greg,

>>>> while this is patch is correct, I do not really care about staging drivers that actually bluntly violate my copyright.
>>>> 
>>> 
>>> That's very cryptic.
>>> 
>>> What is going on here?  I googled it and I wasn't able to find what you
>>> are talking about.  Care to give us a hint and what you want us to do
>>> here?
>> 
>> the last time I checked, the majority of drivers/bluetooth/btusb.c has been written by myself. Now go and compare btusb.c to btmtk_usb.[ch].
>> 
>>> I have also added Johan Hedberg to the CC list because he also helped
>>> break the build.  Don't do that.
>> 
>> Yes, we are doing exactly that. It is a staging driver. I could not care less if a staging drivers breaks the build or not.
>> 
>> If anybody cares about this driver, then take the time to merge it upstream. It has never been submitted to linux-bluetooth mailing list.
>> 
>> There are drivers that should have never been merged into staging.
>> This is one of them. Look for yourself and explain to me why this
>> driver is part of staging in the first place.
> 
> Because it was sent to me by a developer?

it is a problem when staging just becomes a dumping ground for drivers that the distributions find somewhere on the Internet or CD-ROMs. And then nobody has any intentions to clean up and integrate properly. This one did not even go through linux-bluetooth mailing list once. It was submitted right to staging. And then the submitter walked away.

> Seriously, what's the issue here, I didn't notice it was a fork of your
> code, sorry, I didn't check.  I figured it would be eventually cleaned
> up properly and then it will be sent to linux-bluetooth for proper
> merging.

Kernel subsystem maintainers should not be responsible for fixing staging drivers. I did not even know that this driver existed in staging. I remember you saying that we can just ignore staging. The group of people looking after staging will take care of drivers that break.

Actually I am taken personal offense when someone takes my code, removes my copyright and slaps their copyright notice on top of it. Yes, I am looking at you Mediatek. I feel completely in my right to say that I am not touching this driver or care if it breaks.

And of course there is the technical problem that this driver as it is should not exist in the first place. We do not need duplicated code. The only difference between btusb.c and btmtk_usb.c is the driver init for loading firmware and poking at vendor specific registers. The Bluetooth subsystem has a vendor specific driver setup stage for exactly this. That should be used instead of forking the driver.

> Yu-Chen, what's the satus of getting this cleaned up "properly"?  You
> haven't really done anything on this since I took the driver in May.

My comment above stands, distributions do not seem to care :(

The Realtek Bluetooth driver is the same mess. I rejected it for the same reasons, but so far nobody made the effort to clean it up and build it as mini-driver of btusb.c.

Only our Intel guys managed to get that one done properly for their hardware. So yes, it can be done. I am not talking about unicorns here ;)

Regards

Marcel

