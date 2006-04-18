Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sdp_connect and co, timing
Message-ID: <20060418120837.GA7644@localdomain>
References: <a3b1b800604160901k6e86614bueceba1bcd5466d5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a3b1b800604160901k6e86614bueceba1bcd5466d5d@mail.gmail.com>
From: Amateur <ztl.post@gmail.com>
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
Date: Tue, 18 Apr 2006 20:08:37 +0800

On Sun, Apr 16, 2006 at 06:01:54PM +0200, Jan Benes wrote:
>=20
> hello,
> I'm trying ot write an application that scans for devices, asks for
> name and services and eventually sends some files/data. I'm running in
> threads. I've already discovered that I must use exclusive access to
> the dongle during connection-time. I also don't do any connecting

On my Broadcom chipped dongle, I do can initiate two connection
request simultaneously. But I found scanning and connect can't
operate properly at the same time. Could this be a hardware
limitation?=20

> while asking for services or scanning for devices. Still, sometimes,
> the sdp_connect fails to connect for some time. Also, rarely, the
> inquiry fails. Is it possible that there needs to be some time gap
> between such requests? Do scanning/asking for
> services/connectiong/sending cause "collisions"?
>=20
> PS: also, what are the possible responses from a sdp_connect (or the
> respective socket functinos from the function itself. I can't find
> them anywhere)
>=20
> thanks, Jan
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
> that extends applications into web and mobile media. Attend the live webc=
ast
> and join the prime developer group breaking into this new coding territor=
y!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=110944&bid$1720&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20
-------------------------

--=20
You fill a much-needed gap.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
