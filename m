Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Russell Neches <russell@ccs.neu.edu>
To: Brad Midgley <bmidgley@xmission.com>, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] crash on remove
Message-ID: <20040311024720.GA3297@omocha.vort.org>
References: <20040310182158.GA9279@naginata.ccs.neu.edu> <404F84BC.4020406@xmission.com> <20040310223504.GA3398@omocha.vort.org> <404FB5D1.5030104@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <404FB5D1.5030104@xmission.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 21:47:20 -0500

> yes, i enabled force remove because the module shows up as in use. i 
> think it's unsafe, but how much worse can it be than crashing the kernel?

Indeed. 

> i am compiling the modules without SCO support right now to see if that 
> helps.

Now, by SCO support, do we mean the module (CONFIG_BT_SCO) or
CONFIG_BT_HCIUSB_SCO? I'm actually getting the crash without the sco
module loaded, and I have my kernel built with CONFIG_BT_HCIUSB_SCO not
set. I don't think SCO shows up anywhere else in the kernel. Sorry if
I'm beginning to sound pedantic. 

Maybe I should figure out how to use SysReq after all...

Russell


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
