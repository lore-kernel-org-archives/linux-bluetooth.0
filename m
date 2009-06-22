Return-Path: <cyrus@holtmann.org>
From: Lihui Lei <Lihui.Lei@Atheros.com>
To: John Frankish <j-frankish@slb.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Mon, 22 Jun 2009 10:35:46 +0800
Subject: RE: failed to start bluetooth deamon, unable to get on dbus.....
Message-ID: <72981EBCFD196144B7C6999B9FC34A9A493D454B93@SHEXMB-01.global.atheros.com>
References: <4A3E3927.7080802@googlemail.com>
 <6AC5A55546F64545AE996F8200E3AC4E06ABD03A@NL0105EXC01V01.eur.slb.com>
In-Reply-To: <6AC5A55546F64545AE996F8200E3AC4E06ABD03A@NL0105EXC01V01.eur.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Tamer

> Hi people!
> I tried to start the bluetooth deamon and I get the message:
>
> tux tamer # /usr/sbin/bluetoothd -nd
> bluetoothd[26851]: Bluetooth daemon 4.41
> bluetoothd[26851]: Enabling debug information
> bluetoothd[26851]: parsing main.conf
> bluetoothd[26851]: discovto=0
> bluetoothd[26851]: pairto=0
> bluetoothd[26851]: pageto=8192
> bluetoothd[26851]: name=%h-%d
> bluetoothd[26851]: class=0x000100
> bluetoothd[26851]: discov_interval=0
> bluetoothd[26851]: Key file does not have key 'DeviceID'
> bluetoothd[26851]: Unable to get on D-Bus
>
>
>
> What did I make wrong?
>
> For any help I would thank you kindly.
>


Please use root to start bluetoothd, that is "/usr/sbin/bluetoothd -nd".


Thanks,
Leo
