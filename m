Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Subject: Re: Problem with StopDiscovery() via dbus-send
Reply-To: ProklovAV@mail.zabtrans.ru
References: <5B7F662D.5010903@mail.zabtrans.ru>
 <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <5B907845.1000100@mail.zabtrans.ru>
Date: Thu, 6 Sep 2018 08:43:49 +0800
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ee5BTR_gqjP3XJFMCfoSxGZNCVBuDA3mraS0hN5LkNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

24.08.2018 16:19, Luiz Augusto von Dentz пишет:

>> May be possible to set a default pin code via /etc/bluetooth/main.conf
>> if it is available, do not make a request for a pin from the command line? I
>> think that then #bluetoothctl pair 11:22:33:44:55:66 will be able to work
>> fine.
>
> That is something I had in mind, lets see if I can come up with something.
>


Can be implemented such an option:
#bluetoothctl pair 11:22:33:44:55:66 [pin_code] --timeout 15

bluetoothctl register agent and send pin_code to device.
--timeout time for user response, enter pin_code on device.


NOW I use pair my Aftershokz Trekz headphones without request pin_code 
via Dbus command from script:
#dbus-send --system --type=method_call --dest=org.bluez 
/org/bluez/55:55:55:55:55:55/dev_11:22:33:44:55:66 org.bluez.Device1.Pair


-----------
Best regards,
Aleksandr Proklov
