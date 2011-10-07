Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 6 Oct 2011 18:05:27 -0700
Message-ID: <CADPrc81d_zS5OOmqzKxmuJtnkFTxHD3V2JHOyYHONGL0AiYvKA@mail.gmail.com>
Subject: Bluetooth Network Aggregation Point
From: =?UTF-8?B?Q2FuZWsgUGVsw6FleiBWYWxkw6lz?= <caneko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi; I want to share my laptop network connection to my Android
cellphone (a Xperia Play). I believe this is called Bluetooth Network
Aggregation Point, and (since I use Gentoo) I tried to follow this
guide:

http://en.gentoo-wiki.com/wiki/Set_up_a_bluetooth_NAP

However, it doesn't seem to be working. Roughly, the steps I believe
are necessary are:

1. Start a DHCP server on the laptop.
2. Link the phone and the laptop.
3. Connect the phone and the laptop.
4. Create a bridge containing the laptop network adapter (eth0 in my
case) and the bluetooth connection adapter (bnep0, I believe should be
called).
5. Cellphone should be able to use the laptop network.

If I'm failing to understand something, please tell me.

I cannot get to step 3: I can link my laptop and cellphone, either
using the command line tools or the gnome-bluetooth package, but my
phone says "Linked but not connected". I have never seen the bnep0
adapter with ifconfig -a. And even if I can see the dbus API with

gdbus introspect -r -y -d org.bluez -o /

I don't understand how to call the (seemingly appropriate) methods,
like org.bluez.NetworkServer.Register. I can't find the documentation,
and Google doesn't help since I'm using version 4.96, and most search
results give instructions for older versions, before the dbus API.

I'm using:

Kernel 3.0.4
bluez 4.96
gnome-bluetooth 3.2.0
bridge-utils 1.4

I'm asking here first before reading the source code: I can do that,
but at least a couple of pointers of what to look for would be really
appreciated.

Regards.
-- 
Canek Peláez Valdés
Posgrado en Ciencia e Ingeniería de la Computación
Universidad Nacional Autónoma de México
