Return-Path: <cyrus@holtmann.org>
From: "Poulain, Loic" <loic.poulain@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCHv3] tools: add bcm43xx specific init in hciattach
Date: Tue, 1 Apr 2014 20:56:27 +0000
Message-ID: <50C3158CF44D924791C15F1437EF2EC65D731F@HASMSX104.ger.corp.intel.com>
References: <50C3158CF44D924791C15F1437EF2EC65D65DB@HASMSX104.ger.corp.intel.com>
 <8EB7E4EA-4933-4282-8663-8B932B0A38E6@holtmann.org>
In-Reply-To: <8EB7E4EA-4933-4282-8663-8B932B0A38E6@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks, I'm going to rework this patch.

Regards,
Loic Poulain

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org] =

Sent: Tuesday, April 1, 2014 6:15 PM
To: Poulain, Loic
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3] tools: add bcm43xx specific init in hciattach

Hi Loic,

> Add a bcm43xx specific init sequence in hciattach in order to =

> initialize bcm43xx controllers.
> ---
> Makefile.tools            |   3 +-
> tools/hciattach.c         |  13 +-
> tools/hciattach.h         |   2 +
> tools/hciattach_bcm43xx.c | 373 =

> ++++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 388 insertions(+), 3 deletions(-) create mode 100644 =

> tools/hciattach_bcm43xx.c
> =

> diff --git a/Makefile.tools b/Makefile.tools index 4dc9380..f618a97 =

> 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -182,7 +182,8 @@ tools_hciattach_SOURCES =3D tools/hciattach.c tools/h=
ciattach.h \
> 						tools/hciattach_tialt.c \
> 						tools/hciattach_ath3k.c \
> 						tools/hciattach_qualcomm.c \
> -						tools/hciattach_intel.c
> +						tools/hciattach_intel.c \
> +						tools/hciattach_bcm43xx.c
> tools_hciattach_LDADD =3D lib/libbluetooth-internal.la
> =

> tools_hciconfig_SOURCES =3D tools/hciconfig.c tools/csr.h tools/csr.c =

> diff --git a/tools/hciattach.c b/tools/hciattach.c index =

> db01b85..c700b5a 100644
> --- a/tools/hciattach.c
> +++ b/tools/hciattach.c
> @@ -84,9 +84,9 @@ static void sig_alarm(int sig)
> 	exit(1);
> }
> =

> -static int uart_speed(int s)
> +int uart_speed(int speed)
> {
> -	switch (s) {
> +	switch (speed) {
> 	case 9600:
> 		return B9600;
> 	case 19200:

this change is not really needed or is it?

> @@ -327,6 +327,11 @@ static int intel(int fd, struct uart_t *u, struct te=
rmios *ti)
> 	return intel_init(fd, u->init_speed, &u->speed, ti); }
> =

> +static int bcm43xx(int fd, struct uart_t *u, struct termios *ti) {
> +	return bcm43xx_init(fd, u->speed, ti, u->bdaddr); }
> +
> static int read_check(int fd, void *buf, int count) {
> 	int res;
> @@ -1135,6 +1140,10 @@ struct uart_t uart[] =3D {
> 	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4,   115200, 460800,
> 				FLOW_CTL, DISABLE_PM, NULL, bcm2035  },
> =

> +	/* Broadcom BCM43XX */
> +	{ "bcm43xx",    0x0000, 0x0000, HCI_UART_H4,   115200, 3000000,
> +				FLOW_CTL, DISABLE_PM, NULL, bcm43xx, NULL  },
> +
> 	{ "ath3k",    0x0000, 0x0000, HCI_UART_ATH3K, 115200, 115200,
> 			FLOW_CTL, DISABLE_PM, NULL, ath3k_ps, ath3k_pm  },
> =

> diff --git a/tools/hciattach.h b/tools/hciattach.h index =

> 1b23ad7..4810a09 100644
> --- a/tools/hciattach.h
> +++ b/tools/hciattach.h
> @@ -46,6 +46,7 @@
> =

> int read_hci_event(int fd, unsigned char *buf, int size); int =

> set_speed(int fd, struct termios *ti, int speed);
> +int uart_speed(int speed);
> =

> int texas_init(int fd, int *speed, struct termios *ti); int =

> texas_post(int fd, struct termios *ti); @@ -57,3 +58,4 @@ int =

> ath3k_init(int fd, int speed, int init_speed, char *bdaddr, int =

> ath3k_post(int fd, int pm); int qualcomm_init(int fd, int speed, =

> struct termios *ti, const char *bdaddr); int intel_init(int fd, int =

> init_speed, int *speed, struct termios *ti);
> +int bcm43xx_init(int fd, int speed, struct termios *ti, const char =

> +*bdaddr);
> diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c new =

> file mode 100644 index 0000000..b38bd67
> --- /dev/null
> +++ b/tools/hciattach_bcm43xx.c
> @@ -0,0 +1,373 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2014 Intel Corporation
> + *
> + *
> + *  This program is free software; you can redistribute it and/or =

> +modify
> + *  it under the terms of the GNU General Public License as published =

> +by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program. If not, see <http://www.gnu.org/licenses/>.
> + *
> + */

please use the copyright template provided by all files inside BlueZ. I wan=
t to keep it consistent.

> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <termios.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <dirent.h>
> +#include <time.h>
> +
> +#include <bluetooth/bluetooth.h>
> +#include <bluetooth/hci.h>
> +#include <bluetooth/hci_lib.h>
> +
> +#include "hciattach.h"
> +
> +#ifndef FIRMWARE_DIR
> +#define FIRMWARE_DIR "/etc/firmware"
> +#endif
> +
> +#define BCM43XX_CLOCK_48 1
> +#define BCM43XX_CLOCK_24 2
> +
> +/* HCI packet type*/
> +#define HCI_CMD 0x01
> +#define HCI_EVT 0x04

since you include bluetooth/hci.h, we do have these packet types defined as=
 HCI_COMMAND_PKT and HCI_EVENT_PKT.

> +
> +#define CMD_SUCCESS 0x00
> +
> +#define CC_MIN_SIZE 7
> +
> +#define MIN(X,Y) ((X) < (Y) ? (X) : (Y))
> +
> +static int bcm43xx_read_local_name(int fd, char *name, size_t size) {
> +	unsigned char cmd[] =3D {HCI_CMD, 0x14, 0x0C, 0x00};
> +	unsigned char *resp;
> +	unsigned int name_len;
> +
> +	resp =3D malloc(size + CC_MIN_SIZE);
> +	if (!resp) {
> +		return -1;
> +	}
> +
> +	tcflush(fd, TCIOFLUSH);
> +
> +	if (write(fd, cmd, sizeof(cmd)) !=3D sizeof(cmd)) {
> +		fprintf(stderr, "Failed to write read local name command\n");
> +		goto fail;
> +	}
> +
> +	if (read_hci_event(fd, resp, size) < CC_MIN_SIZE) {
> +		fprintf(stderr, "Failed to read local name, invalid HCI event\n");
> +		goto fail;
> +	}
> +
> +	if (resp[4] !=3D cmd[1] || resp[5] !=3D cmd[2] || resp[6] !=3D CMD_SUCC=
ESS) {
> +		fprintf(stderr, "Failed to read local name, command failure\n");
> +		goto fail;
> +	}
> +
> +	name_len =3D (uint8_t)resp[2] - 1;
> +
> +	strncpy(name, (char *)&resp[7], MIN(name_len, size));
> +	name[size - 1] =3D 0;
> +
> +	free(resp);
> +	return 0;
> +
> +fail:
> +	free(resp);
> +	return -1;
> +}
> +
> +static int bcm43xx_reset(int fd)
> +{
> +	unsigned char cmd[] =3D {HCI_CMD, 0x03, 0x0C, 0x00};
> +	unsigned char resp[CC_MIN_SIZE];
> +
> +	if (write(fd, cmd, sizeof(cmd)) !=3D sizeof(cmd)) {
> +		fprintf(stderr, "Failed to write reset command\n");
> +		return -1;
> +	}
> +
> +	if (read_hci_event(fd, resp, sizeof(resp)) < CC_MIN_SIZE) {
> +		fprintf(stderr, "Failed to reset chip, invalid HCI event\n");
> +		return -1;
> +	}
> +
> +	if (resp[4] !=3D cmd[1] || resp[5] !=3D cmd[2] || resp[6] !=3D CMD_SUCC=
ESS) {
> +		fprintf(stderr, "Failed to reset chip, command failure\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm43xx_set_bdaddr(int fd, const char *bdaddr) {
> +	unsigned char cmd[] =3D
> +			{HCI_CMD, 0x01, 0xfc, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
> +	unsigned char resp[CC_MIN_SIZE];
> +
> +	printf("Set BDADDR UART: %s\n", bdaddr);
> +
> +	if (strlen(bdaddr) !=3D 17) {
> +		fprintf(stderr, "Incorrect bdaddr\n");
> +		return -1;
> +	}
> +
> +	str2ba(bdaddr, (bdaddr_t *) (&cmd[4]));
> +
> +	tcflush(fd, TCIOFLUSH);
> +
> +	if (write(fd, cmd, sizeof(cmd)) !=3D sizeof(cmd)) {
> +		fprintf(stderr, "Failed to write set bdaddr command\n");
> +		return -1;
> +	}
> +
> +	if (read_hci_event(fd, resp, sizeof(resp)) < CC_MIN_SIZE) {
> +		fprintf(stderr, "Failed to set bdaddr, invalid HCI event\n");
> +		return -1;
> +	}
> +
> +	if (resp[4] !=3D cmd[1] || resp[5] !=3D cmd[2] || resp[6] !=3D CMD_SUCC=
ESS) {
> +		fprintf(stderr, "Failed to set bdaddr, command failure\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm43xx_set_speed(int fd, uint32_t speed) {
> +	unsigned char cmd[] =3D
> +		{HCI_CMD, 0x18, 0xfc, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
> +	unsigned char resp[CC_MIN_SIZE];
> +	int len, i;
> +
> +	printf("Set Controller UART speed to %d bit/s\n", speed);
> +
> +	cmd[6] =3D (uint8_t)(speed);
> +	cmd[7] =3D (uint8_t)(speed >> 8);
> +	cmd[8] =3D (uint8_t)(speed >> 16);
> +	cmd[9] =3D (uint8_t)(speed >> 24);
> +
> +	tcflush(fd, TCIOFLUSH);
> +
> +	if (write(fd, cmd, sizeof(cmd)) !=3D sizeof(cmd)) {
> +		fprintf(stderr, "Failed to write update baudrate command\n");
> +		return -1;
> +	}
> +
> +	if ((len =3D read_hci_event(fd, resp, sizeof(resp))) < CC_MIN_SIZE) {
> +		fprintf(stderr, "Failed to update baudrate, invalid HCI event\n");
> +		return -1;
> +	}
> +
> +	if (resp[4] !=3D cmd[1] || resp[5] !=3D cmd[2] || resp[6] !=3D CMD_SUCC=
ESS) {
> +		fprintf(stderr, "Failed to update baudrate, command failure\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm43xx_set_clock(int fd, uint8_t clock) {
> +	unsigned char cmd[] =3D {HCI_CMD, 0x45, 0xfc, 0x01, 0x00};
> +	unsigned char resp[CC_MIN_SIZE];
> +
> +	printf("Set Controller clock (%d)\n", clock);
> +
> +	cmd[4] =3D (unsigned char)clock;
> +
> +	tcflush(fd, TCIOFLUSH);
> +
> +	if (write(fd, cmd, sizeof(cmd)) !=3D sizeof(cmd)) {
> +		fprintf(stderr, "Failed to write update clock command\n");
> +		return -1;
> +	}
> +
> +	if (read_hci_event(fd, resp, sizeof(resp)) < CC_MIN_SIZE) {
> +		fprintf(stderr, "Failed to update clock, invalid HCI event\n");
> +		return -1;
> +	}
> +
> +	if (resp[4] !=3D cmd[1] || resp[5] !=3D cmd[2] || resp[6] !=3D CMD_SUCC=
ESS) {
> +		fprintf(stderr, "Failed to update clock, command failure\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bcm43xx_load_firmware(int fd, const char *fw) {
> +	unsigned char cmd[] =3D {HCI_CMD, 0x2e, 0xfc, 0x00 };
> +	struct timespec tm_mode =3D {0, 50000};
> +	struct timespec tm_ready =3D {0, 2000000};
> +	unsigned char resp[CC_MIN_SIZE];
> +	unsigned char tx_buf[1024];
> +	int len;
> +
> +	printf("Flash firmware %s\n", fw);
> +
> +	int fd_fw =3D open(fw, O_RDONLY);
> +	if (fd_fw < 0) {
> +		fprintf(stderr, "Unable to open firmware (%s)\n", fw);
> +		return -1;
> +	}
> +
> +	tcflush(fd, TCIOFLUSH);
> +
> +	if (write(fd, cmd, sizeof(cmd)) !=3D sizeof(cmd)) {
> +		fprintf(stderr, "Failed to write download mode command\n");
> +		return -1;
> +	}
> +
> +	if (read_hci_event(fd, resp, sizeof(resp)) < CC_MIN_SIZE) {
> +		fprintf(stderr, "Failed to load firmware, invalid HCI event\n");
> +		return -1;
> +	}
> +
> +	if (resp[4] !=3D cmd[1] || resp[5] !=3D cmd[2] || resp[6] !=3D CMD_SUCC=
ESS) {
> +		fprintf(stderr, "Failed to load firmware, command failure\n");
> +		return -1;
> +	}
> +
> +	/* Wait 50ms to let the firmware placed in download mode */
> +	nanosleep(&tm_mode, NULL);
> +
> +	tcflush(fd, TCIOFLUSH);
> +
> +	while (read(fd_fw, &tx_buf[1], 3)) {
> +		tx_buf[0] =3D HCI_CMD;
> +
> +		len =3D tx_buf[3];
> +
> +		read(fd_fw, &tx_buf[4], len);
> +
> +		if (write(fd, tx_buf, len + 4) !=3D (len + 4)) {
> +			fprintf(stderr, "Failed to write firmware\n");
> +			return -1;
> +		}
> +
> +		read_hci_event(fd, resp, sizeof(resp));
> +		tcflush(fd, TCIOFLUSH);
> +	}
> +
> +	close(fd_fw);
> +
> +	/* Wait for firmware ready */
> +	nanosleep(&tm_ready, NULL);
> +
> +	return 0;
> +}
> +
> +static int
> +bcm43xx_locate_patch(const char *dir_name, const char *chip_name, =

> +char *location) {
> +	DIR *dir;
> +	struct dirent *entry;
> +	int ret =3D -1;
> +	char fw_ext[] =3D ".hcd";
> +
> +	dir =3D opendir (dir_name);
> +	if (!dir) {
> +		fprintf (stderr, "Cannot open directory '%s': %s\n",
> +				dir_name, strerror (errno));
> +		return -1;
> +	}
> +
> +	/* Recursively look for a BCM43XX*.hcd */
> +	while(1) {
> +		entry =3D readdir (dir);

		entry =3D readdir(dir);

> +		if (!entry)
> +			break;
> +
> +		if (entry->d_type & DT_DIR) {
> +			char path[PATH_MAX];
> +
> +			if (!strcmp(entry->d_name, "..") || !strcmp(entry->d_name, "."))
> +				continue;
> +
> +			snprintf(path, PATH_MAX, "%s/%s", dir_name, entry->d_name);
> +
> +			ret =3D bcm43xx_locate_patch(path, chip_name, location);
> +			if (!ret)
> +				break;
> +		} else if (!strncmp(chip_name, entry->d_name, strlen(chip_name))) {
> +			unsigned int name_len =3D strlen(entry->d_name);
> +			unsigned int curs_ext =3D name_len - sizeof(fw_ext) + 1;
> +
> +			if (curs_ext > name_len)
> +				break;
> +
> +			if (strncmp(fw_ext, &entry->d_name[curs_ext], sizeof(fw_ext)))
> +				break;
> +
> +			/* found */
> +			snprintf(location, PATH_MAX, "%s/%s", dir_name, entry->d_name);
> +			ret =3D 0;
> +			break;
> +		}
> +	}
> +
> +	closedir(dir);
> +
> +	return ret;
> +}
> +
> +int bcm43xx_init(int fd, int speed, struct termios *ti, const char =

> +*bdaddr) {
> +	char chip_name[20];
> +	char fw_path[PATH_MAX];
> +
> +	printf("bcm43xx_init\n");
> +
> +	if (bcm43xx_reset(fd))
> +		return -1;
> +
> +	if (bcm43xx_read_local_name(fd, chip_name, sizeof(chip_name)))
> +		return -1;
> +
> +	if (bcm43xx_locate_patch(FIRMWARE_DIR, chip_name, fw_path)) {
> +		fprintf(stderr, "Patch not found, continue anyway\n");
> +	} else {
> +		if (bcm43xx_load_firmware(fd, fw_path))
> +			return -1;
> +
> +		if (bcm43xx_reset(fd))
> +			return -1;
> +	}
> +
> +	if (bdaddr) {
> +		bcm43xx_set_bdaddr(fd, bdaddr);
> +	}
> +
> +	if (speed > 3000000 && bcm43xx_set_clock(fd, BCM43XX_CLOCK_48)) {
> +		return -1;
> +	}
> +
> +	if (bcm43xx_set_speed(fd, speed))
> +		return -1;
> +
> +	return 0;
> +}

Regards

Marcel

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
