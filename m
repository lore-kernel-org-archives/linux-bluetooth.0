Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 05 Jul 2017 00:45:54 +0200
From: Olivier MARTIN <olivier@labapart.com>
To: linux-bluetooth@vger.kernel.org
Subject: DBUS API: Retrieve current MTU used by remote device
Message-ID: <0fef8015e74a2a96af45c36e9c67dc36@labapart.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
I am writing a GATT server (and also a GATT client) using Bluez DBUS 
API. I looked into the Bluez DBUS API documentation but I have not found 
a way to retrieve the MTU size used for the connection between Bluez and 
a Bluetooth device.

Would a MTU property have a place in 
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/device-api.txt?

I found some code to retrieve MTU using L2CAP. Is it the way to go?

Thanks in advance,
Olivier
