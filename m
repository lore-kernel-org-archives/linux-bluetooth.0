Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Nov 2011 19:40:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Create a unique mgmt error code hierarchy
Message-ID: <20111111174031.GA1176@fusion.localdomain>
References: <1321021134-31809-2-git-send-email-johan.hedberg@gmail.com>
 <1321027800-353-1-git-send-email-johan.hedberg@gmail.com>
 <E91B9660-3CDC-4632-8718-4C3103362219@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E91B9660-3CDC-4632-8718-4C3103362219@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Nov 11, 2011, Andre Guedes wrote:
> > The management protocol uses a single byte for error codes (aka command
> > status). In some places this value is directly copied from HCI and in
> > other a POSIX error number is used. This makes it impossible for
> > user-space to uniquily decipher the meaning of an error.
> > 
> > To solve this issue a new mgmt-specific set of error codes is added
> > along with a conversion table for HCI status values.
> 
> Using _only_ POSIX error codes in management protocol doesn't solve
> this problems? We could use the bt_to_errno() function to translate
> HCI errors into POSIX errors.

I think it's a bit too risky to restrict ourself to POSIX for all
possible Bluetooth errors we may need to communicate to user-space.
Considering that we still haven't added HS and LE based procedures to
the protocol at least I'm not willing to bet that POSIX is enough, or at
least that we'd get an intuitive mapping for it. Using our own codes
gives us flexibility in the long run and it also allows for more clear
and intuitive error names which you don't need to go digging in the
kernel source to figure out exactly what HCI error they map to.

Johan
