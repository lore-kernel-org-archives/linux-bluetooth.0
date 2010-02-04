Return-Path: <cyrus@holtmann.org>
Subject: RE: Kernel panic when SCO connection
From: Marcel Holtmann <marcel@holtmann.org>
To: SINGH DEVENDRA-DHGW76 <DevSingh@motorola.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <C408AA84F077D5498977E4A236357B2206C1E687@ZMY16EXM67.ds.mot.com>
References: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com>
	 <20100202171612.GA7034@vigoh>
	 <912bb79a1002022051o1faf229en95605084fa0e380b@mail.gmail.com>
	 <C408AA84F077D5498977E4A236357B2206C1E687@ZMY16EXM67.ds.mot.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 04 Feb 2010 06:11:23 -0800
Message-ID: <1265292683.31341.153.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I noticed the same problem when I was working with a embedded board with
> Broadcom chipset and Linux kernel 2.6.18 (I guess). Use case was, a
> Bluetooth based headset sends data to the CSR Bluetooth dongle(USB),
> which in turn provide data to the Application through bluez stack.
> 
> 
> Following were my observation:
> 
> 1. Board processor is not strong enough and so there was no URB in the
> queue and audio data was getting accumulated in the USB host controller.
> There are only 2 Rx URBs (hci_usb.h: #define HCI_MAX_ISOC_RX
> 2).
> 2. Actual length of data for data in the URB is reaching to the level of
> 1K bytes. (Max ISOC data length) however Bluetooth driver is expecting
> 10 packets of 64 bytes each. hci_usb_isoc_rx_submit function in
> hci_usb.c file.
> 3. Completion routine copies data for actual length returned for packet
> that could be 1024 while limit for one packet is 64B only. (hci_usb.c:
> hci_usb_rx_complete function).
> 4. These "SCO packet for unknown connection handle" error logs further
> complicated the problem as this will further eat-up cpu time.
> 
> 
> Cause:
> 
> Max length of available transfer buffer could be 640 bytes (that's
> depend upon the buffer index) and copying big chunk of data was
> resulting into memory overrun and kernel memory was getting corrupted
> that results in un-expected behavior line connection break, lots of
> noise  and even kernel panic some times.
> 
> 
> Following was the work around:
> 
> 1. Increased number of Rx URBs to 6. (hci_usb.h: #define HCI_MAX_ISOC_RX
> 6).
> 2. Increased transfer buffer size to 1.5K.
> 3. Put a check in completion routine that in case actual length is more
> then frame length then copy only frame length size data as follows:
> 
> int len = (urb->iso_frame_desc[i].actual_length >
> urb->iso_frame_desc[i].length)?
> 	     urb->iso_frame_desc[i].length:
> 	     urb->iso_frame_desc[i].actual_length;
> 
> __recv_frame(husb,
> 		 _urb->type, 
> 		urb->transfer_buffer + urb->iso_frame_desc[i].offset,
> 		len);
> 4. Logging "SCO packet for unknown connection handle" error only once
> for 100 errors. This will give more change to queue a URB as
> follows(hci_core.c:hci_scodata_packet function):
> hdev->stat.err_rx++;
> if(!(hdev->stat.err_rx % 100))
> {
> 	BT_ERR("%s 100 SCO packets for unknown connection
> handles",hdev->name);
> }
> 
> 
> I must say that I did not try with latest Linux kernel however I could
> not see any code change regarding this functionality. Hope this will
> help.

I can see a big code change in the latest 2.6.33-rc6 kernel. The hci_usb
driver has been replaced by btusb since a few releases now ;)

Regards

Marcel


