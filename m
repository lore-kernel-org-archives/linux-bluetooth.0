Return-Path: <cyrus@holtmann.org>
Message-ID: <1351712048.1828.17.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Notify about device registration before
 power on
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 31 Oct 2012 12:34:08 -0700
In-Reply-To: <20121031190907.GA3631@x220.P-661HNU-F1>
References: <1351586140-30708-1-git-send-email-marcel@holtmann.org>
	 <20121031181801.GB1679@joana> <20121031190907.GA3631@x220.P-661HNU-F1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > > It is important that the monitor interface gets notified about
> > > a new device before its power on procedure has been started.
> > > 
> > > For some reason that is no longer working as expected and the power
> > > on procedure runs first. It is safe to just notify about device
> > > registration and trigger the power on procedure afterwards.
> > > 
> > > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > > ---
> > >  net/bluetooth/hci_core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Patch has been applied to bluetooth-next. Thanks.
> 
> I guess you mean bluetooth.git? (that's where the patch is right now -
> not bluetooth-next). Also, I don't think the Cc: stable addition was
> necessary since this scheduling behavior seems to be something only
> introduced for 3.7 (not 100% sure about this though).

I did not send this to stable, because I think it is 3.7-rc only
behavior. Feel free to test it. With the help of btmon it is really easy
to see if the New Index event arrives before the first HCI command or
not. Remember that this only applies for newly attached devices and
btmon already running.

Regards

Marcel


