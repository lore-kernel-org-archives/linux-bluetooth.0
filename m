Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Connection dropped or cannot connect
From: Marcel Holtmann <marcel@holtmann.org>
To: rcox27@triad.rr.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200404101642.14384.conardcox@earthlink.net>
References: <000801c41e98$9e75d080$0100a8c0@terre>
	 <200404101642.14384.conardcox@earthlink.net>
Content-Type: text/plain
Message-Id: <1081631352.5398.43.camel@pegasus>
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
Date: Sat, 10 Apr 2004 23:09:12 +0200

Hi Richard,

> Good news and bad news,
> 	Good news is that i've got my iPAQ pan connection working very well, but am 
> having a very similar problem to the once described here.  Here's what 
> happens in the log:
> 
> Apr 10 16:31:45 furrball kernel: hci_acl_tx_to: hci0 ACL tx timeout
> Apr 10 16:31:45 furrball kernel: hci_acl_tx_to: hci0 killing stalled ACL 
> connection B6:CB:5A:16:05:00
> Apr 10 16:31:45 furrball kernel: pan0: port 1(bnep0) entering disabled state
> Apr 10 16:31:45 furrball kernel: pan0: port 1(bnep0) entering disabled state
> Apr 10 16:31:45 furrball kernel: device bnep0 left promiscuous mode
> 
> After that happens, the only thing that will fix it is to unplug and re-insert 
> the USB dongle.  hciconfig just returns this when I try a reset:
> 
> [furrball:~]# hciconfig hci0 reset
> Can't init device hci0. Connection timed out(110)
> 
> I read this response and turned off encrypt and authentication in hci.conf, 
> but it has made no noticable difference.  This always happens after a little 
> over 1 or 2 Mb of data xfer.

this sound to me like the Transilica chip in the USB-220 is buggy and
that it has a problem when sending frames with multiple size of bulk max
packet. You can try to add "#define CONFIG_BT_HCIUSB_ZERO_PACKET" at the
top of hci_usb.c and try again.

> PS:  I'm using the latest bluez download from the download section, i'm 
> running a vanilla 2.4.25 kernel on gentoo linux.  I've got a Belkin F8T003 
> USB adapter too.

Do this adapter have the same problem? Is it CSR based?

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
