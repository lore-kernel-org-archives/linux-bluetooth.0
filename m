Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Marcel Holtmann <marcel@holtmann.org>
To: Eugene Crosser <crosser@average.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073736666.12699.4.camel@pccross.average.org>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
	 <1073736666.12699.4.camel@pccross.average.org>
Content-Type: text/plain
Message-Id: <1073833166.3126.24.camel@pegasus>
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
Date: Sun, 11 Jan 2004 15:59:26 +0100

Hi Eugene,

> > As far as I can tell from analyzing the dump, and objdump of l2cap.o
> > object, BUG() happens when "sk_set_owner(sk, THIS_MODULE);" in
> > net/bluetooth/l2cap.c line 353 encounters zero refcount of the module. 
> > So, probably somebody incorrectly decreases the l2cap's refcount
> > elsewhere...
> 
> yes, this seems to be true (and explains the fixed number of attempts). 
> Reference count increases by one every time session starts, and
> decreases by *two* when it is finished.  Why initial refcount is 5 is
> still unclear to me...

I thought all refcount bugs were fixed, but the initial refcount is easy
to explain. It should be raised by the RFCOMM module and the sdpd. Try
to not load RFCOMM and disable the starting of the sdpd.

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
