Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Mar 2013 16:34:09 -0500
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 07/26] Bluetooth: Add a define for the HCI persistent
 flags mask
Message-ID: <20130315213409.GA24055@x220.dfw6.dal.wayport.net>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
 <1363198337-3896-8-git-send-email-johan.hedberg@gmail.com>
 <035D9C11-5F66-4584-AB2C-86DA558E2A2E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <035D9C11-5F66-4584-AB2C-86DA558E2A2E@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 15, 2013, Marcel Holtmann wrote:
> > +/* A mask for the flags that are supposed to remain when a reset happens
> > + * or the HCI device is closed.
> > + */
> > +#define HCI_PERSISTENT_MASK ~(BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ))
> > +
> 
> didn't we agree and getting this fixed and moving the ~ to the actual call.

Yes we did. I just forgot about it, sorry. v5 of this patch coming in a
minute.

Johan
