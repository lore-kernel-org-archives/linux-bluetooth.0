Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Subject: Background scanning and white list usage
Message-Id: <BFAEE1C5-E74F-40F0-A1A4-8F4907FBDCF4@holtmann.org>
Date: Thu, 27 Feb 2014 19:20:43 -0800
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

with the background scanning and auto-connect patches now merged, I want to move into the direction of utilizing the white list for background scanning.

For every devices where we have an auto-connect entry, the device should be placed into the white list. From our management side, it makes sense to only allow auto-connect entries for identity addresses (meaning public or static addresses).

If our identity addresses are not using LE Privacy this is pretty much straight forward. We just put the identity address into the white list and scan with the white list filter policy. This should be our first target. Start using the white list and populate it with our identity addresses.

The complicated part comes into play when we have devices with LE Privacy enabled and when they are using resolvable private addresses. Meaning when our IRK list is populated with identity addresses and their IRKs. The only way to make this work with the current available controller features is if we program the RPA into the white list. Since that RPA is going to change over time, we need to stop scanning with the white list filter every now and then, scan for all devices and resolve the RPA. If we see a new RPA for a know IRK, we have to replace the old RPA in the white list with the new RPA. And then we go back to scanning with the white list filter policy.

Now the important question is what are good enough intervals to make this work smoothly. Devices using LE Privacy will take a hit in their re-connection time, but that is what we have to trade in for compared to waking up the host for every single advertising packet.

My initial idea is to scan 5 minutes using the white list, then scan 10 seconds without the white list, then back to 5 minutes using the white list and so on.

The default value for the PRA lifetime according to the specification is 15 minutes. I timed recent iOS devices which seem to be using 9 minutes intervals. So we have to play a little bit with this and see what are good values.

Maybe 3 minutes white list scan and 5 seconds without white list is better. Things to try out.

First task now should be to track the white list inside the kernel. I want a debugfs entry that tells us exactly what devices are in the white list. And second step is to make sure that when adding devices with auto-connect enabled, they get added to the white list, same as they get removed when connected or no longer have auto-connect enabled.

Regards

Marcel

