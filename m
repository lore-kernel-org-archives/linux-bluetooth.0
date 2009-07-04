Return-Path: <cyrus@holtmann.org>
Message-ID: <4A4F39E8.4020908@powercraft.nl>
Date: Sat, 04 Jul 2009 13:15:52 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Feature request:  boolean properties to auto reconnect list of MAC's
 at daemon start up
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everybody,

I would like to request a feature to make it possible from command line
tool and dbus gtk gui to set a property just similar as the trusted
device property to directly reconnect a device at start-up of the
bluetoothd daemon.

Use-case: I have a lot of systems with successful connected bluetooth
keyboards. The boot-up of these systems are around 5 seconds with full
GUI. But the devices is not usable yet, because when you press a key it
first start connection... this takes almost the same time as the
complete boot-up and it forces an extra key press of the user every time
they start the system. Maybe some org.bluez.Input interface thing?

Would somebody be willing to place this on there to-do list, it has no
hurry bot somewhere in the next 6 months would be nice.

Thanks in advance,

Jelle de Jong
