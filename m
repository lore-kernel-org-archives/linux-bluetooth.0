Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Wait for child devices to go away before deleting a
 connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Rogers <brian@xyzw.org>
Cc: linux-bluetooth@vger.kernel.org,
	Kay Sievers <kay.sievers@vrfy.org>,
	David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <4A6864DE.5010501@xyzw.org>
References: <4A6424D8.3040306@xyzw.org> <1248077430.4549.97.camel@violet>
	 <4A6864DE.5010501@xyzw.org>
Content-Type: text/plain
Date: Wed, 29 Jul 2009 23:12:44 +0200
Message-Id: <1248901964.28545.242.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> >> This patch fixes the device removal order when a connection is closed, 
> >> which allows HAL to see the remove event and prevents a bunch of 
> >> duplicate devices from piling up and eventually hitting the limit for 
> >> the for input devices in X.
> >>
> >> Posting for discussion since I used a polling loop (with a sleep) to 
> >> wait for child devices to go away. I assume it'd be preferable to wait 
> >> in a more proper way. In that case, before I start, is this the right 
> >> place to be waiting?
> >>     
> >
> > since this is executed in a workqueue, you could easily sleep here
> > without any problems. However why do you need to sleep at all. The
> > device_move should sleep until the device is moved away, doesn't it?
> >   
> 
> The moves do complete before the connection is removed, but it seems bad 
> to me to just move the child devices away rather than letting them close 
> down and be removed directly from the original location where they were 
> created. HAL thinks so, too: it still doesn't catch the input device 
> removal if they are moved away before they are deleted.
> 
> > Kay, David, wouldn't be pinning of the parent device here be enough to
> > get this done in a clean way?
> >   
> 
> If there's a way that the connection can be pinned until the child 
> devices go away, that definitely sounds cleaner to me.

so I pushed some patches to bluetooth-testing tree that should fix this
problem. They are not fully tested by me. Please test and report back
the results.

Regards

Marcel


