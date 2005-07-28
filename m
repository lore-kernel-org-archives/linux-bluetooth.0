Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dfutool block size
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <42E799DA.70207@fbl.cz>
References: <42E799DA.70207@fbl.cz>
Content-Type: text/plain
Message-Id: <1122511081.916.4.camel@notepaq>
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
Date: Thu, 28 Jul 2005 02:38:01 +0200

Hi Thomas,

> I tryied upgrade an old i-Tec BT dongle (CSR BlueCore2 ext + 4M flash, 
> ID=0a12:0001, original version 272 - BT 1.1 HCI 14.3) by dfutool. 
> Archiving old firmware was OK.
> 
> dfutool upgrade GenericCSR829.dfu
> 
> failed after time-out with message:
> 
> Can't upload next block: Broken pipe (32)
> 
> No change after upgrading to today's bluez cvs head.
> I reduced written block size to 512 (why original length was 1023 and 
> not 1024??)
> and dongle got upgraded OK (tested with archived fw version 272). Then I 
> tested sizes
> in between:
> 
> 1008 and 992: broken pipe
> 960: Can't get status: No such device after 9600 bytes
> 896: dfutool finished upgrade OK but dongle stays in DFU mode
> 768: upgrade worked
> 
> It's clear this is a problem in dfu loader in the dongle. I tested it again
> with upgraded firmware and problem persists.
> If there is more such dongles, it might be worth to add a block size 
> parameter to dfutool.

feel free to send in a patch that adds a parameter for a different block
size.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
