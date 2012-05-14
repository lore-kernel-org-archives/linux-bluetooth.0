Return-Path: <cyrus@holtmann.org>
Message-ID: <1336963950.5970.234.camel@aeonflux>
Subject: Re: [PATCH] hciattach: Add support for Intel Bluetooth device
From: Marcel Holtmann <marcel@holtmann.org>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 13 May 2012 19:52:30 -0700
In-Reply-To: <2805951.HZP8Jj1jGZ@tedd-ubuntu>
References: <2805951.HZP8Jj1jGZ@tedd-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch enables the Intel Bluetooth device (UART sku) over the H4 protocol.
> It is responsible for bring up the device into known state by configuring
> the baudrate and applying the patches, if required.
> 
> ---
>  Makefile.tools          |    3 +-
>  tools/hciattach.8       |    3 +
>  tools/hciattach.c       |   13 ++
>  tools/hciattach.h       |    1 +
>  tools/hciattach_intel.c |  585 
> +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 604 insertions(+), 1 deletion(-)
>  create mode 100644 tools/hciattach_intel.c
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index cb0d1d0..4df7453 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -27,7 +27,8 @@ tools_hciattach_SOURCES = tools/hciattach.c 
> tools/hciattach.h \
>  						tools/hciattach_ti.c \
>  						tools/hciattach_tialt.c \
>  						tools/hciattach_ath3k.c \
> -						tools/hciattach_qualcomm.c
> +						tools/hciattach_qualcomm.c \
> +						tools/hciattach_intel.c
>  tools_hciattach_LDADD = lib/libbluetooth-private.la
>  
>  tools_hciconfig_SOURCES = tools/hciconfig.c tools/csr.h tools/csr.c \
> diff --git a/tools/hciattach.8 b/tools/hciattach.8
> index e0e2730..cc97cad 100644
> --- a/tools/hciattach.8
> +++ b/tools/hciattach.8
> @@ -89,6 +89,9 @@ Serial adapters using CSR chips with BCSP serial protocol
>  .TP
>  .B ath3k
>  Atheros AR300x based serial Bluetooth device
> +.TP
> +.B intel
> +Intel Bluetooth device
>  .RE
>  
>  Supported IDs are (manufacturer id, product id)
> diff --git a/tools/hciattach.c b/tools/hciattach.c
> index e0a9821..3e73956 100644
> --- a/tools/hciattach.c
> +++ b/tools/hciattach.c
> @@ -131,6 +131,10 @@ static int uart_speed(int s)
>  	case 3500000:
>  		return B3500000;
>  #endif
> +#ifdef B3710000
> +	case 3710000
> +		return B3710000;
> +#endif
>  #ifdef B4000000
>  	case 4000000:
>  		return B4000000;
> @@ -322,6 +326,11 @@ static int qualcomm(int fd, struct uart_t *u, struct 
> termios *ti)
>  	return qualcomm_init(fd, u->speed, ti, u->bdaddr);
>  }
>  
> +static int intel(int fd, struct uart_t *u, struct termios *ti)
> +{
> +	return intel_init(fd, u->init_speed, &u->speed, ti);
> +}
> +
>  static int read_check(int fd, void *buf, int count)
>  {
>  	int res;
> @@ -1137,6 +1146,10 @@ struct uart_t uart[] = {
>  	{ "qualcomm",   0x0000, 0x0000, HCI_UART_H4,   115200, 115200,
>  			FLOW_CTL, DISABLE_PM, NULL, qualcomm, NULL },
>  
> +	/* Intel Bluetooth Module */
> +	{ "intel",      0x0000, 0x0000, HCI_UART_H4,   115200, 115200,
> +			FLOW_CTL, DISABLE_PM, NULL, intel, NULL },
> +
>  	{ NULL, 0 }
>  };
>  
> diff --git a/tools/hciattach.h b/tools/hciattach.h
> index f8093ff..a24dbc4 100644
> --- a/tools/hciattach.h
> +++ b/tools/hciattach.h
> @@ -56,3 +56,4 @@ int ath3k_init(int fd, int speed, int init_speed, char 
> *bdaddr,
>  						struct termios *ti);
>  int ath3k_post(int fd, int pm);
>  int qualcomm_init(int fd, int speed, struct termios *ti, const char *bdaddr);
> +int intel_init(int fd, int init_speed, int *speed, struct termios *ti);
> diff --git a/tools/hciattach_intel.c b/tools/hciattach_intel.c
> new file mode 100644
> index 0000000..a629076
> --- /dev/null
> +++ b/tools/hciattach_intel.c
> @@ -0,0 +1,585 @@
> +/*
> + * BlueZ - Bluetooth protocol stack for Linux
> + *
> + * Intel Bluetooth initialization module

I was serious with that fact that I want the copyright/license
statements common across all files. So why do you have to add your own
extra comment here and break the style?

> + *
> + * Copyright (C) 2012 Intel Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/param.h>
> +#include <sys/ioctl.h>
> +#include <time.h>
> +
> +#include <bluetooth/bluetooth.h>
> +#include <bluetooth/hci.h>
> +#include <bluetooth/hci_lib.h>
> +
> +#include "hciattach.h"
> +
> +#ifdef INTEL_DEBUG
> +#define DBGPRINT(x...)	printf(x)
> +#define PRINT_PACKET(buf, len)	{		\
> +	int i;					\
> +	for (i = 0; i < len; i++)		\
> +		printf("%02X ", buf[i]);	\
> +	printf("\n");				\
> +	}
> +#else
> +#define DBGPRINT(x...)
> +#define PRINT_PACKET(buf, len)
> +#endif

the more I look at this, the less I  like it. I rather have a general
debug switch --debug/-d to hciattach that sets a global debug on/off
variable and that is used here. And we fix this once and for all for all
manufactures.

I think this got way too much out of hand. Since this is not your fault
that this original code is bad, I would have it merged with these macros
if you promise to fix it up in a later patch.

> +
> +#define PATCH_SEQ_EXT           ".bseq"
> +#define PATCH_FILE_PATH         "/lib/firmware/intel/"
> +#define PATCH_MAX_LEN           260
> +#define PATCH_TYPE_CMD          1
> +#define PATCH_TYPE_EVT          2
> +
> +#define INTEL_VER_PARAM_LEN     9
> +#define INTEL_MFG_PARAM_LEN     2
> +
> +/**
> + * A data structure for a patch entry.
> + */
> +struct _p_ent {
> +	int type;
> +	int len;
> +	unsigned char data[PATCH_MAX_LEN];
> +};

Coming to think about it, why not call it patch_entry.

> +
> +/**
> + * A structure for patch context
> + */
> +struct _p_ctx {
> +	int dev;
> +	int fd;
> +	int patch_error;
> +	int reset_enable_patch;
> +};

And patch_ctx here. What is up with this _p prefix.

> +
> +/**
> + * Send HCI command to the controller
> + */
> +static int intel_write_cmd(int dev, unsigned char *buf, int len)
> +{
> +	int ret;
> +
> +	DBGPRINT("<----- SEND CMD: ");
> +	PRINT_PACKET(buf, len);

Why does PRINT_PACKET not also takes the initial message string as
input. Make the macro clean and self contained.

> +
> +	ret = write(dev, buf, len);
> +	if (ret < 0)
> +		return -errno;
> +
> +	if (ret != len)
> +		return -1;
> +
> +	return ret;
> +}
> +
> +/**
> + * Read the event from the controller
> + */
> +static int intel_read_evt(int dev, unsigned char *buf, int len)
> +{
> +	int ret;
> +
> +	ret = read_hci_event(dev, buf, len);
> +	if (ret < 0)
> +		return -1;
> +
> +	DBGPRINT("-----> READ EVT: ");
> +	PRINT_PACKET(buf, ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * Validate HCI events
> + */
> +static int validate_events(struct _p_ent *e_ent, struct _p_ent *p_ent)
> +{
> +	if (e_ent == NULL || p_ent == NULL) {
> +		DBGPRINT("DBG: invalid patch entry parameters\n");

If you keep using DBG: in front of the debug messages, then it should be
part of the macro. Same as the \n actually.

> +		return -1;
> +	}
> +
> +	if (e_ent->len != p_ent->len) {
> +		DBGPRINT("DBG: lengths are mismatched:[%d|%d]\n",
> +			e_ent->len, p_ent->len);
> +		return -1;
> +	}
> +
> +	if (memcmp(e_ent->data, p_ent->data, e_ent->len)) {
> +		DBGPRINT("DBG: data is mismatched\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Read the next patch entry one line at a time
> + */
> +static int get_next_p_ent(int fd, struct _p_ent *p_ent)
> +{

Make this get_next_patch_ent or get_next_patch_entry. This _p shortcut
is really a bad idea.

> +	int len;
> +	char rb;
> +
> +	if (read(fd, &rb, 1) <= 0)
> +		return 0;
> +
> +	p_ent->type = rb;
> +	len = 0;
> +
> +	switch (p_ent->type) {
> +	case PATCH_TYPE_CMD:
> +		p_ent->data[len++] = HCI_COMMAND_PKT;
> +		len += read(fd, &p_ent->data[len], 3);

You need error handling here. What happens if the read fails?

> +		len += read(fd, &p_ent->data[len], (int)p_ent->data[3]);
> +		p_ent->len = len;
> +		break;
> +	case PATCH_TYPE_EVT:
> +		p_ent->data[len++] = HCI_EVENT_PKT;
> +		len += read(fd, &p_ent->data[len], 2);

And same here.

> +		len += read(fd, &p_ent->data[len], (int)p_ent->data[2]);
> +		p_ent->len = len;
> +		break;
> +	default:
> +		fprintf(stderr, "invalid patch entry(%d)\n", p_ent->type);
> +		return -1;
> +	}
> +
> +	return len;
> +}
> +
> +/**
> + * Download the patch set to the controller and verify the event
> + */
> +static int intel_download_patch(struct _p_ctx *p_ctx)
> +{
> +	int ret;
> +	struct _p_ent p_ent;
> +	struct _p_ent e_ent;

The more and more I go through the code, this becomes less readable.
Calling the variables ctx and entry/ent would be just fine.

Also you do know that "struct patch_entry patch_entry" is a perfectly
fine variable declaration.

> +
> +	DBGPRINT("DBG: start patch downloading\n");
> +
> +	do {
> +		ret = get_next_p_ent(p_ctx->fd, &p_ent);
> +		if (ret <= 0) {
> +			p_ctx->patch_error = 1;
> +			break;
> +		}
> +
> +		if (p_ent.type == PATCH_TYPE_CMD) {

Why not use a switch statement here?

> +			ret = intel_write_cmd(p_ctx->dev,
> +					p_ent.data,
> +					p_ent.len);
> +			if (ret <= 0) {
> +				fprintf(stderr,
> +					"failed to send cmd(%d)\n", ret);
> +				break;
> +			}
> +		} else if (p_ent.type == PATCH_TYPE_EVT) {
> +			ret = intel_read_evt(p_ctx->dev,
> +					e_ent.data,
> +					sizeof(e_ent.data));
> +			if (ret <= 0) {
> +				fprintf(stderr,
> +					"failed to read evt(%d)\n", ret);
> +				break;
> +			}
> +			e_ent.len = ret;
> +
> +			if (validate_events(&e_ent, &p_ent) < 0) {
> +				DBGPRINT("DBG: events are mismatched\n");
> +				p_ctx->patch_error = 1;
> +				ret = -1;
> +				break;
> +			}
> +		} else {
> +			fprintf(stderr, "unknown patch type(%d)\n",
> +					p_ent.type);
> +			ret = -1;
> +			break;
> +		}
> +	} while (1);
> +
> +	return ret;
> +}
> +
> +static int open_patch_file(struct _p_ctx *p_ctx, char *fw_ver)
> +{
> +	char patch_file[PATH_MAX] = {0};

The variable initialization here is useless. So don't bother with it.

> +
> +	snprintf(patch_file, PATH_MAX, "%s%s"PATCH_SEQ_EXT,
> +		PATCH_FILE_PATH, fw_ver);

Please use %s%s%s here. And not cat the string together.

> +	DBGPRINT("DBG: PATCH_FILE: %s\n", patch_file);
> +
> +	p_ctx->fd = open(patch_file, O_RDONLY);
> +	if (p_ctx->fd < 0) {
> +		DBGPRINT("DBG: cannot open patch file. go to post patch\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Prepare the controller for patching.
> + */
> +static int pre_patch(struct _p_ctx *p_ctx)
> +{
> +	int ret, i;
> +	struct _p_ent p_ent;
> +	char fw_ver[INTEL_VER_PARAM_LEN * 2];
> +
> +	DBGPRINT("DBG: start pre_patch\n");
> +
> +	p_ent.data[0] = HCI_COMMAND_PKT;
> +	p_ent.data[1] = 0x11;
> +	p_ent.data[2] = 0xFC;
> +	p_ent.data[3] = 0x02;
> +	p_ent.data[4] = 0x01;
> +	p_ent.data[5] = 0x00;
> +	p_ent.len = HCI_TYPE_LEN + HCI_COMMAND_HDR_SIZE + INTEL_MFG_PARAM_LEN;
> +
> +	ret = intel_write_cmd(p_ctx->dev, p_ent.data, p_ent.len);
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to send cmd(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = intel_read_evt(p_ctx->dev, p_ent.data, sizeof(p_ent.data));
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to read evt(%d)\n", ret);
> +		return ret;
> +	}
> +	p_ent.len = ret;
> +
> +	if (p_ent.data[6] != 0x00) {
> +		DBGPRINT("DBG: command failed. status=%02x\n", p_ent.data[6]);
> +		p_ctx->patch_error = 1;
> +		return -1;
> +	}
> +
> +	p_ent.data[0] = HCI_COMMAND_PKT;
> +	p_ent.data[1] = 0x05;
> +	p_ent.data[2] = 0xFC;
> +	p_ent.data[3] = 0x00;
> +	p_ent.len = HCI_TYPE_LEN + HCI_COMMAND_HDR_SIZE;
> +
> +	ret = intel_write_cmd(p_ctx->dev, p_ent.data, p_ent.len);
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to send cmd(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = intel_read_evt(p_ctx->dev, p_ent.data, sizeof(p_ent.data));
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to read evt(%d)\n", ret);
> +		return ret;
> +	}
> +	p_ent.len = ret;
> +
> +	if (p_ent.data[6] != 0x00) {
> +		DBGPRINT("DBG: command failed. status=%02x\n", p_ent.data[6]);
> +		p_ctx->patch_error = 1;
> +		return -1;
> +	}
> +
> +	for (i = 0; i < INTEL_VER_PARAM_LEN; i++)
> +		sprintf(&fw_ver[i*2], "%02x", p_ent.data[7+i]);
> +
> +	if (open_patch_file(p_ctx, fw_ver) < 0) {
> +		p_ctx->patch_error = 1;
> +		return -1;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * check the event is startup event
> + */
> +static int is_startup_evt(unsigned char *buf)
> +{
> +	if (buf[1] == 0xFF && buf[2] == 0x01 && buf[3] == 0x00)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/**
> + * Finalize the patch process and reset the controller
> + */
> +static int post_patch(struct _p_ctx *p_ctx)
> +{
> +	int ret;
> +	struct _p_ent p_ent;
> +
> +	DBGPRINT("DBG: start post_patch\n");
> +
> +	p_ent.data[0] = HCI_COMMAND_PKT;
> +	p_ent.data[1] = 0x11;
> +	p_ent.data[2] = 0xFC;
> +	p_ent.data[3] = 0x02;
> +	p_ent.data[4] = 0x00;
> +	if (p_ctx->reset_enable_patch)
> +		p_ent.data[5] = 0x02;
> +	else
> +		p_ent.data[5] = 0x01;
> +
> +	p_ent.len = HCI_TYPE_LEN + HCI_COMMAND_HDR_SIZE + INTEL_MFG_PARAM_LEN;
> +
> +	ret = intel_write_cmd(p_ctx->dev, p_ent.data, p_ent.len);
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to send cmd(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = intel_read_evt(p_ctx->dev, p_ent.data, sizeof(p_ent.data));
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to read evt(%d)\n", ret);
> +		return ret;
> +	}
> +	p_ent.len = ret;
> +	if (p_ent.data[6] != 0x00) {
> +		fprintf(stderr, "cmd failed. st=%02x\n", p_ent.data[6]);
> +		return -1;
> +	}
> +
> +	do {
> +		ret = intel_read_evt(p_ctx->dev, p_ent.data,
> +					sizeof(p_ent.data));
> +		if (ret < 0) {
> +			fprintf(stderr, "failed to read cmd(%d)\n", ret);
> +			return ret;
> +		}
> +		p_ent.len = ret;
> +	} while (!is_startup_evt(p_ent.data));
> +
> +	return ret;
> +}
> +
> +/**
> + * Main routine that handles the device patching process.
> + */
> +static int intel_patch_device(struct _p_ctx *p_ctx)
> +{
> +	int ret;
> +
> +	ret = pre_patch(p_ctx);
> +	if (ret < 0) {
> +		if (!p_ctx->patch_error) {
> +			fprintf(stderr, "I/O error: pre_patch failed\n");
> +			return ret;
> +		}
> +
> +		DBGPRINT("DBG: patch failed. proceed to post patch\n");
> +		goto post_patch;
> +	}
> +
> +	ret = intel_download_patch(p_ctx);
> +	if (ret < 0) {
> +		if (!p_ctx->patch_error) {
> +			fprintf(stderr, "I/O error: download_patch failed\n");
> +			close(p_ctx->fd);
> +			return ret;
> +		}
> +	} else {
> +		DBGPRINT("DBG: patch done\n");
> +		p_ctx->reset_enable_patch = 1;
> +	}
> +
> +	close(p_ctx->fd);
> +
> +post_patch:
> +	ret = post_patch(p_ctx);
> +	if (ret < 0) {
> +		fprintf(stderr, "post_patch failed(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int set_rts(int dev, int rtsval)
> +{
> +	int arg;
> +
> +	if (ioctl(dev, TIOCMGET, &arg) < 0) {
> +		perror("cannot get TIOCMGET");
> +		return -errno;
> +	}
> +	if (rtsval)
> +		arg |= TIOCM_RTS;
> +	else
> +		arg &= ~TIOCM_RTS;
> +
> +	if (ioctl(dev, TIOCMSET, &arg) == -1) {
> +		perror("cannot set TIOCMGET");
> +		return -errno;
> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned char get_intel_speed(int speed)
> +{
> +	switch (speed) {
> +	case 9600:
> +		return 0x00;
> +	case 19200:
> +		return 0x01;
> +	case 38400:
> +		return 0x02;
> +	case 57600:
> +		return 0x03;
> +	case 115200:
> +		return 0x04;
> +	case 230400:
> +		return 0x05;
> +	case 460800:
> +		return 0x06;
> +	case 921600:
> +		return 0x07;
> +	case 1843200:
> +		return 0x08;
> +	case 3250000:
> +		return 0x09;
> +	case 2000000:
> +		return 0x0A;
> +	case 3000000:
> +		return 0x0B;
> +	default:
> +		return 0xFF;
> +	}
> +}
> +
> +/**
> + * if it failed to change to new baudrate, it will rollback
> + * to initial baudrate
> + */
> +static int change_baudrate(int dev, int init_speed, int *speed,
> +				struct termios *ti)
> +{
> +	int ret;
> +	unsigned char br;
> +	unsigned char cmd[5];
> +	unsigned char evt[7];
> +
> +	DBGPRINT("DBG: start baudrate change\n");
> +
> +	ret = set_rts(dev, 0);
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to clear RTS\n");
> +		return ret;
> +	}
> +
> +	cmd[0] = HCI_COMMAND_PKT;
> +	cmd[1] = 0x06;
> +	cmd[2] = 0xFC;
> +	cmd[3] = 0x01;
> +
> +	br = get_intel_speed(*speed);
> +	if (br == 0xFF) {
> +		fprintf(stderr, "speed %d is not supported\n", *speed);
> +		return -1;
> +	}
> +	cmd[4] = br;
> +
> +	ret = intel_write_cmd(dev, cmd, sizeof(cmd));
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to send cmd(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 *  wait for buffer to be consumed by the controller
> +	 */
> +	usleep(300000);
> +
> +	if (set_speed(dev, ti, *speed) < 0) {
> +		fprintf(stderr, "can't set to new baud rate\n");
> +		return -1;
> +	}
> +
> +	ret = set_rts(dev, 1);
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to set RTS\n");
> +		return ret;
> +	}
> +
> +	ret = intel_read_evt(dev, evt, sizeof(evt));
> +	if (ret < 0) {
> +		fprintf(stderr, "failed to read evt(%d)\n", ret);
> +		return ret;
> +	}
> +
> +	if (evt[4] != 0x00) {
> +		fprintf(stderr,
> +			"failed to change speed. use default speed %d\n",
> +			init_speed);
> +		*speed = init_speed;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * An entry point for Intel specific initialization
> + */
> +int intel_init(int dev, int init_speed, int *speed, struct termios *ti)
> +{
> +	int ret = 0;
> +	struct _p_ctx *p_ctx;
> +
> +	if (change_baudrate(dev, init_speed, speed, ti) < 0)
> +		return -1;
> +
> +	/*
> +	 * initialize the patch context
> +	 */
> +	p_ctx = malloc(sizeof(struct _p_ctx));
> +	if (!p_ctx) {
> +		fprintf(stderr, "failed to allocate the patch context");
> +		return -ENOMEM;
> +	}
> +	memset(p_ctx, 0, sizeof(struct _p_ctx));

What is this malloc for. You could just put it on the stack.

> +
> +	p_ctx->dev = dev;
> +
> +	ret = intel_patch_device(p_ctx);
> +	if (ret < 0)
> +		fprintf(stderr, "failed to initialize the device");
> +
> +	free(p_ctx);
> +	return ret;
> +}

Regards

Marcel


