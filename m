Return-Path: <cyrus@holtmann.org>
Message-ID: <1386951491.23365.16.camel@pc.interlinx.bc.ca>
Subject: Re: Failed to connect: org.bluez.Error.NotReady
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 13 Dec 2013 11:18:11 -0500
In-Reply-To: <1386950230.6234.2.camel@nuvo>
References: <1386948800.23365.2.camel@pc.interlinx.bc.ca>
	 <1386949351.6234.0.camel@nuvo>
	 <1386949827.23365.9.camel@pc.interlinx.bc.ca>
	 <1386950230.6234.2.camel@nuvo>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-+hBJW+mZHl45DAz6yQ6l"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-+hBJW+mZHl45DAz6yQ6l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2013-12-13 at 16:57 +0100, Bastien Nocera wrote:
>=20
> Then use btmon

It doesn't report anything:

=3D New Index: 00:02:72:1E:E0:12 (BR/EDR,USB,hci0)                [hci0] 0.=
981520

That's it.  I tried turning the mouse off and on while running that.
Headset too.

>  to gather some debug information, or even use "journalctl
> -b | grep bluetooth"

Dec 11 11:51:57 pc.interlinx.bc.ca bluetoothd[1405]: Bluetooth daemon 5.11
Dec 11 11:51:57 pc.interlinx.bc.ca bluetoothd[1405]: Starting SDP server
Dec 11 11:51:57 pc.interlinx.bc.ca bluetoothd[1405]: Bluetooth management i=
nterface 1.3 initialized
Dec 11 11:52:36 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint registered: s=
ender=3D:1.40 path=3D/MediaEndpoint/A2DPSource
Dec 11 11:52:36 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint registered: s=
ender=3D:1.40 path=3D/MediaEndpoint/A2DPSink
Dec 11 15:06:51 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint unregistered:=
 sender=3D:1.40 path=3D/MediaEndpoint/A2DPSource
Dec 11 15:06:51 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint unregistered:=
 sender=3D:1.40 path=3D/MediaEndpoint/A2DPSink
Dec 11 15:06:51 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.40" (uid=3D1001 pid=3D196=
2 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=3D=
"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Error.N=
otImplemented" requested_reply=3D"0" destination=3D":1.14" (uid=3D0 pid=3D1=
405 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 11 15:06:51 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.40" (uid=3D1001 pid=3D196=
2 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=3D=
"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Error.N=
otImplemented" requested_reply=3D"0" destination=3D":1.14" (uid=3D0 pid=3D1=
405 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 11 15:06:51 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.40" (uid=3D1001 pid=3D196=
2 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=3D=
"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Error.N=
otImplemented" requested_reply=3D"0" destination=3D":1.14" (uid=3D0 pid=3D1=
405 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 11 15:06:51 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.40" (uid=3D1001 pid=3D196=
2 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=3D=
"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Error.N=
otImplemented" requested_reply=3D"0" destination=3D":1.14" (uid=3D0 pid=3D1=
405 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 11 15:06:51 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.40" (u=
id=3D1001 pid=3D1962 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsys=
log ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.Med=
iaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1.1=
4" (uid=3D0 pid=3D1405 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 11 15:06:51 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.40" (u=
id=3D1001 pid=3D1962 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsys=
log ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.Med=
iaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1.1=
4" (uid=3D0 pid=3D1405 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 11 15:06:52 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.40" (u=
id=3D1001 pid=3D1962 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsys=
log ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.Med=
iaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1.1=
4" (uid=3D0 pid=3D1405 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 11 15:06:52 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.40" (u=
id=3D1001 pid=3D1962 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsys=
log ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.Med=
iaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1.1=
4" (uid=3D0 pid=3D1405 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 11 15:07:05 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint registered: s=
ender=3D:1.40 path=3D/MediaEndpoint/A2DPSource
Dec 11 15:07:05 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint registered: s=
ender=3D:1.40 path=3D/MediaEndpoint/A2DPSink
Dec 11 15:07:07 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 11 15:07:07 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 11 15:11:06 pc.interlinx.bc.ca kernel: input: Microsoft Sculpt Touch Mo=
use as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1.3/2-1.3:1.0/bluetooth/=
hci0/hci0:11/input15
Dec 11 15:11:07 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 11 18:51:38 pc.interlinx.bc.ca kernel: input: Microsoft Sculpt Touch Mo=
use as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1.3/2-1.3:1.0/bluetooth/=
hci0/hci0:11/input16
Dec 11 18:51:40 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 12 05:49:53 pc.interlinx.bc.ca kernel: input: Microsoft Sculpt Touch Mo=
use as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1.3/2-1.3:1.0/bluetooth/=
hci0/hci0:11/input17
Dec 12 05:49:55 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 12 06:44:22 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 12 06:44:25 pc.interlinx.bc.ca kernel: input: Microsoft Sculpt Touch Mo=
use as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1.3/2-1.3:1.0/bluetooth/=
hci0/hci0:11/input18
Dec 12 11:23:37 pc.interlinx.bc.ca kernel: input: Microsoft Sculpt Touch Mo=
use as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1.3/2-1.3:1.0/bluetooth/=
hci0/hci0:11/input19
Dec 12 11:23:42 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 12 13:53:30 pc.interlinx.bc.ca kernel: input: Microsoft Sculpt Touch Mo=
use as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1.3/2-1.3:1.0/bluetooth/=
hci0/hci0:11/input20
Dec 12 13:53:32 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 12 15:32:47 pc.interlinx.bc.ca kernel: input: Microsoft Sculpt Touch Mo=
use as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1.3/2-1.3:1.0/bluetooth/=
hci0/hci0:11/input21
Dec 12 15:32:49 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 13 05:46:01 pc.interlinx.bc.ca kernel: input: Microsoft Sculpt Touch Mo=
use as /devices/pci0000:00/0000:00:02.0/usb2/2-1/2-1.3/2-1.3:1.0/bluetooth/=
hci0/hci0:11/input22
Dec 13 05:46:02 pc.interlinx.bc.ca bluetoothd[1405]: No supported periphera=
l found
Dec 13 10:00:19 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint unregistered:=
 sender=3D:1.40 path=3D/MediaEndpoint/A2DPSource
Dec 13 10:00:19 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint unregistered:=
 sender=3D:1.40 path=3D/MediaEndpoint/A2DPSink
Dec 13 10:01:00 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint registered: s=
ender=3D:1.243 path=3D/MediaEndpoint/A2DPSource
Dec 13 10:01:00 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint registered: s=
ender=3D:1.243 path=3D/MediaEndpoint/A2DPSink
Dec 13 10:16:57 pc.interlinx.bc.ca bluetoothd[1405]: Terminating
Dec 13 10:16:59 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint unregistered:=
 sender=3D:1.243 path=3D/MediaEndpoint/A2DPSource
Dec 13 10:16:59 pc.interlinx.bc.ca bluetoothd[1405]: Endpoint unregistered:=
 sender=3D:1.243 path=3D/MediaEndpoint/A2DPSink
Dec 13 10:16:59 pc.interlinx.bc.ca bluetoothd[1405]: Stopping SDP server
Dec 13 10:16:59 pc.interlinx.bc.ca bluetoothd[1405]: Exit
Dec 13 10:17:01 pc.interlinx.bc.ca bluetoothd[27809]: Bluetooth daemon 5.12
Dec 13 10:17:02 pc.interlinx.bc.ca bluetoothd[27809]: Starting SDP server
Dec 13 10:17:02 pc.interlinx.bc.ca bluetoothd[27809]: Bluetooth management =
interface 1.3 initialized
Dec 13 10:17:05 pc.interlinx.bc.ca bluetoothd[27809]: Endpoint registered: =
sender=3D:1.243 path=3D/MediaEndpoint/A2DPSource
Dec 13 10:17:05 pc.interlinx.bc.ca bluetoothd[27809]: Endpoint registered: =
sender=3D:1.243 path=3D/MediaEndpoint/A2DPSink
Dec 13 10:21:11 pc.interlinx.bc.ca sudo[28307]: brian : TTY=3Dpts/1 ; PWD=
=3D/home/brian ; USER=3Droot ; COMMAND=3D/sbin/service bluetooth restart
Dec 13 10:21:12 pc.interlinx.bc.ca bluetoothd[27809]: Terminating
Dec 13 10:21:12 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.243" (uid=3D1001 pid=3D24=
392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=
=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Erro=
r.NotImplemented" requested_reply=3D"0" destination=3D":1.256" (uid=3D0 pid=
=3D27809 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:21:12 pc.interlinx.bc.ca bluetoothd[27809]: Endpoint unregistered=
: sender=3D:1.243 path=3D/MediaEndpoint/A2DPSource
Dec 13 10:21:12 pc.interlinx.bc.ca bluetoothd[27809]: Endpoint unregistered=
: sender=3D:1.243 path=3D/MediaEndpoint/A2DPSink
Dec 13 10:21:12 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.243" (uid=3D1001 pid=3D24=
392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=
=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Erro=
r.NotImplemented" requested_reply=3D"0" destination=3D":1.256" (uid=3D0 pid=
=3D27809 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:21:12 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.243" (uid=3D1001 pid=3D24=
392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=
=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Erro=
r.NotImplemented" requested_reply=3D"0" destination=3D":1.256" (uid=3D0 pid=
=3D27809 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:21:12 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.243" (uid=3D1001 pid=3D24=
392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=
=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Erro=
r.NotImplemented" requested_reply=3D"0" destination=3D":1.256" (uid=3D0 pid=
=3D27809 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:21:12 pc.interlinx.bc.ca bluetoothd[27809]: Stopping SDP server
Dec 13 10:21:12 pc.interlinx.bc.ca bluetoothd[27809]: Exit
Dec 13 10:21:12 pc.interlinx.bc.ca bluetoothd[28339]: Bluetooth daemon 5.12
Dec 13 10:21:12 pc.interlinx.bc.ca bluetoothd[28339]: Starting SDP server
Dec 13 10:21:13 pc.interlinx.bc.ca bluetoothd[28339]: Bluetooth management =
interface 1.3 initialized
Dec 13 10:21:13 pc.interlinx.bc.ca bluetoothd[28339]: Endpoint registered: =
sender=3D:1.243 path=3D/MediaEndpoint/A2DPSource
Dec 13 10:21:13 pc.interlinx.bc.ca bluetoothd[28339]: Endpoint registered: =
sender=3D:1.243 path=3D/MediaEndpoint/A2DPSink
Dec 13 10:21:14 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.243" (=
uid=3D1001 pid=3D24392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Ds=
yslog ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.M=
ediaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1=
.256" (uid=3D0 pid=3D27809 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:21:14 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.243" (=
uid=3D1001 pid=3D24392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Ds=
yslog ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.M=
ediaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1=
.256" (uid=3D0 pid=3D27809 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:21:14 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.243" (=
uid=3D1001 pid=3D24392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Ds=
yslog ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.M=
ediaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1=
.256" (uid=3D0 pid=3D27809 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:21:14 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.243" (=
uid=3D1001 pid=3D24392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Ds=
yslog ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.M=
ediaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1=
.256" (uid=3D0 pid=3D27809 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca bluetoothd[28339]: Endpoint unregistered=
: sender=3D:1.243 path=3D/MediaEndpoint/A2DPSource
Dec 13 10:24:03 pc.interlinx.bc.ca bluetoothd[28339]: Endpoint unregistered=
: sender=3D:1.243 path=3D/MediaEndpoint/A2DPSink
Dec 13 10:24:03 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.243" (uid=3D1001 pid=3D24=
392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=
=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Erro=
r.NotImplemented" requested_reply=3D"0" destination=3D":1.261" (uid=3D0 pid=
=3D28339 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.243" (uid=3D1001 pid=3D24=
392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=
=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Erro=
r.NotImplemented" requested_reply=3D"0" destination=3D":1.261" (uid=3D0 pid=
=3D28339 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.243" (uid=3D1001 pid=3D24=
392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=
=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Erro=
r.NotImplemented" requested_reply=3D"0" destination=3D":1.261" (uid=3D0 pid=
=3D28339 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca dbus[1232]: [system] Rejected send messa=
ge, 4 matched rules; type=3D"error", sender=3D":1.243" (uid=3D1001 pid=3D24=
392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Dsyslog ") interface=
=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.MediaEndpoint1.Erro=
r.NotImplemented" requested_reply=3D"0" destination=3D":1.261" (uid=3D0 pid=
=3D28339 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.243" (=
uid=3D1001 pid=3D24392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Ds=
yslog ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.M=
ediaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1=
.261" (uid=3D0 pid=3D28339 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.243" (=
uid=3D1001 pid=3D24392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Ds=
yslog ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.M=
ediaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1=
.261" (uid=3D0 pid=3D28339 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.243" (=
uid=3D1001 pid=3D24392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Ds=
yslog ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.M=
ediaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1=
.261" (uid=3D0 pid=3D28339 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca dbus-daemon[1232]: dbus[1232]: [system] =
Rejected send message, 4 matched rules; type=3D"error", sender=3D":1.243" (=
uid=3D1001 pid=3D24392 comm=3D"/usr/bin/pulseaudio --start --log-target=3Ds=
yslog ") interface=3D"(unset)" member=3D"(unset)" error name=3D"org.bluez.M=
ediaEndpoint1.Error.NotImplemented" requested_reply=3D"0" destination=3D":1=
.261" (uid=3D0 pid=3D28339 comm=3D"/usr/libexec/bluetooth/bluetoothd ")
Dec 13 10:24:03 pc.interlinx.bc.ca systemd[1]: Service bluetooth.target is =
not needed anymore. Stopping.
Dec 13 10:24:13 pc.interlinx.bc.ca bluetoothd[28339]: Endpoint registered: =
sender=3D:1.243 path=3D/MediaEndpoint/A2DPSource
Dec 13 10:24:13 pc.interlinx.bc.ca bluetoothd[28339]: Endpoint registered: =
sender=3D:1.243 path=3D/MediaEndpoint/A2DPSink

Earlier today I did a "service bluetooth restart" as well as
unplugging/plugging the dongle, so those are probably reflected in
there.

> to see if there's more debug output from the
> daemon.
>=20
> The mouse should be trying to reconnect, no idea why it wouldn't be able
> to...

Indeed.  :-)

b.




--=-+hBJW+mZHl45DAz6yQ6l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQEcBAABAgAGBQJSqzNDAAoJENrB0DQWy8igS9sIAJxRpJyLbWBEBq3AAaB0Xmbi
dXTOH7085YS1qFDgqjKarCGuFaG6z4UkCmdJFWvPfYmLjpkv4WNz1DT9yGmnCPS/
Mm7teBVLnm4BKplkN79Jhsx42sTuKesA5Si+BRld2fX5Yx6NscQjmdB3/zs6G/Gd
/T1SzNCCmqiTSQGEAMFEhNZK0A4od8qCmDHJJOvwqNgQKL6VQwH4PJwYQdhl8LbF
5uxIA5UMV/3xL/a1njLIhmAQ357zou+ZQXbHAIUz9TUI5K7KyTvAzwngGEBUAq9s
aXB1+xHXyoLSm+zFmNtJAi8mWmy6n1iVIhLUYZ0fD+rCsqITUUuoaJCdiIFQELA=
=YnPM
-----END PGP SIGNATURE-----

--=-+hBJW+mZHl45DAz6yQ6l--

