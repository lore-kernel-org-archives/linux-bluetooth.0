Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-users] sniff & pand
Message-ID: <8350AFF45303EE44BE0AF1AB40CA43584A9097@scsmsx404.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 7 Apr 2006 13:46:06 -0700

how are you parsing your command line?  I don' tunderstand how you get
the sniff attempts (0x0062) and sniff timeout (0x0062) from your
command. Do you mean 0x0462? I parse your max interval as 0x8E00.
Double-check the *number* of arguments you have... you have 11, when you
should have 10.

	Trevor


-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Alexandre
Coser Monteiro
Sent: Friday, April 07, 2006 12:26 PM
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sniff & pand


 =20
   Thank you for your attention Steven.
  =20
  With a detailed eye in my sniff command line, I agree whith you that I
introduce wrong
parameters, but I still doesn`t understand why a pand connection doesn`t
accept my sniff
command line after my correction.
  I`ve been introduced the sniff commando through the linux shell using
hcitool

[root@helio script]# hcitool cmd 0x02 0x0003 0x00 0x06 0x00 0x8E 0x25
0x8D 0x25 0x62
0x04 0x62 0X04
< HCI Command: ogf 0x02, ocf 0x0003, plen 11
  00 06 00 8E 25 8E 24 62 04 62 04
> HCI Event: 0x0f plen 4
  02 01 03 08

Sniff Interval =3D 6 seg.
Sniff Attempt =3D 0.7 seg.
    Connection handle:  0x0006
    Sniff Max Interval: 0x258E
    Sniff Min Interval: 0x258D
    Sniff Attempts:     0x0062
    Sniff Timeout:      0x0062

The notation for sniff command line is LSB-MSB ? How can I do sniff work
in a pand
connection ?
 I work with FedoraCore-3, Linux kernel 2.6.9-1.667smp and a usb
bluetooth dongle BT3030
from BroadCom

Sds,=20
  Alexandre

On Fri, 07 Apr 2006 16:02:06 +0100, Steven Singer wrote
> Alexandre Coser Monteiro wrote:
> > < HCI Command: ogf 0x02, ocf 0x0003, plen 9
> >  06 10 00 00 10 FF F7 00 07
> > > HCI Event: 0x0f plen 4
> > 12 01 03 08
>=20
> The Command Status event shows error code 0x12 =3D Invalid HCI Command
> Parameters.
>=20
> This means that the controller didn't like one of the parameters to
the
> sniff mode command.
>=20
> The sniff mode command you gave had the parameters:
>=20
>    Connection handle:  0x1006
>    Sniff Max Interval: 0x0000
>    Sniff Min Interval: 0xff10
>    Sniff Attempts:     0x00f7
>    Sniff Timeout:      0x??07
>=20
> Notes:
>=20
>   The connection handle is invalid. The valid range is 0x0000..0x0eff
>=20
>   The maximum interval is invalid. The valid range is 0x0002..0xfffe
>=20
>   The minimum interval is invalid. The valid range is 0x0002..max
>   interval.
>=20
>   The sniff attempts is highly unusual (but not actually invalid).
>=20
>   The sniff timeout field is truncated, it should be two bytes.
>=20
> So, it's not surprising that the controller is rejecting it.
>=20
> Where is the sniff mode command being generated? How is it getting
> through the BlueZ APIs to generate such an invalid event? Are the
> normal APIs being bypassed and is a raw command being sent.
>=20
> 	- Steven
> --
>=20
> To access the latest news from CSR copy this link into a web browser:=20
http://www.csr.com/email_sig.php
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting
language
> that extends applications into web and mobile media. Attend the live
webcast
> and join the prime developer group breaking into this new coding
territory!
>
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


--
Sds,
 Alexandre
Tel.:+55 21 9312-7293



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting
language
that extends applications into web and mobile media. Attend the live
webcast
and join the prime developer group breaking into this new coding
territory!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
