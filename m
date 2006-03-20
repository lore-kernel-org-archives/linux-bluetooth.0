Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1142865034.19109.18.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] information responses in l2cap.c
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
Date: Mon, 20 Mar 2006 15:30:34 +0100

Hello together,

I need urgent help on an issue concerning information responses in
l2cap.c, perhaps somebody knows something about this implementation.
The current code didn't make use of information requests and so didn't
receive information responses, too. I'd like to change that as it is
recommended by the specfication to first interact with the remote peer
by using information requests after a successful connection. I would
like to ask the remote peer if it supports extended features, namely
especially flow control, before I start request this technique. So far
so good.
So I send an information request via the l2cap_build_info_req() in the
function l2cap_connect_rsp() whenever the connection response signals
success. This works as expected and my Siemens S75 mobile phone responds
with an information response immediately. Guess what, it send as a
result the bytes =BB07 00 00 00=AB which indicates full extended features
support. Wow. Now I'd like store this information in the corresponding
socket so that I can continue the whole process with a configuration
request. I would like to call l2cap_build_conf_req() within
l2cap_information_rsp() like this:

/* build configuration request */
l2cap_pi(sk)->conf_state |=3D L2CAP_CONF_REQ_SENT;
l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ,
			l2cap_build_conf_req(sk, req), req);

 But here is the problem located. From within an information response, I
cannot reliably find the corresponding socket. All information pieces I
get are the connection, the command header and the data. So there is no
source or destination ID and the only function I could find which may
return the socket for a connection is l2cap_get_chan_by_ident() like
this:
if (!(sk =3D l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident))) {
	printk("---> no socket!\n");
	return 0;
}
Unfortunately cmd->ident and the conn ident are not equal and so the
socket cannot be found ...

I have no clue what is wrong or what else I should do to get the socket
from an incoming information_rsp()

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
