Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Subject: Problem with StopDiscovery() via dbus-send
Reply-To: ProklovAV@mail.zabtrans.ru
To: linux-bluetooth@vger.kernel.org
Message-ID: <59BB4845.60808@mail.zabtrans.ru>
Date: Fri, 15 Sep 2017 11:25:57 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hello All,

Maybe it's a bug?

I'm trying to manage Bluetooth using dbus-send command,
I send command for start discovery:
dbus-send --system --reply-timeout=5000 --type=method_call 
--dest=org.bluez /org/bluez/hci0 org.bluez.Adapter1.StartDiscovery


Discovery process NOT stop!!! in btmgmt i see:
hci0 type 7 discovering off
hci0 type 7 discovering on
hci0 type 7 discovering off
hci0 type 7 discovering on
hci0 type 7 discovering off
hci0 type 7 discovering on

and it goes on continuously!
How can I stop the search process? "StopDiscovery" not work from 
dbus-send command.


---------------------
Best regards,
Aleksandr Proklov
