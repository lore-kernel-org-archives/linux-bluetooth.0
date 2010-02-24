Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100223200149.GA17518@kroah.com>
References: <b0bd1ee11002230708j397dd2fds7d1fe711264f29b0@mail.gmail.com>
	<b0bd1ee11002230710xdda50eeqcba20a98a88ce6db@mail.gmail.com>
	<20100223200149.GA17518@kroah.com>
From: Reuben Firmin <rf@flavor8.com>
Date: Tue, 23 Feb 2010 19:22:17 -0500
Message-ID: <b0bd1ee11002231622g58666e94tbb901febab37ea76@mail.gmail.com>
Subject: Events apparently not detected from USB bluetooth speaker
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a Saitek A-250, which is a USB bluetooth dongle sound device
which transmits to a set of speakers. Sound output works well.
However, I would like to capture events from the buttons on the
speakers (it has buttons for play, next, previous, etc, which cause
events to be sent back to the dongle, and which apparently work with
the windows driver.)

I used gizmod to monitor /dev/input/event*, but nothing showed up when
pressing the buttons on the speaker. Are the events coming in
elsewhere? Is there any tool that I can use to detect and kick off
actions on these events?

I asked over on the linux-usb list, and they suggested posting the
question here, believing that enabling the HID driver would do the
job. Because the dongle masquerades as a sound device, the bluetooth
stack apparently doesn't see it as being bluetooth. Any ideas on how
to proceed?

Thanks
Reuben
