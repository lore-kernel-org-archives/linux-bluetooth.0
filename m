Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hid2hci and Logitech Hub
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Holler <holler@ahsoftware.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <10920000.1072457386@[192.168.207.2]>
References: <8430000.1072356496@[192.168.207.2]>
	 <1072363056.2876.75.camel@pegasus>  <30700000.1072366993@[192.168.207.2]>
	 <1072369721.2876.90.camel@pegasus>  <19230000.1072404120@[192.168.207.2]>
	 <1072406653.2876.98.camel@pegasus>  <27150000.1072412780@[192.168.207.2]>
	 <1072451203.2640.11.camel@pegasus>  <10920000.1072457386@[192.168.207.2]>
Content-Type: text/plain
Message-Id: <1072466121.2640.26.camel@pegasus>
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
Date: Fri, 26 Dec 2003 20:15:22 +0100

Hi Alexander,

> I've looked somewhat deeper into it. When your description is right, it 
> seems that the problem is in the usb-hid-parser. According to your 
> discovery, the report 16 should have 6 fields, each 8 bits wide (I've read 
> some hid-pages ;) ).

it have 6 fields, each 8 bits wide. Logitech uses the same report for
control of the Mediapad and I already have proven that it works.

> I've now put some printk's to hid_register_field in hid-core.c, the parser 
> only registers only one field for report 16. So hiddev is correct and it 
> complains about trying to send 6 fields with report 16.

So the HID parser must be fixed first. Keep on looking at it.

> Isn't there any free parser for Windows which outputs the report 
> descriptions (just for checking before looking deeper into the linux 
> parser)?

I don't know of anyone.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
