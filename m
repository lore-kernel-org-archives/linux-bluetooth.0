Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Marcel Holtmann <marcel@holtmann.org>
To: Eugene Crosser <crosser@average.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073889186.3923.27.camel@pccross.average.org>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
	 <1073736666.12699.4.camel@pccross.average.org>
	 <1073833166.3126.24.camel@pegasus>
	 <1073889186.3923.27.camel@pccross.average.org>
Content-Type: text/plain
Message-Id: <1073913755.3126.48.camel@pegasus>
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
Date: Mon, 12 Jan 2004 14:22:35 +0100

Hi Eugene,

> Interesting that running "rfcomm bind" or "rfcomm listen" does not
> increase l2cap's refcount.  It gets increased at the moment when
> incoming connection actually takes place.  And is decreased (by 2) when
> it terminates.

it is ok that the L2CAP refcount is increased, because every RFCOMM
connection needs an underlaying L2CAP link. But of course the increase
and the decrease should be the same ;)

> I do not understand how refcount is maintained well enough to do further
> investigation myself.  Anything I can do to help you (or anybody) to fix
> the problem?

Let us summarize this problem a little bit. We know that this is
refcount bug and it happens in __module_get(). It also seems that we
only get hit by this bug if we got in incoming connection. Is this
right? Do the refcounting work correct on outgoing? My question is if
this is a L2CAP only problem or if it only happens in conjunction with
RFCOMM? Can you reproduce it with the l2test program only? Don't load
the rfcomm.ko module and don't start the sdpd, so you have a better
starting refcount.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
