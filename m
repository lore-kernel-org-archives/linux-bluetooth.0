Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Wang Haiguang <wanghg@i2r.a-star.edu.sg>
In-reply-to: <1085473805.27156.219.camel@imladris.demon.co.uk>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Message-id: <LMEOKMJFKNFFHEAEDGDEKEEECHAA.wanghg@i2r.a-star.edu.sg>
MIME-version: 1.0
Content-type: text/plain; charset=gb2312
Subject: [Bluez-devel] Some question on flush timeout at L2CAP.
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
Date: Tue, 25 May 2004 19:29:13 +0800

Hi, all.

I saw there is a parameter for the flush timeout in L2CAP. 

It is defiened in the ..../include/net/bluetooth/l2cap.h as follows:

#define L2CAP_DEFAULT_FLUSH_TO 0xFFFF

and in the l2cap.c line 323 the value is assigned to some socket
variable as follows:

pi->flush_to = L2CAP_DEFAULT_FLUSH_TO.

What is the function of this variable "flush_to"?

Is it used to flush the L2CAP Packet after timeout? Where is this
value used?

I searched through the source code and find no timer related to it. 

And also, does anybody knows what are the value of the 
"flush timeout" value of the baseband and can it be configured through
hciconfig command?

Thanks.

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
