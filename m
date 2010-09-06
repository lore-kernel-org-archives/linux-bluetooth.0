Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Sep 2010 10:22:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] hciconfig: add LE_SET_ADVERTISE_ENABLE cmd
Message-ID: <20100906072237.GA12349@jh-x301>
References: <1282251158-27015-1-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282251158-27015-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, Aug 19, 2010, Anderson Briglia wrote:
> This patch implements two new hciconfig commands: leadv and noleadv.
> These new hciconfig flags are responsible to LE_SET_ADVERTISE_ENABLE
> command implementation.
> ---
>  tools/hciconfig.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)

Sorry for the delay with this patch, seems I've missed it.

> +static void cmd_le_adv(int ctl, int hdev, char *opt)
> +{
> +	struct hci_request rq;
> +	le_set_advertise_enable_cp advertise_cp;
> +	uint8_t status, enable;
> +	int dd, ret;
> +
> +	if (hdev < 0)
> +		hdev = hci_get_route(NULL);
> +
> +	dd = hci_open_dev(hdev);
> +	if (dd < 0) {
> +		perror("Could not open device");
> +		exit(1);
> +	}
> +
> +	enable = 0x01;
> +	if (!strcmp(opt, "noleadv"))
> +		enable = 0x00;
> +
> +	memset(&advertise_cp, 0, sizeof(advertise_cp));
> +	advertise_cp.enable = enable;

I know that the other functions in the file have similar logic, but
could we still simplify this a little bit. I.e. get rid of the enable
variable completely and move the checking for "noleadv" after the
memset:

	if (strcmp(opt, "noleadv") == 0)
		advertise_cp.enable = 0x00;
	else
		advertise_cp.enable = 0x01;

Other than that the patch seems fine to me.

Johan
