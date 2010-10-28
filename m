Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101028120950.GB17930@vigoh>
References: <AANLkTimTzSMQW3cJQPphWgTBKgn0fbN7zui7tRA1enmi@mail.gmail.com>
	<20101028120950.GB17930@vigoh>
Date: Thu, 28 Oct 2010 22:48:20 +0530
Message-ID: <AANLkTi=H+zqzZb6f303VJRXA_zmibiG=Zec0unxy5b-=@mail.gmail.com>
Subject: Re: Unable to get on D-Bus: bluez 4.77
From: Puneet Pant <pant.puneet464@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Oct 28, 2010 at 5:39 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Puneet,
>
> * Puneet Pant <pant.puneet464@gmail.com> [2010-10-28 17:02:48 +0530]:
>
>> Hello,
>>
>> I have compiled Bluez 4.77. But I'm getting the following error when
>> trying to start Bluetooth Daemon:
>>
>> root@puneet-VirtualBox:/home/puneet/packages/bluez-4.77/src#
>> dbus-daemon --system
>> root@puneet-VirtualBox:/home/puneet/packages/bluez-4.77/src# ./bluetoothd -nd
>> bluetoothd[11819]: Bluetooth deamon 4.77
>> bluetoothd[11819]: src/main.c:parse_config() parsing main.conf
>> bluetoothd[11819]: src/main.c:parse_config() discovto=0
>> bluetoothd[11819]: src/main.c:parse_config() pairto=0
>> bluetoothd[11819]: src/main.c:parse_config() pageto=8192
>> bluetoothd[11819]: src/main.c:parse_config() name=%h-%d
>> bluetoothd[11819]: src/main.c:parse_config() class=0x000100
>> bluetoothd[11819]: src/main.c:parse_config() discov_interval=0
>> bluetoothd[11819]: src/main.c:parse_config() Key file does not have
>> key 'DeviceID'
>> bluetoothd[11819]: Unable to get on D-Bus
>
> One of the reasons could be that you already have the bluetoothd daemon
> running.
>

I did "ps -e | grep bluetooth" and found no bluetoothd running.
Could this be related to D-Bus library version incompatibility with ubuntu.
As I see, Ubuntu 10.10 comes with Dbus 1.4.0 installed, but when I run
./configure for bluez, it does not detect the installed D-Bus. I had
to manually download and install D-Bus 1.2.24 for bluez configure to
detect and compile?

> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
>

Thanks,
Puneet
