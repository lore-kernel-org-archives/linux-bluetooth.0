Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Mar 2011 15:44:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arno Willig <akw@thinkwiki.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bug in hciconfig.c
Message-ID: <20110328124448.GA15266@jh-x301>
References: <AANLkTin4-oCPX3qoWFS1rnLScPmS1xs5LGW6+rAKyEaX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTin4-oCPX3qoWFS1rnLScPmS1xs5LGW6+rAKyEaX@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arno,

On Mon, Mar 28, 2011, Arno Willig wrote:
> I do not follow this list, so please excuse me, if this request isn't
> appropriate here.
> 
> I think I found an error in the Bluez Package of my Ubuntu 11.04
> distro. (bluez-4.90)
> In bluez-4.90/tools/hciconfig.c (Function cmd_version(), line 1141):
> 
>        hciver = hci_vertostr(ver.hci_ver);
>  -     lmpver = lmp_vertostr(ver.hci_ver);
> 
> 
> I think it should be this, right?
> 
>        hciver = hci_vertostr(ver.hci_ver);
>  +    lmpver = lmp_vertostr(ver.lmp_ver);
> 
> 
> Maybe nobody saw this before, because the values are nevertheless
> equal (2.1 for example) ?
> 
> 
> Please tell me if this is really a bug or if I oversaw something, will you?

It's a real bug which can be seen from commit 9848c1fa that introduced
it (6 years ago). Before that commit the code was correctly using lmp_ver.

I've pushed a patch to fix it upstream.

Johan
