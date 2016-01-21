Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: Preferred way to set name of device?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <75A0596B-E431-46F2-8906-E14839E46A57@gmail.com>
Date: Thu, 21 Jan 2016 12:07:41 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <39D83547-62A5-4FF2-B260-DFCFB7F08A38@holtmann.org>
References: <75A0596B-E431-46F2-8906-E14839E46A57@gmail.com>
To: Travis Griggs <travisgriggs@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

> I’m intersted in setting the name of my device, when I’m acting as a BLE Peripheral. I see at least two, maybe three, ways to do it:
> 
> 1) Set the `Name=` line near the top of /etc/bluetooth/main.conf
> 2) Use hciconfig hc0 name FooBar
> 3) Maybe something with the dbus interface?
> 
> So I’m curious which is the preferred/idiomatic way? In particular for my use case as a BLE Peripheral.
> 
> I’ve discovered the following issues already:
> 
> 1) If I use main.conf, that will be tricky, because I’d like to set the name based on dynamic information computed by the device in startup (serial number from an attached piece of equipment). So I’d have to modify the file after I have gotten that information, and then restart the service. Not undoable, but far from elegant.
> 2) Though hciconfig will show back the name set, it doesn’t seem to actually show up when I scan.
> 3) Not sure how I figure out what the dbus interface is. Is this documented anywhere? Or does one just explore and guess with tools? Maybe it’s too early in the experimental phase to really document?

if you are actually more into the BLE space, then the LE Advertising D-Bus API is something you might want to look into. With a recent kernel and recent BlueZ, you can build your own advertising reports and include more dynamic naming if you want to.

Otherwise there is also a plugin mechanism for setting the device name. That is a preferred one and for example on a system running systemd-hostnamed it will take the device name from there. You could write your own plugin.

Regards

Marcel

