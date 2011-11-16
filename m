Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 2/3] Bluetooth: remove old code
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 17 Nov 2011 06:47:11 +0900
In-Reply-To: <20111116204408.GD6027@joana>
References: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321457422-31641-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <20111116204408.GD6027@joana>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321480034.15441.551.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-16 17:30:21 +0200]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Remove old code not touched for several years.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/hci_core.c |   12 ------------
> >  1 files changed, 0 insertions(+), 12 deletions(-)
> 
> In despite of this being an RFC I'm taking this patch. Applied, thanks.

I wish you didn't sine I left that code in as a reminder that eventually
we might need to get this working for host-to-host-controller flow
control.

Regards

Marcel


