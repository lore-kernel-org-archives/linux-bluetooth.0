Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1142243128.30440.15.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] Question about L2CAP sockets
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
Date: Mon, 13 Mar 2006 10:45:28 +0100

Hello together,

I'm currently recoding some functions to provide Flow Control mechanism
on the L2CAP layer. Incoming Configuration Requests, Configuration
Responses and Information Requests are mostly done. Now I try to do the
corresponding work for an incoming Information Response. In order to
keep track of the results (let's say I sent an info request about
supported flow control) I need to store those results somewhere from
where I can use them for a reasonable configuration request (if the
remote peer doesn't support Flow Control, then we don't need request any
Flow Control options any more). I thought these pieces of information
belong to the corresponding socket, but now I have quite some trouble to
access the socket struct from l2cap_information_rsp() as the only
informational field I have is the l2cap_conn struct. 

So is there a way to obtain the socket just from the connection struct?

My only idea is to use the function:
static inline struct *l2cap_get_chan_by_ident(struct l2cap_chan_list *l,
u8 ident)
as we have two candidate fields -- rx_ident and tx_ident -- in our
connection struct. But I don't know if that might work.
Is there anybody who may help me out a bit with the l2cap stuff?

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
