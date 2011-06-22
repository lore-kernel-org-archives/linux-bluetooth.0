Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Bluetooth: Add MGMT_OP_SET_LE_SUPPORT command
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 22 Jun 2011 09:57:42 -0700
In-Reply-To: <BANLkTik_5+s9coWFR0Nd2GsH6gO=pRBKUQ@mail.gmail.com>
References: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
	 <1308686870-26101-3-git-send-email-andre.guedes@openbossa.org>
	 <1308688620.2196.61.camel@aeonflux>
	 <BANLkTik_5+s9coWFR0Nd2GsH6gO=pRBKUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308761865.2196.77.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> > any reason why we want this separated and being under host stack control
> > in the first place. Should we not always enable LE if we can support it?
> > What are the reason to run an LE capable BlueZ on an LE capable dongle
> > and then not enable LE?
> >
> 
> I don't know the reason why, but today LE enabling is separated and is
> under host control. There is an option in main.conf (EnableLE) to
> enable/disable LE.
> 
> AFAIK, the reason we want to disable LE is qualification tests only. Also,
> since LE support is under development we may not wanna have LE enabled
> by default (maybe this is another reason).

for that I would have used a enable_le kernel module option since it
should be all triggered by the kernel anyway.

> > Maybe we should just have a generic kernel mgmt features enabling
> > command. One thing that I do not wanna do is to just blindly make a copy
> > of HCI commands for mgmt interface. The controller abstraction for the
> > mgmt interface is suppose to have a feature list so we can check what
> > the kernel supports and what not.
> >
> 
> We had a little discussion here and we came up with this idea of having
> new parameter to the module (e. g. enable_le) to enable/disable LE. If
> the module is loaded with enable_le=y we would enable LE host support.
> Once LE support is stable enough, we have enable_le=y by default.
> This approach we don't need a mgmt command.

See above ;)

I am open for discussion on how we might solve this in a bit more
generic way on let this control by the user. Mainly for qualification
testing and UPF testing. However we need a clear story for LE and SSP
since both are host stack driven features.

Regards

Marcel


