Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Flush timeout at Baseband
From: Marcel Holtmann <marcel@holtmann.org>
To: Wang Haiguang <wanghg@i2r.a-star.edu.sg>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LMEOKMJFKNFFHEAEDGDEAEEGCHAA.wanghg@i2r.a-star.edu.sg>
References: <LMEOKMJFKNFFHEAEDGDEAEEGCHAA.wanghg@i2r.a-star.edu.sg>
Content-Type: text/plain
Message-Id: <1085492577.9779.125.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 25 May 2004 15:42:57 +0200

Hi Haiguang,

> It seems that the current implementaion of "hciconfig" does not support the
> "flush timeout" configuration for ACL data. 
> 
> Is there any plan on it as it is important for the real-time traffic?. 
> 
> According to the specification, the default value is infinite. 

I don't had a need to touch the flush timeout value. About what HCI
command to modify the flush timeout are you talking? If you talk about
QoS then there is room in our code to fill.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
