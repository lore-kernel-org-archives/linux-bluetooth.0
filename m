Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Message-ID: <51aa1a9.d945d30cb26cb71f81aa2e9217bb7f3a@1oca1host.de>
From: thilo@cestona.ro
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: AW: Re: Support for 0489:e031 Foxconn / Hon Hai
Date: Mon, 6 Jun 2011 09:50:13 +0200 (CEST)
Content-Type: text/plain;
	charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Marcel,

> what about the usb-devices.sh script output or /proc/bus/usb/devices
> content for this adatper.

The output for the bluetooth device from /usr/bin/usb-devices (on Ubuntu=
 11.04) is the following:

T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D03 Cnt=3D03 Dev#=3D  5 Spd=3D12  =
MxCh=3D 0
D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1=

P:  Vendor=3D0489 ProdID=3De031 Rev=3D01.12
S:  Manufacturer=3DBroadcom Corp
S:  Product=3DBCM20702A0
S:  SerialNumber=3DEC55F9EADE09
C:  #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3D(none)
I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Drive=
r=3D(none)
I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Drive=
r=3D(none)
I:  If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Drive=
r=3D(none)

The folder /proc/bus/usb doesn't exists here. Are the informations from =
/sys/bus/usb the same?
When yes, which are you really interessted in (as there are plenty files=
 for that device)?

Can I provide other usefull informations?

Ciao
Thilo
