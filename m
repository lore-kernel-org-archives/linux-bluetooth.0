Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 14 Jul 2010 10:51:16 +0800
Message-ID: <AANLkTindKcwRn6tRxdL8ciW3uCA-y42o_IzItvJZyRyu@mail.gmail.com>
Subject: scotest cause linux 2.6.34.1 memory leak?
From: manfred Dong <manfred.donn@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi
I am trying scotest in bluez on linux-2.6.34.1 with 2 PCs.
I switched off the bluetooth-udev and remove l2cap and rfcomm modules.
Then do following commands separately on 2 PCs.

1. ./scotest -r
2. ./scotest -s <BD_ADDR>

Then using "free", I found sending PC's free memory decreased fast,
and never restored even I kill the lt-scotest process.
Shortly then, Linux can not work normally.

Did any one meet this ever?
The data path for me should be scotest-> sco.ko->btusb.ko.

Thanks
