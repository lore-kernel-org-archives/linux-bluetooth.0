Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 15 Nov 2006 23:51:35 +0100
From: Michel Leconte <leconte.michel@cegetel.net>
To: bluez-users@lists.sourceforge.net
Message-id: <009e01c70908$9ab526a0$8ba54256@claudia>
MIME-version: 1.0
Subject: [Bluez-users] Signification of the state term
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0606832333=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0606832333==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_ZXJI9vByTugHR6QzqNIZnw)"

This is a multi-part message in MIME format.

--Boundary_(ID_ZXJI9vByTugHR6QzqNIZnw)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT

Hi all,

I search the signification of the "state" term given for each connection
by the "hcitool con" command.


1. First, I have an ACL connection between 2 bluetooth kits    : the state of the ACL connection is 1

2. I create an SCO connection on this ACL connection           :  the state of the ACL connection stills 1

3. I make an HCI_disconnect on one side of the connection.     

With hcidump, after the HCI_disconnect command, I see consecutively two events of  complete deconnection :

- the first one  for the SCO link,
- the second one for the ACL link.

But, the "hcitool con" command shows again the ACL connection with 8 value for the "state".

When I try to disconnect this link I have a disconnect error.

Does someone have an idea ? What is the signification of a 8 value for the "state" ?

regards.

Michel  

 


--Boundary_(ID_ZXJI9vByTugHR6QzqNIZnw)
Content-type: text/html; charset=iso-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT face=Arial size=2>Hi all,</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>I search the signification of the "state" term 
given for each connection</FONT></DIV>
<DIV><FONT face=Arial size=2>by the "hcitool con" command.</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>1. First, I have an ACL connection between 2 
bluetooth kits&nbsp;&nbsp;&nbsp; : the state of the ACL&nbsp;connection is 
1</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>2. I create an SCO connection on&nbsp;this ACL 
connection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;the 
state of the ACL&nbsp;connection&nbsp;stills 1</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>3. I make an HCI_disconnect on one side of the 
connection.&nbsp;&nbsp;&nbsp;&nbsp; </FONT><FONT face=Arial size=2></FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>With hcidump, after the HCI_disconnect command, I 
see consecutively two events of&nbsp; complete deconnection :</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>- the first one &nbsp;for the SCO 
link,</FONT></DIV>
<DIV><FONT face=Arial size=2>- the second one for the 
ACL&nbsp;link.</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>But, the "hcitool con" command&nbsp;shows again the 
ACL connection with 8 value for the "state".</FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>When I try to disconnect this&nbsp;link I have a 
disconnect error.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>Does someone have an idea ? What is the 
signification of a 8 value for the "state" ?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>regards.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>Michel</FONT>&nbsp;&nbsp;</DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

--Boundary_(ID_ZXJI9vByTugHR6QzqNIZnw)--


--===============0606832333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0606832333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0606832333==--
