Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2013 20:47:11 +0200
Message-ID: <CAGMh8s_RNftv8X32ayf4L-ZjBqSGv3HYxPAR28GthVPWUht-xw@mail.gmail.com>
Subject: Device discovery/pairing issue w/ BlueZ on Debian
From: Clemens Vasters <clemensv@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I’ve got a cheap Bluetooth car diagnostics dongle (OBD-2, ELM327) that
gets discovered by and pairs with Windows 8, Windows Phone 8, OSX
Mountain Lion, iOS 6, and Android Jelly Bean.

I can’t get it to be either discovered or paired with BlueZ on Debian
Wheezy on my Notebook (bare metal, ThinkPad W510) or Raspbian Wheezy
on the Raspberry Pi. On the latter I even went so far to pull the
source for BlueZ 5.8 and install it from source. No dice.

I’m pretty puzzled about this. How would I go about debugging or,
rather, what data do I need to gather (and how) for someone to help me
with this.


Thanks
Clemens
