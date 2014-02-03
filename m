Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 03 Feb 2014 14:51:44 +0100
From: a.mv@gmx.fr
To: linux-bluetooth@vger.kernel.org
Subject: BlueZ 5 mouse autoconnect
Message-ID: <81ed438b244ebb8497b47a009cb30bb0@gmx.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I followed all possible guides to connect automatically my Apple 
MagicMouse to my Linux PC. I saw on the forums that the key is to mark 
it as "trusted". I did it in bluetoothctl and put it to "trusts" file in 
/var/lib/bluetooth/xx:xx..../.

It works fine if I connect it manually but after restart I see only 
messages like this in bluetoothctl:
[NEW] Device 84:38:35:24:08:D9 MagicMouse
[CHG] Device 84:38:35:24:08:D9 Class: 0x002580
[CHG] Device 84:38:35:24:08:D9 Icon: input-mouse
[CHG] Device 84:38:35:24:08:D9 Connected: yes
[CHG] Device 84:38:35:24:08:D9 Connected: no
[DEL] Device 84:38:35:24:08:D9 MagicMouse
[NEW] Device 84:38:35:24:08:D9 MagicMouse
[CHG] Device 84:38:35:24:08:D9 Class: 0x002580
[CHG] Device 84:38:35:24:08:D9 Icon: input-mouse
[CHG] Device 84:38:35:24:08:D9 Connected: yes
[CHG] Device 84:38:35:24:08:D9 Connected: no
[DEL] Device 84:38:35:24:08:D9 MagicMouse

Messages are printed when I click a mouse button. There is a small delay 
between "Connected: yes" and "Connected: no" and during this time I see 
a bluetooth sign in the notification area (I have Gnome).
Sometimes I see a paring request from the mouse. Sometimes authorisation 
request and if I go to the bluetooth settings it even propose to type a 
PIN code on the mouse )
Regardless my action after restart of bluez I am at the starting point.
