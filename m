Return-Path: <cyrus@holtmann.org>
Message-ID: <4C6BFF05.5040506@codeaurora.org>
Date: Wed, 18 Aug 2010 10:40:53 -0500
From: Ron Shaffer <rshaffer@codeaurora.org>
MIME-Version: 1.0
To: Matthew Wilson <mtwilson@codeaurora.org>
CC: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com
Subject: Re: [PATCH v2] Firmware download for Qualcomm Bluetooth devices
References: <4C620A8A.9030707@codeaurora.org> <1281713636-24955-1-git-send-email-mtwilson@codeaurora.org>
In-Reply-To: <1281713636-24955-1-git-send-email-mtwilson@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 8/13/2010 10:33 AM, Matthew Wilson wrote:
> Configures device address from hciattach parameter.
> UART speed limited to 115200.
> Requires separate device specific firmware.
> ---
>  Makefile.tools             |    3 +-
>  tools/hciattach.c          |    8 ++
>  tools/hciattach.h          |    1 +
>  tools/hciattach_qualcomm.c |  279 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 290 insertions(+), 1 deletions(-)
>  create mode 100644 tools/hciattach_qualcomm.c
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 2dbf925..0ce7b75 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -23,7 +23,8 @@ tools_l2ping_LDADD = lib/libbluetooth.la
>  tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
>  						tools/hciattach_st.c \
>  						tools/hciattach_ti.c \
> -						tools/hciattach_tialt.c
> +						tools/hciattach_tialt.c \
> +						tools/hciattach_qualcomm.c
>  tools_hciattach_LDADD = lib/libbluetooth.la
>  
>  tools_hciconfig_SOURCES = tools/hciconfig.c tools/csr.h tools/csr.c \
> diff --git a/tools/hciattach.c b/tools/hciattach.c
> index 81aea7b..4d4b0a1 100644
> --- a/tools/hciattach.c
> +++ b/tools/hciattach.c
> @@ -299,6 +299,11 @@ static int texasalt(int fd, struct uart_t *u, struct termios *ti)
>  	return texasalt_init(fd, u->speed, ti);
>  }
>  
> +static int qualcomm(int fd, struct uart_t *u, struct termios *ti)
> +{
> +	return qualcomm_init(fd, u->speed, ti, u->bdaddr);
> +}
> +
>  static int read_check(int fd, void *buf, int count)
>  {
>  	int res;
> @@ -1073,6 +1078,9 @@ struct uart_t uart[] = {
>  	/* Broadcom BCM2035 */
>  	{ "bcm2035",    0x0A5C, 0x2035, HCI_UART_H4,   115200, 460800, FLOW_CTL, NULL, bcm2035  },
>  
> +	/* QUALCOMM BTS */
> +	{ "qualcomm",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200, FLOW_CTL, NULL, qualcomm },
> +
>  	{ NULL, 0 }
>  };
>  
> diff --git a/tools/hciattach.h b/tools/hciattach.h
> index c0b80a1..3d5605b 100644
> --- a/tools/hciattach.h
> +++ b/tools/hciattach.h
> @@ -49,3 +49,4 @@ int texas_post(int fd, struct termios *ti);
>  int texasalt_init(int fd, int speed, struct termios *ti);
>  int stlc2500_init(int fd, bdaddr_t *bdaddr);
>  int bgb2xx_init(int dd, bdaddr_t *bdaddr);
> +int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr);
> diff --git a/tools/hciattach_qualcomm.c b/tools/hciattach_qualcomm.c
> new file mode 100644
> index 0000000..31ca3c8
> --- /dev/null
> +++ b/tools/hciattach_qualcomm.c
> @@ -0,0 +1,279 @@
> +/*
> + *
> + *  BlueZ - Bluetooth protocol stack for Linux
> + *
> + *  Copyright (C) 2005-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> + *
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <syslog.h>
> +#include <termios.h>
> +#include <time.h>
> +#include <sys/time.h>
> +#include <sys/poll.h>
> +#include <sys/param.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <sys/uio.h>
> +
> +#include <bluetooth/bluetooth.h>
> +#include <bluetooth/hci.h>
> +#include <bluetooth/hci_lib.h>
> +
> +#include "hciattach.h"
> +
> +#define FAILIF(x, args...) do {   \
> +	if (x) {					  \
> +		fprintf(stderr, ##args);  \
> +		return -1;				  \
> +	}							  \
> +} while(0)
> +
> +typedef struct {
> +	uint8_t uart_prefix;
> +	hci_event_hdr hci_hdr;
> +	evt_cmd_complete cmd_complete;
> +	uint8_t status;
> +	uint8_t data[16];
> +} __attribute__((packed)) command_complete_t;
> +
> +
> +static int read_command_complete(int fd, unsigned short opcode, unsigned char len) {
> +	command_complete_t resp;
> +	unsigned char vsevent[512];
> +	int n;
> +
> +	/* Read reply. */
> +	n = read_hci_event(fd, vsevent, sizeof(vsevent));
> +	FAILIF(n < 0, "Failed to read response");
> +
> +	FAILIF(vsevent[1] != 0xFF, "Failed to read response");
> +
> +	n = read_hci_event(fd, (unsigned char *)&resp, sizeof(resp));
> +	FAILIF(n < 0, "Failed to read response");
> +
> +	FAILIF(resp.hci_hdr.evt != EVT_CMD_COMPLETE, /* event must be event-complete */
> +		   "Error in response: not a cmd-complete event, "
> +		   "but 0x%02x!\n", resp.hci_hdr.evt);
> +
> +	FAILIF(resp.hci_hdr.plen < 4, /* plen >= 4 for EVT_CMD_COMPLETE */
> +		   "Error in response: plen is not >= 4, but 0x%02x!\n",
> +		   resp.hci_hdr.plen);
> +
> +	/* cmd-complete event: opcode */
> +	FAILIF(resp.cmd_complete.opcode != 0,
> +		   "Error in response: opcode is 0x%04x, not 0!",
> +		   resp.cmd_complete.opcode);
> +
> +	return resp.status == 0 ? 0 : -1;
> +}
> +
> +static int qualcomm_load_firmware(int fd, const char *firmware, const char *bdaddr_s) {
> +
> +	int fw = open(firmware, O_RDONLY);
> +
> +	fprintf(stdout, "Opening firmware file: %s\n", firmware);
> +
> +	FAILIF(fw < 0,
> +		   "Could not open firmware file %s: %s (%d).\n",
> +		   firmware, strerror(errno), errno);
> +
> +	fprintf(stdout, "Uploading firmware...\n");
> +	do {
> +		/* Read each command and wait for a response. */
> +		unsigned char data[1024];
> +		unsigned char cmdp[1 + sizeof(hci_command_hdr)];
> +		hci_command_hdr *cmd = (hci_command_hdr *)(cmdp + 1);
> +		int nr;
> +		nr = read(fw, cmdp, sizeof(cmdp));
> +		if (!nr)
> +			break;
> +		FAILIF(nr != sizeof(cmdp), "Could not read H4 + HCI header!\n");
> +		FAILIF(*cmdp != HCI_COMMAND_PKT, "Command is not an H4 command packet!\n");
> +
> +		FAILIF(read(fw, data, cmd->plen) != cmd->plen,
> +			   "Could not read %d bytes of data for command with opcode %04x!\n",
> +			   cmd->plen,
> +			   cmd->opcode);
> +
> +		if ((data[0] == 1) && (data[1] == 2) && (data[2] == 6)) {
> +			bdaddr_t bdaddr;
> +			if (bdaddr_s != NULL) {
> +				(void) str2ba(bdaddr_s, &bdaddr);
> +				memcpy(&data[3], &bdaddr, sizeof(bdaddr_t));
> +			}
> +		}
> +
> +		{
> +			int nw;
> +			struct iovec iov_cmd[2];
> +			iov_cmd[0].iov_base = cmdp;
> +			iov_cmd[0].iov_len	= sizeof(cmdp);
> +			iov_cmd[1].iov_base = data;
> +			iov_cmd[1].iov_len	= cmd->plen;
> +			nw = writev(fd, iov_cmd, 2);
> +			FAILIF(nw != (int) sizeof(cmdp) + cmd->plen,
> +				   "Could not send entire command (sent only %d bytes)!\n",
> +				   nw);
> +		}
> +
> +		/* Wait for response */
> +		if (read_command_complete(fd,
> +					  cmd->opcode,
> +					  cmd->plen) < 0) {
> +			return -1;
> +		}
> +
> +	} while(1);
> +	fprintf(stdout, "Firmware upload successful.\n");
> +
> +	close(fw);
> +	return 0;
> +}
> +
> +int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr)
> +{
> +	struct timespec tm = {0, 50000};
> +	char cmd[5];
> +	unsigned char resp[100];		/* Response */
> +	char fw[100];
> +	int n;
> +
> +	memset(resp,'\0', 100);
> +
> +	/* Get Manufacturer and LMP version */
> +	cmd[0] = HCI_COMMAND_PKT;
> +	cmd[1] = 0x01;
> +	cmd[2] = 0x10;
> +	cmd[3] = 0x00;
> +
> +	do {
> +		n = write(fd, cmd, 4);
> +		if (n < 0) {
> +			perror("Failed to write init command (READ_LOCAL_VERSION_INFORMATION)");
> +			return -1;
> +		}
> +		if (n < 4) {
> +			fprintf(stderr, "Wanted to write 4 bytes, could only write %d. Stop\n", n);
> +			return -1;
> +		}
> +
> +		/* Read reply. */
> +		if (read_hci_event(fd, resp, 100) < 0) {
> +			perror("Failed to read init response (READ_LOCAL_VERSION_INFORMATION)");
> +			return -1;
> +		}
> +
> +		/* Wait for command complete event for our Opcode */
> +	} while (resp[4] != cmd[1] && resp[5] != cmd[2]);
> +
> +	/* Verify manufacturer */
> +	if ((resp[11] & 0xFF) != 0x1d)
> +		fprintf(stderr,"WARNING : module's manufacturer is not Qualcomm\n");
> +
> +	/* Print LMP version */
> +	fprintf(stderr, "Qualcomm module LMP version : 0x%02x\n", resp[10] & 0xFF);
> +
> +	/* Print LMP subversion */
> +	{
> +		unsigned short lmp_subv = resp[13] | (resp[14] << 8);
> +
> +		fprintf(stderr, "Qualcomm module LMP sub-version : 0x%04x\n", lmp_subv);
> +
> +	}
> +
> +	/* Get SoC type */
> +	cmd[0] = HCI_COMMAND_PKT;
> +	cmd[1] = 0x00;
> +	cmd[2] = 0xFC;
> +	cmd[3] = 0x01;
> +	cmd[4] = 0x06;
> +
> +	do {
> +		n = write(fd, cmd, 5);
> +		if (n < 0) {
> +			perror("Failed to write init command");
> +			return -1;
> +		}
> +		if (n < 5) {
> +			fprintf(stderr, "Wanted to write 5 bytes, could only write %d. Stop\n", n);
> +			return -1;
> +		}
> +
> +		/* Read reply. */
> +		if ((n = read_hci_event(fd, resp, 100)) < 0) {
> +			perror("Failed to read init response");
> +			return -1;
> +		}
> +
> +	} while (resp[3] != 0 && resp[4] != 2);
> +
> +	snprintf(fw, sizeof(fw),
> +		"/etc/firmware/%c%c%c%c%c%c_%c%c%c%c.bin",
> +		resp[18], resp[19], resp[20], resp[21],
> +		resp[22], resp[23],
> +		resp[32], resp[33], resp[34], resp[35]);
> +
> +	/* Wait for command complete event for our Opcode */
> +	if (read_hci_event(fd, resp, 100) < 0) {
> +		perror("Failed to read init response");
> +		return -1;
> +	}
> +
> +	qualcomm_load_firmware(fd, fw, bdaddr);
> +
> +	/* Reset */
> +	cmd[0] = HCI_COMMAND_PKT;
> +	cmd[1] = 0x03;
> +	cmd[2] = 0x0C;
> +	cmd[3] = 0x00;
> +
> +	do {
> +		n = write(fd, cmd, 4);
> +		if (n < 0) {
> +			perror("Failed to write reset command");
> +			return -1;
> +		}
> +		if (n < 4) {
> +			fprintf(stderr, "Wanted to write 4 bytes, could only write %d. Stop\n", n);
> +			return -1;
> +		}
> +
> +		/* Read reply. */
> +		if ((n = read_hci_event(fd, resp, 100)) < 0) {
> +			perror("Failed to read reset response");
> +			return -1;
> +		}
> +
> +	} while (resp[4] != cmd[1] && resp[5] != cmd[2]);
> +
> +	nanosleep(&tm, NULL);
> +	return 0;
> +}

Ping

-- 
Ron Shaffer
Employee of the Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
