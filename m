Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Difference between rctest.c and main.c in
	/rfcomm directory
From: Marcel Holtmann <marcel@holtmann.org>
To: Anthony Yulo <strikewing16th@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY16-F358WlSOBCCLj0001e0fe@hotmail.com>
References: <BAY16-F358WlSOBCCLj0001e0fe@hotmail.com>
Content-Type: text/plain
Message-Id: <1082391200.4403.59.camel@pegasus>
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
Date: Mon, 19 Apr 2004 18:13:20 +0200

Hi Anthony,

> I am only familiar with rfcomm that uses plain sockets...
> 
> I am only familiart with the rctest.c code that just setup the socket for 
> RFCOMM..
> 
> but i noticed some additional constants i.e. RFCOMM_REUSE_DLC, 
> RFCOMM_RELEASE_ONHUP..  in main.c of the /rfcomm directory (src)
> 
> Can someone explain to me briefly whats this for?

they are for transforming a Bluetooth RFCOMM socket into a TTY device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
