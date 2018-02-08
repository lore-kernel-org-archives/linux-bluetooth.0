Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Matthias Schuh <m.schuh.jr@googlemail.com>
Date: Thu, 8 Feb 2018 14:14:55 +0100
Message-ID: <CAFGVEfDdoP17uEBvU3FoYj5FV2cF5ig4nYxgEy_ofV==ihoYWA@mail.gmail.com>
Subject: Configuring scan behaviour of bluez
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear bluez-mailingslist,

thanks for taking the time to read this:

Setup:

bluez-5.48, kernel 4.14.16

bluetoothctl and btmgmt to scan, setup and configure bt 4.2 enabled sensor nodes

The requirement is to keep up uninterrupted scanning as long as
possible, since the sensor nodes dynamically modify their Manufacturer
Data enhancing it with sensor information.

In general turning on discovery via bluetoothctl  "scan on" delivers:

- Information on devices in the vincinity
- Updates of devices that changed their manufacturer payload

Monitoring the scan activity via btmgmt delivers the following loop behaviour:

- After issueing "scan on" via bluetoothctl shows:  "hci0 type 7 discovering on"
- After exactly 10 seconds I get the info: "hci0 type7 discovering off"
- After exactly 5 seconds I get the info: "hci0 type 7 discovering on"

Analyzing the packages I scan with wireshark I noticed that I'm
missing out on several broadcast from the sensor nodes. One
explanation is that discovery seems to be automatically turned off in
the described interval. This interval is the same on different
bluetooth hardware so i guess this is somehow defined by bluez.

In the official documentation I could not find any clue on how to
influence this behaviour.
Is there a way to define these  interval parameters?

Thanks ahead and all the best,

Matthias
