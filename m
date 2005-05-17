Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <OF9A811F48.3D259B3A-ONC1257004.002BB233-C1257004.002F049A@telemotive.de>
From: Markus.Heininger@telemotive.de
Content-Type: multipart/alternative; boundary="=_alternative 002F0494C1257004_="
Subject: [Bluez-devel] HCI-Uart Driver & Kernel 2.4.25 , Headset/Handsfree Profile
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 17 May 2005 10:33:15 +0200

Dies ist eine mehrteilige Nachricht im MIME-Format.
--=_alternative 002F0494C1257004_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I=B4m trying to get the Handsfree/Headset-Profile running on an embedded=20
power pc-platform using the 2.4.25 kernel and a bluetooth module
which is connected to the host processor via UART-Interface.=20

The strange thing is that all other profiles work fine (OBEX, DUN etc.)
but when it comes to transfer synchronous data in both directions like the =

handsfree profile does, I got an error message from
the kernel like "unkown HCI packet type 00 received".

Although there were no additional error messages from the kernel like=20
buffer overruns of the UART interface, the first thing I thought about=20
was that there might by something wrong with the hardware handshake of the =

UART interface, but I managed to connect the bluetooth module=20
via RS232 to a normal PC running linux kernel 2.6 even without RTS and CTS =

lines of the UART interface connected (only RXD & TXD).=20
Here everything works fine, so the problem is surely not caused by a=20
missing/buggy hardware handshake.

It would be a hard work to upgrade from kernel 2.4  to 2.6 on our platform =

since we already applied many changes to the kernel (not concerning=20
bluez),
so my question is if someone of you did experience the same problems and=20
perhaps there is a way to patch the linux 2.4 kernel to solve them.

I already applied all available patches to bluez, but I=B4m afraid that the=
=20
problem originates on a different place in the linux 2.4 kernel, maybe
in the higher level - serial/tty drivers or in the communication between=20
them and the hci uart driver.

Perhaps someone of you can help me,

many thanks and with best regards,
Markus






--=_alternative 002F0494C1257004_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I=B4m trying to get the Handsfree/He=
adset-Profile
running on an embedded power pc-platform using the 2.4.25 kernel and a
bluetooth module</font>
<br><font size=3D2 face=3D"sans-serif">which is connected to the host proce=
ssor
via UART-Interface. </font>
<br>
<br><font size=3D2 face=3D"sans-serif">The strange thing is that all other
profiles work fine (OBEX, DUN etc.)</font>
<br><font size=3D2 face=3D"sans-serif">but when it comes to transfer synchr=
onous
data in both directions like the handsfree profile does, I got an error
message from</font>
<br><font size=3D2 face=3D"sans-serif">the kernel like &quot;unkown HCI pac=
ket
type 00 received&quot;.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Although there were no additional er=
ror
messages from the kernel like buffer overruns of the UART interface, the
first thing I thought about </font>
<br><font size=3D2 face=3D"sans-serif">was that there might by something wr=
ong
with the hardware handshake of the UART interface, but I managed to connect
the bluetooth module </font>
<br><font size=3D2 face=3D"sans-serif">via RS232 to a normal PC running lin=
ux
kernel 2.6 even without RTS and CTS lines of the UART interface connected
(only RXD &amp; TXD). </font>
<br><font size=3D2 face=3D"sans-serif">Here everything works fine, so the p=
roblem
is surely not caused by a missing/buggy hardware handshake.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">It would be a hard work to upgrade f=
rom
kernel 2.4 &nbsp;to 2.6 on our platform since we already applied many chang=
es
to the kernel (not concerning bluez),</font>
<br><font size=3D2 face=3D"sans-serif">so my question is if someone of you
did experience the same problems and perhaps there is a way to patch the
linux 2.4 kernel to solve them.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">I already applied all available patc=
hes
to bluez, but I=B4m afraid that the problem originates on a different place
in the linux 2.4 kernel, maybe</font>
<br><font size=3D2 face=3D"sans-serif">in the higher level - serial/tty dri=
vers
or in the communication between them and the hci uart driver.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Perhaps someone of you can help me,<=
/font>
<br>
<br><font size=3D2 face=3D"sans-serif">many thanks and with best regards,</=
font>
<br><font size=3D2 face=3D"sans-serif">Markus</font>
<br>
<br>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif"><br>
</font>
--=_alternative 002F0494C1257004_=--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
