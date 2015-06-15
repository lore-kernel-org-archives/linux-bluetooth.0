Return-Path: <cyrus@holtmann.org>
Message-ID: <6dd76c85325eecb245178246ff563563.squirrel@mungewell.org>
In-Reply-To: <1690931.rDxa1ayEBf@athlon>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
    <1434392910-31648-2-git-send-email-szymon.janc@gmail.com>
    <467bb868b4b5b8120da0818a969eb054.squirrel@mungewell.org>
    <1690931.rDxa1ayEBf@athlon>
Date: Mon, 15 Jun 2015 16:36:21 -0400
Subject: Re: [PATCH 1/5] sixaxis: Fix PID for Navigation Controller
From: simon@mungewell.org
To: "Szymon Janc" <szymon.janc@gmail.com>
Cc: simon@mungewell.org, linux-bluetooth@vger.kernel.org,
	"Veseli Veseljko" <veseljko75@gmail.com>,
	"Alex Gal" <a.gal@miip.ca>,
	"Laurence Brown" <linux-bluetooth@protazoa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>> I don't have a good way on initiating the pairing, instead used a
>> hacked-up 'psmovepair' from PSMoveAPI guys. Followed by some hand
>> editing
>> of '/var/lib/bluetooth/<my-mac>/*' files.
>
> Sixaxis plugin should work for setting up Navigation.

You make the assumption that I'm on a recent version of Bluez ;-), which
perhaps I should be... being on Xubuntu means that by default I'm at 4.101
- with the occasional dip to something newer (breaks package manager
horribly).

I'll give a recent Bluez a go during the week.

> So, I'm not sure how to handle this. At least for me it looks like
> Navigation
> works just fine if setup as 0x0268 even if connects as 0x042f. The
> opposite
> doesn't work.
>
> Any thoughts?

There's not really much difference in behaviour. For me the advantage of
having 0x042f is that I can identify correctly and only enable 1-LED and
no rumble. I also patch the HID descriptor so that unused/randomly
changing Axis are masked.

Simon

