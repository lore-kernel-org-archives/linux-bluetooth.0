Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Wang Haiguang <wanghg@i2r.a-star.edu.sg>
To: bluez-devel@lists.sourceforge.net
Message-id: <LMEOKMJFKNFFHEAEDGDEKEKNCGAA.wanghg@i2r.a-star.edu.sg>
MIME-version: 1.0
Content-type: text/plain; charset=gb2312
Subject: [Bluez-devel] Question about baseband configuration.
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
Date: Wed, 05 May 2004 10:46:09 +0800

Hi, all.

I have some questions about the baseband configuration. 

In our development, we want the baseband to delivery packet with
bit errors to the L2CAP. 

After reading the Baseband specification, we found there are 7 packet
types for ACL connection in Baseband level -- DM1, DM3, DM5, DH1, 
DH3, DH5 and AUX1. The first 6 has 16 bit CRC for payload. 

My question is: 

Is it possible to disable the CRC check for payload at the receiver side 
through the some configuration command so that the IP packet with bit 
errors could be passed to L2CAP? 

Thanks a lot.

BR

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
