Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Mar 2014 21:49:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gordon <kernel@gkr.i24.cc>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: PATCH hid2hci for CSR 8510 A10
Message-ID: <20140328194907.GA24300@t440s.P-661HNU-F1>
References: <1388440779.28025.21.camel@g-VPCF13Z1E>
 <1396034462.3390.5.camel@g-VPCF13Z1E>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396034462.3390.5.camel@g-VPCF13Z1E>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gordon,

On Fri, Mar 28, 2014, Gordon wrote:
> some time ago I sent a patch attached to following mail.
> 
> On Mo, 2013-12-30 at 22:59 +0100, Gordon wrote:
> > Hi,
> > 
> > ich had a problem with the Sitecom CNT-524 as described by someone else
> > here:
> > http://blog.ruecker.fi/2013/10/06/adventures-in-bluetooth-4-0-part-i/
> > 
> > so i tried to fix that by introducing --mode csr2 for hid2hci
> > 
> > I neither know how to switch back to hid nor how to detect the EALREADY
> > state, otherwise the patch is very small.
> > 
> > I works on my machine in ubuntu 13.04 with bluez 4.101-0ubuntu8b1 and
> > said sitecom usb dongle. the patch is against bluez commit
> > fd00064e0bb2c81e53e9d0b7d22ce919b41dbe60
> > 
> > Could someone please review.
> 
> I didn't get a reply yet. Since it has been my first mail to this list I
> wonder whether there is anything wrong with this request, or just nobody
> is interested ?

A couple of things regarding the presentation of the patch should at
least be fixed:

 - Send it as a proper git patch, i.e. using git commit, format-patch
   and send-email
 - Try to follow the bluez.git coding style which is roughly the same as
   the Linux kernel coding style. I realize the rest of hid2hci.c is
   probably the worst reference for good BlueZ coding style (being one
   of the oldest pieces of code with very little maintenance over the
   years).

A couple of things that could be improved coding style-wise:

> +static int usb_switch_csr2(int fd, enum mode mode)
> +{
> +	int err = 0;

Does this really need to be initialized to 0 upon declaration? Doing
this prevents the compiler from pointing out places where we should be
setting the variable to something else but dot (i.e.. in the case of
errors).

> +	struct usbfs_disconnect disconnect;
> +	char report[] = { 0x1 , 0x5 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 };

This should be an unsigned integer, uint8_t is probably best choice.
Spell out the individual values with two digits to make clear they are
bytes and not 4-bit values.


> +	switch (mode) {
> +	case HCI:
> +		//send report as is
> +		disconnect.interface = 0;
> +		disconnect.flags = USBFS_DISCONNECT_EXCEPT_DRIVER;
> +		strcpy(disconnect.driver, "usbfs");
> +
> +		if (ioctl(fd, USBFS_IOCTL_DISCONNECT, &disconnect) < 0) {
> +			fprintf(stderr, "Can't claim interface: %s (%d)\n",
> +						strerror(errno), errno);
> +			return -1;
> +		}
> +
> +		err = control_message(fd, USB_ENDPOINT_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +					USB_REQ_SET_CONFIGURATION, //Set_Report Request
> +					0x01 | (0x03 << 8), //report id: 0x01, report type: feature (0x03)
> +					0, //interface
> +					report, sizeof(report), 5000);

Looks like you're hitting the 80-character line limits here. I know
other places in hid2hci.c violate against it but it'd be nice to at
least follow the rule for new code.

> +		//unable to detect EALREADY

We don't generally use C++ style comments in the tree. Prefer /* .. */
where possible. In this case I'd elaborate the comment a bit since I
don't quite understand what it means.

> +	case HID:
> +		// currently unknown what to do here

Same here.

Johan
