Return-Path: <Peter.K.Martin@t-online.de>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
   <bluez-users@lists.sourceforge.net>
Subject: AW: BT unter SuSE 9.2
Date: Wed, 8 Dec 2004 15:10:02 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAuD34QxxG80OHXRWPDw9h+QEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1102514327.9988.73.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Hello Marcel,
the BT-device is always activate by the switch. I was really astonished =
that
it doesn't work under 9.2
At the moment I'm working with Windows, also connected by the BT-device =
to
my network.

What have I to do, when it is not shown up in /proc/bus/usb/devices ???
In order to find out, I have to reboot with Linux.

Regards
Peter

##>-----Urspr=FCngliche Nachricht-----
##>Von: Marcel Holtmann [mailto:marcel@holtmann.org]=20
##>Gesendet: Mittwoch, 8. Dezember 2004 14:59
##>An: Peter K. Martin
##>Cc: BlueZ Mailing List
##>Betreff: Re: BT unter SuSE 9.2
##>
##>
##>Hi Peter,
##>
##>> now the trouble begins. I install SuSE 9.2 and wnted to start the=20
##>> bluetooth-function of my toshiba satellite pro m10, which already=20
##>> worked under 9.1 ---> but now nothing happens. When I try to start=20
##>> with dmabt the response is: unable to access /dev/toshiba,=20
##>although=20
##>> the file (?) is existing. The lines in modules.conf are also o.k.
##>> =20
##>> I tried to patch the toshiba_acpi, but without any result.=20
##>Only a long=20
##>> time of compilation, etc.
##>> =20
##>> Please give me an idea what to do to solve the problem. I=20
##>have always=20
##>> to switch from Linux to Windows in order to get an=20
##>internet-connection=20
##>> and this is very boring.
##>
##>the SuSE 9.2 and Bluetooth is working perfect. Your problems=20
##>seems to be in activating the dongle on the hardware side .=20
##>Actually this is not really a BlueZ related problem.
##>
##>Do it show up in /proc/bus/usb/devices? Can you use a=20
##>hardware switch near your keyboard to activate it?
##>
##>Regards
##>
##>Marcel
##>
##>
##>
