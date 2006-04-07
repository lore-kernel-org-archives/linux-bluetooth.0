Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-users] sniff & pand
Message-ID: <8350AFF45303EE44BE0AF1AB40CA43584A8F00@scsmsx404.amr.corp.intel.com>
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
Date: Fri, 7 Apr 2006 12:07:09 -0700

Are you sure your connection handle is right? I've seen connection
handles of 0x42 or 0x00 but nothing like 0x1006.  You can find out the
connection handle with "hctiool con" after you've made the pan
connection.

I've found that getting sniff mode set up can be very fickle.  depends
on firmware and other random parameters, so... can take some fiddling.=20

As far as I know BlueZ provides no direct support for sniff, and so I've
always used "hcitool cmd" to generate the sequence...

	Trevor



=20

-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Steven
Singer
Sent: Friday, April 07, 2006 8:02 AM
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sniff & pand

Alexandre Coser Monteiro wrote:
> < HCI Command: ogf 0x02, ocf 0x0003, plen 9
>  06 10 00 00 10 FF F7 00 07
> > HCI Event: 0x0f plen 4
> 12 01 03 08              =20

The Command Status event shows error code 0x12 =3D Invalid HCI Command
Parameters.

This means that the controller didn't like one of the parameters to the
sniff mode command.

The sniff mode command you gave had the parameters:

   Connection handle:  0x1006
   Sniff Max Interval: 0x0000
   Sniff Min Interval: 0xff10
   Sniff Attempts:     0x00f7
   Sniff Timeout:      0x??07

Notes:

  The connection handle is invalid. The valid range is 0x0000..0x0eff

  The maximum interval is invalid. The valid range is 0x0002..0xfffe

  The minimum interval is invalid. The valid range is 0x0002..max
  interval.

  The sniff attempts is highly unusual (but not actually invalid).

  The sniff timeout field is truncated, it should be two bytes.

So, it's not surprising that the controller is rejecting it.

Where is the sniff mode command being generated? How is it getting
through the BlueZ APIs to generate such an invalid event? Are the
normal APIs being bypassed and is a raw command being sent.

	- Steven
--=20


To access the latest news from CSR copy this link into a web browser:
http://www.csr.com/email_sig.php


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
