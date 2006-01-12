Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Martin =?ISO-8859-1?Q?R=F6hricht?= <ml@felicis.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Message-Id: <1137082576.20029.8.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] possible minor bug in l2cap.c
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
Date: Thu, 12 Jan 2006 17:16:15 +0100

Hello together,

I was wondering if there is an uninitialised variable in use:
In function l2cap_config_req() we declare =C2=BBu8 rsp[64];=C2=AB and call =
it only
twice:
	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
		l2cap_build_conf_rsp(sk, rsp, NULL), rsp);
	l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
		l2cap_build_conf_rsp(sk, rsp, &result), rsp);

In l2cap_build_conf_rsp() (rsp changed its name to data) we access it
like that:
	struct l2cap_conf_rsp *rsp =3D data;
        void *ptr =3D rsp->data;

I think whatever is going to be in ptr is from now on undefined, right?
But maybe I'm just wrong and someone could help me out?!

Martin



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
