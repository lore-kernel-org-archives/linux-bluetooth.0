Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Olivier Dole <olivier.dole@palmsource.com>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 03 Jul 2006 16:44:19 +0200
Message-Id: <1151937859.8418.26.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-devel] PAN Profile: NAP & GN at the same time ???
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1084961427=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1084961427==
Content-Type: multipart/alternative; boundary="=-9J/vP/lr1WU9uFmC/Pm9"


--=-9J/vP/lr1WU9uFmC/Pm9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I wonder wether it is possible or not to have a bluetooth device which
manages a NAP and a GN connection at the same time.
If we consider BlueZ implementation, it is not possible:

pand --listen --role NAP -n
pand[10750]: Bluetooth PAN daemon version 2.20
pand[10750]: Bind failed. Address already in use(98)

And it is a normal behaviour when we consider that NAP & GN both use
BNEP so PSM=0x0F=15.
I also have a look at Bluetooth and PAN profile specs and nothing seems
to prevent us from doing such a thing.
So my question is: does PSM aspect imply that it is not possible to
manage 2 master services at the same time or is there solution to do
that ???

Regards,

Olivier



--=-9J/vP/lr1WU9uFmC/Pm9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.8.1">
</HEAD>
<BODY>
Hello,<BR>
<BR>
I wonder wether it is possible or not to have a bluetooth device which manages a NAP and a GN connection at the same time.<BR>
If we consider BlueZ implementation, it is not possible:
<PRE>
pand --listen --role NAP -n
pand[10750]: Bluetooth PAN daemon version 2.20
pand[10750]: Bind failed. Address already in use(98)
</PRE>
And it is a normal behaviour when we consider that NAP &amp; GN both use BNEP so PSM=0x0F=15.<BR>
I also have a look at Bluetooth and PAN profile specs and nothing seems to prevent us from doing such a thing.<BR>
So my question is: does PSM aspect imply that it is not possible to manage 2 master services at the same time or is there solution to do that ???<BR>
<BR>
Regards,<BR>
<BR>
Olivier
<PRE>

</PRE>
</BODY>
</HTML>

--=-9J/vP/lr1WU9uFmC/Pm9--



--===============1084961427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1084961427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1084961427==--
