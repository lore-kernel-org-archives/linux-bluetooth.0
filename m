Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: 5.43 Experimental Status?
Date: Wed, 11 Jan 2017 14:38:19 -0800
References: <CAM4OqtDier-LrdJymk5npiGvZcvj7rsaGsrJwv+tz1o+kCoFcw@mail.gmail.com>
 <1BE3F300-B719-44E3-971F-5015C5F65A78@holtmann.org>
 <CAM4OqtDb6cm18Eqs=+rJrt7a-h0N=j+s-jPEUc1c4rHwGDbYqQ@mail.gmail.com>
 <49A36183-9C83-43B4-B462-3838E28E21C9@holtmann.org>
 <CAO1O6scU_WUU5KVVnUuC8YD5CWa+Spn24_7f_s8O3b2rLDBnAw@mail.gmail.com>
 <9AE508C4-7C2E-4126-AF76-DC551C6142D4@holtmann.org>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <9AE508C4-7C2E-4126-AF76-DC551C6142D4@holtmann.org>
Message-Id: <9CFEE4B0-5A6B-4153-BB3B-2CDF13955E2C@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I=E2=80=99m trying to bring my linux SBC acting as a peripheral up to =
debian stretch. I had been running on jessie, with my own build of bluez =
5.41. I had been modifying the bluetooth.service to execute:

    /usr/lib/bluetooth/bluetoothd -d -E --noplugin=3D*

The latest stretch/testing bluez seems to be 5.43 though:

    dpkg -l | grep bluez
    ii  bluez                         5.43-1                   armhf     =
   Bluetooth tools and daemons

I thought the -E flag was supposed to no longer be necessary after 5.42. =
So I removed it. I updated my own python code to match the small changes =
I found in example-advertisement. But I=E2=80=99m getting the following =
error:

    ERROR:dbus.connection:Unable to set arguments =
(dbus.ObjectPath('/nelson_irrigation/twig_pilot'), {}) according to =
signature None: <class 'ValueError'>: Unable to guess signature from an =
empty dict

Which after googling, was the same error I found a while back when I had =
forgotten to turn -E on with 5.40.=20

So I added the -E back in and it started working as hoped.

Can someone explain why the -E is still needed with 5.43, for dbus code =
like that found in the test/examples? Did it not really get promoted =
after all? Or did I misunderstand the semantics of what was changing?=
