Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403070400.04900.wim.delvaux@adaptiveplanet.com>
References: <200403070334.32315.wim.delvaux@adaptiveplanet.com>
	 <1078627214.2807.31.camel@pegasus>
	 <200403070400.04900.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078628633.2807.35.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: bnep module use count ...
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
Date: Sun, 07 Mar 2004 04:03:53 +0100

Hi Wim,

> 	Is there anything you want me to put in the bnep/bluetooth network module
> 	so that I can give you more info ?  E.g where is the reference counting 
> mantained (dev->refcnt is apparently the field but I cannot seem to find the 
> ++ for it)
> 
> 	I just did a normal connect/disconnect (not suspend) and then did a pand -l
> 	and all connections are gone ...

at the moment I have no idea where to start. Play a little bit with it.

> 	I also added this line to the listen loop.  It reads the pids of children 
> processes so you have no more ghost apps.
> 
> 	while( waitpid( -1, 0, WNOHANG) > 0 ) ;

Send me a patch against the CVS code.

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
