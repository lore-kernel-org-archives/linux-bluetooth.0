Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Writing a bluetooth mouse driver...
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Blundell <pb@nexus.co.uk>
Cc: Keith Pemberton <kbpember@cox.net>, Vojtech Pavlik <vojtech@suse.cz>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1079359127.21325.3.camel@mill.nexus.co.uk>
References: <1079350703.4317.7.camel@linuxcomp.gatep5.net>
	 <1079352208.3405.26.camel@pegasus>
	 <1079359127.21325.3.camel@mill.nexus.co.uk>
Content-Type: text/plain
Message-Id: <1079360285.3405.46.camel@pegasus>
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
Date: Mon, 15 Mar 2004 15:18:06 +0100

Hi Philip,

> I spoke with Vojtech last year about moving the HID parser from the USB
> code into the input subsystem, so that it could be shared with
> Bluetooth.  He seemed happy with that in principle, and I don't think it
> would be very difficult to implement, but I haven't had time to actually
> write a patch yet.

the problematic part is hid-core.c, because it contains the USB specific
transport layer. I ripped it off and included the rest into my HIDP code
and it works flawless. The Bluetooth transport code is almost ready. I
only need to include some workarounds for the stupid L2CAP disconnect
problems with some HID implementations, but this has nothing to do with
the HID parser.

Actually the HID parser is independent from the input and USB subsystem,
because you can use a Bluetooth transport and the hiddev interface for
reading and writing reports. What I have in mind is cleaning up the
current code and putting it under drivers/hid/ with this API:

	struct hid_device {
		...

		void *driver_data;
		int (*send)(struct hid_device *device, unsigned char *data, int size);
	}

	struct hid_device *hid_alloc_device(unsigned char *data, int size);
	void hid_free_device(struct hid_device *device);
	int hid_register_device(struct hid_device *device);
	void hid_unregister_device(struct hid_device *device);
	int hid_recv_report(struct hid_device *hid, int type, unsigned char *data, int size);

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
