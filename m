Return-Path: <cyrus@holtmann.org>
Message-ID: <87589ef80806140525v4145ba3ja0c0b314a17bbadf@mail.gmail.com>
Date: Sat, 14 Jun 2008 09:25:18 -0300
From: "Carlos Jose Mazieri" <carlos.mazieri@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] reaching LAN from a mobile
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0709955655=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0709955655==
Content-Type: multipart/alternative;
	boundary="----=_Part_199_30889280.1213446318648"

------=_Part_199_30889280.1213446318648
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I'd like to reach my LAN from a Sony Ericsson K750,  it has PAN Access Point
service

May I use PAN method with pand --connect ?
I have done this and I could not reach my LAN

Does anyone can help me ?

Thanks in advance,
Carlos Jose Mazieri

Some of services from my K750:

kurumin@kurumingrub:~$ sudo sdptool browse 00:1B:59:AC:11:FB

Service Name: Dial-up Networking
Service RecHandle: 0x10002
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Service Name: PAN Network Access Point
Service Description: NAP provides access to internet for one connecting PANu
Service RecHandle: 0x10008
Service Class ID List:
  "Network Access Point" (0x1116)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 15
  "BNEP" (0x000f)
    Version: 0x0100
    SEQ8: 0 6 dd
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Network Access Point" (0x1116)
    Version: 0x0100

------=_Part_199_30889280.1213446318648
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>I&#39;d like to reach my LAN from a Sony Ericsson K750,&nbsp; it has PAN Access Point service<br><br>May I use PAN method with pand --connect ? <br>I have done this and I could not reach my LAN<br><br>Does anyone can help me ? <br>
<br>Thanks in advance,<br>Carlos Jose Mazieri<br><br>Some of services from my K750:<br><br><div style="margin-left: 80px;">kurumin@kurumingrub:~$ sudo sdptool browse 00:1B:59:AC:11:FB<br><br>Service Name: Dial-up Networking<br>
Service RecHandle: 0x10002<br>Service Class ID List:<br>&nbsp; &quot;Dialup Networking&quot; (0x1103)<br>&nbsp; &quot;Generic Networking&quot; (0x1201)<br>Protocol Descriptor List:<br>&nbsp; &quot;L2CAP&quot; (0x0100)<br>&nbsp; &quot;RFCOMM&quot; (0x0003)<br>
&nbsp;&nbsp;&nbsp; Channel: 2<br>Profile Descriptor List:<br>&nbsp; &quot;Dialup Networking&quot; (0x1103)<br>&nbsp;&nbsp;&nbsp; Version: 0x0100<br><br>Service Name: PAN Network Access Point<br>Service Description: NAP provides access to internet for one connecting PANu<br>
Service RecHandle: 0x10008<br>Service Class ID List:<br>&nbsp; &quot;Network Access Point&quot; (0x1116)<br>Protocol Descriptor List:<br>&nbsp; &quot;L2CAP&quot; (0x0100)<br>&nbsp;&nbsp;&nbsp; PSM: 15<br>&nbsp; &quot;BNEP&quot; (0x000f)<br>&nbsp;&nbsp;&nbsp; Version: 0x0100<br>
&nbsp;&nbsp;&nbsp; SEQ8: 0 6 dd<br>Language Base Attr List:<br>&nbsp; code_ISO639: 0x656e<br>&nbsp; encoding:&nbsp;&nbsp;&nbsp; 0x6a<br>&nbsp; base_offset: 0x100<br>Profile Descriptor List:<br>&nbsp; &quot;Network Access Point&quot; (0x1116)<br>&nbsp;&nbsp;&nbsp; Version: 0x0100<br></div>
<br>

------=_Part_199_30889280.1213446318648--


--===============0709955655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0709955655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0709955655==--
