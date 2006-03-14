Return-Path: <galibert@dspnet.fr.eu.org>
Date: Wed, 15 Mar 2006 00:47:15 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        "Hack inc." <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
        bluez-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix SCO on Broadcom Bluetooth adapters
Message-ID: <20060314234714.GA49778@dspnet.fr.eu.org>
References: <20060314111248.GA75477@dspnet.fr.eu.org> <1142344144.4448.3.camel@aeonflux.holtmann.net> <20060314140828.GA87175@dspnet.fr.eu.org> <1142375276.3623.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1142375276.3623.25.camel@localhost.localdomain>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Mar 14, 2006 at 10:27:56PM +0000, Alan Cox wrote:
> Just add a wildcard quirk so your fixup is called for every single
> device and then does the check. Keeps the fix out of the core and
> clearly documented while keeping the list short.

Errr, ok, I'm all for doing that but I'm not sure what "that" means.
You want the test/fix to be put in a function somewhere to be defined
and hci_event to call it where I put the if initially?

  OG.

PS: It's only 51 after all.  For now, that is, since we know there
    will be new ones with the same problem.
