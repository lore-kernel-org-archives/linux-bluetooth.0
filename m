Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60609211230m6333bca7x4778a76f23bfbc8a@mail.gmail.com>
Date: Thu, 21 Sep 2006 12:30:25 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] RFCOMM error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1233041007=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1233041007==
Content-Type: multipart/alternative;
	boundary="----=_Part_15066_6915187.1158867025916"

------=_Part_15066_6915187.1158867025916
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:

I have a an RFCOMM server process listening on one box.  From a Linux
laptop,
I just wrote a simple RFCOMM client to connect to it.  Very simple, via
AF_BLUETOOTH, SOCK_SEQPACKET and
BTPROTO_RFCOMM.

I got back errno as Bad File Descriptor.  When I strace it, I saw this line:

   socket(PF_BLUETOOTH, SOCK_SEQPACKET, 3) = -1  ESOCKTNOSUPPORT (Socket
type not supported).

What does that mean?  Did I construct the socket wrong?

thanks

Mark

------=_Part_15066_6915187.1158867025916
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&nbsp;</div>
<div>Hi:</div>
<div>&nbsp;</div>
<div>I have a an RFCOMM server process listening on one box.&nbsp; From a Linux laptop,</div>
<div>I just wrote a simple RFCOMM client to connect to it.&nbsp; Very simple, via AF_BLUETOOTH, SOCK_SEQPACKET and</div>
<div>BTPROTO_RFCOMM.</div>
<div>&nbsp;</div>
<div>I got back errno as Bad File Descriptor.&nbsp; When I strace it, I saw this line:</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; socket(PF_BLUETOOTH, SOCK_SEQPACKET, 3) = -1&nbsp; ESOCKTNOSUPPORT (Socket type not supported).</div>
<div>&nbsp;</div>
<div>What does that mean?&nbsp; Did I construct the socket wrong?</div>
<div>&nbsp;</div>
<div>thanks</div>
<div>&nbsp;</div>
<div>Mark</div>

------=_Part_15066_6915187.1158867025916--


--===============1233041007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1233041007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1233041007==--
