Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetoooth and Threads?
From: Nils Faerber <nils.faerber@kernelconcepts.de>
To: Anthony Yulo <strikewing16th@hotmail.com>
Cc: bluez-devel@lists.sourceforge.net, blueinfo@yahoogroups.com
In-Reply-To: <Law11-F108gLzhVOJwn00013a60@hotmail.com>
References: <Law11-F108gLzhVOJwn00013a60@hotmail.com>
Content-Type: text/plain
Message-Id: <1073655487.989.50.camel@localhost>
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
Date: Fri, 09 Jan 2004 14:38:07 +0100

Am Fr, den 09.01.2004 schrieb Anthony Yulo um 04:38:
> Hi!
Hi!

> I'm just wondering if multiple threads can have their own bluetooth stack?

Errrmm... several *stacks* ??
Do you use several IP stacks for several IP connections??
I don't...

> I'm planning of a single program that uses threads, one thread does only 
> device discovery.. and then store the devices on a list/queue.. and then 
> maybe a couple of threads that reads from  the queue and send data from the 
> devices on the queue using RFCOMM.. maybe i can have seven threads since 
> this is the maximum number bluetooth allows...
> is this possible?

Sure, perfectly possible.
You simply open the appropriate sockets in each thread and that's it.
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
