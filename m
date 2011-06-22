Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308688620.2196.61.camel@aeonflux>
References: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
	<1308686870-26101-3-git-send-email-andre.guedes@openbossa.org>
	<1308688620.2196.61.camel@aeonflux>
Date: Wed, 22 Jun 2011 13:36:23 -0300
Message-ID: <BANLkTik_5+s9coWFR0Nd2GsH6gO=pRBKUQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Add MGMT_OP_SET_LE_SUPPORT command
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jun 21, 2011 at 5:36 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> any reason why we want this separated and being under host stack control
> in the first place. Should we not always enable LE if we can support it?
> What are the reason to run an LE capable BlueZ on an LE capable dongle
> and then not enable LE?
>

I don't know the reason why, but today LE enabling is separated and is
under host control. There is an option in main.conf (EnableLE) to
enable/disable LE.

AFAIK, the reason we want to disable LE is qualification tests only. Also,
since LE support is under development we may not wanna have LE enabled
by default (maybe this is another reason).

> Maybe we should just have a generic kernel mgmt features enabling
> command. One thing that I do not wanna do is to just blindly make a copy
> of HCI commands for mgmt interface. The controller abstraction for the
> mgmt interface is suppose to have a feature list so we can check what
> the kernel supports and what not.
>

We had a little discussion here and we came up with this idea of having
new parameter to the module (e. g. enable_le) to enable/disable LE. If
the module is loaded with enable_le=y we would enable LE host support.
Once LE support is stable enough, we have enable_le=y by default.
This approach we don't need a mgmt command.

What do you think about this approach ?

BR,

Andre Guedes.
