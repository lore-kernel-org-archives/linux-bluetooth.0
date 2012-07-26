Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Jul 2012 13:54:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: victor yeo <victoryeo1974@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: After pairing, get "Link Key Request Negative Reply"
Message-ID: <20120726115404.GA24623@x220.ice.intel.com>
References: <CADX0rsbmzFwwPu4VteS+0m7oqow4-rY0P1O33GgaFrQZc4YTAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADX0rsbmzFwwPu4VteS+0m7oqow4-rY0P1O33GgaFrQZc4YTAg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Victor,

On Thu, Jul 26, 2012, victor yeo wrote:
> I have a device with address 00:09:1F:80:12:21, i can pair the device
> to Bluez, the linkkeys file contains:
> 
> # cat /var/lib/bluetooth/00\:07\:80\:56\:F8\:70/linkkeys
> 00:09:1F:80:12:21    41F80F349B12603669616D178B0F5974 4 0
> 
> from hcidump, the "Link Key Request Negative Reply" is received, then
> "Unauthenticated Combination Key" is received, then  "Connection
> refused - security block" is received.
> 
> Is this a Bluez or device problem?

It looks like a BlueZ (kernel) problem.

> There is a "Fix l2cap conn failures for ssp devices", is it related?

Yes, I think that patch should fix the issue.

Johan
