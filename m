Return-Path: <vojtech@suse.cz>
Date: Mon, 15 Mar 2004 15:32:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Philip Blundell <pb@nexus.co.uk>, Keith Pemberton <kbpember@cox.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Writing a bluetooth mouse driver...
Message-ID: <20040315143214.GB1365@ucw.cz>
References: <1079350703.4317.7.camel@linuxcomp.gatep5.net> <1079352208.3405.26.camel@pegasus> <1079359127.21325.3.camel@mill.nexus.co.uk> <1079360285.3405.46.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1079360285.3405.46.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

On Mon, Mar 15, 2004 at 03:18:06PM +0100, Marcel Holtmann wrote:
> Hi Philip,
> 
> > I spoke with Vojtech last year about moving the HID parser from the USB
> > code into the input subsystem, so that it could be shared with
> > Bluetooth.  He seemed happy with that in principle, and I don't think it
> > would be very difficult to implement, but I haven't had time to actually
> > write a patch yet.
> 
> the problematic part is hid-core.c, because it contains the USB specific
> transport layer. I ripped it off and included the rest into my HIDP code
> and it works flawless. The Bluetooth transport code is almost ready. I
> only need to include some workarounds for the stupid L2CAP disconnect
> problems with some HID implementations, but this has nothing to do with
> the HID parser.
> 
> Actually the HID parser is independent from the input and USB subsystem,
> because you can use a Bluetooth transport and the hiddev interface for
> reading and writing reports. What I have in mind is cleaning up the
> current code and putting it under drivers/hid/ with this API:
> 
> 	struct hid_device {
> 		...
> 
> 		void *driver_data;
> 		int (*send)(struct hid_device *device, unsigned char *data, int size);
> 	}
> 
> 	struct hid_device *hid_alloc_device(unsigned char *data, int size);
> 	void hid_free_device(struct hid_device *device);
> 	int hid_register_device(struct hid_device *device);
> 	void hid_unregister_device(struct hid_device *device);
> 	int hid_recv_report(struct hid_device *hid, int type, unsigned char *data, int size);

This is a very nice idea. I'm all for it. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
