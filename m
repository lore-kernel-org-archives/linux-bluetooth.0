Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Preferred way to set name of device?
Message-Id: <75A0596B-E431-46F2-8906-E14839E46A57@gmail.com>
Date: Tue, 19 Jan 2016 11:39:38 -0800
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I’m intersted in setting the name of my device, when I’m acting as a BLE Peripheral. I see at least two, maybe three, ways to do it:

1) Set the `Name=` line near the top of /etc/bluetooth/main.conf
2) Use hciconfig hc0 name FooBar
3) Maybe something with the dbus interface?

So I’m curious which is the preferred/idiomatic way? In particular for my use case as a BLE Peripheral.

I’ve discovered the following issues already:

1) If I use main.conf, that will be tricky, because I’d like to set the name based on dynamic information computed by the device in startup (serial number from an attached piece of equipment). So I’d have to modify the file after I have gotten that information, and then restart the service. Not undoable, but far from elegant.
2) Though hciconfig will show back the name set, it doesn’t seem to actually show up when I scan.
3) Not sure how I figure out what the dbus interface is. Is this documented anywhere? Or does one just explore and guess with tools? Maybe it’s too early in the experimental phase to really document?

TIA