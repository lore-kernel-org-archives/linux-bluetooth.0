Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems while sending and receiving with rfcomm
	sockects
From: Marcel Holtmann <marcel@holtmann.org>
To: dsas@mega.ist.utl.pt
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1086102474.40bc9bca939eb@webmail.rnl.ist.utl.pt>
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>
	 <1086094054.1978.26.camel@fischer>
	 <1086102474.40bc9bca939eb@webmail.rnl.ist.utl.pt>
Content-Type: text/plain
Message-Id: <1086102999.4702.62.camel@pegasus>
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
Date: Tue, 01 Jun 2004 17:16:39 +0200

Hi Didier,

> When I execute 2 servers on masters side (one only sending and the other only
> receiving) using diferents rfcomm channels, I also receive corrupt data (very
> rarely :-( ). If they're both sending or receiving, everything works fine... I
> think it's possible to use semaphores to synchronize the 2 processes but I'd
> like to use a simpler solution or at least understand where the problem is.

if you are using two different RFCOMM channels and this happens it looks
like a bug in the kernel code. As I said, check the latest kernel and
try to send us a simple program that triggers this effect.

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
