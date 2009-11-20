Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 20 Nov 2009 11:15:13 +0530
Message-ID: <912bb79a0911192145j2c97d8adjfd9ae445a9b3e50a@mail.gmail.com>
Subject: Pincode request Problem
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

How to get PIN request and wait for the reply without using gnome.

My scenario is as below,

I have cross complied  Bluez-4.52 and using with my custom board with ARM.
./bluetoothd is running in background.
In my application I do DeviceDiscovery (hci_inquiry) and able get the
discovered devices addresses.

But when I tried to connect selected address from the discovered
address on RFCOM, bluetoothd is trying to get Pincode and get fails
because I am not using gnome on my embedded platform.(to solve this
problem I have hard coded Pin code in bluetoothd)

I am using Qt for GUI, Now I want to wait in bluetoothd  for Pincode
and  want to pass the pincode from Qt to bluetoothd , and then
bluetoothd should proceed.

In other way I want to pass pincode from one process to another
process, but I am using Qt not GTK which has been used in Bluez.

But is there any window to solve with problem, I mean any API OR any
document which can help me Or Is anybody has done something like that.

I have got few queries regarding to solve the above issue

1) Is it Strongly recommended to  write another application similar to
bluetoothd if I don't want to use GTK OR If I use custom board?
2) Is there any API that can I use to get Pin request and send the
PinCode to bluetooth deamon.
OR
Any Suggestion.

Your suggestion would be a great help for me....
Thanks in Advance

-- 
With Regards,
Nirav Rabara
