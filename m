Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] killing a persisted pand session
From: Marcel Holtmann <marcel@holtmann.org>
To: wim delvaux <wim.delvaux@adaptiveplanet.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403070244.05285.wim.delvaux@adaptiveplanet.com>
References: <200403070058.50508.wim.delvaux@adaptiveplanet.com>
	 <200403070221.59578.wim.delvaux@adaptiveplanet.com>
	 <1078623235.2807.6.camel@pegasus>
	 <200403070244.05285.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1078624545.2807.17.camel@pegasus>
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
Date: Sun, 07 Mar 2004 02:55:45 +0100

Hi Wim,

> When the ioctl locks I get the following dmesg 
> 
> unregister_netdevice: waiting for bnep0 to become free. Usage count = 2

then your suspend don't clean up everything. What kernel are you using?
Maybe it is impossible to do a suspend while you have a BNEP connection
opened.

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
