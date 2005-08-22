Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BCCMD Test Command "memory"
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4309DF55.3010106@hasborg.com>
References: <4309DF55.3010106@hasborg.com>
Content-Type: text/plain
Message-Id: <1124721945.23599.58.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 Aug 2005 16:45:45 +0200

Hi Josh,

> While reading through the BlueCore BCCMD Commands documentation, I came
> across the "memory" test command.  This command allows us to read or
> write from/to a block of RAM within the chip.
> 
> The documentation is rather sparse for this test command.  The Varid and
> Type are documented, indicating that it's possible to specify a base
> memory address and a length of bytes, but it does not indicate how to
> differentiate a read or write operation.

the BCCMD itself differs between writing or reading a value and this
should be the same for direct memory access.

> Does anyone have more documentation on this test command, or know how to
> use this command to read memory from RAM on the chip for a given offset?

I think that I do, but without permission from CSR I will not share them
or make them public.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
