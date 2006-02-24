Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] sdptool fails with ppc6700
Message-ID: <C70061B183DE09419568AB2060C52A9501C19EA3@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Fri, 24 Feb 2006 16:04:38 +0100

Brad,

Once I had a Nokia phone locking up each time I download data with max.
rate. That was a phone problem. I veryfied it by connecting the phone to
a Windowds PC (so no bluez) and making a download - it was still locking
up.  Later on after upgrading the firmware the problem was solved.

Regards,
    Victor.

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Brad
Midgley
Sent: Friday, February 24, 2006 16:00 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdptool fails with ppc6700

Victor

> Try usimg sdptool browse XX:XX:XX:XX:XX:XX --l2cap (some phones do not

> implement Public Browse Group which is used for discovery by default)=20
> and if this does not help for some phones you have to ask for specific

> profiles to get an answer (new Motorola's): sdptool search --bdaddr=20
> XX:XX:XX:XX:XX:XX DUN for an example.

thanks... the l2cap scan didn't help, but searching specifically for DUN
did.

The phone still locks up whenever I try to max out the connection so
it's going back unless there's an easy fix. Maybe it's some kind of bad
interaction between bluez and pocketpc. :(

~# sdptool search --bdaddr 00:12:37:BD:9F:xx DUN Searching for DUN on
00:12:37:BD:9F:xx ...
Service Name: Dial-up Networking
Service RecHandle: 0x10002
Service Class ID List:
  "Dialup Networking" (0x1103)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting
language that extends applications into web and mobile media. Attend the
live webcast and join the prime developer group breaking into this new
coding territory!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
