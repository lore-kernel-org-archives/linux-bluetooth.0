Return-Path: <cyrus@holtmann.org>
Reply-To: <wyrles@ytram.com>
From: "Tom Allebrandi" <wyrles@ytram.com>
To: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>
Subject: DBus APIs for HCI/L2CAP?
Date: Thu, 21 Jul 2011 15:05:36 -0700
Message-ID: <04f101cc47f2$652cbbf0$2f8633d0$@ytram.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi -

Is there a DBus API for issuing HCI commands? I want to be able to issue
vendor specific commands.

Also, I want to be able set the Limited Inquiry Access Code for both
discovery and discoverability. I see the Discoverable property in
org.bluez.Adapter but I don't see any way to set the IAC.

Similarly, is there a DBus API for L2CAP? I need to be able to manually
setup channels and control the packets that I send over those channels.

I'm working with profiles that are not yet implemented in BlueZ. Also, I
need to be able to generate malformed packets for test purposes.

I'm pretty sure that I can do all of the above with BTIO or the socket
interface. I'm just trying to be a good boy and use DBus :-).

Cheers!

--- tom
tom allebrandi
wyrles@ytram.com


