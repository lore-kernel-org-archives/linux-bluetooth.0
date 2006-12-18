Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <020201c7227a$94e3a590$9301a8c0@LUBI>
References: <020201c7227a$94e3a590$9301a8c0@LUBI>
Date: Mon, 18 Dec 2006 10:36:59 +0100
Message-Id: <1166434619.6557.55.camel@aeonflux.holtmann.net>
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

Hi,

> Is there more information available how the kernel creates an ACL
> connection? I have been reading source code for 2.6.13-15 but not seen
> anything about creating an ACL connection yet. Well, I am quite unfamiliar
> with the kernel source code.
> 
> I have re-written some parts of hcitool so that it uses clock_offset and
> pscan_repetition_mode when ACL-connecting. Is kernel code more optimised
> that this?
> 
> Q2: Any ideas for a good way to time kernel creating the ACL connection? So
> that to compare with a "hacked" hcitool.

this is all the wrong approach. Create a L2CAP or RFCOMM connection and
the kernel will create any needed ACL link for you. Don't try to think
to complicate. If you try to mess around with connection reference
counting of the ACL the kernel will always win and simply disconnect the
link if it thinks it is no longer needed. Messing around directly with
HCI is never a good idea.

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
