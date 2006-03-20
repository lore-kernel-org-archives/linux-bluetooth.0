Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] information responses in l2cap.c
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1142865034.19109.18.camel@localhost.localdomain>
References: <1142865034.19109.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1142877563.18472.10.camel@localhost.localdomain>
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
Date: Mon, 20 Mar 2006 18:59:22 +0100

I may have found a solution for it.

Am Montag, den 20.03.2006, 15:30 +0100 schrieb Martin R=F6hricht:
> /* build configuration request */
> l2cap_pi(sk)->conf_state |=3D L2CAP_CONF_REQ_SENT;
> l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
> 			l2cap_build_conf_req(sk, req), req);

(Damn, I posted the wrong lines in my preceeding mail, but it looks
almost the same. Instead of building a configuration request, I have
code to build an information request)
Within the send_cmd function call, I use l2cap_get_ident(conn) which
increases the ident counter by one for each call. I did mistakenly
assume that it just returns the ID for a given connection. Instead I use
now cmd->ident like this:

l2cap_send_cmd(conn, cmd->ident, L2CAP_INFO_REQ,
			l2cap_build_info_req(sk, &info), &info);

> if (!(sk =3D l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident))) {
> 	printk("---> no socket!\n");
> 	return 0;
> }

These lines work now, as a socket can be found.

I'm not 100% sure yet whether this works as expected or not, but I have
a better feeling.
If somebody has some more information about socket and ID handling in
this case, feel free to let me know.

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
