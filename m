Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Using BlueZ for network access via ppp does not
	work, nothing at all in log files
From: Marcel Holtmann <marcel@holtmann.org>
To: Richard Pruen <r.pruen@btinternet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <008601c4200c$4c75ee30$0000fea9@RICHARDP>
References: <008601c4200c$4c75ee30$0000fea9@RICHARDP>
Content-Type: text/plain
Message-Id: <1081777025.5398.115.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 12 Apr 2004 15:37:05 +0200

Hi Richard,

> I am trying to use dund to allow my pocket pc 2003 device to connect to my
> home network. And it won't work, having checked all the log files there is
> nothing in them at all relating to this. If I remove rfcomm tty support from
> the kernel, then I do get entries saying that rfcomm can't connect. But with
> it enabled there isn't a peep out of anything at all, dund, rfcomm and pppd
> are all silent.

dund needs the RFCOMM TTY support. No matter what.

> rfcomm can be connected to serial ports on my other pc, so everything seems
> to work ok.
> 
> I have a Belken USB dongle, and slackware 9.1 with the 2.6.4 kernel, I have
> the latest BlueZ packages.
> 
> Hope someone has some ideas of what to try to find the problem.

Without any logfiles or hcidump or any other clues, how should we find
your problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
