Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v5] Bluetooth: btusb: Add routine for applying Intel DDC parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150612162005.75849a3b@tedd-fedora-vm>
Date: Wed, 17 Jun 2015 15:09:19 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <278D0F44-C20B-4FB4-A11F-FFD2B2DC9609@holtmann.org>
References: <20150612162005.75849a3b@tedd-fedora-vm>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds the routine to apply the DDC parameter from device
> specific ddc file.
> 
> Once the device is rest to operational mode, optionally, it can
> download the device specific configration (DDC) parameters before
> the BlueZ starts the stack initialization.
> 
> It opens the DDC file based on HW_VARIANT and DEV_REVISION and
> send ID/Value with HCI_Intel_Write_DDC command.
> 
> Format of DDC file
> DDC file contains one or more number of DDC structure.
> 
> DDC Structure
> It has 'Length' field of one octet, DDC 'ID' field of
> two octets followed by the array of DDC 'Value' that gives
> the value of parameters itself.
> 'Length' contains the length of DDC 'ID' and DDC 'Value'.
> 
> +------------+----------+
> | Size(byte) |    Name  |
> +------------+----------+
> |      1     | Length   |
> +------------+----------+
> |      2     | ID       |
> +------------+----------+
> | Length - 2 | Value    |
> +------------+----------+
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btusb.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 42 insertions(+)

patch has been applied to bluetooth-next tree. However I did a few minor wording changes in the comments and BT_INFO sections.

Regards

Marcel

