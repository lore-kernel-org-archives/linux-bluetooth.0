Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with SDP.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <001a01c637fa$8affa800$c800a8c0@kazama>
References: <001a01c637fa$8affa800$c800a8c0@kazama>
Content-Type: text/plain; charset=utf-8
Message-Id: <1140649027.4519.53.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 22 Feb 2006 23:57:07 +0100

Hi,

> I hope somebody can help me. I made a aplication in c++ for blueZ and
> register my own perfil in the SDP.  The function
> to register works well.
> =20
> I make the SPDTOOL BROWSE LOCAL  and the new perfil appeards without
> any problem.
> =20
> But... If I try to conect with SDP from Symbian, other linux or
> Windows, They CAN=C2=B4T  connect and don=C2=B4t obtain any perfil.
> =20
> the sdpd daemon is working.... (I checkit).
> =20
> What is necessary to SDP are public and other bluetooth devices can
> see it?

check with "hcidump -X -V" if the other side really connects to your
machine and what maybe fails.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
