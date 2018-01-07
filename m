Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Adam Pigg <adam@piggz.co.uk>
Date: Sun, 7 Jan 2018 22:52:21 +0000
Message-ID: <CANFkB1weoWSOw7OUktNZsn7dLFR9A+qJEY3jDMHx3ug_wsc=OQ@mail.gmail.com>
Subject: Bluez on a modern (ish) Android kernel
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I was wondering if bluez5 works with the qualcomm BT devices often
found in Android phones?

Specifically, im porting SailfishOS to a phone with a Qualcomm BT
adaptor.  BT mostly works, but I have to modify the kernel to add the
hci_smd driver.  This driver appears to have been abandoned a few
years ago.

My kernel version is 3.18, and the chipset is msm8953,

With the hci_smd driver, BT works most of the time, but I do get
reboots sometimes when initiating a call from my car kit, and my
instinct is to blame the hci_smd driver which I had to add.  The
backtrace for a crash is https://bpaste.net/show/3644d521584b.

So...
is the hci_smd driver the only way for bluez to communicate with the adaptor?
how does bluedroid work without it?
are there any alternatives to this driver?
is the driver ok, and mt problem is elsewhere?

Cheers

Adam
