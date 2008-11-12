Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Nov 2008 11:59:52 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluez-gnome wizard deficiencies make it mostly useless
In-Reply-To: <1226518197.15397.11.camel@snoogens.fab.redhat.com>
Message-ID: <Pine.LNX.4.64.0811121150340.25291@simba.math.ucla.edu>
References: <491AB358.9000209@SSpaeth.de> <1226518197.15397.11.camel@snoogens.fab.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 12 Nov 2008, Bastien Nocera wrote:

> On Wed, 2008-11-12 at 11:43 +0100, Sebastian Spaeth wrote:
> <snip>

> That wouldn't work, a lot of devices will get out of pairing mode after
> an unsuccesful pairing.

It may be just my fumble fingers, but I think with my Motorola HT-820 
headset you have to exit from pairing mode (power cycle) and re-enter if 
you botch the 0000.

> My solution would be to have a button at the bottom of the device
> selection page called "PIN options" (or similar). The button would popup
> a dialogue with options:
> [X] Automatic PIN selection
> 
> [ ] Force a random PIN number
> 
> [ ] Use fixed PIN code:
>         [X] '0000' (most headsets, mice and GPS devices)
>         [ ] '1111'
>         [ ] '1234'
>         [ ] Custom: ___________

Excellent!  But I haven't messed enough with GTK+ to make it happen.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
