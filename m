Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Oops with 2.6.5-mh3
Message-ID: <20040417092404.GA1880@gmx.net>
References: <407C4B88.1010102@thomae-privat.de> <1082161132.4489.33.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1082161132.4489.33.camel@pegasus>
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
Date: Sat, 17 Apr 2004 11:24:04 +0200

On  0, Marcel Holtmann <marcel@holtmann.org> wrote:
> > I get a kernel Oops with 2.6.5-mh3 (with and without preempt) and an 
> > Acer BT-700 USB dongle on a Vaio Notebook, not when unplugging it, but 
> > when plugging it back in.
> 
> check the latest 2.6.6-rc or Bitkeeper snapshots, because there are many
> USB patches that are not merged into 2.6.5. If it still fails send a
> report the USB mailing list, because I don't think that this is our
> fault.

The problem was already submitted to lkml (i found at least 3reports) 
and one time declared impossible by Andrew Morton. I can't reproduce
this error with 2.6.6-rc1 because, the usb dongle ain't even working
at all. It seems USB is a bit messed up in that release.
In 2.6.5 there is an easy workaround. If you don't need the hci_usb 
SCO (CONFIG_BT_HCIUSB_SCO) support, disable it in your kernelconfig. 

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
