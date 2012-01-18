Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Jan 2012 21:25:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 09/15] Bluetooth: Merge boolean members of struct
 hci_conn into flags
Message-ID: <20120118192522.GA27730@fusion.localdomain>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
 <1326912717-6347-10-git-send-email-johan.hedberg@gmail.com>
 <1326913969.6454.405.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326913969.6454.405.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jan 18, 2012, Marcel Holtmann wrote:
> >  	unsigned int	sent;
> > @@ -409,6 +406,9 @@ enum {
> >  	HCI_CONN_MODE_CHANGE_PEND,
> >  	HCI_CONN_SCO_SETUP_PEND,
> >  	HCI_CONN_LE_SMP_PEND,
> > +	HCI_CONN_SSP_SUPPORT,
> 
> didn't we agree on naming this SSP_ENABLED?

We agreed about that for hci_dev but not for hci_conn (or then I
misunderstood you). I used "support" here since it means that the remote
device can support it if we have it enabled (and hence "enabled" for the
hci_dev flag). But I can change it anyway you like.

Johan
