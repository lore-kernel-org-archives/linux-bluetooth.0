Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] absolute clock
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: paolo2278@freemail.it,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <406AB277.2030503@csr.com>
References: <20040331104607.18049.qmail@mail.supereva.it>
	 <406AB277.2030503@csr.com>
Content-Type: text/plain
Message-Id: <1080735266.2674.88.camel@pegasus>
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
Date: Wed, 31 Mar 2004 14:14:26 +0200

Hi Steven,

> If you have access to the CSR support website (www.csrsupport.com) then
> it's all fully documented. Don't forget that you may need to tunnel the
> commands over HCI. Alternatively, you might find it easier to dig through
> the BlueZ source and find out where it sends the commands to change the
> uart baud rate - that should give you a good example to work from.

the better example code will be in utils/tools/csr.[ch].

> I can't recall if BlueZ has a tool that allows you to send arbitrary
> BCCMDs to CSR chips - if not, it sounds like a good project for
> someone.

A program like btcli don't exists for Linux.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
