Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Wang Haiguang <wanghg@i2r.a-star.edu.sg>
In-reply-to: <1085489942.900.89.camel@fischer>
To: BlueZ-devel List <bluez-devel@lists.sourceforge.net>
Message-id: <LMEOKMJFKNFFHEAEDGDEAEEGCHAA.wanghg@i2r.a-star.edu.sg>
MIME-version: 1.0
Content-type: text/plain; charset=gb2312
Subject: [Bluez-devel] Flush timeout at Baseband
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 25 May 2004 21:32:04 +0800

Hi, all.

It seems that the current implementaion of "hciconfig" does not support the
"flush timeout" configuration for ACL data. 

Is there any plan on it as it is important for the real-time traffic?. 

According to the specification, the default value is infinite. 

Best regards.

Haiguang 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
