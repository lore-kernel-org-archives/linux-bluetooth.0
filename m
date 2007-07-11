Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: George Hansel <ghansel@MIT.EDU>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Wed, 11 Jul 2007 16:11:03 -0400
Message-Id: <1184184663.6062.30.camel@Epimenides>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Handling simultaneous SCO connections: Does	BlueZ
	have multiple SCO
Reply-To: ghansel@MIT.EDU,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0510838010=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0510838010==
Content-Type: multipart/alternative; boundary="=-CIXCBKbE+f/Art9ww6Ek"


--=-CIXCBKbE+f/Art9ww6Ek
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

It was my fault. I was binding the port without specifying a local
adapter - don't do that.

Problem solved. I'm very happy not to have to go into the kernel.

George

--=-CIXCBKbE+f/Art9ww6Ek
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.14.1">
</HEAD>
<BODY>
It was my fault. I was binding the port without specifying a local adapter - don't do that.<BR>
<BR>
Problem solved. I'm very happy not to have to go into the kernel.<BR>
<BR>
George
</BODY>
</HTML>

--=-CIXCBKbE+f/Art9ww6Ek--



--===============0510838010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0510838010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0510838010==--
