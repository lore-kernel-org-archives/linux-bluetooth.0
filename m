Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Dec 2008 20:52:13 -0500
From: "J.R. Mauro" <jrm8005@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: jrm8005@gmail.com
Subject: Apple Mighty Mouse and aluminum keyboard woes
Message-ID: <20081208015213.GA11816@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I recently purchased an Apple Bluetooth Mighty Mouse and it's been giving me
some grief. Both the mouse and the aluminum bluetooth keyboard I own fail to
show up with hcitool or hidd, but both of them seem to be registering with the
input subsystem as they both work. I can only imagine this is because I paired
them with OS X (since I couldn't pair them with Linux). Despite those hiccups,
both of the devices *work* but the mouse is not sending scroll or squeeze
events. I don't really care about the squeeze events, but the lack of scrolling
is quite aggravating.

I've run evtest and it shows that my mouse has: vendor 0x5ac product 0x820b
version 0x111 for ID numbers. The keyboard has the following: vendor 0x5ac
product 0x820a version 0x111

So obviously they're Apple, and possibly they are new devices and no one has
seen their minor IDs yet, as Apple comes up with slightly-different "new"
devices every few months to give everyone a headache. I know I've seen patches
floating around about the keyboard, but I can't apply them to my kernel. I'm
content to wait for 2.6.28 to come out if issues are fixed there, but I'm
willing to be a guinea pig for anything that will apply to 2.6.27.

In support of my claim, the mouse lists the following events:

Supported events:
Event type 0 (Sync)
Event type 1 (Key)
	Event code 272 (LeftBtn)
	Event code 273 (RightBtn)
	Event code 274 (MiddleBtn)
Event type 2 (Relative)
	Event code 0 (X)
	Event code 1 (Y)
Event type 4 (Misc)
	Event code 4 (ScanCode)

As you can see, there's no scroll, and there should be both vertical and
horizontal scrolling. So we have a couple of mysteries, namely, why the
bluetooth tools can't actually communicate with the devices (although,
sometimes, if there's a full moon or something, I can actually do things like
"hcitool info <BDADDR>" and get real info) and the whole missing-event problem.

As I hinted, I'm using kernel 2.6.27 (though I have a couple of patches applied
for applesmc, I don't think they have any bearing on this problem). I'm not
subscribed to this particular mailing list, so I've added myself to the CC list.

Thanks,
~J.R.
