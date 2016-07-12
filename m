Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?Q?Cl=c3=a9ment_Jacquemin?= <clement.jacquemin@epita.fr>
To: <linux-bluetooth@vger.kernel.org>
Subject: Connection handler and btmgmt/bluetoothctl
Message-ID: <578439E0.5080703@epita.fr>
Date: Tue, 12 Jul 2016 02:29:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am implementing my own GATT server using the "tool/gatt-service.c" as 
example. Create services and read/write characteristics is not a 
problem, but I need a way to track connection and disconnection of clients.
Is there any way to make a handler or callback function that trigger 
when a client connects/disconnects to my server?


Another question about best practice. For the moment I use "btmgmt" to 
configure my daemon. However, the "bluetoothctl" binary seems to be a 
more stable alternative except that i cannot find any way to do the "le 
on" command as in "btmgmt".
Is there any way to activate the low energy option with bluetoothctl?

Regards,

Clément.
