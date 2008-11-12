Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Nov 2008 10:39:07 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluez-gnome wizard deficiencies make it mostly useless
In-Reply-To: <491AB358.9000209@SSpaeth.de>
Message-ID: <Pine.LNX.4.64.0811121011130.25291@simba.math.ucla.edu>
References: <491AB358.9000209@SSpaeth.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 12 Nov 2008, Sebastian Spaeth wrote:

> I see 2 solutions and I would like input in what bluez-gnome devs think:
> 1) Try to pair with random PIN if that fails try "0000", "1234", "1111".
> This would at least cover about 90% of all devices and only special case
> the rest.
> 
> 2) Prepopulate a Random PIN in a field but allow the user to override
> that PIN. After all he should know best what PIN to use.

3)  A little more complicated: if the device class suggests no keyboard,
try the hardwired codes listed above, and in the 10% of cases where that 
fails (or if the device class suggests that there is a keyboard), then pop 
the dialog box for solution #2.  Particularly crappy devices may have a 
problem if pairing fails, so it could be helpful to have an override to 
bypass the hardwired codes even for device classes where they would 
normally be tried.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
