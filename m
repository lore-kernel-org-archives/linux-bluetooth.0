Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <457EE1A3.5030700@siemens.com>
Date: Tue, 12 Dec 2006 18:06:43 +0100
From: Lukas Szemla <lukas.szemla@siemens.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] L2CAP: ECONNRESET
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi *,
I have a problem with BlueZ when used with openOBEX. I've implemented 
application for vCard receiving and every time the vCard is received, 
the error on L2CAP level is signalled. This error takes place after the 
vCard is sucessfully received (and no error on OBEX level is signaled to 
me).

The error is ECONNRESET and is a result of
l2cap_chan_del(sk, ECONNRESET) call
in
l2cap_disconnect_req
This is called from l2cap_sig_channel after device sent 
L2CAP_DISCONN_REQ on 0x001 CID channel.

My question is why is the l2cap_chan_del(sk, ECONNRESET) is hard-wired 
in L2CAP_DISCONN_REQ request handling? Where is the problem and how can 
I get rid of it (on the OBEX level)? Should I never get 
L2CAP_DISCONN_REQ in normal operation mode?
I've tried several devices with the same result. My openOBEX is of 1.3, 
kernel 2.4.31 official one. I run the application on MIPS.

I've added some traces in the kernel and I can post it here if somebody 
finds this useful. I haven't done it now since this is a lot of bloody 
stuff that is not the official one.

Any hint is greatly welcomed.
Thanks in advance!

-- 
Best regards.

LS.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
