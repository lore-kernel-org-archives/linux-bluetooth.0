Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: jbarnett@pobox.com, BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1166148309.3279.6.camel@localhost>
References: <1166076796.3984.9.camel@localhost>
	<20061214092546.GA6244@163.com>  <1166148309.3279.6.camel@localhost>
Date: Sun, 17 Dec 2006 13:43:43 +0100
Message-Id: <1166359423.6557.35.camel@aeonflux.holtmann.net>
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

Hi Jon,

> No. The disconnect happens at most maybe a couple of seconds after the
> cc command has completed. I've tried:
> hcitool cc 00:12:EE:E0:AB:CA; hcitool auth 00:12:EE:E0:AB:CA

don't use "hcitool cc" for connecting devices. This command is not for
general purpose use. Let the kernel create you low-level ACL, because it
knows what to do.

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
