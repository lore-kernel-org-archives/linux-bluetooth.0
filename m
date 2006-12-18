Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <022d01c7228a$377febb0$9301a8c0@LUBI>
References: <022d01c7228a$377febb0$9301a8c0@LUBI>
Date: Mon, 18 Dec 2006 12:55:09 +0100
Message-Id: <1166442909.23875.1.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Immediate disconnect after doing "hcitool cc"
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

Hi Lauri,

> Well, I'm a man in a bad need of performance and have to create ACL
> connections in the most optimized way. The current tests (hcidump) have
> unfortunately showed that the Linux kernel (2.5.16) does make use of
> pscan_repetition_mode, not sure about the clock_offset. Inquiry scan has
> been done just seconds before connection attempts.
> 
> With this background I guess there are 2 ways out: messing with HCI directly
> and taking the risk of kernel overriding me; or re-writing some
> Bluetooth/sockets code in the kernel. Do you agree?

that is all crap. The kernel is the fastest way to create the ACL. There
is no other way, because the kernel has all needed information and keeps
them up-to-date. So don't even try to accomplish something that is
impossible to achieve.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
