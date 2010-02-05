Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Kernel panic when SCO connection
Date: Fri, 5 Feb 2010 21:51:16 +0800
Message-ID: <C408AA84F077D5498977E4A236357B2206C1E8FC@ZMY16EXM67.ds.mot.com>
In-Reply-To: <1265292683.31341.153.camel@localhost.localdomain>
References: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com> <20100202171612.GA7034@vigoh> <912bb79a1002022051o1faf229en95605084fa0e380b@mail.gmail.com> <C408AA84F077D5498977E4A236357B2206C1E687@ZMY16EXM67.ds.mot.com> <1265292683.31341.153.camel@localhost.localdomain>
From: "SINGH DEVENDRA-DHGW76" <DevSingh@motorola.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for information Marcel. Do you know that 2.6.33-rc6 kernel code
having any change regarding points I encountered on older release?=20

Regards,
Dev

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Thursday, February 04, 2010 7:41 PM
To: SINGH DEVENDRA-DHGW76
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: Kernel panic when SCO connection

Hi,

> I noticed the same problem when I was working with a embedded board=20
> with Broadcom chipset and Linux kernel 2.6.18 (I guess). Use case was,

> a Bluetooth based headset sends data to the CSR Bluetooth dongle(USB),

> which in turn provide data to the Application through bluez stack.
>=20
>=20
> Following were my observation:
>=20
> 1. Board processor is not strong enough and so there was no URB in the

> queue and audio data was getting accumulated in the USB host
controller.
> There are only 2 Rx URBs (hci_usb.h: #define HCI_MAX_ISOC_RX 2).
> 2. Actual length of data for data in the URB is reaching to the level=20
> of 1K bytes. (Max ISOC data length) however Bluetooth driver is=20
> expecting 10 packets of 64 bytes each. hci_usb_isoc_rx_submit function

> in hci_usb.c file.
> 3. Completion routine copies data for actual length returned for=20
> packet that could be 1024 while limit for one packet is 64B only.
(hci_usb.c:
> hci_usb_rx_complete function).
> 4. These "SCO packet for unknown connection handle" error logs further

> complicated the problem as this will further eat-up cpu time.
>=20
>=20
> Cause:
>=20
> Max length of available transfer buffer could be 640 bytes (that's=20
> depend upon the buffer index) and copying big chunk of data was=20
> resulting into memory overrun and kernel memory was getting corrupted=20
> that results in un-expected behavior line connection break, lots of=20
> noise  and even kernel panic some times.
>=20
>=20
> Following was the work around:
>=20
> 1. Increased number of Rx URBs to 6. (hci_usb.h: #define=20
> HCI_MAX_ISOC_RX 6).
> 2. Increased transfer buffer size to 1.5K.
> 3. Put a check in completion routine that in case actual length is=20
> more then frame length then copy only frame length size data as
follows:
>=20
> int len =3D (urb->iso_frame_desc[i].actual_length >
> urb->iso_frame_desc[i].length)?
> 	     urb->iso_frame_desc[i].length:
> 	     urb->iso_frame_desc[i].actual_length;
>=20
> __recv_frame(husb,
> 		 _urb->type,=20
> 		urb->transfer_buffer + urb->iso_frame_desc[i].offset,
> 		len);
> 4. Logging "SCO packet for unknown connection handle" error only once=20
> for 100 errors. This will give more change to queue a URB as=20
> follows(hci_core.c:hci_scodata_packet function):
> hdev->stat.err_rx++;
> if(!(hdev->stat.err_rx % 100))
> {
> 	BT_ERR("%s 100 SCO packets for unknown connection=20
> handles",hdev->name); }
>=20
>=20
> I must say that I did not try with latest Linux kernel however I could

> not see any code change regarding this functionality. Hope this will=20
> help.

I can see a big code change in the latest 2.6.33-rc6 kernel. The hci_usb
driver has been replaced by btusb since a few releases now ;)

Regards

Marcel
