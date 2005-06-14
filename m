Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <ef9938ec05061322251d0b493a@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] varying time to connect
In-Reply-To: <20050613194748.5455A56F@arbetsmyra.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050613194748.5455A56F@arbetsmyra.dyndns.org>
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
Date: Tue, 14 Jun 2005 01:25:02 -0400

The short answer is no.  The connection algorithm (paging) is
probabilistic, and the frequency that one bluetooth device is
listening on may not match the frequency the connecting device is
transmitting on for a few seconds.

-albert=20

On 6/13/05, Ronny L Nilsson <bb@arbetsmyra.dyndns.org> wrote:
>=20
> Hi
> I guess this is normal, but I'm a bit curious:
>=20
> When connecting to a remote device with:
>   hcitool cc 00:11:22:33:44:55
> the time for the connection to succeed vary from anything between 0.5 -
> 5 seconds. Is there any good explanation for this? Shouldn't it be
> somewhat equal each and every time? Especially when trying many times
> in a row?
>=20
> Is there a way to optimse the connection phase? Obviously it can be
> made within 0.5 s, but how to do it every time and not just randomly?
>=20
>=20
> BR
> /Ronny Nilsson
>=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you sho=
tput
> a projector? How fast can you ride your desk chair down the office luge t=
rack?
> If you want to score the big prize, get to know the little guy.
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
