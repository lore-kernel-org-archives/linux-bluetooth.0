Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: ProklovAV@mail.zabtrans.ru
Subject: Re: Problem with StopDiscovery() via dbus-send
References: <59BB4845.60808@mail.zabtrans.ru>
 <CABBYNZLAqZqsavif1mfWR6vM_u6i1Eo_P1ogK5=6APD56ey3jQ@mail.gmail.com>
 <59BB90DD.1040408@mail.zabtrans.ru>
 <CABBYNZJQRH75iaddKeNFJXqSwWqAxhRjLYHddAuMhxVq_T1V+A@mail.gmail.com>
To: linux-bluetooth@vger.kernel.org
From: =?UTF-8?B?0J/RgNC+0LrQu9C+0LIg0JDQu9C10LrRgdCw0L3QtNGAINCS0LDQu9C10YA=?=
         =?UTF-8?B?0YzQtdCy0LjRhw==?= <ProklovAV@mail.zabtrans.ru>
Message-ID: <59BF3492.3080503@mail.zabtrans.ru>
Date: Mon, 18 Sep 2017 10:50:58 +0800
MIME-Version: 1.0
In-Reply-To: <CABBYNZJQRH75iaddKeNFJXqSwWqAxhRjLYHddAuMhxVq_T1V+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

15.09.2017 16:46, Luiz Augusto von Dentz пишет:
> Ive just a set of patches adressing race condition with StartDiscovery
> and StopDiscovery, please have a try. Also it is not a good idea to
> mix usage of D-Bus with btmgmt, they might not play well together
> especially when it comes to discovery.
>

Thank you, I add "patch v2 adapter: Refactor code around discovery" to 
source bluez-5.47 and compile it.

My test results:

1. btmgmt after "find" command NOT set org.bluez.Adapter1 
string:Discovering =1 . But the Discovery process is already running, 
why he does not do it? btmgmt not use dbus for managment?

2. If i send method StartDiscovery via dbus-send command, i see 
org.bluez.Adapter1 string:Discovering =1 status. But I can not stop the 
process, method StopDiscovery - has no effect.
"btmgmt stop-find" - has no effect, in therminal i see:
hci0 type 7 discovering off
hci0 type 7 discovering on
hci0 type 7 discovering off
hci0 type 7 discovering on
hci0 type 7 discovering off
hci0 type 7 discovering on

after btmgmt power off and btmgmt power on
org.bluez.Adapter1 string:Discovering =0

I assume that the method StopDiscovery must completely terminate the 
process StartDiscovery, regardless of the way the scan was started 
(btmgmt, dbus-send, hcitool, bluetoothctl or more other).
