Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth/gprs problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Marian Gasparovic <marosg@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040423081254.81987.qmail@web20421.mail.yahoo.com>
References: <20040423081254.81987.qmail@web20421.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1082985281.28880.151.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 26 Apr 2004 15:14:41 +0200

Hi Marian,

> now it is very strange waht I see. First I tried some
> experiments with uhci, uhci(je) and ohci, nothing
> helped. Then I tried hcidump -w and I was able to surf
> half an hour without a problem !!! Then I restarted a
> computer, surfing worked, but I was aborted after
> several minutes. Now I have hcidump output I hope you
> will find something there. And another thing - when I
> restart my notebook, I have to restart bluez-utils and
> bluez-sdp before I can connect, otherwise pppd doesn't
> connect with /dev/rfcomm0:connection refused. I even
> attach my ppp chatscript and peer config files.

after getting the full dump the important part is this

	> ACL data: handle 0x0006 flags 0x01 dlen 10
	    L2CAP(d): cid 0x40 len 329 [psm 3]
	      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 323 fcs 0x5c 
	> HCI Event: Disconn Complete(0x05) plen 4
	  00 06 00 22 

It is not a PPP error, because the remote device (your phone)
disconnects the ACL link with "LMP Response Timeout" error. Actually
this is because the Broadcom dongle has a buggy link manager or your
phone needs a firmware update. However this is a firmware problem in one
of your two device and we can actually do nothing to fix it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
