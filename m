Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Wait for child devices to go away before deleting a
 connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Brian Rogers <brian@xyzw.org>
Cc: linux-bluetooth@vger.kernel.org,
	Kay Sievers <kay.sievers@vrfy.org>,
	David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <4A6424D8.3040306@xyzw.org>
References: <4A6424D8.3040306@xyzw.org>
Content-Type: text/plain
Date: Mon, 20 Jul 2009 10:10:30 +0200
Message-Id: <1248077430.4549.97.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> This patch fixes the device removal order when a connection is closed, 
> which allows HAL to see the remove event and prevents a bunch of 
> duplicate devices from piling up and eventually hitting the limit for 
> the for input devices in X.
> 
> Posting for discussion since I used a polling loop (with a sleep) to 
> wait for child devices to go away. I assume it'd be preferable to wait 
> in a more proper way. In that case, before I start, is this the right 
> place to be waiting?

since this is executed in a workqueue, you could easily sleep here
without any problems. However why do you need to sleep at all. The
device_move should sleep until the device is moved away, doesn't it?

Kay, David, wouldn't be pinning of the parent device here be enough to
get this done in a clean way?

Regards

Marcel


