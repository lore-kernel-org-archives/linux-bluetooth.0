Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Ed Tomlinson <edt@aei.ca>
Subject: Re: [BUG] usb problems in .38-rc3+
Date: Mon, 7 Feb 2011 10:09:51 +0100
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-usb@vger.kernel.org
References: <201102051417.58953.edt@aei.ca>
In-Reply-To: <201102051417.58953.edt@aei.ca>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201102071009.51238.oneukum@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Samstag, 5. Februar 2011, 20:17:57 schrieb Ed Tomlinson:
> Hi,
> 
> My bluetooth usb dongle has stopped working in .38-rc3+
> 
> Bus 002 Device 008: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
> 
> and in dmesg
> 
> [108495.369056] usb 5-1: new full speed USB device using ohci_hcd and address 3
> [108495.573077] usb 5-1: New USB device found, idVendor=0a12, idProduct=0001
> [108495.580099] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [108652.971977] usb 5-1: USB disconnect, address 3
> [108652.972718] btusb_bulk_complete: hci0 urb ffff8800684e99c0 failed to resubmit (19)
> [108652.973725] btusb_bulk_complete: hci0 urb ffff8800684e9c00 failed to resubmit (19)
> [108652.974707] btusb_intr_complete: hci0 urb ffff8800684e9840 failed to resubmit (19)
> [108653.001690] btusb_send_frame: hci0 urb ffff8800bb42a240 submission failed
> [108657.007541] usb 2-4.7: new full speed USB device using ehci_hcd and address 8
> [108657.147736] usb 2-4.7: New USB device found, idVendor=0a12, idProduct=0001
> [108657.154954] usb 2-4.7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> 
> Its been working for years here.
> 
> Any ideas on what to try or additional info to gather?

Please test what happens if you disable runtime power management.

	Regards
		Oliver
