Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Oct 2010 13:09:50 +0100
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Puneet Pant <pant.puneet464@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Unable to get on D-Bus: bluez 4.77
Message-ID: <20101028120950.GB17930@vigoh>
References: <AANLkTimTzSMQW3cJQPphWgTBKgn0fbN7zui7tRA1enmi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimTzSMQW3cJQPphWgTBKgn0fbN7zui7tRA1enmi@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Puneet,

* Puneet Pant <pant.puneet464@gmail.com> [2010-10-28 17:02:48 +0530]:

> Hello,
> 
> I have compiled Bluez 4.77. But I'm getting the following error when
> trying to start Bluetooth Daemon:
> 
> root@puneet-VirtualBox:/home/puneet/packages/bluez-4.77/src#
> dbus-daemon --system
> root@puneet-VirtualBox:/home/puneet/packages/bluez-4.77/src# ./bluetoothd -nd
> bluetoothd[11819]: Bluetooth deamon 4.77
> bluetoothd[11819]: src/main.c:parse_config() parsing main.conf
> bluetoothd[11819]: src/main.c:parse_config() discovto=0
> bluetoothd[11819]: src/main.c:parse_config() pairto=0
> bluetoothd[11819]: src/main.c:parse_config() pageto=8192
> bluetoothd[11819]: src/main.c:parse_config() name=%h-%d
> bluetoothd[11819]: src/main.c:parse_config() class=0x000100
> bluetoothd[11819]: src/main.c:parse_config() discov_interval=0
> bluetoothd[11819]: src/main.c:parse_config() Key file does not have
> key 'DeviceID'
> bluetoothd[11819]: Unable to get on D-Bus

One of the reasons could be that you already have the bluetoothd daemon
running.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
