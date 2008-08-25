Return-Path: <cyrus@holtmann.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-pm@lists.linux-foundation.org,
	linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
	linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>
Message-Id: <A990FF09-40FE-40B4-B0AA-C89827D1A559@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
In-Reply-To: <200808251353.12590.oliver@neukum.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: btusb hibernation/suspend breakage in current -git
Date: Mon, 25 Aug 2008 13:55:50 +0200
References: <200808221520.19791.oliver@neukum.org> <1219415470.7591.472.camel@violet.holtmann.net> <200808251337.16076.rjw@sisk.pl> <200808251353.12590.oliver@neukum.org>
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

>> Since the bluetooth adapter in this box is apparently handled by  
>> btusb, I'm
>> suspecting the problem may be related to it or to the USB subsystem  
>> (ehci-hcd
>> in particular).  I'm going to debug it further, but if you have any  
>> ideas to
>> try, I'll appreciate any help.
>
> btusb in current git doesn't implement suspend/resume. Thus the  
> driver will be
> unbound. Possibly the bluetooth subsystem cannot stand that while  
> suspended.

that should work. It then really looks like a bug. Something more  
weird must be going on here.

Regards

Marcel

