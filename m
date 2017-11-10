Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Thomas Green <TGreen2@Sorenson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: porting from bluez4
Date: Fri, 10 Nov 2017 17:51:15 +0000
Message-ID: <C2BC44D770753C45AAAC42695FB5BE020125718348@SLC-EXMB01.CORP.SRELAY.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

I'm porting our company's application from bluez4 to bluez5.  I'm currently=
 using bluez5.42  (I'm nervous about using higher than that because I've ha=
d to backport many kernel changes to support this recent version (what else=
 do I need to backport?)).  I have most things working, but there are two i=
ssues I've not yet been able to resolve.  The first is devices reconnecting=
 when they come back into range.  For example, I am testing with a Jawbone =
from Jambox.  When coming back into range (or powering back on), I watch it=
 attempt to connect, and it fails.  If I have bluetoothctl up I see the sta=
tus change from connected to unconnected about three or four times before t=
he Jambox quits trying and powers back down.   I have a BTLE keyboard that =
comes back into range and will not connect until I hit a key and the connec=
tion happens.   I have other BTLE devices that attempt to reconnect, but fa=
il as well.

The second issue is that of  headset devices.  In Bluez4 there was a headse=
t 'profile' and the IndicateCall method that could be invoked.  In bluez5 t=
here is the Alert1 interface with the NewAlert call, but it is deprecated c=
ode, so what should I be using?  As a matter of interest, if I try to use t=
he NewAlert method what is the proper use?  I've tried:

root# dbus-send --print-reply --system --dest=3Dorg.bluez --type=3Dmethod_c=
all /org/bluez org.bluez.Alert1.NewAlert string:"ringer" uint16:1 string:"a=
ctive"
Error org.bluez.Error.InvalidArguments: Invalid arguments in method call

TIA,

Tom
