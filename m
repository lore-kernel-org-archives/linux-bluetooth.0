Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050801014906.16001.qmail@web15703.mail.cnb.yahoo.com>
From: =?gb2312?q?=C4=FE=20=C4=FE?= <gadfly_no@yahoo.com.cn>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: [Bluez-devel] Re:How can I set CSR module as PCM master?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 1 Aug 2005 09:49:06 +0800 (CST)

Hi,Steven
thanks for your help!
I connected bluecore2 module and MC145483 like this:

    bluecor2               MC145483
   PCM_OUT <-----------> PCM_IN
   PCM_IN   <-----------> PCM_OUT
   PCM_CLK <-----------> PCM_CLK
   PCM_SYNC <-----------> PCM_SYNC

Is that right?

And I try to transmit vocie like this:
 
 on PC A: 
  $ rfcomm listen 0 5&
  Waiting for connection on channel 5
  $ scotest -r
  scotest[114]: Waiting for connection ...
 
  on PC B:
  $ hstest play wrong.mp3 4A:49:4E:00:15:2F 5
   Voice setting: 0x0060
   RFCOMM channel connected
   SCO audio channel connected (handle 44, mtu 64)
 
 then, on PC A, I recieve :
   scotest[87]: Connect from 4A:49:4E:00:15:2D [handle
 45, class        0x000000]
   scotest[87]: Receiving ...
   scotest[87]: 728 bytes in 0.00m speed 4.43 kb
   scotest[87]: 728 bytes in 0.00m speed 4.55 kb
   scotest[87]: 728 bytes in 0.00m speed 4.55 kb 
    ......
Then ,I can"t hear anything from the speaker of
 MC145483 Codec on PC A!
How do you transmit voice? what's your steps? what's
your program?

Thanks in advance!

Regards
gadfly



__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
