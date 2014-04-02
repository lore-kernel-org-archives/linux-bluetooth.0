Return-Path: <cyrus@holtmann.org>
From: Jim Hollister <jim.hollister@allure-energy.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 2 Apr 2014 11:10:02 -0500
Subject: Need advice: bluez on older Linux kernel?
Message-ID: <CF61A08A.5BFD%jim.hollister@allure-energy.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I need to add Bluetooth Low Energy (BLE) capability to an ARM-based embedded
system that's currently based on Ubuntu Lucid 11.04 and Linux kernel 2.6.35.
I've read that BLE support in bluez requires Linux kernel version 3.5 or
later. At this point, I think this leaves me with four options:

A) Upgrade the embedded system to a recent Linux kernel >= 3.5
B) Backport the most recent bluez to run on Linux kernel 2.6.35
C) Combine both approaches A and C, so that the embedded system and bluez
meet at a kernel version somewhere between 2.6.35 and 3.5
D) Find a different BLE stack that will run on Linux kernel 2.6.35. I see a
number of those described at
http://en.wikipedia.org/wiki/Bluetooth_stack#Embedded_implementations

I would much prefer to use bluez, but I'm concerned about the effort
involved in upgrading the embedded system, and I don't know anything about
the feasibility of backporting bluez. Would some kind and knowledgeable
person please give me some advice or an opinion about how I should approach
this?

Thank you,

Jim Hollister

