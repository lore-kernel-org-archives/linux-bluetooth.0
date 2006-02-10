Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: bluez-devel@lists.sf.net
In-Reply-To: <43ECC82B.80400@gentoo.org>
References: <43ECC82B.80400@gentoo.org>
Content-Type: text/plain
Message-Id: <1139591157.26234.52.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: bt3c_cs hang when card is inserted
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 10 Feb 2006 18:05:57 +0100

Hi Daniel,

> There is a bug in the Gentoo bugzilla about a BUG() caused by plugging 
> in a cardbus bluetooth card.
> 
> http://bugs.gentoo.org/show_bug.cgi?id=120937
> 
> There is a patch there, apparently written by yourself. I'm just 
> wondering on the status there - is that the final fix? I noticed it is 
> not yet included in Linus' tree and is not in your bluetooth git tree on 
> kernel.org either.

it is the final one and it is waiting in my repository to be send
upstream, but so far I haven't had time to finally do it. I was way to
busy with other work.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
