Return-Path: <cyrus@holtmann.org>
Date: Mon, 16 Apr 2012 12:59:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 2/2] Bluetooth: Temporary keys should be retained
 during connection
Message-ID: <20120416095909.GA26169@x220.P-661HNU-F1>
References: <1334567684-14210-1-git-send-email-vishal.agarwal@stericsson.com>
 <1334569876.16897.172.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334569876.16897.172.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 16, 2012, Marcel Holtmann wrote:
> > If a key is non persistent then it should not be used in future
> > connections but it should be kept for current connection. And it
> > should be removed when connecion is removed.
> > 
> > Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> > ---
> >  include/net/bluetooth/hci_core.h |    1 +
> >  net/bluetooth/hci_core.c         |    6 ++----
> >  net/bluetooth/hci_event.c        |    2 ++
> >  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Both patches have been applied to the bluetooth and bluetooth-next
trees. Thanks.

Johan
