Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 13:17:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Steffen Becker <steffen.becker@tu-ilmenau.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: are those patches up-to-date?
Message-ID: <20120524101709.GA23856@x220>
References: <31e819c2c3bf85abeabfbe74e3341826@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <31e819c2c3bf85abeabfbe74e3341826@localhost>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffen,

On Thu, May 24, 2012, Steffen Becker wrote:
> I searched a little in your mail archive on gmane and found
> something that looks similar to my problem. On 25th January 2011 and
> 26th October 2011 you pushed out two patches because of a security
> block issue -> "[PATCH] bluetooth: Fix for security block issue."
> and "[PATCH] Bluetooth: Revert: Fix L2CAP connection establishment".
> 
> The postet hcidump message in the second mail (10/26/2011) looks
> very similar to my hcidump message.
> 
> So I would like to know if those two patches are up-to-date
> (compatibel with bluez4.99) and/or if they are already included in
> bluez4.99 (so patching is not necessary) ?

Your question doesn't make much sense as those are both kernel patches
and BlueZ 4.99 is a user space component. I think both of those patches
can be found in kernel 3.3 and later.

Johan
