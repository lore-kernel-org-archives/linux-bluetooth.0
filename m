Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] unresolved symbol __do_softirq
From: Marcel Holtmann <marcel@holtmann.org>
To: jens.carroll@carroll.de
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3FFD4845.3090206@carroll.de>
References: <3FFD4845.3090206@carroll.de>
Content-Type: text/plain
Message-Id: <1073582997.2563.14.camel@pegasus>
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
Date: Thu, 08 Jan 2004 18:29:57 +0100

Hi Jens,

> I have a problem integrating bluez into a cross complied kernel version
> 2.4.20. The target is a arm7tdmi and I used the latest patch for that
> kernel. The kernel compilation (bluez as modules) works fine and does
> not report any errors. However when I want to insmod the bluez.o I get:
> 
> Using bluez.o
> insmod: unresolved symbol __do_softirq
> 
> Well, I am not even sure it is a bluez or a kernel problem. The symbol
> __do_softirq is not exported (checked with "cat ksyms | grep __do_softirq").

I am no ARM expert so I can't help you, but from a quick search through
the kernel source I saw the __do_softirq is specific for the ARM arch.
Try to post this on an ARM mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
