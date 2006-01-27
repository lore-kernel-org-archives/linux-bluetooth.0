Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] possible minor bug in l2cap.c
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1137082576.20029.8.camel@localhost.localdomain>
References: <1137082576.20029.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Message-Id: <1138353979.7949.1.camel@localhost.localdomain>
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
Date: Fri, 27 Jan 2006 10:26:19 +0100

Am Donnerstag, den 12.01.2006, 17:16 +0100 schrieb Martin R=C3=B6hricht:
> Hello together,
>=20
> I was wondering if there is an uninitialised variable in use:
> In function l2cap_config_req() we declare =C2=BBu8 rsp[64];=C2=AB and cal=
l it only
> twice:
> 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
> 		l2cap_build_conf_rsp(sk, rsp, NULL), rsp);
> 	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
> 		l2cap_build_conf_rsp(sk, rsp, &result), rsp);
>=20
> In l2cap_build_conf_rsp() (rsp changed its name to data) we access it
> like that:
> 	struct l2cap_conf_rsp *rsp =3D data;
>         void *ptr =3D rsp->data;
>=20
> I think whatever is going to be in ptr is from now on undefined, right?
> But maybe I'm just wrong and someone could help me out?!

I was wrong -- ptr is set some lines later. Everything should be fine
with it so far.

Martin



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
