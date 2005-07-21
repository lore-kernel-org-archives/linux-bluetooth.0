Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050721092539.76952.qmail@web15706.mail.cnb.yahoo.com>
From: =?gb2312?q?=C4=FE=20=C4=FE?= <gadfly_no@yahoo.com.cn>
To: bluez users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: [Bluez-users] Can I use headset tools such as hstest in this case?
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
Date: Thu, 21 Jul 2005 17:25:38 +0800 (CST)

My case is as fllows:
I use two CSR(Bluecore2) modlues on two arm platforms
respectively ,what I want to do is that I can use
bluez stack on arm platform sucessfully.And now,I can
create ACL and SCO connection,both l2test and scotest
run well.Even,I can transmit files using the program
obex_test.
 I just want to transmit voice data through bluetooth
modules so that I can talk with others using
microphone.And I connected a MC145483 Codes(13-bit
Line ) throught PCM interface.

What I did is as follows:
 on platform A: 
 $ rfcomm listen 0 5&
 Waiting for connection on channel 5
 $ scotest -r
 scotest[114]: Waiting for connection ...

 on platform B:
 $ hstest play wrong.mp3 4A:49:4E:00:15:2F 5
  Voice setting: 0x0060
  RFCOMM channel connected
  SCO audio channel connected (handle 44, mtu 64)

then, on platform A, I recieve :
  scotest[87]: Connect from 4A:49:4E:00:15:2D [handle
45, class        0x000000]
  scotest[87]: Receiving ...
  scotest[87]: 728 bytes in 0.00m speed 4.43 kb
  scotest[87]: 728 bytes in 0.00m speed 4.55 kb
  scotest[87]: 728 bytes in 0.00m speed 4.55 kb 
 ......
Then ,I can't hear anything from the speaker of
MC145483 Codec on platform A!

If try hsmicro on platform B:
 $ hsmicro 4A:49:4E:00:15:2F 1
 -t: No such file or directory
 Voice setting: 0x0060
 RFCOMM channel connected
 SCO audio channel connected (handle 44, mtu 64)
 R
 I
 N
 G                                                  
                                                      
                                                      
                                                  
 O                                                    
                                                      
  
 K
                                                      

                                                      
  
 O
 K                                                    
                                                      
                     
  ....
 on platform A,receive the same message as above !

And ,A and B can't change role each other, if A send
and B listen,then B can't recieve anything!
 
 Please correct me if i"m wrong. I wonder if I can use
headset profile or not! after all, my hardware is just
bluetooth module instead of Headset!
 Or maybe there is something wrong on the connection
 between Bluetooth module"s PCM interface and the
 Motoral MC145483 Codec? This Codec is a 13-bit line
PCM Codec, maybe the voice data format is wrong ?

[\u@\h \W]\$ hciconfig hci0 version revision
 hci0:   Type: UART
         BD Address: 4A:49:4E:00:15:2D ACL MTU: 384:4
SCO MTU: 64:8
         HCI Ver: 1.1 (0x1) HCI Rev: 0x2c1 LMP Ver:
1.1 (0x1) LMP Subver: 0x2c1
         Manufacturer: Cambridge Silicon Radio (10)
         Build 705
         Chip version: BlueCore02-External
         Max key size: 56 bit
         SCO mapping:  PCM

your replay is always welcome!

regards
gadfly


	

	
		
___________________________________________________________ 
—≈ª¢√‚∑—G” œ‰£≠÷–π˙µ⁄“ªæ¯Œﬁ¿¨ª¯” º˛…ß»≈≥¨¥Û” œ‰
http://cn.mail.yahoo.com/?id=77071



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
