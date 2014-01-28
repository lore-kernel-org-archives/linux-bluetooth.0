Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jan 2014 09:31:54 +0100
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Alexander Holler <holler@ahsoftware.de>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	peter@hurleysoftware.com,
	"linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Regression fixes for rfcomm/tty.c
Message-ID: <20140128083154.GA29060@sottospazio.it>
References: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it>
 <53C8DDF7-94EA-4E01-A2A9-C366F9F85530@holtmann.org>
 <52DCDF84.1040902@ahsoftware.de>
 <E0DDC796-EECF-46B6-8EDF-801CF8EFD456@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E0DDC796-EECF-46B6-8EDF-801CF8EFD456@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jan 20, 2014 at 09:37:14AM -0800, Marcel Holtmann wrote:
> Hi Alexander,
> 
> >> all 4 patches have been applied to bluetooth-next tree.
> > 
> > Maybe a bit late, but I've just seen they miss a Cc: stable@vger.kernel.org to automatically end up in 3.12 and 3.13 too.
> 
> we can always promote them to stable. On Purpose I wanted them to cycle through bluetooth-next for a while to make sure they do not cause any other regressions.
> 
> Regards
> 
> Marcel
> 

Unfortunately it seems I overlooked the fact that rfcomm_dev_activate() is
called with the port->mutex held. So patches 2/3/4 cause a regression I missed
because I didn't turn on the appropriate debug options (circular locking
dependency, a bug report already appeared on this list).

I'm afraid this all stems from my partial knowledge of the tty_port code and
unfortunately I don't know how to solve the problem right now.

I think it's better to revert those patches for the moment.

Regards,

Gianluca
