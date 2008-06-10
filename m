Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000001c8ca8d$2d47aa50$87d6fef0$%park@samsung.com>
References: <000001c8ca8d$2d47aa50$87d6fef0$%park@samsung.com>
Date: Tue, 10 Jun 2008 02:37:36 +0200
Message-Id: <1213058256.17870.8.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BlueZ 3.32 HSP SCO Bug Report & Solution
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> Recently I found BlueZ 3.32 HSP SCO connection bug.
> 
> Fortunately I fix the bug as follows. 
> 
> 
> In the function "sco_connect (glib-helper.c)"
> Bluez 3.32 code doesn't handle socket variable "sk"
> 
> So I add "socket file descriptor save routine"
> 
> 636 : io_cxtf->fd=sk;
> 
> 
> If you have any question about my idea, don't hesitate to tell me ^^
> 
> If possible , could you let me know how to check out/check in my code ?

can you please check with the latest CVS. I like to know if that issue
is still present or if we actually fixed in the meantime.

Regards

Marcel



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
