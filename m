Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	PV Subramanian <pvs@visybl.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: Raspberry Pi 3: BLE via Java?
Date: Thu, 24 Mar 2016 12:53:48 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D71727A@S0MSMAIL111.arc.local>
References: <CAFah_xDfwqU3pGMoJ_fUwN=ZqwMGJrGp4Ynj-+wNjzF67oD75g@mail.gmail.com>,<CABBYNZLZYoingyodYn3XpBy0ci3Qy1vNz1zRk6kdZB4DGGgx2A@mail.gmail.com>
In-Reply-To: <CABBYNZLZYoingyodYn3XpBy0ci3Qy1vNz1zRk6kdZB4DGGgx2A@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I was using BLE also on the Raspberry 2 with Java before, using a USB Bluetooth dongle.
However, what you need is the Java dbus API which maps the DBUS objects to Java objects. 

It is available in the Linux repos:
sudo apt-get install libdbus-java

If you need help let me now, can provide you some source code as well if wanted.


However, I have problems using the newest versions of bluez 5.37 and 5.38 with ble hci devices like a weighing scale. The devices do not connect anymore automatically when paired.



JOHANNES KROPF
Health & Environment Department
Biomedical Systems

AIT Austrian Institute of Technology GmbH
Viktor Kaplan Straﬂe 2  |  2700 Wiener Neustadt  |  Austria
T +43(0) 50550-4845  |  M +43(0) 664 235 1732  |  F +43(0) 50550-4803
johannes.kropf@ait.ac.at |  http://www.ait.ac.at

FN: 115980 i HG Wien  |  UID: ATU14703506
www.ait.ac.at/Email-Disclaimer

________________________________________
Von: linux-bluetooth-owner@vger.kernel.org [linux-bluetooth-owner@vger.kernel.org]&quot; im Auftrag von &quot;Luiz Augusto von Dentz [luiz.dentz@gmail.com]
Gesendet: Dienstag, 15. M‰rz 2016 10:07
An: PV Subramanian
Cc: linux-bluetooth@vger.kernel.org
Betreff: Re: Raspberry Pi 3: BLE via Java?

Hi,

On Tue, Mar 15, 2016 at 2:05 AM, PV Subramanian <pvs@visybl.com> wrote:
> Hello: Just got my new Raspberry Pi 3, and confirmed BLE is working
> (sudo hcitool lescan)

hcitool is deprecated, either use bluetoothctl or btmgmt to scan.

> How can one access BlueZ via Java, to enable applications?

There exists Java bindings for D-Bus, so you can probably use
bluetoothd, otherwise you will probably need to implement the
something to talk to the mgmt interface in java.

> Thanks
>
> PVS
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
Luiz Augusto von Dentz
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
