Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40507F94.2040004@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: sjok1 <sjok1@student.cs.ucc.ie>
CC: Bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Bluetooth Headset Profile
References: <40500CFF@webmail.ucc.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 11 Mar 2004 16:02:44 +0100



sjok1 wrote:
> Hi,
>=20
> I don't know if this is the right list to put this but I've been follow=
ing=20
> what's being posted for the last couple of weeks and it seems like peop=
le=20
> might know how to help me.
>=20
>    I'm writing an application for a PC that (tries to :) ) emulates a=20
> Bluetooth Headset. I want the the PC application to be the one to creat=
e the=20
> initial RFCOMM connection and I just need to know specifically what the=
 phone=20
> tries to do when I send the AT+CKPD=3D200 command for the first time? O=
r do I=20
> need to send this command at all, can I just listen for an SCO connecti=
on?=20

you have to send this command, as it will tell the phone to initiate the =
sco link
(else you won't get sound).

> Will the phone try to verify that the PC supports the Headset/Handsfree=
=20
> Profile at this time?
>=20

I tried a p800 which worked without the profile entry, but it will help w=
hen you
want to look up your 'headset'.

Simon


> Thanks,
>=20
> Steven.
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dc=
lick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


--=20
_______________________________________________________________________
Dr. Simon Vogl
Institut f=FCr Pervasive Computing, Johannes Kepler Universit=E4t Linz
Altenberger Stra=DFe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/








-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
