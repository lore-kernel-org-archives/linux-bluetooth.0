Return-Path: <cyrus@holtmann.org>
Message-ID: <4D03DC83.8010200@aircable.net>
Date: Sat, 11 Dec 2010 17:18:11 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: BlueZ <linux-bluetooth@vger.kernel.org>
Subject: EDR support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi guys,

I was checking the latest BlueZ source code and the kernel source code, 
and I noticed that by default EDR is disabled, when a dongle is detected 
net/bluetooth/hci_core.c initializes the packet types with DM1, DH1 and 
HV1, and then net/bluetooth/hci_event.c does it for DM3-5 DH3-5 and 
HV3-5, but it never initializes the 2DHx or 3DHx. Was it made on purpose 
or is it a bug in the code?

I just figured out how to help and try fixing it, but kernel hacking 
isn't an easy to do task, and would prefer to get professional advice first.

Manuel
