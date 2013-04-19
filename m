Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Apr 2013 10:16:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>, linux-bluetooth@vger.kernel.org,
	don.fry@intel.com, gustavo@padovan.org
Subject: Re: [PATCH v5] Bluetooth: Add support for Intel Bluetooth device
 [8087:07dc]
Message-ID: <20130419071609.GA3214@x220>
References: <1657315.CFhxFClec5@tedd-ubuntu>
 <7AA63F25-1E5A-4449-96F9-07E307C9F9C6@holtmann.org>
 <1683721.rPzt6KZh0J@tedd-ubuntu>
 <1FD1A5F4-36D2-44E0-BBA8-BA5147C7322D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1FD1A5F4-36D2-44E0-BBA8-BA5147C7322D@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Apr 18, 2013, Marcel Holtmann wrote:
> >>> +	u8 mfg_enable[] = { 0x01, 0x00 };
> >>> +	u8 mfg_disable[] = { 0x00, 0x00 };
> >>> +	u8 mfg_reset_deactivate[] = { 0x00, 0x01 };
> >>> +	u8 mfg_reset_activate[] = { 0x00, 0x02 };
> >> 
> >> Check if you can make these const.
> > 
> > If these becomes const, the compiler throws a warning at __hci_cmd_sync() below.
> 
> That is what I almost figured.
> 
> Johan, can you check if we can fix __hci_cmd_sync to take a const array.

Done. The patch for this is now on the list.

Johan
