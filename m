Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: Reproducible kernel oops on PPP session start
From: Marcel Holtmann <marcel@holtmann.org>
To: Eugene Crosser <crosser@average.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1073944953.5527.16.camel@pccross.average.org>
References: <1073475736.6998.9.camel@pccross.average.org>
	 <1073477754.2508.135.camel@pegasus>
	 <1073483871.2816.9.camel@pccross.average.org>
	 <1073736024.7742.12.camel@pccross.average.org>
	 <1073736666.12699.4.camel@pccross.average.org>
	 <1073833166.3126.24.camel@pegasus>
	 <1073889186.3923.27.camel@pccross.average.org>
	 <1073913755.3126.48.camel@pegasus>
	 <1073919178.7667.41.camel@ariel.sovam.com>
	 <1073920544.3126.100.camel@pegasus>
	 <1073942535.5527.7.camel@pccross.average.org>
	 <1073943342.8198.8.camel@pegasus>
	 <1073944953.5527.16.camel@pccross.average.org>
Content-Type: text/plain
Message-Id: <1074015121.2533.11.camel@pegasus>
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
Date: Tue, 13 Jan 2004 18:32:02 +0100

Hi Eugene,

> while right now I only have one host where l2test can be run, I tried
> it:
> 
> l2test -s 00:01:02:03:04:05
>  - l2cap count increased by 2, then I get "Host is down" and count
> decreased by 2
> 
> l2test -r
>  - count increased by 3, program waits.  When I hit ctrl-break, count
> decreased by 3

ok, I ran my own tests and found that the L2CAP module is working fine
and this explains why I never got this problem while working on HID.
Even the PAN and CMTP module do correct reference counting, but if you
use RFCOMM on top of L2CAP and got an incoming RFCOMM connection the
refcounting gets wrong.

This means that the termination of an incoming RFCOMM connections
decrements the reference counting of the L2CAP module. This should not
happen and I think we have a wrong owner entry somewhere in the RFCOMM
socket code, but at the moment I don't know where.

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
