Return-Path: <cyrus@holtmann.org>
Message-ID: <1436188651.26954.9.camel@hadess.net>
Subject: Why doesn't plugins/sixaxis.c set devices as Trusted?
From: Bastien Nocera <hadess@hadess.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Szymon Janc <szymon.janc@tieto.com>
Date: Mon, 06 Jul 2015 15:17:31 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

I don't understand the reason why plugins/sixaxis.c doesn't set the
device as trusted when plugged in.

I would expect the Sixaxis plugin to do that, because there's no way to
assert, in the UI, where the device information is coming from to trust
it automatically, and I don't really want to show a "Do you want to
allow device X to connect as a HID device" for devices which weren't
setup in the UI.

For example, I could create a program on another computer with similar
characteristics (same name, class and service UUIDs) which would make
it indistinguishable from the device that was plugged in.

If security was a problem, we probably shouldn't be setting the master
BD address on the pad unless there's a running agent.

So, do we stop setup_device() early if there's no agent running and set
as trusted, or simply always set as trusted?

Cheers
