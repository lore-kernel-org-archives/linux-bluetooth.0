Return-Path: <cyrus@holtmann.org>
Message-ID: <1322744973.26198.31.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Ignore HCI_Read_Local_Commands failures
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Date: Thu, 01 Dec 2011 14:09:33 +0100
In-Reply-To: <20111201124039.GB2894@joana>
References: <1321898484-17952-1-git-send-email-johan.hedberg@gmail.com>
	 <1321898484-17952-2-git-send-email-johan.hedberg@gmail.com>
	 <20111201124039.GB2894@joana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Some 1.2 controllers will fail the HCI_Read_Local_Commands HCI command
> > even though (according to the specification) they should support it.
> > Since this HCI command is part of the controller init sequence
> > controllers broken in this manner would be unusable. Since not having
> > the list of supported commands is not critical for these controllers it
> > is better to just ignore failures in this case (additionally, this is
> > also how older kernels used to behave).
> > 
> > Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> > ---
> >  net/bluetooth/hci_event.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> Both patches have been applied, thanks.

I would have preferred you didn't. Since now I have to get this all
fixed up as well.

Regards

Marcel


