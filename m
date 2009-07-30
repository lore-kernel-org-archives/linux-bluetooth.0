Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Wait for child devices to go away before deleting a
 connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Rogers <brian@xyzw.org>
Cc: linux-bluetooth@vger.kernel.org,
	Kay Sievers <kay.sievers@vrfy.org>,
	David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <4A70CF45.1060706@xyzw.org>
References: <4A6424D8.3040306@xyzw.org> <1248077430.4549.97.camel@violet>
	 <4A6864DE.5010501@xyzw.org> <1248901964.28545.242.camel@violet>
	 <4A70CF45.1060706@xyzw.org>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 04:33:11 +0200
Message-Id: <1248921191.28545.251.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> >>> Kay, David, wouldn't be pinning of the parent device here be enough to
> >>> get this done in a clean way?
> >>>   
> >>>       
> >> If there's a way that the connection can be pinned until the child 
> >> devices go away, that definitely sounds cleaner to me.
> >>     
> >
> > so I pushed some patches to bluetooth-testing tree that should fix this
> > problem. They are not fully tested by me. Please test and report back
> > the results.
> >   
> 
> Fails to compile if CONFIG_USB_HIDDEV=y :
> 
> ERROR: "hiddev_disconnect" [net/bluetooth/hidp/hidp.ko] undefined!
> 
> Ironically, the reference to hiddev_disconnect is fine if hiddev isn't 
> enabled because then hiddev.h supplies an empty static inline function.
> 
> I'm going to test with a kernel without hiddev for now.

just take that piece out of the patch. It is not important. I just wanna
now if the uevents are now coming in order.

Regards

Marcel


