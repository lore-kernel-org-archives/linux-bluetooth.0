Return-Path: <cyrus@holtmann.org>
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluez dfutool: patch & questions
References: <200904240329.12596.s.giessl@niftylight.de>
Date: Fri, 24 Apr 2009 09:57:52 +0200
In-Reply-To: <200904240329.12596.s.giessl@niftylight.de> (Sandro Giessl's
	message of "Fri, 24 Apr 2009 03:29:12 +0200")
Message-ID: <87r5zijxfj.fsf@nemi.mork.no>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sandro Giessl <s.giessl-Bfi1pWw08knh+Csq1SFZ+Q@public.gmane.org> writes:

> Dear Marcel and others,
>
> I'm developing DFU capabilities for a ARM7 STM32 based device. As I've be=
en=20
> new to DFU this wasn't a straigt forward process for me, but my endeavors=
 are=20
> slowly paying off. :) I must say that I've been glad to find dfutool. It =
was=20
> very helpful to have a lean code base I was able to modify as I whished a=
nd=20
> that could easily be stepped through with gdb.
>
> While the device by now can be programmed more or less using the stock=20
> dfutool, I have made some modifications (based on=20
> http://www.usb.org/developers/devclass_docs/usbdfu10.pdf) that may be use=
ful=20
> to others; these are mainly:
>
> - When waiting for the DNLOAD_BUSY -> idle state transition, do not sleep=
 1s,=20
> but use the timeout suggested by the device in the state response. makes =
the=20
> upgrade a little bit quicker.
>
> - Between the last download request in the loop and the EOF (zero length)=
=20
> download-request, there should also be repeated get_status requests; othe=
rwise=20
> the EOF-download request would fail (for me, it did).
> The patch fixes it this way: basically, the order of get_status and downl=
oad=20
> within the download loop should better be reversed, in my eyes. Download=
=20
> should be first, and get_status should wait for idle state.
>
> - After the EOF download request, some devices want to get put into=20
> manifestation state (initiated by get_status) where the write operation c=
ould=20
> be finished and the device can reset itself. I have implemented this.

Great!=20=20

I've also looked into using dfutool for other DFU capable devices in the
past (actually a DFU based PIC18F bootloader I wrote myself), but ran
into a few issues where it became difficult to both follow the spec and
allow dfutool to work.  I assume that's because dfutool is adapted to
real world devices.

This is so long ago that I don't think the patches apply cleanly anymore
(this was done two years ago).  So I'm the complete copies of my
modified dfu.{c,h} and dfutool.c, hoping that some of it may be useful
to you or anyone else.

Do note that my focus was getting this to work with my device, and that
there probably are lots of fixes needed to avoid loosing compatibility
with the original dfutool.

I see that I did quote parts of the spec here and there when I had to
change things to be conformant.  I'd really like to hear about it if
anyone disagrees with my interpretation of the spec.  It's not like it's
all crystal clear to me...


> I didn't find information about the current state and goals for dfutool. =
Would=20
> you mind elaborating a little about this?
> Is dfutool only targeted at bluetooth device firmware upgrades? Does it c=
over=20
> the full range of bluetooth devices (this would surprise me since DFU pro=
tocol=20
> implementations seem to differ from device to device. there are various=20
> different tools for linux, each with its own strength/weakness/list of=20
> supported target devices)?=20
>
> I'm curious about any experience of how devices in practise do differ in=
=20
> details when talking to them via DFU. With DfuSe by STMicroelectronics th=
ere=20
> is an effort of an DFU extension that allows devices to announce their=20
> capabilities (memory layout, alternative memory settings to choose from, =
add=20
> generic 'function' list and functions such as LIST_FUNCTIONS, SET_POINTER=
,=20
> ERASE). I'm not considering to use it since it appears to be a little com=
plex=20
> for simple consumer devices. I consider it dangerous as well, since=20
> SET_POINTER/ERASE allows to access any memory area, not just the one rese=
rved=20
> for the firmware image, possibly making the device not recoverable via DF=
U.=20
> And ironically, is incompatible to most dfu tools because in UPLOAD/DOWNL=
OAD=20
> requests, the blocks 0 and 1 are reserved for the generic function extens=
ion=20
> thing (data blocks are numbered from 2 to n instead of 0 to n. when used =
with=20
> e.g. dfutool, the device would get into STATUS_ERRSTALLEDPKT because it's=
=20
> forbidden to DNLOAD to block 1).
>
> Another question regarding the hardcoded upload/download packet size of 1=
023=20
> bytes (in dfutool.c): Why this and not e.g. 1024? (I'm going to use a fix=
ed=20
> size of 1024 because this allows usb firmware code to erase one page of f=
lash=20
> memory and program it in one go).

This was one of my issues too.  Given a device with extremely limited
amounts of RAM, the hardcoded packet size became a real problem.  If you
look at my code below, it uses the packet size from the DFU desciptor.
This should probably fall back to using 1023 for all the real world
devices without a DFU functional decriptor (guessing they must exist) or
with bogus packet sizes (e.g. 0).



Bj=C3=B8rn


--=-=-=
Content-Type: text/x-chdr; charset=utf-8
Content-Disposition: attachment; filename=dfu.h
Content-Transfer-Encoding: quoted-printable

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2003-2007  Marcel Holtmann <marcel@holtmann.org>
 *  Copyright 2007           Bj=C3=B8rn Mork <bjorn@mork.no>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 *
 */

#include <stdint.h>

/* DFU Interface Class SubClass Code */
#define DFU_INTF_SUBCLASS          0x01

/* DFU Interface Class Protocol Codes */
#define DFU_PROTOCOL_NONE          0x00
#define DFU_PROTOCOL_RUNTIME       0x01
#define DFU_PROTOCOL_DFUMODE       0x02

/* CRC interface */
uint32_t crc32_init(void);
uint32_t crc32_byte(uint32_t accum, uint8_t delta);

/* DFU descriptor */
struct usb_dfu_descriptor {
	u_int8_t  bLength;
	u_int8_t  bDescriptorType;
	u_int8_t  bmAttributes;
	u_int16_t wDetachTimeout;
	u_int16_t wTransferSize;
} __attribute__ ((packed));

/* bmAttributes */
#define DFU_CAN_DOWNLOAD	0x01
#define DFU_CAN_UPLOAD		0x02
#define DFU_MANIFEST_TOL	0x04
#define DFU_WILL_DETACH		0x08

/* DFU commands */
#define DFU_DETACH		0
#define DFU_DNLOAD		1
#define DFU_UPLOAD		2
#define DFU_GETSTATUS		3
#define DFU_CLRSTATUS		4
#define DFU_GETSTATE		5
#define DFU_ABORT		6

/* DFU status */
struct dfu_status {
	uint8_t bStatus;
	uint8_t bwPollTimeout[3];
	uint8_t bState;
	uint8_t iString;
} __attribute__ ((packed));
#define DFU_STATUS_SIZE 6

/* DFU status */
#define DFU_OK			0x00
#define DFU_ERR_TARGET		0x01
#define DFU_ERR_FILE		0x02
#define DFU_ERR_WRITE		0x03
#define DFU_ERR_ERASE		0x04
#define DFU_ERR_CHECK_ERASED	0x05
#define DFU_ERR_PROG		0x06
#define DFU_ERR_VERIFY		0x07
#define DFU_ERR_ADDRESS		0x08
#define DFU_ERR_NOTDONE		0x09
#define DFU_ERR_FIRMWARE	0x0a
#define DFU_ERR_VENDOR		0x0b
#define DFU_ERR_USBR		0x0c
#define DFU_ERR_POR		0x0d
#define DFU_ERR_UNKNOWN		0x0e
#define DFU_ERR_STALLEDPKT	0x0f

/* DFU state */
#define DFU_STATE_APP_IDLE		0
#define DFU_STATE_APP_DETACH		1
#define DFU_STATE_DFU_IDLE		2
#define DFU_STATE_DFU_DNLOAD_SYNC	3
#define DFU_STATE_DFU_DNLOAD_BUSY	4
#define DFU_STATE_DFU_DNLOAD_IDLE	5
#define DFU_STATE_DFU_MANIFEST_SYNC	6
#define DFU_STATE_DFU_MANIFEST		7
#define DFU_STATE_MANIFEST_WAIT_RESET	8
#define DFU_STATE_UPLOAD_IDLE		9
#define DFU_STATE_ERROR			10

/* DFU suffix */
struct dfu_suffix {
	uint16_t bcdDevice;
	uint16_t idProduct;
	uint16_t idVendor;
	uint16_t bcdDFU;
	uint8_t  ucDfuSignature[3];
	uint8_t  bLength;
	uint32_t dwCRC;
} __attribute__ ((packed));
#define DFU_SUFFIX_SIZE 16

/* DFU interface */
int dfu_detach(struct usb_dev_handle *udev, int intf, u_int16_t timeout);
int dfu_upload(struct usb_dev_handle *udev, int intf, int block, char *buff=
er, int size);
int dfu_download(struct usb_dev_handle *udev, int intf, int block, char *bu=
ffer, int size);
int dfu_get_status(struct usb_dev_handle *udev, int intf, struct dfu_status=
 *status);
int dfu_clear_status(struct usb_dev_handle *udev, int intf);
int dfu_get_state(struct usb_dev_handle *udev, int intf, uint8_t *state);
int dfu_abort(struct usb_dev_handle *udev, int intf);
int dfu_get_dfu_descriptor(struct usb_dev_handle *udev, int intf, struct us=
b_dfu_descriptor *dfu_dsc);

char *dfu_attributes_to_string(uint8_t attrs);
char *dfu_status_to_string(uint8_t status);
char *dfu_state_to_string(uint8_t state);

--=-=-=
Content-Type: text/x-csrc; charset=utf-8
Content-Disposition: attachment; filename=dfutool.c
Content-Transfer-Encoding: quoted-printable

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2003-2007  Marcel Holtmann <marcel@holtmann.org>
 *  Copyright 2007           Bj=C3=B8rn Mork <bjorn@mork.no>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <getopt.h>
#include <malloc.h>
#include <string.h>
#include <libgen.h>
#include <endian.h>
#include <byteswap.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <usb.h>

#include "dfu.h"

#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
#define cpu_to_le16(d)  (d)
#define cpu_to_le32(d)  (d)
#define le16_to_cpu(d)  (d)
#define le32_to_cpu(d)  (d)
#elif __BYTE_ORDER =3D=3D __BIG_ENDIAN
#define cpu_to_le16(d)  bswap_16(d)
#define cpu_to_le32(d)  bswap_32(d)
#define le16_to_cpu(d)  bswap_16(d)
#define le32_to_cpu(d)  bswap_32(d)
#else
#error "Unknown byte order"
#endif

#ifdef NEED_USB_GET_BUSSES
static inline struct usb_bus *usb_get_busses(void)
{
	return usb_busses;
}
#endif

#ifndef USB_CLASS_APPLICATION
#define USB_CLASS_APPLICATION	0xfe
#endif

#ifndef VERSION
#define VERSION "0.01"
#endif

static struct usb_interface_descriptor *get_interface(struct usb_device *de=
v)
{
	int c, i, a;

	for (c =3D 0; c < dev->descriptor.bNumConfigurations; c++) {
		struct usb_config_descriptor *config =3D &dev->config[c];

		for (i =3D 0; i < config->bNumInterfaces; i++) {
			struct usb_interface *interface =3D &config->interface[i];

			for (a =3D 0; a < interface->num_altsetting; a++) {
				struct usb_interface_descriptor *desc =3D &interface->altsetting[a];

				if (desc->bInterfaceClass !=3D USB_CLASS_APPLICATION)
					continue;
				if (desc->bInterfaceSubClass !=3D DFU_INTF_SUBCLASS)
					continue;

				return desc;
			}
		}
	}

	return NULL;
}

static void print_device(struct usb_device *dev)
{
	struct usb_interface_descriptor *desc =3D get_interface(dev);
	printf("Bus %s Device %s: ID %04x:%04x Interface %d%s\n",
		dev->bus->dirname, dev->filename,
		dev->descriptor.idVendor, dev->descriptor.idProduct,
		desc->bInterfaceNumber,
		desc->bInterfaceProtocol =3D=3D DFU_PROTOCOL_DFUMODE ? " (DFU mode)" : ""=
);


/* NOTE: 1668:2441 Actiontec Electronics, Inc. [hex] uses bInterfaceProtoco=
l =3D DFU_PROTOCOL_NONE
   in both runtime and dfu mode:

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass       254 Application Specific Interface
      bInterfaceSubClass      1 Device Firmware Update
      bInterfaceProtocol      0=20
      iInterface              0=20


   This is not complying with version 1.1 of the DFU spec, but I guess we m=
ust handle it
*/

}


static void print_status(struct usb_dev_handle *udev, struct dfu_status sta=
tus)
{
	unsigned long timeout =3D (status.bwPollTimeout[2]<<16) | (status.bwPollTi=
meout[1]<<8) | status.bwPollTimeout[0];=20
	char msg[255] =3D "";
	if (status.iString)
		usb_get_string_simple(udev, status.iString, msg, sizeof(msg));
	printf("dfu_status =3D { bStatus =3D %s, bwPollTimeout =3D %lu, bState =3D=
 %s, iString =3D %d %s }\n", dfu_status_to_string(status.bStatus),=20
	       timeout, dfu_state_to_string(status.bState), status.iString, msg);
}

static void print_dfu_descriptor(struct usb_dfu_descriptor dfu_dsc)
{
	printf("    DFU descriptor\n"=20
	       "      bLength%18d\n"
	       "      bDescriptorType      0x%02x\n"
	       "      bmAttributes         0x%02x %s\n"
	       "      wDetachTimeout%11d ms\n"
	       "      wTransferSize      0x%04x 1x %d bytes\n",=20
	       dfu_dsc.bLength,=20
	       dfu_dsc.bDescriptorType,=20
	       dfu_dsc.bmAttributes, dfu_attributes_to_string(dfu_dsc.bmAttributes=
),
	       dfu_dsc.wDetachTimeout,=20=20
	       dfu_dsc.wTransferSize, dfu_dsc.wTransferSize);
}

static void dfu_sleep(struct dfu_status status)
{
	unsigned long timeout;

	timeout =3D (status.bwPollTimeout[2] << 16) | (status.bwPollTimeout[1] << =
8) | status.bwPollTimeout[0];
	usleep(timeout * 1000);
}

static struct usb_dev_handle *open_device(char *device, struct dfu_suffix *=
suffix, struct usb_dfu_descriptor *dfu_dsc)
{
	struct usb_bus *bus;
	struct usb_device *dev, *dfu_dev[10];
	struct usb_dev_handle *udev;
	struct dfu_status status;
	struct usb_interface_descriptor *intf_dsc;
	char str[8];
	int i, intf, sel, num =3D 0, try =3D 5, bus_id =3D -1, dev_id =3D -1;

	printf("Scanning USB busses ... ");
	fflush(stdout);

	usb_find_busses();
	usb_find_devices();

	for (bus =3D usb_get_busses(); bus; bus =3D bus->next) {
		if (bus_id > 0) {
			snprintf(str, sizeof(str) - 1, "%03i", bus_id);
			if (strcmp(str, bus->dirname))
				continue;
		}

		for (dev =3D bus->devices; dev; dev =3D dev->next) {
			if (bus_id > 0 && dev_id > 0) {
				snprintf(str, sizeof(str) - 1, "%03i", dev_id);
				if (strcmp(str, dev->filename))
					continue;
			}

			if (dev->descriptor.bDeviceClass =3D=3D USB_CLASS_HUB)
				continue;

			if (num > 9 || get_interface(dev) =3D=3D NULL)
				continue;

			dfu_dev[num++] =3D dev;
		}
	}

	if (num < 1) {
		printf("\rCan't find any DFU devices\n");
		return NULL;
	}

	printf("\rAvailable devices with DFU support:\n\n");
	for (i =3D 0; i < num; i++) {
		printf("\t%2d) ", i + 1);
		print_device(dfu_dev[i]);
	}
	printf("\n");

	do {
		printf("\rSelect device (abort with 0): ");
		fflush(stdout);
		memset(str, 0, sizeof(str));
		if (!fgets(str, sizeof(str) - 1, stdin))
			continue;
		sel =3D atoi(str);
	} while (!isdigit(str[0]) || sel < 0 || sel > num );

	if (sel < 1)
		return NULL;

	sel--;

	intf_dsc =3D get_interface(dfu_dev[sel]);
	intf =3D intf_dsc->bInterfaceNumber;
	printf("\n");

	udev =3D usb_open(dfu_dev[sel]);
	if (!udev) {
		printf("Can't open device: %s (%d)\n", strerror(errno), errno);
		return NULL;
	}

	if (usb_claim_interface(udev, intf) < 0) {
		printf("Can't claim interface: %s (%d)\n", strerror(errno), errno);
		usb_close(udev);
		return NULL;
	}

=09
	if (intf_dsc->bInterfaceProtocol =3D=3D DFU_PROTOCOL_RUNTIME) {
                /* support for DFU_GET_STATUS in state DFU_STATE_APP_IDLE i=
s optional - failing is no error */
		if (dfu_get_status(udev, intf, &status) >=3D 0)
			print_status(udev, status);
		else /* assume APP_IDLE if DFU_GET_STATUS is unavailable */
			status.bState =3D DFU_STATE_APP_IDLE;=20
		/* no need to try any other commands in this mode, since they are
		   unsupported anyway... */
	} else { /* DFU_PROTOCOL_DFUMODE or DFU_PROTOCOL_NONE - both may indicate =
DFU mode */

		/* could the device be in DFU_STATE_APP_IDLE with DFU_PROTOCOL_NONE and n=
ot
		   support DFU_GET_STATUS? - if so, then this will fail=20
		   I'll leave it for now, since the only device I have using DFU_PROTOCOL=
_NONE
		   does support DFU_GET_STATUS in all states  */
		if (dfu_get_status(udev, intf, &status) < 0) {
			printf("Can't get status: %s (%d)\n", strerror(errno), errno);
			goto error;
		}
=09=09

		/* it's perfectly legal to be stuck in DFU_PROTOCOL_DFUMODE with DFU_STAT=
E_ERROR
		   if a previous firmware upgrade failed */
 		if (status.bState =3D=3D DFU_STATE_ERROR) {
	 		if (dfu_clear_status(udev, intf) < 0) {
		 		printf("Can't clear status: %s (%d)\n", strerror(errno), errno);
			 	goto error;
			}=20

			/* this should not be necessary, since DFU_CLR_STATUS always will bring =
us into
			   DFU IDLE=20

			if (dfu_abort(udev, intf) < 0) {
				printf("Can't abort previous action: %s (%d)\n", strerror(errno), errno=
);
				goto error;
			}		*/

			if (dfu_get_status(udev, intf, &status) < 0) {
			 	printf("Can't get status: %s (%d)\n", strerror(errno), errno);
			        goto error;
			}=20
			print_status(udev, status);
		}

		/* we might be stuck in any DFU MODE state - try DFU_ABORT  */
		if (status.bState > DFU_STATE_DFU_IDLE) {
			if (dfu_abort(udev, intf) < 0) {
				printf("Can't abort previous action: %s (%d)\n", strerror(errno), errno=
);
				goto error;
			}		*/

			if (dfu_get_status(udev, intf, &status) < 0) {
			 	printf("Can't get status: %s (%d)\n", strerror(errno), errno);
			        goto error;
			}=20
			print_status(udev, status);
		}
	}

	/* at this point, the device should either be in DFU mode and state DFU_ST=
ATE_DFU_IDLE
	   or in runtime mode and state DFU_STATE_APP_IDLE - anything else is an u=
nknown error */

	if (dfu_get_dfu_descriptor(udev, intf, dfu_dsc)  < 0) {
		printf("Can't get DFU descriptor: %s (%d)\n", strerror(errno), errno);
		goto error;
	}
=09
	print_dfu_descriptor(*dfu_dsc);

	if (status.bState =3D=3D DFU_STATE_DFU_IDLE) {  /* already in DFU mode - r=
eturn udev */
		if (suffix) {
			suffix->idVendor  =3D cpu_to_le16(0x0000);
			suffix->idProduct =3D cpu_to_le16(0x0000);
			suffix->bcdDevice =3D cpu_to_le16(0x0000);
		}
		return udev;
	}

	if (status.bState !=3D DFU_STATE_APP_IDLE) {  /* unknown and unhandled err=
or - bug out */
		printf("Device is not idle, can't detach it (state %s)\n", dfu_state_to_s=
tring(status.bState));
		goto error;
	}


	printf("Switching device into DFU mode ... ");
	fflush(stdout);

	if (suffix) {
		suffix->idVendor  =3D cpu_to_le16(dfu_dev[sel]->descriptor.idVendor);
		suffix->idProduct =3D cpu_to_le16(dfu_dev[sel]->descriptor.idProduct);
		suffix->bcdDevice =3D cpu_to_le16(dfu_dev[sel]->descriptor.bcdDevice);
	}


	/* my first attempt on implementing a DFU firmware made the DFU_DETACH req=
uest fail=20
	   but the actual command to succeed, due to resetting too fast - is that =
legal?=20

	   We'll assume it's not, and fail if DFU_DETACH fails
	*/
	if (dfu_detach(udev, intf, dfu_dsc->wDetachTimeout) < 0) {
		printf("\rCan't detach device: %s (%d)\n", strerror(errno), errno);
		goto error;
	}

	/* will the device initiate a detach-attach sequence? if so, then it's not
	   allowed for us to do a USB reset */
	if (dfu_dsc->bmAttributes & DFU_WILL_DETACH) {=20=20
		usb_release_interface(udev, intf);
		usb_close(udev);
		usleep(dfu_dsc->wDetachTimeout * 1000);  /* assume this indicates=20
	} else {   /* verify that State =3D=3D DFU_STATE_APP_DETACH and do a USB r=
eset */

		if (dfu_get_status(udev, intf, &status) < 0) {
			printf("\rCan't get status: %s (%d)\n", strerror(errno), errno);
			goto error;
		}
=09=09
		if (status.bState !=3D DFU_STATE_APP_DETACH) {
			printf("\rDevice is not in detach mode, try again\n");
			goto error;
		}

		usb_release_interface(udev, intf);
		usb_reset(udev);
		usb_close(udev);
	}

	bus =3D dfu_dev[sel]->bus;  /* device shouldn't change bus... */
	num =3D 0;

	while (num !=3D 1 && try-- > 0) {
		sleep(1);
		usb_find_devices();

		for (dev =3D bus->devices; dev; dev =3D dev->next) {

			if (dev->descriptor.bDeviceClass =3D=3D USB_CLASS_HUB)
				continue;

/* is this correct? - I've sort of assumed that changing VID is allowed too=
...=20
 			if (suffix && dev->descriptor.idVendor !=3D le16_to_cpu(suffix->idVendo=
r))
				continue;
*/
			intf_dsc =3D get_interface(dev);
			if (intf_dsc =3D=3D NULL)
				continue;

			if (num > 9 || intf_dsc->bInterfaceNumber !=3D 0)
				continue;

			dfu_dev[num++] =3D dev;
		}
	}

	if (num !=3D 1) {
		printf("\rCan't identify device with DFU mode\n");
		goto error;
	}

	printf("\r");

	intf =3D 0;

	udev =3D usb_open(dfu_dev[0]);
	if (!udev) {
		printf("Can't open device: %s (%d)\n", strerror(errno), errno);
		return NULL;
	}

	if (usb_claim_interface(udev, intf) < 0) {
		printf("Can't claim interface: %s (%d)\n", strerror(errno), errno);
		usb_close(udev);
		return NULL;
	}

	if (dfu_get_status(udev, intf, &status) < 0) {
		printf("Can't get status: %s (%d)\n", strerror(errno), errno);
		goto error;
	}

	if (status.bState !=3D DFU_STATE_DFU_IDLE) {
		printf("Device is not in DFU mode, can't use it\n");
		goto error;
	}
	print_status(udev, status);

	return udev;

error:
	usb_release_interface(udev, intf);
	usb_close(udev);
	return NULL;
}

static void usage(void);

static void cmd_verify(char *device, int argc, char **argv)
{
	struct stat st;
	struct dfu_suffix *suffix;
	uint32_t crc;
	uint16_t bcd;
	char str[16];
	unsigned char *buf;
	unsigned long size;
	char *filename;
	int i, fd, len;

	if (argc < 2) {
		usage();
		exit(1);
	}

	filename =3D argv[1];

	if (stat(filename, &st) < 0) {
		perror("Can't access firmware");
		exit(1);
	}

	size =3D st.st_size;

	if (!(buf =3D malloc(size))) {
		perror("Unable to allocate file buffer");=20
		exit(1);
	}

	if ((fd =3D open(filename, O_RDONLY)) < 0) {
		perror("Can't open firmware");
		free(buf);
		exit(1);
	}

	if (read(fd, buf, size) < size) {
		perror("Can't load firmware");
		free(buf);
		close(fd);
		exit(1);
	}

	printf("Filename\t%s\n", basename(filename));
	printf("Filesize\t%ld\n", size);

	crc =3D crc32_init();
	for (i =3D 0; i < size - 4; i++)
		crc =3D crc32_byte(crc, buf[i]);
	printf("Checksum\t%08x\n", crc);

	printf("\n");
	len =3D buf[size - 5];
	printf("DFU suffix\t");
	for (i =3D 0; i < len; i++) {
		printf("%02x ", buf[size - len + i]);
	}
	printf("\n\n");

	suffix =3D (struct dfu_suffix *) (buf + size - DFU_SUFFIX_SIZE);

	printf("idVendor\t%04x\n", le16_to_cpu(suffix->idVendor));
	printf("idProduct\t%04x\n", le16_to_cpu(suffix->idProduct));
	printf("bcdDevice\t%x\n", le16_to_cpu(suffix->bcdDevice));

	printf("\n");

	bcd =3D le16_to_cpu(suffix->bcdDFU);

	printf("bcdDFU\t\t%x.%x\n", bcd >> 8, bcd & 0xff);
	printf("ucDfuSignature\t%c%c%c\n", suffix->ucDfuSignature[2],
		suffix->ucDfuSignature[1], suffix->ucDfuSignature[0]);
	printf("bLength\t\t%d\n", suffix->bLength);
	printf("dwCRC\t\t%08x\n", le32_to_cpu(suffix->dwCRC));
	printf("\n");

	memset(str, 0, sizeof(str));
	memcpy(str, buf, 8);

	if (!strcmp(str, "CSR-dfu1") || !strcmp(str, "CSR-dfu2")) {
		crc =3D crc32_init();
		for (i =3D 0; i < size - DFU_SUFFIX_SIZE; i++)
			crc =3D crc32_byte(crc, buf[i]);

		printf("Firmware type\t%s\n", str);
		printf("Firmware check\t%s checksum\n", crc =3D=3D 0 ? "valid" : "corrupt=
");
		printf("\n");
	}

	free(buf);

	close(fd);
}

static void cmd_modify(char *device, int argc, char **argv)
{
}

static void cmd_upgrade(char *device, int argc, char **argv)
{
	struct usb_dev_handle *udev;
	struct dfu_status status;
	struct dfu_suffix suffix;
	struct usb_dfu_descriptor dfu_dsc;
	struct stat st;
	char *buf;
	unsigned long filesize, count, timeout =3D 0;
	char *filename;
	uint32_t crc, dwCRC;
	int fd, i, block, len, size, sent =3D 0, try =3D 10;

	if (argc < 2) {
		usage();
		exit(1);
	}

	filename =3D argv[1];

	if (stat(filename, &st) < 0) {
		perror("Can't access firmware");
		exit(1);
	}

	filesize =3D st.st_size;

	if (!(buf =3D malloc(filesize))) {
		perror("Unable to allocate file buffer");=20
		exit(1);
	}

	if ((fd =3D open(filename, O_RDONLY)) < 0) {
		perror("Can't open firmware");
		free(buf);
		exit(1);
	}

	if (read(fd, buf, filesize) < filesize) {
		perror("Can't load firmware");
		free(buf);
		close(fd);
		exit(1);
	}

	memcpy(&suffix, buf + filesize - DFU_SUFFIX_SIZE, sizeof(suffix));
	dwCRC =3D le32_to_cpu(suffix.dwCRC);

	printf("Filename\t%s\n", basename(filename));
	printf("Filesize\t%ld\n", filesize);

	crc =3D crc32_init();
	for (i =3D 0; i < filesize - 4; i++)
		crc =3D crc32_byte(crc, buf[i]);

	printf("Checksum\t%08x (%s)\n", crc,
			crc =3D=3D dwCRC ? "valid" : "corrupt");

	if (crc !=3D dwCRC) {
		free(buf);
		close(fd);
		exit(1);
	}

	printf("\n");

	udev =3D open_device(device, &suffix, &dfu_dsc);
	if (!udev)
		exit(1);

	printf("\r" "          " "          " "          " "          " "         =
 ");
	printf("\rFirmware download ... ");
	fflush(stdout);

	count =3D filesize - DFU_SUFFIX_SIZE;
	block =3D 0;

	while (count) {
		size =3D (count > dfu_dsc.wTransferSize) ? dfu_dsc.wTransferSize : count;

		if (dfu_get_status(udev, 0, &status) < 0) {
			if (try-- > 0) {
				sleep(1);
				continue;
			}
			printf("\rCan't get status: %s (%d)\n", strerror(errno), errno);
			goto done;
		}

		if (status.bStatus !=3D DFU_OK) {
			if (try-- > 0) {
				dfu_clear_status(udev, 0);
				printf("here: ");
				print_status(udev, status);
				sleep(1);
				continue;
			}
			printf("\rFirmware download ... aborting ");
			print_status(udev, status);
			goto done;
		}

		print_status(udev, status);
		dfu_sleep(status);

		printf("size=3D%d,dfu_dsc.wTransferSize=3D%d\n", size, dfu_dsc.wTransferS=
ize);

		len =3D dfu_download(udev, 0, block, buf + sent, size);
		if (len < 0) {
			if (try-- > 0) {
				printf("here2\n");
				sleep(1);
				continue;
			}
			printf("\rCan't upload next block: %s (%d)\n", strerror(errno), errno);
			goto done;
		}

		printf("\rFirmware download ... %d bytes ", block * dfu_dsc.wTransferSize=
 + len);
		fflush(stdout);

		sent  +=3D len;
		count -=3D len;
		block++;
	}

	printf("\r" "          " "          " "          " "          " "         =
 ");
	printf("\rFinishing firmware download ... ");
	fflush(stdout);

	sleep(1);



	if (dfu_get_status(udev, 0, &status) < 0) {
		printf("\rCan't get status: %s (%d)\n", strerror(errno), errno);
		goto done;
	}

	print_status(udev, status);
	dfu_sleep(status);

		sleep(2);

	len =3D dfu_download(udev, 0, block, NULL, 0);  /* send 0 byte block to fi=
nish download */
	if (len < 0) {
		printf("\rCan't send final block: %s (%d)\n", strerror(errno), errno);
		goto done;
	}

	/* should now be in MANIFEST-SYNC state. send GET_STATUS to enter MANIFEST=
 state: */
	if (dfu_get_status(udev, 0, &status) < 0) {
		printf("\rCan't get status: %s (%d)\n", strerror(errno), errno);
		goto done;
	}
	print_status(udev, status);
	dfu_sleep(status);


	/* DFU spec 1.1:

Following a successful reprogramming, the device enters one of two states: =
dfuMANIFEST-SYNC or
dfuMANIFEST-WAIT-RESET, depending on whether or not it is still capable of =
communicating via
USB. The host is aware of which state the device will enter by virtue of th=
e bmAttributes bit
bitManifestationTolerant. If the device enters dfuMANIFEST-SYNC (bitMainfes=
tationTolerant =3D 1),
then the host issues the DFU_GETSTATUS request, and the device enters the d=
fuIDLE state. At that
point, the host can perform another download, solicit an upload, or issue a=
 USB reset to return the
device to application run-time mode. If, however, the device enters the dfu=
MANIFEST-WAIT-RESET
state (bitManifestationTolerant =3D 0), then if bitWillDetach =3D 1 the dev=
ice generates a detach-attach
sequence on the bus, otherwise (bitWillDetach =3D 0) the host must issue a =
USB reset to the device.
After the bus reset the device will evaluate the firmware status and enter =
the appropriate mode.

	*/

	if (dfu_dsc.bmAttributes & DFU_MANIFEST_TOL) {
		dfu_get_status(udev, 0, &status);
		print_status(udev, status);  /* state should be MANIFEST-SYNC */

		dfu_get_status(udev, 0, &status);
		print_status(udev, status);  /* state should be DFU-IDLE */
	} /* else: state is MANIFEST-WAIT-RESET - further communication is not all=
owed! */
	printf("\r" "          " "          " "          " "          " "         =
 ");
	printf("\rWaiting for device ... ");
	fflush(stdout);

	sleep(10);

	printf("\n");

done:
	free(buf);
	close(fd);

	usb_release_interface(udev, 0);
	if (!(dfu_dsc.bmAttributes & DFU_WILL_DETACH)) usb_reset(udev); /* don't r=
eset if device already detached */
	usb_close(udev);
}

static void cmd_archive(char *device, int argc, char **argv)
{
	struct usb_dev_handle *udev;
	struct dfu_status status;
	struct dfu_suffix suffix;
	struct usb_dfu_descriptor dfu_dsc;
	char buf[2048];
	unsigned long timeout =3D 0;
	char *filename;
	uint32_t crc;
	int fd, i, n, len, try =3D 8;

	if (argc < 2) {
		usage();
		exit(1);
	}

	filename =3D argv[1];

	udev =3D open_device(device, &suffix, &dfu_dsc);
	if (!udev)
		exit(1);

	fd =3D open(filename, O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR | S_=
IRGRP | S_IROTH);
	if (fd < 0) {
		printf("Can't open firmware file: %s (%d)\n", strerror(errno), errno);
		goto done;
	}

	printf("\r" "          " "          " "          " "          " "         =
 ");
	printf("\rFirmware upload ... ");
	fflush(stdout);

	crc =3D crc32_init();
	n =3D 0;
	while (1) {
		if (dfu_get_status(udev, 0, &status) < 0) {
			if (try-- > 0) {
				sleep(1);
				continue;
			}
			printf("\rCan't get status: %s (%d)\n", strerror(errno), errno);
			goto done;
		}

		if (status.bStatus !=3D DFU_OK) {
			if (try-- > 0) {
				dfu_clear_status(udev, 0);
				sleep(1);
				continue;
			}
			printf("\rFirmware upload ... aborting ");
			print_status(udev, status);
			goto done;
		}

		if (status.bState !=3D DFU_STATE_DFU_IDLE &&
				status.bState !=3D DFU_STATE_UPLOAD_IDLE) {
			sleep(1);
			continue;
		}

		dfu_sleep(status);

		len =3D dfu_upload(udev, 0, n, buf, dfu_dsc.wTransferSize);
		if (len < 0) {
			if (try-- > 0) {
				sleep(1);
				continue;
			}
			printf("\rCan't upload next block: %s (%d)\n", strerror(errno), errno);
			goto done;
		}

		printf("\rFirmware upload ... %d bytes ", n * dfu_dsc.wTransferSize + len=
);
		fflush(stdout);

		for (i =3D 0; i < len; i++)
			crc =3D crc32_byte(crc, buf[i]);

		if (len > 0) {
			if (write(fd, buf, len) < 0) {
				printf("\rCan't write next block: %s (%d)\n", strerror(errno), errno);
				goto done;
			}
		}

		n++;
		if (len !=3D dfu_dsc.wTransferSize)  /* i.e. upload complete */
			break;
	}
	printf("\n");

	suffix.bcdDFU =3D cpu_to_le16(0x0100);
	suffix.ucDfuSignature[0] =3D 'U';
	suffix.ucDfuSignature[1] =3D 'F';
	suffix.ucDfuSignature[2] =3D 'D';
	suffix.bLength =3D DFU_SUFFIX_SIZE;

	memcpy(buf, &suffix, DFU_SUFFIX_SIZE);
	for (i =3D 0; i < DFU_SUFFIX_SIZE - 4; i++)
		crc =3D crc32_byte(crc, buf[i]);

	suffix.dwCRC =3D cpu_to_le32(crc);

	if (write(fd, &suffix, DFU_SUFFIX_SIZE) < 0)
		printf("Can't write suffix block: %s (%d)\n", strerror(errno), errno);

done:
	close(fd);

	usb_release_interface(udev, 0);
	usb_reset(udev);
	usb_close(udev);
}

static void cmd_suffix(char *device, int argc, char **argv)
{
	struct usb_dev_handle *udev;
	struct dfu_suffix suffix;
	struct usb_dfu_descriptor dfu_dsc;
	char buf[2048];
	char *filename;
	uint32_t crc;
	int fd, i, len;

	if (argc < 2) {
		usage();
		exit(1);
	}

	filename =3D argv[1];

	udev =3D open_device(device, &suffix, &dfu_dsc);
	if (!udev)
		exit(1);

	fd =3D open(filename, O_RDWR | O_APPEND, S_IRUSR | S_IWUSR | S_IRGRP | S_I=
ROTH);
	if (fd < 0) {
		printf("Can't open firmware file: %s (%d)\n", strerror(errno), errno);
		goto done;
	}
	crc =3D crc32_init();
	while (1) {
		len =3D read(fd, buf, 2048);
		if (len =3D=3D 0) break;
		for (i =3D 0; i < len; i++)
			crc =3D crc32_byte(crc, buf[i]);

	}

	suffix.bcdDFU =3D cpu_to_le16(0x0100);
	suffix.ucDfuSignature[0] =3D 'U';
	suffix.ucDfuSignature[1] =3D 'F';
	suffix.ucDfuSignature[2] =3D 'D';
	suffix.bLength =3D DFU_SUFFIX_SIZE;

	memcpy(buf, &suffix, DFU_SUFFIX_SIZE);
	for (i =3D 0; i < DFU_SUFFIX_SIZE - 4; i++)
		crc =3D crc32_byte(crc, buf[i]);

	suffix.dwCRC =3D cpu_to_le32(crc);

	if (write(fd, &suffix, DFU_SUFFIX_SIZE) < 0)
		printf("Can't write suffix block: %s (%d)\n", strerror(errno), errno);

done:
	close(fd);
}

struct {
	char *cmd;
	char *alt;
	void (*func)(char *device, int argc, char **argv);
	char *opt;
	char *doc;
} command[] =3D {
	{ "verify",  "check",    cmd_verify,  "<dfu-file>", "Check firmware file" =
        },
	{ "modify",  "change",   cmd_modify,  "<dfu-file>", "Change firmware attri=
butes"  },
	{ "upgrade", "download", cmd_upgrade, "<dfu-file>", "Download a new firmwa=
re"     },
	{ "archive", "upload",   cmd_archive, "<dfu-file>", "Upload the current fi=
rmware" },
	{ "suffix", "change",   cmd_suffix, "<dfu-file>", "Add suffix to firmware =
file" },
	{ NULL, NULL, NULL, 0, 0 }
};

static void usage(void)
{
	int i;

	printf("dfutool - Device Firmware Upgrade utility ver %s\n\n", VERSION);

	printf("Usage:\n"
		"\tdfutool [options] <command>\n"
		"\n");

	printf("Options:\n"
		"\t-d, --device <device>   USB device\n"
		"\t-h, --help              Display help\n"
		"\n");

	printf("Commands:\n");
	for (i =3D 0; command[i].cmd; i++)
		printf("\t%-8s %-10s\t%s\n", command[i].cmd,
		command[i].opt ? command[i].opt : " ",
		command[i].doc);
	printf("\n");
}

static struct option main_options[] =3D {
	{ "help",	0, 0, 'h' },
	{ "device",	1, 0, 'd' },
	{ 0, 0, 0, 0 }
};

int main(int argc, char *argv[])
{
	char *device =3D NULL;
	int i, opt;

	while ((opt =3D getopt_long(argc, argv, "+d:h", main_options, NULL)) !=3D =
-1) {
		switch(opt) {
		case 'd':
			device =3D strdup(optarg);
			break;

		case 'h':
			usage();
			exit(0);

		default:
			exit(0);
		}
	}

	argc -=3D optind;
	argv +=3D optind;
	optind =3D 0;

	if (argc < 1) {
		usage();
		exit(1);
	}

	usb_init();

	for (i =3D 0; command[i].cmd; i++) {
		if (strcmp(command[i].cmd, argv[0]) && strcmp(command[i].alt, argv[0]))
			continue;
		command[i].func(device, argc, argv);
		exit(0);
	}

	usage();
	exit(1);
}

--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment; filename=dfu.c

/*
 *
 *  BlueZ - Bluetooth protocol stack for Linux
 *
 *  Copyright (C) 2003-2007  Marcel Holtmann <marcel@holtmann.org>
 *
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <errno.h>
#include <string.h>

#include <usb.h>

#include "dfu.h"

#ifndef USB_DIR_OUT
#define USB_DIR_OUT	0x00
#endif

#ifndef USB_DIR_IN
#define USB_DIR_IN	0x80
#endif

#ifndef USB_DT_DFU
#define USB_DT_DFU	0x21
#endif

#define DFU_PACKETSIZE		0x03ff		/* CSR default value: 1023 */
#define DFU_TIMEOUT		10000

static uint32_t dfu_crc32_table[] = {
	0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419, 0x706af48f,
	0xe963a535, 0x9e6495a3, 0x0edb8832, 0x79dcb8a4, 0xe0d5e91e, 0x97d2d988,
	0x09b64c2b, 0x7eb17cbd, 0xe7b82d07, 0x90bf1d91, 0x1db71064, 0x6ab020f2,
	0xf3b97148, 0x84be41de, 0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7,
	0x136c9856, 0x646ba8c0, 0xfd62f97a, 0x8a65c9ec, 0x14015c4f, 0x63066cd9,
	0xfa0f3d63, 0x8d080df5, 0x3b6e20c8, 0x4c69105e, 0xd56041e4, 0xa2677172,
	0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b, 0x35b5a8fa, 0x42b2986c,
	0xdbbbc9d6, 0xacbcf940, 0x32d86ce3, 0x45df5c75, 0xdcd60dcf, 0xabd13d59,
	0x26d930ac, 0x51de003a, 0xc8d75180, 0xbfd06116, 0x21b4f4b5, 0x56b3c423,
	0xcfba9599, 0xb8bda50f, 0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924,
	0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d, 0x76dc4190, 0x01db7106,
	0x98d220bc, 0xefd5102a, 0x71b18589, 0x06b6b51f, 0x9fbfe4a5, 0xe8b8d433,
	0x7807c9a2, 0x0f00f934, 0x9609a88e, 0xe10e9818, 0x7f6a0dbb, 0x086d3d2d,
	0x91646c97, 0xe6635c01, 0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e,
	0x6c0695ed, 0x1b01a57b, 0x8208f4c1, 0xf50fc457, 0x65b0d9c6, 0x12b7e950,
	0x8bbeb8ea, 0xfcb9887c, 0x62dd1ddf, 0x15da2d49, 0x8cd37cf3, 0xfbd44c65,
	0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2, 0x4adfa541, 0x3dd895d7,
	0xa4d1c46d, 0xd3d6f4fb, 0x4369e96a, 0x346ed9fc, 0xad678846, 0xda60b8d0,
	0x44042d73, 0x33031de5, 0xaa0a4c5f, 0xdd0d7cc9, 0x5005713c, 0x270241aa,
	0xbe0b1010, 0xc90c2086, 0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
	0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4, 0x59b33d17, 0x2eb40d81,
	0xb7bd5c3b, 0xc0ba6cad, 0xedb88320, 0x9abfb3b6, 0x03b6e20c, 0x74b1d29a,
	0xead54739, 0x9dd277af, 0x04db2615, 0x73dc1683, 0xe3630b12, 0x94643b84,
	0x0d6d6a3e, 0x7a6a5aa8, 0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1,
	0xf00f9344, 0x8708a3d2, 0x1e01f268, 0x6906c2fe, 0xf762575d, 0x806567cb,
	0x196c3671, 0x6e6b06e7, 0xfed41b76, 0x89d32be0, 0x10da7a5a, 0x67dd4acc,
	0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5, 0xd6d6a3e8, 0xa1d1937e,
	0x38d8c2c4, 0x4fdff252, 0xd1bb67f1, 0xa6bc5767, 0x3fb506dd, 0x48b2364b,
	0xd80d2bda, 0xaf0a1b4c, 0x36034af6, 0x41047a60, 0xdf60efc3, 0xa867df55,
	0x316e8eef, 0x4669be79, 0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236,
	0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f, 0xc5ba3bbe, 0xb2bd0b28,
	0x2bb45a92, 0x5cb36a04, 0xc2d7ffa7, 0xb5d0cf31, 0x2cd99e8b, 0x5bdeae1d,
	0x9b64c2b0, 0xec63f226, 0x756aa39c, 0x026d930a, 0x9c0906a9, 0xeb0e363f,
	0x72076785, 0x05005713, 0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38,
	0x92d28e9b, 0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21, 0x86d3d2d4, 0xf1d4e242,
	0x68ddb3f8, 0x1fda836e, 0x81be16cd, 0xf6b9265b, 0x6fb077e1, 0x18b74777,
	0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c, 0x8f659eff, 0xf862ae69,
	0x616bffd3, 0x166ccf45, 0xa00ae278, 0xd70dd2ee, 0x4e048354, 0x3903b3c2,
	0xa7672661, 0xd06016f7, 0x4969474d, 0x3e6e77db, 0xaed16a4a, 0xd9d65adc,
	0x40df0b66, 0x37d83bf0, 0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
	0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6, 0xbad03605, 0xcdd70693,
	0x54de5729, 0x23d967bf, 0xb3667a2e, 0xc4614ab8, 0x5d681b02, 0x2a6f2b94,
	0xb40bbe37, 0xc30c8ea1, 0x5a05df1b, 0x2d02ef8d
};

uint32_t crc32_init(void)
{
	return 0xffffffff;
}

uint32_t crc32_byte(uint32_t accum, uint8_t delta)
{
	return dfu_crc32_table[(accum ^ delta) & 0xff] ^ (accum >> 8);
}

int dfu_detach(struct usb_dev_handle *udev, int intf, u_int16_t timeout)
{
	if (!udev)
		return -EIO;

	return usb_control_msg(udev, USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
		DFU_DETACH, timeout, intf, NULL, 0, DFU_TIMEOUT);
}

int dfu_upload(struct usb_dev_handle *udev, int intf, int block, char *buffer, int size)
{
	if (!udev)
		return -EIO;

	return usb_control_msg(udev, USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE,
		DFU_UPLOAD, block, intf, buffer, size, DFU_TIMEOUT);
}

int dfu_download(struct usb_dev_handle *udev, int intf, int block, char *buffer, int size)
{
	if (!udev)
		return -EIO;

	return usb_control_msg(udev, USB_TYPE_CLASS | USB_DIR_OUT | USB_RECIP_INTERFACE,
		DFU_DNLOAD, block, intf, buffer, size, DFU_TIMEOUT);
}

int dfu_get_status(struct usb_dev_handle *udev, int intf, struct dfu_status *status)
{
	if (!udev || !status)
		return -EIO;

	return usb_control_msg(udev, USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE,
		DFU_GETSTATUS, 0, intf, (char *) status, DFU_STATUS_SIZE, DFU_TIMEOUT);
}

int dfu_clear_status(struct usb_dev_handle *udev, int intf)
{
	if (!udev)
		return -EIO;

	return usb_control_msg(udev, USB_TYPE_CLASS | USB_DIR_OUT | USB_RECIP_INTERFACE,
		DFU_CLRSTATUS, 0, intf, NULL, 0, DFU_TIMEOUT);
}

int dfu_get_state(struct usb_dev_handle *udev, int intf, uint8_t *state)
{
	if (!udev || !state)
		return -EIO;

	return usb_control_msg(udev, USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE,
		DFU_GETSTATE, 0, intf, (char *) state, 1, DFU_TIMEOUT);
}

int dfu_abort(struct usb_dev_handle *udev, int intf)
{
	if (!udev)
		return -EIO;

	return usb_control_msg(udev, USB_TYPE_CLASS | USB_DIR_OUT | USB_RECIP_INTERFACE,
		DFU_ABORT, 0, intf, NULL, 0, DFU_TIMEOUT);
}


/* libusb lacks a USB_RECIP_INTERFACE, GET_DESCRIPTOR interface */
int dfu_get_dfu_descriptor(struct usb_dev_handle *udev, int intf, struct usb_dfu_descriptor *dfu_dsc)
{
	return usb_control_msg(udev, USB_RECIP_INTERFACE | USB_ENDPOINT_IN, USB_REQ_GET_DESCRIPTOR, 
			       0x21<<8, intf, (char *) dfu_dsc, sizeof(struct usb_dfu_descriptor), DFU_TIMEOUT);
}



/* bmAttributes */
char *dfu_attributes_to_string(uint8_t attrs)
{
	char *msg = NULL;
	switch (attrs) {
	case 0x00:
		msg = "<none>";
		break;
	case DFU_CAN_DOWNLOAD: /* 0x01 */
		msg = "DFU_CAN_DOWNLOAD";
		break;
	case DFU_CAN_UPLOAD:   /* 0x02 */
		msg = "DFU_CAN_UPLOAD";
		break;
	case DFU_CAN_DOWNLOAD|DFU_CAN_UPLOAD: /* 0x03 */
		msg = "DFU_CAN_DOWNLOAD|DFU_CAN_UPLOAD";
		break;
	case DFU_MANIFEST_TOL: /* 0x04 */
		msg = "DFU_MANIFEST_TOL";
		break;
	case DFU_MANIFEST_TOL|DFU_CAN_DOWNLOAD: /* 0x05 */
		msg = "DFU_MANIFEST_TOL|DFU_CAN_DOWNLOAD";
		break;
	case DFU_MANIFEST_TOL|DFU_CAN_UPLOAD:   /* 0x06 */
		msg = "DFU_MANIFEST_TOL|DFU_CAN_UPLOAD";
		break;
	case DFU_MANIFEST_TOL|DFU_CAN_UPLOAD|DFU_CAN_DOWNLOAD: /* 0x07 */
		msg = "DFU_MANIFEST_TOL|DFU_CAN_UPLOAD|DFU_CAN_DOWNLOAD";
		break;
	case DFU_WILL_DETACH: /* 0x08 */
		msg = "DFU_WILL_DETACH";
		break;
	case DFU_WILL_DETACH|DFU_CAN_DOWNLOAD: /* 0x09 */
		msg = "DFU_WILL_DETACH|DFU_CAN_DOWNLOAD";
		break;
	case DFU_WILL_DETACH|DFU_CAN_UPLOAD: /* 0x10 */
		msg = "DFU_WILL_DETACH|DFU_CAN_UPLOAD";
		break;
	case DFU_WILL_DETACH|DFU_CAN_UPLOAD|DFU_CAN_DOWNLOAD: /* 0x11 */
		msg = "DFU_WILL_DETACH|DFU_CAN_UPLOAD|DFU_CAN_DOWNLOAD";
		break;
	case DFU_WILL_DETACH|DFU_MANIFEST_TOL: /* 0x12 */
		msg = "DFU_WILL_DETACH|DFU_MANIFEST_TOL";
		break;
	case DFU_WILL_DETACH|DFU_MANIFEST_TOL|DFU_CAN_DOWNLOAD: /* 0x13 */
		msg = "DFU_WILL_DETACH|DFU_MANIFEST_TOL|DFU_CAN_DOWNLOAD";
		break;
	case DFU_WILL_DETACH|DFU_MANIFEST_TOL|DFU_CAN_UPLOAD: /* 0x14 */
		msg = "DFU_WILL_DETACH|DFU_MANIFEST_TOL|DFU_CAN_UPLOAD";
		break;
	case DFU_WILL_DETACH|DFU_MANIFEST_TOL|DFU_CAN_UPLOAD|DFU_CAN_DOWNLOAD: /* 0x15 */
		msg = "DFU_WILL_DETACH|DFU_MANIFEST_TOL|DFU_CAN_UPLOAD|DFU_CAN_DOWNLOAD";
		break;
	}
	return msg;
}

/* DFU status */
char *dfu_status_to_string(uint8_t status)
{
	char *msg = NULL;
	switch (status) {
	case DFU_OK:
		msg = "DFU_OK";
		break;
	case DFU_ERR_TARGET:
		msg = "DFU_ERR_TARGET";
		break;
	case DFU_ERR_FILE:
		msg = "DFU_ERR_FILE";
		break;
	case DFU_ERR_WRITE:
		msg = "DFU_ERR_WRITE";
		break;
	case DFU_ERR_ERASE:
		msg = "DFU_ERR_ERASE";
		break;
	case DFU_ERR_CHECK_ERASED:
		msg = "DFU_ERR_CHECK_ERASED";
		break;
	case DFU_ERR_PROG:
		msg = "DFU_ERR_PROG";
		break;
	case DFU_ERR_VERIFY:
		msg = "DFU_ERR_VERIFY";
		break;
	case DFU_ERR_ADDRESS:
		msg = "DFU_ERR_ADDRESS";
		break;
	case DFU_ERR_NOTDONE:
		msg = "DFU_ERR_NOTDONE";
		break;
	case DFU_ERR_FIRMWARE:
		msg = "DFU_ERR_FIRMWARE";
		break;
	case DFU_ERR_VENDOR:
		msg = "DFU_ERR_VENDOR";
		break;
	case DFU_ERR_USBR:
		msg = "DFU_ERR_USBR";
		break;
	case DFU_ERR_POR:
		msg = "DFU_ERR_POR";
		break;
	case DFU_ERR_UNKNOWN:
		msg = "DFU_ERR_UNKNOWN";
		break;
	case DFU_ERR_STALLEDPKT:
		msg = "DFU_ERR_STALLEDPKT";
		break;
	}
	return msg;
}

/* DFU state */
char *dfu_state_to_string(uint8_t state )
{
	char *msg = NULL;
	switch (state) {
	case DFU_STATE_APP_IDLE:
		msg = "DFU_STATE_APP_IDLE";
		break;
	case DFU_STATE_APP_DETACH:
		msg = "DFU_STATE_APP_DETACH";
		break;
	case DFU_STATE_DFU_IDLE:
		msg = "DFU_STATE_DFU_IDLE";
		break;
	case DFU_STATE_DFU_DNLOAD_SYNC:
		msg = "DFU_STATE_DFU_DNLOAD_SYNC";
		break;
	case DFU_STATE_DFU_DNLOAD_BUSY:
		msg = "DFU_STATE_DFU_DNLOAD_BUSY";
		break;
	case DFU_STATE_DFU_DNLOAD_IDLE:
		msg = "DFU_STATE_DFU_DNLOAD_IDLE";
		break;
	case DFU_STATE_DFU_MANIFEST_SYNC:
		msg = "DFU_STATE_DFU_MANIFEST_SYNC";
		break;
	case DFU_STATE_DFU_MANIFEST:
		msg = "DFU_STATE_DFU_MANIFEST";
		break;
	case DFU_STATE_MANIFEST_WAIT_RESET:
		msg = "DFU_STATE_MANIFEST_WAIT_RESET";
		break;
	case DFU_STATE_UPLOAD_IDLE:
		msg = "DFU_STATE_UPLOAD_IDLE";
		break;
	case DFU_STATE_ERROR:
		msg = "DFU_STATE_ERROR";
		break;
	}
	return msg;
}

--=-=-=--
