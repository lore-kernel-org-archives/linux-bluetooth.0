Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Rfcomm Use Count
From: Marcel Holtmann <marcel@holtmann.org>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003001c49f55$4a2d3610$1a01010a@baked>
References: <003001c49f55$4a2d3610$1a01010a@baked>
Content-Type: text/plain
Message-Id: <1095715737.5731.70.camel@pegasus>
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
Date: Mon, 20 Sep 2004 23:28:57 +0200

Hi Daryl,

> I just tried an experiment where I listen for a while before calling
> accept(). I can raise the use cound by connecting, disconnecting, etc (as
> before). As soon as accept() is called, the excess use count goes away.
> 
> Before accept() is called, the server will start refusing connections after
> you fill up the accept queue. The queue is emptied with a single call to
> accept().

so this means when we disconnect we must ensure that we also remove this
connection from the accept queue if it is pending there.

What I know think is that calling the bt_accept_unlink() function only
from bt_accept_dequeue() is wrong. If bt_sk(sk)->parent is set and we
ran into a disconnect then we must unlink it by ourself. Does this make
sense?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
