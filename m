Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Bluetooth device missing after kernel
	recompile
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Wever <mick@machina.no>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <pan.2004.03.29.10.58.33.731525@machina.no>
References: <pan.2004.03.29.08.17.54.697624@netbeans.org>
	 <1080556737.2281.217.camel@pegasus>
	 <pan.2004.03.29.10.58.33.731525@machina.no>
Content-Type: text/plain
Message-Id: <1080559561.2281.227.camel@pegasus>
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
Date: Mon, 29 Mar 2004 13:26:02 +0200

Hi Michael,

> Output from lsmod was in original post,

I meant lsusb.

> lspci | grep USB
> 
> 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01)
> 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01)
> 00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01)

Check the dmesg output to see if any of the USB host controller drivers
complain about anything.

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
