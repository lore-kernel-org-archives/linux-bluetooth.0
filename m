Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
References: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
	<3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
Date: Wed, 04 Oct 2006 16:37:50 +0200
Message-Id: <1159972670.1601.25.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About the kernel 2.6.18
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

> 
>    My oepnsuse 10.1 with the default kernel 2.6.16.13-4.
>    When 2.6.18-mh3 released, I rebuilt and updated the kernel to
> 2.6.18 and then patched it.
>    When Holtman released the patch for handling multiple l2cap
> connections, I patched the new kernel .
>    But at last, I found that the speed of  the OBEX pushing and other
> Rfcomm socket communications is slower than the original kernel.
>    Then I rebuilt the 2.6.18 without the 2.6.18-mh3 and the patch for
> handling multiple l2cap connections, I found it is still slower.
>    So I think the patch is not the reason.
>    But what makes the bluetooth communication slower? The new kernel
> version 2.6.18?

if the 2.6.18 kernel is slower, then it must be something else. You
might wanna test with a 2.6.17 kernel.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
