Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Apr 2012 15:33:01 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Auth combination keys should be stored
 permanently
Message-ID: <20120417123301.GA4069@x220.ger.corp.intel.com>
References: <1334663953-15017-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334663953-15017-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Tue, Apr 17, 2012, Vishal Agarwal wrote:
> If either local or remote device auth type is general bonding
> (for ex. if local auth type is 0 but remote auth type is 5) then it
> will result in link key of type authenticated link key. Which according
> to spec should be stored for future use.

You'll need to give some precise references into the core specification
about where you think it says this since I think you are a bit confused
here. I'd also advice you to carefully read section 5.2.2.6 on page 1668
and table 5.6 on page 1669. Those describe how the IO capabilities
(note: *not* authentication requirements) map to the resulting key type.
The only case where the auth requirements affect the key type is if
neither side has the MITM bit set (in which case you get an
unauthenticated key).

In your example with the local auth requirement being 0, meaning no
bonding, the spec says this (section 6.5.3.1, page 1680):

"'No bonding' is used when the device is performing a Secure Simple
Pairing procedure, but does not intend to retain the link key after the
physical link is disconnected."

I.e. if we have 0 it means that we do not intend to store the key and
hci_persistent_key should return false. The key type otoh tells us
nothing about the authentication requirement. You can get an
authenticated combination key with no-bonding, dedicated bonding
as well as with general bonding.

Johan
