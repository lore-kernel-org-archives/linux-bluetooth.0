Return-Path: <cyrus@holtmann.org>
Subject: Re: [HCI Events] Connection Event  Processing
From: Marcel Holtmann <marcel@holtmann.org>
To: Shreesh Holla <hshreesh@yahoo.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <128267.36461.qm@web56505.mail.re3.yahoo.com>
References: <128267.36461.qm@web56505.mail.re3.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Jul 2010 11:10:06 -0700
Message-ID: <1279563007.4572.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shressh,

first of all, stop top posting. This is rude and we will ignore further
emails from you if you keep doing this.

> ugh! I see the issues now. As you said - neither of those approaches would work for me since we need to conditionally handle the incoming connection really.
> 
> Wonder if there is some design reason this was done i.e. hardcoding it in hci_event.c? Or is it for performance reasons?   Any plans on supporting this in the future? 
> 
> What I'm considering is plugging in our own handler inside hci_event.c.
> 
> We can do this inside some custom hardware - but we are trying to avoid this since we already have other custom hardware we need to do in our device which is a wireless access control system.

I really don't know what you are trying to achieve here, but you might
better not use BlueZ if you wanna do something like this. The connection
handling needs to be done in the kernel and it does this the right way.

Use your own Bluetooth stack or switch the device into RAW mode and
program it as you like. As Johan mentioned RAW devices are left alone by
the kernel.

Regards

Marcel


