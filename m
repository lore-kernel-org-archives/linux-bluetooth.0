Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Writing a bluetooth mouse driver...
From: Marcel Holtmann <marcel@holtmann.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Philip Blundell <pb@nexus.co.uk>, Keith Pemberton <kbpember@cox.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040315143214.GB1365@ucw.cz>
References: <1079350703.4317.7.camel@linuxcomp.gatep5.net>
	 <1079352208.3405.26.camel@pegasus>
	 <1079359127.21325.3.camel@mill.nexus.co.uk>
	 <1079360285.3405.46.camel@pegasus>  <20040315143214.GB1365@ucw.cz>
Content-Type: text/plain
Message-Id: <1079362843.3405.58.camel@pegasus>
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
Date: Mon, 15 Mar 2004 16:00:43 +0100

Hi Vojtech,

> > the problematic part is hid-core.c, because it contains the USB specific
> > transport layer. I ripped it off and included the rest into my HIDP code
> > and it works flawless. The Bluetooth transport code is almost ready. I
> > only need to include some workarounds for the stupid L2CAP disconnect
> > problems with some HID implementations, but this has nothing to do with
> > the HID parser.
> > 
> > Actually the HID parser is independent from the input and USB subsystem,
> > because you can use a Bluetooth transport and the hiddev interface for
> > reading and writing reports. What I have in mind is cleaning up the
> > current code and putting it under drivers/hid/ with this API:
> > 
> > 	struct hid_device {
> > 		...
> > 
> > 		void *driver_data;
> > 		int (*send)(struct hid_device *device, unsigned char *data, int size);
> > 	}
> > 
> > 	struct hid_device *hid_alloc_device(unsigned char *data, int size);
> > 	void hid_free_device(struct hid_device *device);
> > 	int hid_register_device(struct hid_device *device);
> > 	void hid_unregister_device(struct hid_device *device);
> > 	int hid_recv_report(struct hid_device *hid, int type, unsigned char *data, int size);
> 
> This is a very nice idea. I'm all for it. 

the problem that I see is that someone has to code it and I am not a
real HID parser expert. I want to add kernel side Bluetooth HID support
into 2.6.5 and at the moment I only see to choices:

1. I include my ripped hid-core.c and hid-input.c code along with my
HIDP code in net/bluetooth/hidp/

2. I build up a basic drivers/hid/ with limited functionality (only
input and no hiddev support) and the proposed API. The name of the
kernel module should be something like hid-ng.ko until we have a full
replacement for hid.ko.

Comments?

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
