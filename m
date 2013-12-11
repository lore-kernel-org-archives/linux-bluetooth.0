Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 Dec 2013 11:21:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: mouse not found with bluez5 but was fine with bluez4
Message-ID: <20131211092135.GA16525@x220.p-661hnu-f1>
References: <1386680927.11483.6.camel@pc.interlinx.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386680927.11483.6.camel@pc.interlinx.bc.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Tue, Dec 10, 2013, Brian J. Murrell wrote:
> So, in chasing an issue with mouse pairing in another thread I was asked
> to upgrade to Fedora 20 to see if my mouse pairing issue was
> reproducible on bluez5 given that bluez4 is pretty dead now.
> 
> But the same mouse that could be found and paired on bluez4 (Fedora 19)
> is not even being found during the search on bluez5 (Fedora 20) on the
> exact same hardware (same machine in fact).  Bluez5 did manage to see
> and pair a headset though, just not this mouse.
> 
> What information/tests can I provide to help figure this out?

For one thing, it'd be good to determine whether this is a GUI thing (I
assume you're using the GNOME UI?) or something in BlueZ. The way to do
that would be to use the bluetoothctl tool that's part of BlueZ 5. The
commands you'd give it would go something like:

	agent on
	power on
	scan on
	<wait for mouse to show up>
	scan off
	pair <mouse addr>	(optional if the mouse doesn't support pairing)
	connect <mouse addr>
	trust <mouse addr>

Johan
