Return-Path: <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Fix SCO on Broadcom Bluetooth adapters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        "Hack inc." <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
        bluez-devel@lists.sourceforge.net
In-Reply-To: <20060314140828.GA87175@dspnet.fr.eu.org>
References: <20060314111248.GA75477@dspnet.fr.eu.org>
	 <1142344144.4448.3.camel@aeonflux.holtmann.net>
	 <20060314140828.GA87175@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 22:27:56 +0000
Message-Id: <1142375276.3623.25.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Maw, 2006-03-14 at 15:08 +0100, Olivier Galibert wrote:
> Meanwhile, I'll implement it with a quirk, and I can guarantee that
> you're not going to like the result.  I have a list of 104 (iirc)
> device ids that may need it, and given that hardware is supposed to
> work they will have to be added until proven otherwise.

Just add a wildcard quirk so your fixup is called for every single
device and then does the check. Keeps the fix out of the core and
clearly documented while keeping the list short.
