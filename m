Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 23 Nov 2006 22:54:46 +0100
From: Michel Leconte <leconte.michel@cegetel.net>
To: bluez-users@lists.sourceforge.net
Message-id: <003901c70f49$fe158180$27b44856@claudia>
MIME-version: 1.0
Subject: [Bluez-users] Bad disconnection in a PAN network after an SCO link
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0342212119=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0342212119==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_qXWiuJvYXAp50KwGmXkf0A)"

This is a multi-part message in MIME format.

--Boundary_(ID_qXWiuJvYXAp50KwGmXkf0A)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT

Hi all,

I resend you this mail that could'nt be seen in the list. 
I have a problem of disconnection in a PAN network 
when an SCO link is establised before the disconnection of two entities.

Topology of the network : One Bluetooth kit is GN (configured in master) the other one is PANU (configured in slave), these two entities constitute a Bluetooth IP network (using Bnep interfaces and PAN daemons).


First test : 
----------
The PANU wish to make a disconnection with the GN, it applies a bnep_kill_connection().
With hcidump, one can see a disconnection complete event. 
Then with "hcitool con" command, we don't see any ACL connection.  

Second test : 
----------

The PANU and the GN establish an SCO connection on the ACL link.
The PANU wishes to make a disconnection with the GN, it applies a bnep_kill_connection().
With hcidump, one can see two disconnection complete events. 
The first one for the SCO connection the second one for the ACL link.

In despite of these two deconnection events, the "hcitool con" command
shows always an ACL connection with a state 8. These state value corresponds to a
disconnection state. My goal is to have a real complete disconnection of the link as
in the first test.

Does anyone has an idea to fully disconnect these link without seeing it with the "hcitool con" 
command ?  

How a link can be in a disconnection state and always visible with these later command ?


thanks for any idea or suggestion.

regards.

Michel

--Boundary_(ID_qXWiuJvYXAp50KwGmXkf0A)
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
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>I resend you this mail that could'nt be seen in the 
list. <BR>I have a problem of disconnection in a PAN network <BR>when an SCO 
link is establised before the disconnection of two entities.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=Arial size=2>Topology of the network : One Bluetooth kit is GN 
(configured in master) the other one is PANU (configured in slave), these two 
entities constitute a Bluetooth IP network (using Bnep interfaces and PAN 
daemons).</FONT></DIV>
<DIV>&nbsp;</DIV><FONT face=Arial size=2>
<DIV><BR>First test : <BR>----------<BR>The PANU wish to make a disconnection 
with the GN, it applies a bnep_kill_connection().<BR>With hcidump, one can see a 
disconnection complete event. <BR>Then with "hcitool con" command, we don't see 
any ACL connection.&nbsp; </DIV>
<DIV>&nbsp;</DIV>
<DIV>Second test : <BR>----------</DIV>
<DIV>&nbsp;</DIV>
<DIV>The PANU and the GN establish an SCO connection on the ACL link.<BR>The 
PANU wishes to make a disconnection with the GN, it applies a 
bnep_kill_connection().<BR>With hcidump, one can see two disconnection complete 
events. <BR>The first one for the SCO connection the second one for the ACL 
link.</DIV>
<DIV>&nbsp;</DIV>
<DIV>In despite of these two deconnection events, the "hcitool con" 
command<BR>shows always an ACL connection with a state 8. These state value 
corresponds to a<BR>disconnection state. My goal is to have a real complete 
disconnection of the link as<BR>in the first test.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Does anyone has an idea to fully disconnect these link without seeing it 
with the "hcitool con" <BR>command ?&nbsp; </DIV>
<DIV>&nbsp;</DIV>
<DIV>How a link can be in a disconnection state and always visible with these 
later command ?</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR>thanks for any idea or suggestion.</DIV>
<DIV>&nbsp;</DIV>
<DIV>regards.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Michel<BR></DIV></FONT></BODY></HTML>

--Boundary_(ID_qXWiuJvYXAp50KwGmXkf0A)--


--===============0342212119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0342212119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0342212119==--
