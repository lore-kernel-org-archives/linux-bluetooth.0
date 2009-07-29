Return-Path: <cyrus@holtmann.org>
Message-ID: <4A70CF45.1060706@xyzw.org>
Date: Wed, 29 Jul 2009 15:37:57 -0700
From: Brian Rogers <brian@xyzw.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Wait for child devices to go away before deleting a connection
References: <4A6424D8.3040306@xyzw.org> <1248077430.4549.97.camel@violet>	 <4A6864DE.5010501@xyzw.org> <1248901964.28545.242.camel@violet>
In-Reply-To: <1248901964.28545.242.camel@violet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
>>> Kay, David, wouldn't be pinning of the parent device here be enough to
>>> get this done in a clean way?
>>>   
>>>       
>> If there's a way that the connection can be pinned until the child 
>> devices go away, that definitely sounds cleaner to me.
>>     
>
> so I pushed some patches to bluetooth-testing tree that should fix this
> problem. They are not fully tested by me. Please test and report back
> the results.
>   

Fails to compile if CONFIG_USB_HIDDEV=y :

ERROR: "hiddev_disconnect" [net/bluetooth/hidp/hidp.ko] undefined!

Ironically, the reference to hiddev_disconnect is fine if hiddev isn't 
enabled because then hiddev.h supplies an empty static inline function.

I'm going to test with a kernel without hiddev for now.

Brian
