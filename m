Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Subject: Problem with StopDiscovery() via dbus-send
Reply-To: ProklovAV@mail.zabtrans.ru
To: linux-bluetooth@vger.kernel.org
Message-ID: <5B7F662D.5010903@mail.zabtrans.ru>
Date: Fri, 24 Aug 2018 09:58:05 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  Hello All,

Thanks for your work. Since version bluez-5.50 start-stop discovery work 
from command line and scripts:
#bluetoothctl scan on
#bluetoothctl scan off
(see mail-list "Problem with StopDiscovery() via dbus-send")

--------------------------------------------

My next task is to do pair with device from bash script. I tried several 
ways:
1. #bluetoothctl pair 11:22:33:44:55:66 does not work because the agent 
is not created.
2. Make  agent via Dbus:
#dbus-send --system --print-reply --type=method_call --dest=org.bluez 
/org/bluez org.bluez.AgentManager1.RegisterAgent 
objpath:/org/bluez/agent1 string:KeyboardOnly
the command works, but I do not see in Dbus /org/bluez/agent1 created.
3. Make agent via bluetoothctl:
[bluetooth]#agent on
the command works, but I do not see in Dbus agent path!.

May be possible to set a default pin code via /etc/bluetooth/main.conf
if it is available, do not make a request for a pin from the command 
line? I think that then #bluetoothctl pair 11:22:33:44:55:66 will be 
able to work fine.

---------------------
Best regards,
Aleksandr Proklov
