Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Jun 2015 11:02:45 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4] Bluetooth: btusb: Add routine for applying Intel DDC
 parameters
Message-ID: <20150612110245.3f216445@tedd-fedora-vm>
In-Reply-To: <8903C22A-6194-40CA-A787-D7E79A67322A@holtmann.org>
References: <20150610150156.7522ed3f@tedd-fedora-vm>
	<8903C22A-6194-40CA-A787-D7E79A67322A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, 12 Jun 2015 11:36:16 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Tedd,
> 
> > @@ -2244,7 +2248,66 @@ done:
> > 
> > 	clear_bit(BTUSB_BOOTLOADER, &data->flags);
> > 
> > +	/* Once the device is running in operational mode, it needs to apply
> > +	 * the device configuration(DDC) parameters to the device.
> > +	 */
> > +	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.ddc", dev_revid);
> 
> I would actually just move creating the DDC filename above instead of bothering to introduce a new dev_revid variable.
> 
> > +
> > +	/* Device can work without DDC parameters so even if it fails to load
> > +	 * the file, no need to fail the setup.
> > +	 */
> > +	err = request_firmware_direct(&fw, fwname, &hdev->dev);
> 
> Why _direct compared to the other one?

If the DDC file doesn't exist, then request_firmware() displays the following extra message:

[ 2193.141256] bluetooth hci0: Direct firmware load for intel/ibt-11-5.ddc failed with error -2

I thought its not necessary to display and give a negative impression since the device can work without DDC file.

The request_firmware_direct() suppress the error message and this is the comment from the function says it is useful for optional firmware. 

 * This function works pretty much like request_firmware(), but this doesn't
 * fall back to usermode helper even if the firmware couldn't be loaded
 * directly from fs.  Hence it's useful for loading optional firmwares, which
 * aren't always present, without extra long timeouts of udev.

Functionally, both works fine.

> 
> > +	if (err < 0) {
> > +		BT_ERR("failed to open the ddc file: %s", fwname);
> > +		return 0;
> > +	}
> > +
> > +	BT_INFO("%s: Intel DDC file opened: %s", hdev->name, fwname);
> > +
> > +	fw_ptr = fw->data;
> > +
> > +	/* DDC file contains DDC parameters in HCI Command format. */
> 
> Did we agree on that? I think we did not. We just want the plain DDC parameters. We might have crossed our messages here. I prefer plain DDC key value pairs in the file.
> 

Thanks for clarification. :)

> > 
> 
> Regards
> 
> Marcel
> 

Regards,
Tedd
