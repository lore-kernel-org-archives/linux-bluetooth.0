Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60612151534u714d0533h828a70b5d0b432e7@mail.gmail.com>
Date: Fri, 15 Dec 2006 15:34:23 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] help with dund
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1552402040=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1552402040==
Content-Type: multipart/alternative;
	boundary="----=_Part_36953_15080828.1166225663797"

------=_Part_36953_15080828.1166225663797
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:  I am trying to get a device to talk to my linux host running bluez.
The device speaks AT command set, so I need dund to be enabled.  I can see a
command named dund but I don't see it being launched even though my hcid is
running.  I did 'sdptool add' both sp and dund.  When I do
/etc/init.d/bluetooth status,
I get, amount other things:

    rfcomm  (activated)
        pand   (unused)
        dund   (unused)

If I try to launch dund by hand, it would say "address already in use
--cannot bind".

I see online that some configs needed to say

   DUND_DAEMON  enabled

But I cannot quite figure out where to put that line or do I really need to
use that line.
Communication to/from that device is not running very smoothly.

Is there any good doc/guide on how to use (and program) dund profile to talk
to devices?

Thanks

Mark

------=_Part_36953_15080828.1166225663797
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi:&nbsp; I am trying to get a device to talk to my linux host running bluez.&nbsp; The device speaks AT command set, so I need dund to be enabled.&nbsp; I can see a command named dund but I don't see it being launched even though my hcid is running.&nbsp; I did 'sdptool add' both sp and dund.&nbsp; When I do /etc/init.d/bluetooth status,
<br>I get, amount other things:&nbsp; <br><br>&nbsp;&nbsp;&nbsp; rfcomm&nbsp; (activated)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pand&nbsp;&nbsp; (unused)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dund&nbsp;&nbsp; (unused)<br><br>If I try to launch dund by hand, it would say &quot;address already in use --cannot bind&quot;.
<br><br>I see online that some configs needed to say<br><br>&nbsp;&nbsp; DUND_DAEMON&nbsp; enabled<br><br>But I cannot quite figure out where to put that line or do I really need to use that line.&nbsp; <br>Communication to/from that device is not running very smoothly.
<br><br>Is there any good doc/guide on how to use (and program) dund profile to talk to devices?<br><br>Thanks<br><br>Mark<br>

------=_Part_36953_15080828.1166225663797--


--===============1552402040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1552402040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1552402040==--
