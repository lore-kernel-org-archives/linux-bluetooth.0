Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 15:01:33 +0100
From: Miguel <mc354@tid.es>
In-reply-to: <80662.65756.qm@web8404.mail.in.yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1201615293.14284.39.camel@McM>
MIME-version: 1.0
References: <80662.65756.qm@web8404.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Permission denied
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1021359076=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1021359076==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_ZQ9V5eZ7g5GakiSelqgucw)"


--Boundary_(ID_ZQ9V5eZ7g5GakiSelqgucw)
Content-type: text/plain
Content-transfer-encoding: 7BIT

you have to release the port

rfcomm release 0

and then connect again

On Tue, 2008-01-29 at 19:25 +0530, pramod gurav wrote:

> for HS BT device on my system it shows an error
> [Pramod@localhost ~]$ sudo rfcomm connect 0 00:0F:DE:B1:02:42
> Can't create RFCOMM TTY: Address already in use 

--Boundary_(ID_ZQ9V5eZ7g5GakiSelqgucw)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.14.1">
</HEAD>
<BODY>
you have to release the port<BR>
<BR>
rfcomm release 0<BR>
<BR>
and then connect again<BR>
<BR>
On Tue, 2008-01-29 at 19:25 +0530, pramod gurav wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">for HS BT device on my system it shows an error</FONT><BR>
    <FONT COLOR="#000000">[Pramod@localhost ~]$ sudo rfcomm connect 0 00:0F:DE:B1:02:42</FONT><BR>
    <FONT COLOR="#000000">Can't create RFCOMM TTY: Address already in use </FONT>
</BLOCKQUOTE>
</BODY>
</HTML>

--Boundary_(ID_ZQ9V5eZ7g5GakiSelqgucw)--


--===============1021359076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1021359076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1021359076==--
