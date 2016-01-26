Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3916CF28FA2C014B862815C318D03FF5A0A7493AAF@Courier.syntech.org>
References: <3916CF28FA2C014B862815C318D03FF5A0A7493AAF@Courier.syntech.org>
Date: Tue, 26 Jan 2016 11:41:27 +0200
Message-ID: <CABBYNZJ3DqnNGKGoRZiGGpNSH5r=9FuH6BLeNsjavsgFdZ4=xw@mail.gmail.com>
Subject: Re: Bluetooth Smart 5LoWPAN connection between two devices
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jon Hoffman <Jon.Hoffman@myfuelmaster.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jon,

On Mon, Jan 25, 2016 at 7:53 PM, Jon Hoffman
<Jon.Hoffman@myfuelmaster.com> wrote:
> I do not want to use Bluez 4.XX so I am attempting to get this to work with Bluez 5 on both the master and slave.  I have tried the following commands on both the Raspberry Pi with Bluez 5.23 and Fedora 23 with Bluez 5.35

BlueZ 4 is too old to support, if you want some support from the
community just stick with BlueZ 5.

>
> Slave (Raspberry Pi Bluez 5.23 or Fedora 23 Bluez 5.35):
>        #need root access
>        sudo su
>
>        #enable 6lowpan over Bluetooth le
>        echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enabled
>
>        #start advertising Bluetooth LE service
>        hciconfig hci0 leadv

There is a built-in D-Bus interface to advertise using bluetoothd, or
if you prefer low level then use btmgmt.

> master (Raspberry Pi Bluez 5.23 or Fedora 23 Bluez 5.35):
>         #need root access
>         sudo su
>
>         #enable 6lowpan over Bluetooth le
>         echo 1 > /sys/kernel/debug/bluetooth/6lowpan_enable
>
>         #establish le connection to master
>         hcitool lecc 5C:F3:70:XX:XX:XX
>
>         echo "connect 5C:F3:70:XX:XX:XX 1" > /sys/kernel/debug/bluetooth/6lowpan_control

This actually works for me so perhaps there is something else going
on, you can try enabling dynamic debug in your kernel as well as
checking the HCI trace, perhaps the L2CAP channel doesn't connect or
something like that.


-- 
Luiz Augusto von Dentz
