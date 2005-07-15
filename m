Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050715064552.34058.qmail@web15701.mail.cnb.yahoo.com>
From: =?gb2312?q?=C4=FE=20=C4=FE?= <gadfly_no@yahoo.com.cn>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-698783991-1121409952=:33368"
Subject: [Bluez-users] how to transmit hexadecimal data and voice?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 15 Jul 2005 14:45:52 +0800 (CST)

--0-698783991-1121409952=:33368
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

My case is as fllows:
I use two CSR(Bluecore2) modlues on two arm platforms respectively . And now,I can create ACL and SCO connection£¨both l2test and scotest run well.Even,I can transmit files using the program obex_test.
But still,
1>I don't know how to transmit acl data such as hexadecimal data. Can I use "hcitool cmd"??If I can,what is the hci command?
2>I just want to transmit voice data through bluetooth modules so that I can talk with others using microphone.And I connected a MC145483 Codes throught PCM interface yesterady.But I have no idea about how to do now.which profile should I use? sdptool add Headset?I think it's not the right one! And if I add the right profile,what should I do next?? Maybe some tools just like btsco?
 
[\u@\h \W]\$ hciconfig hci0 version revision
hci0:   Type: UART
        BD Address: 4A:49:4E:00:15:2D ACL MTU: 384:4 SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x2c1 LMP Ver: 1.1 (0x1) LMP Subver: 0x2c1
        Manufacturer: Cambridge Silicon Radio (10)
        Build 705
        Chip version: BlueCore02-External
        Max key size: 56 bit
        SCO mapping:  PCM
 
I'll appreciate your help! 

		
---------------------------------
DO YOU YAHOO!?
  —≈ª¢√‚∑—G” œ‰£≠÷–π˙µ⁄“ªæ¯Œﬁ¿¨ª¯” º˛…ß»≈≥¨¥Û” œ‰ 
--0-698783991-1121409952=:33368
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>My case is as fllows:<BR>I use two CSR(Bluecore2) modlues on two arm platforms respectively . And now,I can create ACL and SCO connection£¨both l2test and scotest run well.Even,I can transmit files using the program obex_test.<BR>But still,<BR>1&gt;I don't know how to transmit acl data such as hexadecimal data. Can I use "hcitool cmd"??If I can,what is the hci command?<BR>2&gt;I just want to transmit voice data through bluetooth modules so that I can talk with others using microphone.And I connected a MC145483 Codes throught PCM interface yesterady.But I have no idea about how to do now.which profile should I use? sdptool add Headset?I think it's not the right one! And if I add the right profile,what should I do next?? Maybe some tools just like btsco?</DIV>
<DIV>&nbsp;</DIV>
<DIV>[\u@\h \W]\$ hciconfig hci0 version revision<BR>hci0:&nbsp;&nbsp; Type: UART<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 4A:49:4E:00:15:2D ACL MTU: 384:4 SCO MTU: 64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x2c1 LMP Ver: 1.1 (0x1) LMP Subver: 0x2c1<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Build 705<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Chip version: BlueCore02-External<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Max key size: 56 bit<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SCO mapping:&nbsp; PCM</DIV>
<DIV>&nbsp;</DIV>
<DIV>I'll appreciate your help! </DIV><p>
		<hr size=1>DO YOU YAHOO!?<br> 
<a href="http://cn.mail.yahoo.com/?id=77071" target=blank> 
—≈ª¢√‚∑—G” œ‰£≠÷–π˙µ⁄“ªæ¯Œﬁ¿¨ª¯” º˛…ß»≈≥¨¥Û” œ‰</a> 
--0-698783991-1121409952=:33368--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
