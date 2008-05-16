Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 May 2008 16:08:01 -0700 (PDT)
From: Michael Oh <michaeloh1@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <884634.96017.qm@web81308.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] Losing SCO connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

It seems like some phones just don't like having a SCO connection up when v=
oice call is not in progress.=A0 So instead of actively trying to connect t=
o the phone, I just let the phone connect to my SCO listener socket as need=
ed and I don't have the disconnect problem anymore.=A0 i.e. I just had to r=
everse the server/client direction in my app.
There's one remaining problem though.=A0 Occasionally, I hear garbage voice=
 on the receive side of SCO.=A0 hcidump shows maybe the 16-bit samples are =
in wrong endianness.=A0 This stays like that until the SCO is closed and re=
established.=A0 Anyone seen this problem?=A0=A0 I will try out a CSR dongle=
 also.
Thanks,
Michael

----- Original Message ----
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Sent: Thursday, May 15, 2008 2:50:32 AM
Subject: Re: [Bluez-users] Losing SCO connection

Hi Michael,

> I wrote a little app that tries to support the hands-free (HF) profile bu=
t I am having trouble keeping the SCO connection alive.=A0 Using an RFCOMM =
connection, I am able to establish the HF Service Level Connection per HF P=
rofile specification and then create an SCO connection to a mobile phone.=
=A0 But SCO seems to get disconnected by the phone after about 40-50msec of=
 bidirectional voice data.=A0 I can reconnect SCO but the phone disconnects=
 it again.=A0 Once in a while, this problem doesn't occur and SCO stays ali=
ve.=A0 When this happens, I can tear down and bring up the HF setup repeate=
dly without any problem unless I power cycle the phone or the linux machine=
.=A0 I would like to make it work on consistent basis.
> Please note that I am using the bluez lib only. I am not relying on the "=
services" utilities in the bluez-util package (I turned them all off).=A0 A=
lso, my SDP setup code seems to operate okay (i.e. output of "sdptool brows=
e local" looks fine)
> Setup:
>=A0 =A0 - Fedora 8 with
>=A0 =A0 =A0 =A0 kernel 2.6.24.4
>=A0 =A0 =A0 =A0 bluez-lib 3.20
>=A0 =A0 =A0 =A0 L2CAP v2.9
>=A0 =A0 =A0 =A0 RFCOMM v1.8
>=A0 =A0 =A0 =A0 SCO v0.5
>=A0 =A0 - Bluetooth dongle: Targus with Broadcom 2045=A0 =A0 - phone: Noki=
a 6085
> I have tried another phone and another BT dongle and the problem is still=
 there so I am leaning it's either my code or bluez...

did you try a CSR based dongle? It looks like the remote side is
disconnecting. Maybe it has something to do with your HFP control
channel handling. Can't really tell.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft =

Defy all challenges. Microsoft(R) Visual Studio 2008. =

http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



      =


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft =

Defy all challenges. Microsoft(R) Visual Studio 2008. =

http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
