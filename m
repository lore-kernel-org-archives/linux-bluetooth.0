Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: ProklovAV@mail.zabtrans.ru
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Subject: Problem with StopDiscovery() via dbus-send
Message-ID: <5977D982.5070808@mail.zabtrans.ru>
Date: Wed, 26 Jul 2017 07:51:30 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hello All,

I'm trying to manage Bluetooth using dbus-send command,

I send command for start discovery:
dbus-send --system --reply-timeout=5000 --type=method_call 
--dest=org.bluez /org/bluez/hci0 org.bluez.Adapter1.StartDiscovery

I see that the scan started, the status is true:
dbus-send --system --print-reply --dest=org.bluez --type=method_call 
/org/bluez/hci0 org.freedesktop.DBus.Properties.Get 
string:org.bluez.Adapter1 string:Discovering

But I can not stop scanning by a command:
dbus-send --system --reply-timeout=5000 --type=method_call 
--dest=org.bluez /org/bluez/hci0 org.bluez.Adapter1.StopDiscovery

"Discovering" status true.

Bluez version 5.45

---------------------
Best regards,
Aleksandr Proklov
