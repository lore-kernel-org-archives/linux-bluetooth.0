Return-Path: <cyrus@holtmann.org>
Message-ID: <1326915115.6454.411.camel@aeonflux>
Subject: Re: [PATCH 09/15] Bluetooth: Merge boolean members of struct
 hci_conn into flags
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 18 Jan 2012 20:31:55 +0100
In-Reply-To: <20120118192522.GA27730@fusion.localdomain>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
	 <1326912717-6347-10-git-send-email-johan.hedberg@gmail.com>
	 <1326913969.6454.405.camel@aeonflux>
	 <20120118192522.GA27730@fusion.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > >  	unsigned int	sent;
> > > @@ -409,6 +406,9 @@ enum {
> > >  	HCI_CONN_MODE_CHANGE_PEND,
> > >  	HCI_CONN_SCO_SETUP_PEND,
> > >  	HCI_CONN_LE_SMP_PEND,
> > > +	HCI_CONN_SSP_SUPPORT,
> > 
> > didn't we agree on naming this SSP_ENABLED?
> 
> We agreed about that for hci_dev but not for hci_conn (or then I
> misunderstood you). I used "support" here since it means that the remote
> device can support it if we have it enabled (and hence "enabled" for the
> hci_dev flag). But I can change it anyway you like.

since this is the host features of the remote side, it does actually
mean it is enabled. So using SSP_ENABLED is actually better.

Regards

Marcel


