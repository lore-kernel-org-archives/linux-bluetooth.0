Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0607311627330.31025@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0607311627330.31025@redbean.intranet.gw-instruments.de>
Date: Mon, 31 Jul 2006 20:13:57 +0200
Message-Id: <1154369637.4982.8.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Refcounting problem in rfcomm
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

Hi Peter,

> while trying to implement a server tty which can be used without a user 
> space daemon I came across a reference counting problem.  Function 
> rfcomm_accept_connection() 
> calls __module_get(nsock->ops->owner) but there is no corresponding
> module_put(). I think for user space sockets this won't be a problem. 
> However, if the owner of the socket is the rfcomm module itself the 
> reference count gets wrong.    
> 
> A work around for this may be to decrement the reference count just before 
> releasing the socket used for listening. 

the RFCOMM module reference counting is not funny and you can mess it up
on so many level. So be careful with it. I haven't looked at it, but
from past experience I know that you can easily break things. So please
give us some more details or code to show the problem.

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
