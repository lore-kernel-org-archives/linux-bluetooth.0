Return-Path: <cyrus@holtmann.org>
Subject: Re: Fwd: Unable to pair keyboard
From: Bastien Nocera <hadess@hadess.net>
To: Carlos Romero <kcrashcore@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <f0a7afec0909011038x1d22f6abxe894dee39e91439@mail.gmail.com>
References: <f0a7afec0909010916s1977725dk46cc34c545f3424c@mail.gmail.com>
	 <1251822966.3326.92.camel@localhost.localdomain>
	 <f0a7afec0909011023p512d5820h10a5264743593845@mail.gmail.com>
	 <f0a7afec0909011038x1d22f6abxe894dee39e91439@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 01 Sep 2009 18:53:43 +0100
Message-Id: <1251827623.3326.167.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2009-09-01 at 13:38 -0400, Carlos Romero wrote:
> I did follow the instructions on the dialog, just like I did when
> setting it up in f11.
> right code and wrong code, main and number pad, nothing happens when I
> press enter.

Then please attach the output of "hcidump -X" when reproducing the
problem, and mention your kernel version. You might also want to upgrade
to the latest bluez[1] and see if it helps.

You could also test with a known working Fedora 11 kernel, if at all
possible.

Cheers

[1]: http://koji.fedoraproject.org/koji/buildinfo?buildID=130161

