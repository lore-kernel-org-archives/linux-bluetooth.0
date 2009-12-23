Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Dec 2009 16:48:41 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, "Daniel T. Cobra"
 <dcobra@videam.com.br>
Subject: Re: Long delay to (re)connect a bluetooth mouse
Message-ID: <20091223164841.7070e75d@strolchi.home.s3e.de>
In-Reply-To: <1261177111.4041.99.camel@localhost.localdomain>
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>
	<4B2A4B90.1040009@videam.com.br>
	<4B2BBF58.4030901@videam.com.br>
	<1261173899.4041.96.camel@localhost.localdomain>
	<1261176544.4b2c06e0e0eae@www.fastmail.com.br>
	<1261177111.4041.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 18 Dec 2009 14:58:31 -0800
Marcel Holtmann <marcel@holtmann.org> wrote:

> even if I use Bluetooth on a daily basis, I don't use any mouse or
> keyboard devices anymore. So I have no idea on how many people are
> actually using these.

I'm still using it occasionally at home (when not sitting on the sofa
with my notebook ;) and for the last few years they worked fine
(actually since we worked out the reconnect problem of the
Logitech mx1000, which looked similar, but probably was not).

My collection of two bluetooth mice still work fine and reconnect
quickly IIRC, but I will check this evening.

David, "every time I bring the mouse out of sleep mode", does this mean
the mouse went to sleep, you click the button (or move the mouse) and
it takes 5 seconds to reconnect? If so, could you try if it makes a
difference if you switch off the mouse instead? (wait until it falls
asleep, then switch off and on and check if it reconnects faster. Might
not be easy if this is a mouse that wakes up on movement, then you
probably need to lay it upside down until it sleeps).

> wouldn't be of much help until I am back at home and have my device
> library at my disposal (and bought new batteries).

I can recommend eneloop rechargeables for BT HID devices ;)
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
