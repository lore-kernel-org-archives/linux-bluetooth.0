Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems while sending and receiving with rfcomm
	sockects
From: Marcel Holtmann <marcel@holtmann.org>
To: dsas@mega.ist.utl.pt
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>
References: <1086088581.40bc65850efcf@webmail.rnl.ist.utl.pt>
Content-Type: text/plain
Message-Id: <1086093267.4702.20.camel@pegasus>
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
Date: Tue, 01 Jun 2004 14:34:27 +0200

Hi Didier,

> I'm writting a server-client application over bluez using rfcomm sockets. I've
> created two threads: one for sending and the other for receiving. The problem
> occurs sometimes (sporadical) and only when I'm sending and receiving data at
> the same time: The received data seems to be corrupt... Do I have to use
> mutexes or other synchronizing method? The error ocurrs more often if I execute
> more than one server at the same time.

I never used RFCOMM in a multi-threaded program. Actually I avoid to use
threads wherever possible. However sending and receiving at the same
time should work. Maybe there is a kernel bug, what version do you use?

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
