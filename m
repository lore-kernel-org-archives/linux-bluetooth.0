Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 20 Nov 2014 23:10:46 +0100
Message-ID: <CANpMpoTWVCYjW_u+GPTu4AKYfA4Zvt-DYdRGbUDZzE6RMpgdSQ@mail.gmail.com>
Subject: 
From: =?UTF-8?Q?Gilles_Gr=C3=A9goire?= <gilles.gregoire@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to understand how a BLE connection is established between
my embedded system and an Android phone. I am using bluez 5.9 on a
3.12 kernel on this embedded system; with a CSR chipset.

I set up bluetooth using:
hciconfig hci0 reset
hciconfig hci0 noscan

Then, I use hcitool to set the advertisement and scan data, and I
enable a connectable advertisement with
hcitool -i hci0 cmd 0x08 0x000a 01

I am _not_ using bluetoothd.

With this simple setup, I can connect with an Android phone to my
embedded system.
I check it with:
hcitool -i hci0 con

Which reports one active connection.

I had a look at the hciconfig and hcitool source code (the only tools
I used to setup bluetooth), but could not find where a connection is
accepted.

My question is: where (in the code) is the connection accepted in the
first place?
