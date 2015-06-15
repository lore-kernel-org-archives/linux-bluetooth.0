Return-Path: <cyrus@holtmann.org>
Message-ID: <467bb868b4b5b8120da0818a969eb054.squirrel@mungewell.org>
In-Reply-To: <1434392910-31648-2-git-send-email-szymon.janc@gmail.com>
References: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
    <1434392910-31648-2-git-send-email-szymon.janc@gmail.com>
Date: Mon, 15 Jun 2015 14:45:39 -0400
Subject: Re: [PATCH 1/5] sixaxis: Fix PID for Navigation Controller
From: simon@mungewell.org
To: "Szymon Janc" <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Veseli Veseljko" <veseljko75@gmail.com>,
	"Alex Gal" <a.gal@miip.ca>,
	"Laurence Brown" <linux-bluetooth@protazoa.com>,
	"Szymon Janc" <szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> Navigation Controller is using PID 0x042f over USB but PID 0x0268
> (same as Dualshock 3) over BT.

Hi,
I'm in the process of fixing the hid-sony driver to support the
Navigation, and I'm seeing that it connects with 0x042f over BT. I did see
at least once when it used the 0x0268, so it must be switching into an
emulation mode at some times.

I don't have a good way on initiating the pairing, instead used a
hacked-up 'psmovepair' from PSMoveAPI guys. Followed by some hand editing
of '/var/lib/bluetooth/<my-mac>/*' files.

Happy to share files/info with you,
Simon.


