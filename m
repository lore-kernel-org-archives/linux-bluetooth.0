Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC 0/6] android: Configuration command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <2033637.5yzdKDHhAh@athlon>
Date: Tue, 13 May 2014 16:13:16 -0700
Cc: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <47461BAE-7996-4B63-A761-3DB79C319776@holtmann.org>
References: <1400000961-24376-1-git-send-email-szymon.janc@tieto.com> <92E59A56-9A08-481D-971C-FD3362FD9208@holtmann.org> <2033637.5yzdKDHhAh@athlon>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> This will allow to pass Android properties over IPC and use them
>>> in daemon for customization eg. Device Information or default adapter
>>> name.
>>> 
>>> Open points:
>>> - what properties should be read, currently I use ro.product.* as those
>>> 
>>>  are present on AOSP Nexus devices, but eg. on Xperia phones there
>>>  seem to be ro.semc.product.* with more userfriendly name, so this
>>>  may vary upon devices. (eg ST18i vs Xperia Ray in model property).
>>>  Or maybe just use ro.bluetooth.* and require integrator to set those
>>>  accrodingly?
>> 
>> I think we should take ro.bluetooth.* and fallback to ro.product.*. If some
>> manufactures want to do something different, they can either set
>> ro.bluetooth.* or hack the code.
>> 
>> Nexus devices should default to something useful. We have to take that as
>> standard location for product information.
>> 
>> Since non of the DID details are mandatory, I prefer also that they are just
>> not present if they are not configured in any property. Maybe BlueZ
>> defaults for manufacturer and systemd id.
> 
> Sounds good.
> 
>>> - should we also use this instead of 'Mode' passed on service init?
>>> 
>>>  This would keep handling of all properities consistent but I'm fine
>>>  if we decide to keep Modes special.
>> 
>> Do not understand the question. What do you mean.
> 
> I mean that we could pass all properties this way, including ones used to 
> configure HALs (persist.sys.bluetooth.handsfree, persist.sys.bluetooth.mode) 
> that currently are passed as "Mode" while registering service.
> 
> I also wonder if we could change our customization properties from 
> persist.sys.bluetooth.* to ro.bluetooth.*. I'm not sure why we choose to use 
> sys.persist.bluetooth in first place... do we really want this to be runtime 
> configurable?

I think we should use sys.persist.bluetooth first and if not present check ro.bluetooth as backup and if both are not present fallback to defaults. That gives us most flexibility.

Regards

Marcel

