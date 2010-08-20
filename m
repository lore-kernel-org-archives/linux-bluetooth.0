Return-Path: <cyrus@holtmann.org>
Date: Sat, 21 Aug 2010 01:37:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Matthew Wilson <mtwilson@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH v3] Firmware download for Qualcomm Bluetooth devices
Message-ID: <20100820223757.GA23924@jh-x301>
References: <4C6BFF05.5040506@codeaurora.org>
 <1282340251-10676-1-git-send-email-mtwilson@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282340251-10676-1-git-send-email-mtwilson@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matt,

On Fri, Aug 20, 2010, Matthew Wilson wrote:
> Configures device address from hciattach parameter.
> UART speed limited to 115200.
> Requires separate device specific firmware.
> ---
>  Makefile.tools             |    3 +-
>  tools/hciattach.c          |   10 ++
>  tools/hciattach.h          |    1 +
>  tools/hciattach_qualcomm.c |  279 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 292 insertions(+), 1 deletions(-)
>  create mode 100644 tools/hciattach_qualcomm.c

Thanks, the patch applies cleanly now. However, I spotted a couple of
whitespace/coding style issues that would be good to get fixed before
pushing this upstream:

> +#define FAILIF(x, args...) do {   \
> +	if (x) {					  \
> +		fprintf(stderr, ##args);  \
> +		return -1;				  \
> +	}							  \
> +} while(0)

Before each \ at the end of the line you use a mix of tabs and spaces.
Please just use tabs.

> +typedef struct {
> +	uint8_t uart_prefix;
> +	hci_event_hdr hci_hdr;
> +	evt_cmd_complete cmd_complete;
> +	uint8_t status;
> +	uint8_t data[16];
> +} __attribute__((packed)) command_complete_t;
> +
> +

Why the two consecutive empty lines? Please remove one.

> +static int read_command_complete(int fd, unsigned short opcode, unsigned char len) {

This one looks like it goes beyond 80 columns. Please split it. Also,
the coding style is to put the opening brace of a function on its own
line.

> +	FAILIF(resp.hci_hdr.evt != EVT_CMD_COMPLETE, /* event must be event-complete */
> +		   "Error in response: not a cmd-complete event, "
> +		   "but 0x%02x!\n", resp.hci_hdr.evt);

Mixed tabs and spaces for indentation. Please just use tabs.

> +	FAILIF(resp.hci_hdr.plen < 4, /* plen >= 4 for EVT_CMD_COMPLETE */
> +		   "Error in response: plen is not >= 4, but 0x%02x!\n",
> +		   resp.hci_hdr.plen);

Same here.

> +
> +	/* cmd-complete event: opcode */
> +	FAILIF(resp.cmd_complete.opcode != 0,
> +		   "Error in response: opcode is 0x%04x, not 0!",
> +		   resp.cmd_complete.opcode);

And here.

> +static int qualcomm_load_firmware(int fd, const char *firmware, const char *bdaddr_s) {

This one goes beyond 80 columns too and the opening brace should be on
its own line.

> +	FAILIF(fw < 0,
> +		   "Could not open firmware file %s: %s (%d).\n",
> +		   firmware, strerror(errno), errno);

Mixed tabs and spaces for indentation.

> +		FAILIF(read(fw, data, cmd->plen) != cmd->plen,
> +			   "Could not read %d bytes of data for command with opcode %04x!\n",
> +			   cmd->plen,
> +			   cmd->opcode);

Same here.

> +			FAILIF(nw != (int) sizeof(cmdp) + cmd->plen,
> +				   "Could not send entire command (sent only %d bytes)!\n",
> +				   nw);

And here.

> +		if (read_command_complete(fd,
> +					  cmd->opcode,
> +					  cmd->plen) < 0) {

And here. Why do you split it into three lines when it all fits within
80 columns?

Johan
