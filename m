Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm use count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002a01c499ed$143282d0$1a01010a@baked>
References: <002a01c499ed$143282d0$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095153493.5695.129.camel@pegasus>
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
Date: Tue, 14 Sep 2004 11:18:13 +0200

Hi Daryl,

> I just noticed that bluez_accept_unlink() was called with a socked that was
> in state BT_CLOSED, so it can't be the second if(). It would have been
> called from the first if().
> 
> Clearly, I'm on glue.
> 
> Still, does the order of bluez_accept_unlink() and sock_release() matter?

I haven't done a full audit yet, but try to switch the order and see
what happens. From a first look at it it makes sense to only release the
socket when all the work is done, because otherwise lock_sock() makes no
sense.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
