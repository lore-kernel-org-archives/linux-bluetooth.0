Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Franck Arnaud" <franck@nenie.org>
To: bluez-devel@lists.sourceforge.net
Message-Id: <45540213.2004.5.22.14.5.39.99703@mem.nenie.org>
Subject: [Bluez-devel] hidp 2.4 backport
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
Date: 22 May 2004 14:05:39 GMT

Hello,

I have an epox (CSR) bluetooth mouse and I'm using kernel 2.4. I 
tried bthid 0.10, which worked fine initially but I could not make 
it handle reconnections (after a long enough timeout, clicking 
the mouse just after the disconnection message seems to 
reconnect OK). This looks like the problem described in the doc, 
although the solution (pinging the mouse to keep it awake) is 
not acceptable.

It would be a pain at this time to upgrade to 2.6 in my setup, so 
I backported the 2.6.6-mh1 hidp module to 2.4:

http://www.nenie.org/misc/bluetooth/bluez-hidp-backport-2.4-26.tar.gz

it may be broken as I don't know anything about kernel 
programming :-) but it seems to work fine, except it seems you 
need the -t timeout option on hidd, otherwise it fails like with 
bthid (I do not understand why).

It may not be worth applying to the official 2.4 patches as I 
guess most people can upgrade to 2.6 more easily than me.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
