Return-Path: <cyrus@holtmann.org>
Message-ID: <1398535642.10933.2.camel@SejoLaptop.guest.mdh.se>
Subject: Newby Question: Pairing a BLE Device using C (or Python)
From: Sejo Ruiz <sejoruiz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Apr 2014 20:07:22 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everybody.
I'm using a bluetooth dongle with a raspberry Pi, in addition with the
latest stable version of BlueZ. I have to connect this dongle to another
device that is using Bluetooth Low Technology, and try to read some
characteristics. From now on, I managed to connect and manually read the
characteristics using first bluetoothct (for pairing with the other
device) and then gatttool in interactive mode(for connecting to the
paired device, and then to read the chars). I tried running only the
gatttool in interative mode, but seems like if I dont leave the
bluetoothctl running after pairing the device, it wont work. So first
question could be: is there any way of doing this using something that
is not bluetoothctl? (so I can make some sort of script and make an
automate process) Also, could it be possible to make a custom
application that do this using C or python?

Thank you very much for your help.
--
Kind Regards

