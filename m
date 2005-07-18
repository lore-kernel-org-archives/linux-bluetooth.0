Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050718075432.27262.qmail@web15702.mail.cnb.yahoo.com>
From: =?gb2312?q?=C4=FE=20=C4=FE?= <gadfly_no@yahoo.com.cn>
To: bluez users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: [Bluez-users] Re:how to transmit hexadecimal data and voice?
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
Date: Mon, 18 Jul 2005 15:54:32 +0800 (CST)

Hi,
Thanks Marcel for your reply! And I have solved the
first problem,I created a rfcomm connection,and sent
data sucessfully! Thanks again!

However,I am still puzzled with then second
problem.What I did is as follows:
on platform A: 
$ rfcomm listen 0 1
Waiting for connection on channel 1

on platform B: 
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

Then ,I inserted a microphone into the MC145483 Codec
on platform B and spoken,but on platform A there was
no response from the Code's speaker! 
Please correct me if i"m wrong. Do I need to add some
services such as HS,HF,A2SRC and A2SNK?
Or maybe there is something wrong on the connection
between Bluetooth module's PCM interface and the
Motoral MC145483 Codec?

I am really confused now!

Regards

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
