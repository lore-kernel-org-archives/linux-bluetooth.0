Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3] Bluetooth: host level Support for Atheros AR300x
 device
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1282113672-16360-1-git-send-email-suraj@atheros.com>
References: <1282113672-16360-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Aug 2010 08:51:25 +0200
Message-ID: <1282114285.23399.136.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Implements support for Atheros AR300x Bluetooth chip in
> hciattach application. Supports configuration download
> and power management configure feature.
> ---
>  Makefile.tools         |    7 +-
>  tools/hciattach.8      |    3 +
>  tools/hciattach.c      |  105 ++++++
>  tools/hciattach.h      |    3 +
>  tools/hciattach_ar3k.c |  859 ++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 974 insertions(+), 3 deletions(-)
>  create mode 100644 tools/hciattach_ar3k.c
> 
> diff --git a/Makefile.tools b/Makefile.tools
> index 2dbf925..e568bd7 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -21,9 +21,10 @@ tools_rfcomm_LDADD = lib/libbluetooth.la
>  tools_l2ping_LDADD = lib/libbluetooth.la
>  
>  tools_hciattach_SOURCES = tools/hciattach.c tools/hciattach.h \
> -						tools/hciattach_st.c \
> -						tools/hciattach_ti.c \
> -						tools/hciattach_tialt.c
> +						tools/hciattach_st.c    \
> +						tools/hciattach_ti.c    \
> +						tools/hciattach_tialt.c \
> +						tools/hciattach_ar3k.c
>  tools_hciattach_LDADD = lib/libbluetooth.la

please stop introducing new whitespaces in between. None of the
Makefile.am to do this.
 
>  Supported IDs are (manufacturer id, product id)
> diff --git a/tools/hciattach.c b/tools/hciattach.c
> index 8616899..6cc92c1 100644
> --- a/tools/hciattach.c
> +++ b/tools/hciattach.c
> @@ -657,6 +657,109 @@ static int csr(int fd, struct uart_t *u, struct termios *ti)
>  	return 0;
>  }
>  
> +#define SLEEP_ENABLE  1
> +#define SLEEP_DISABLE 0
> +
> +/*
> + * Atheros AR300x specific initialization post callback
> + */
> +static int ath3kpost(int fd, struct uart_t *u, struct termios *ti)
> +{
> +	return ath_configure_sleep(fd, u->pm);
> +}
> +
> +#define HCI_VENDOR_CMD_OGF    0x3F
> +#define HCI_PS_CMD_OCF        0x0B
> +#define HCI_CHG_BAUD_CMD_OCF  0x0C
> +
> +#define WRITE_BDADDR_CMD_LEN 14
> +#define WRITE_BAUD_CMD_LEN   6
> +#define MAX_CMD_LEN          WRITE_BDADDR_CMD_LEN
> +
> +/*
> + * Atheros AR300x specific initialization and configureation file
> + * download
> + */
> +static int ath3kinit(int fd, struct uart_t *u, struct termios *ti)
> +{
> +	int r;
> +	int baud;
> +	struct timespec tm = { 0, 500000 };
> +	unsigned char cmd[MAX_CMD_LEN], rsp[HCI_MAX_EVENT_SIZE];
> +	unsigned char *ptr = cmd + 1;
> +	hci_command_hdr *ch = (void *)ptr;
> +
> +	cmd[0] = HCI_COMMAND_PKT;
> +
> +	/* Download PS and patch */
> +	r = ath_ps_download(fd);
> +	if (r < 0) {
> +		perror("Failed to Download configuration");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Write BDADDR */
> +	if (u->bdaddr) {
> +		ch->opcode = htobs(cmd_opcode_pack(HCI_VENDOR_CMD_OGF,
> +							HCI_PS_CMD_OCF));
> +		ch->plen = 10;
> +		ptr += HCI_COMMAND_HDR_SIZE;
> +
> +		ptr[0] = 0x01;
> +		ptr[1] = 0x01;
> +		ptr[2] = 0x00;
> +		ptr[3] = 0x06;
> +		str2ba(u->bdaddr, (bdaddr_t *)(ptr + 4));
> +
> +		if (write(fd, cmd, WRITE_BDADDR_CMD_LEN) !=
> +					WRITE_BDADDR_CMD_LEN) {
> +			perror("Failed to write BD_ADDR command\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		if (read_hci_event(fd, rsp, sizeof(rsp)) < 0) {
> +			perror("Failed to set BD_ADDR\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	/* Send HCI Reset */
> +	cmd[1] = 0x03;
> +	cmd[2] = 0x0C;
> +	cmd[3] = 0x00;
> +
> +	r = write(fd, cmd, 4);
> +	if (r != 4)
> +		return -ETIMEDOUT;
> +
> +	nanosleep(&tm, NULL);
> +	if (read_hci_event(fd, rsp, sizeof(rsp)) < 0)
> +		return -ETIMEDOUT;
> +
> +	/* set controller baud rate to user specified value */
> +	ptr = cmd + 1;
> +	ch->opcode = htobs(cmd_opcode_pack(HCI_VENDOR_CMD_OGF,
> +						HCI_CHG_BAUD_CMD_OCF));
> +	ch->plen = 2;
> +	ptr += HCI_COMMAND_HDR_SIZE;
> +
> +	baud = u->speed/100;
> +	ptr[0] = (char)baud;
> +	ptr[1] = (char)(baud >> 8);
> +
> +	if (write(fd, cmd, WRITE_BAUD_CMD_LEN) != WRITE_BAUD_CMD_LEN) {
> +		perror("Failed to write change baud rate command");
> +		return -ETIMEDOUT;
> +	}
> +
> +	nanosleep(&tm, NULL);
> +
> +	if (read_hci_event(fd, rsp, sizeof(rsp)) < 0)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +

Why is this in hciattach.c if you create your own file for the ar3k
anyway. Please move it all into that file.

Regards

Marcel


