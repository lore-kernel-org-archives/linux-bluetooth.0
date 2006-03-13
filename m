Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Question about L2CAP sockets
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1142243128.30440.15.camel@localhost.localdomain>
References: <1142243128.30440.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1142247244.10826.6.camel@localhost.localdomain>
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
Date: Mon, 13 Mar 2006 11:54:04 +0100

Am Montag, den 13.03.2006, 10:45 +0100 schrieb Martin R=F6hricht:
> So is there a way to obtain the socket just from the connection struct?
>=20
> My only idea is to use the function:
> static inline struct *l2cap_get_chan_by_ident(struct l2cap_chan_list *l,
> u8 ident)
> as we have two candidate fields -- rx_ident and tx_ident -- in our
> connection struct. But I don't know if that might work.

I think I managed to use the right function arguments. My current
solution looks like this:

static inline int l2cap_information_rsp(struct l2cap_conn *conn, struct
l2cap_cmd_hdr *cmd, u8 *data)
{
	[...]
	struct sock *sk;
	[...]
	if (!(sk =3D l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident)))
		return 0;
	[...]
	l2cap_pi(sk)->info_mtu =3D __le16_to_cpup((__le16 *) rsp->data);
	[...]
}

I tried to test this with two Siemens mobilephones (S55 and S75) and a
Windows XP machine, but none of them seems to make use of any
information requests at all ...=20
Perhaps somebody knows of a device that tries to inform itself about
it's remote partner before sending requests?

Martin



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
