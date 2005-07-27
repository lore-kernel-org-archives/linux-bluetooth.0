Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20050727090711.69181.qmail@web15702.mail.cnb.yahoo.com>
From: =?gb2312?q?=C4=FE=20=C4=FE?= <gadfly_no@yahoo.com.cn>
To: bluez-devel <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1588875591-1122455231=:68710"
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
Date: Wed, 27 Jul 2005 17:07:11 +0800 (CST)

--0-1588875591-1122455231=:68710
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi,
thanks Steven and Peter.
I have no other PS tools except pskey,so I cann't set PSKEY PCM_CONFIG32.  
 And if the module's default is PCM master,it should generate clock and sync,but it don't ,so the MC145483 doesn't work! I didn't change other settings except PCM map using "pskey -i hci0 mapsco 1"! The Codec's sample format is 13-bit,but the CSR module's is 16-bit, is that the matter?
If not,what's wrong?
 
regards
gadfly

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
--0-1588875591-1122455231=:68710
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<DIV>Hi,</DIV>
<DIV>thanks Steven and Peter.</DIV>
<DIV>I have no other PS tools except pskey,so I cann't set PSKEY PCM_CONFIG32.&nbsp;&nbsp;<BR> And&nbsp;if&nbsp;the module's&nbsp;default is PCM master,it should generate clock and sync,but&nbsp;it don't&nbsp;,so the&nbsp;MC145483 doesn't work! I didn't change other settings except PCM map using "pskey -i hci0 mapsco&nbsp;1"! The Codec's sample format is 13-bit,but the CSR module's is 16-bit, is that the matter?</DIV>
<DIV>If not,what's wrong?</DIV>
<DIV>&nbsp;</DIV>
<DIV>regards</DIV>
<DIV>gadfly</DIV><p>__________________________________________________<br>∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?<br>http://cn.mail.yahoo.com
--0-1588875591-1122455231=:68710--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
