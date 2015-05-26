Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 May 2015 09:43:22 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3] Bluetooth: btusb: Add routine for applying Intel DDC
 parameters
Message-ID: <20150526094322.763b217f@tedd-fedora-vm>
In-Reply-To: <37510C75-1090-4601-AC8F-AC46800753C1@holtmann.org>
References: <20150520140409.5a3317f5@tedd-fedora-vm>
	<37510C75-1090-4601-AC8F-AC46800753C1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, 25 May 2015 21:31:47 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Tedd,
> 
> > This patch adds the routine to apply the DDC parameter from device
> > specific ddc file.
> > 
> > Once the device is rest to operational mode, optionally, it can
> > download the device specific configration (DDC) parameters before
> > the BlueZ starts the stack initialization.
> > 
> > It opens the DDC file based on HW_VARIANT and send ID/Value with
> > HCI_Intel_Write_DDC command.
> > 
> > Format of DDC file
> > DDC file consists of one or more number of DDC structure that has a
> > 'Length' field of one octet, DDC 'ID' field of two octets followed by
> > the array of DDC 'Value' that gives the value of parameters itself.
> > 'Length' contains the length of DDC 'ID' and DDC 'Value'.
> > 
> > +------------+----------+
> > | Size(byte) |    Name  |
> > +------------+----------+
> > |      1     | Length   |
> > +------------+----------+
> > |      2     | ID       |
> > +------------+----------+
> > | Length - 2 | Value    |
> > +------------+----------+
> 
> I wonder if we should add some sort of header to this file structure.
> 

Could you explain more about the "header"? DDC header is Length and ID.
The DDC file can have more than one DDC. Do you mean the header for all DDC
contents? Then it will be same as HCI plen.

Also, how do you think about saving this file in ASCII format instead of binary?
then I can add some comments that start with # and ignore the line like bash script.


Regards,
Tedd
