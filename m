Return-Path: <cyrus@holtmann.org>
Message-ID: <1331228722.14217.7.camel@aeonflux>
Subject: Re: [PATCH 1/2] bluetooth: hci_ldisc: fix NULL-pointer dereference
 on tty_close
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hovold <jhovold@gmail.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable <stable@vger.kernel.org>
Date: Thu, 08 Mar 2012 09:45:22 -0800
In-Reply-To: <20120308115721.GB4497@localhost>
References: <1331136120-27075-1-git-send-email-jhovold@gmail.com>
	 <1331136120-27075-2-git-send-email-jhovold@gmail.com>
	 <1331148797.3392.191.camel@aeonflux> <20120308115721.GB4497@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > Do not close protocol driver until device has been unregistered.
> > > 
> > > This fixes a race between tty_close and hci_dev_open which can result in
> > > a NULL-pointer dereference.
> > > 
> > > The line discipline closes the protocol driver while we may still have
> > > hci_dev_open sleeping on the req_lock mutex resulting in a NULL-pointer
> > > dereference when lock is acquired and hci_init_req called.
> 
> [...]
> 
> > what kernel version is this against? Our changes in bluetooth-next fixed
> > some of the destruct handling.
> 
> This is against the latest rc as it needs to be fixed in 3.3, but I
> missed a dependency to bluetooth-next as you point out below.
> 
> > Also hci_unregister_dev should be calling the destruct handler and thus
> > your change is now accessing hu but it got freed already.
> 
> You're right, my patch depends on 010666a126fc ("Bluetooth: Make
> hci-destruct callback optional") and 797fe796c4 ("Bluetooth: uart-ldisc:
> Fix memory leak and remove destruct cb") from bluetooth-next. 
> 
> But since the latter one fixes a memory leak it should have been marked
> for stable as well as pushed to Linus for 3.3, right?

we need to look into this and propose patches for -stable. Is your
problem still present with bluetooth-next or not?

Regards

Marcel


