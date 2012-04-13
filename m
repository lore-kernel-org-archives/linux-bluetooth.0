Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 11:40:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Franko Danielos <danielos@zawiercie.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: L2cap bind - invalid argument
Message-ID: <20120413084003.GA9229@x220>
References: <1334261010.32169.14.camel@dhj-danielos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334261010.32169.14.camel@dhj-danielos>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Franko,

On Thu, Apr 12, 2012, Franko Danielos wrote:
> When I try to follow example from this site
> http://people.csail.mit.edu/albert/bluez-intro/x559.html
> I have an error while trying to bind. Error message is invalid argument.
> My question: is it related with newest bluetooth or kernel?
> 
> I use linux mint 12.
> Linux Kernel version 3.0.0 (but the same applies to 3.2.x)
> Bluez version: 4.96
> 
> I tested it also on earlier version of Linux Mint with kernel 2.6.32 and
> bluez 4.66 and that example works.
> Any ideas?

That would be because the PSM value in the example is not valid. Newer
kernels (post 2.6.32) check for this properly:

        /* PSM must be odd and lsb of upper byte must be 0 */
        if ((psm & 0x0101) != 0x0001) {
                err = -EINVAL;
                goto done;
        }

Johan
