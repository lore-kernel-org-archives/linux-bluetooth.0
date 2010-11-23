Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Nov 2010 10:23:46 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH] hciattach: download configuration at maximum baud rate
 possible
Message-ID: <20101123092346.GB28017@jh-x301>
References: <1290423480-29840-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290423480-29840-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Mon, Nov 22, 2010, Suraj Sumangala wrote:
> This patch support downloading configuration files for
> Atheros AR300x HCI UART chip at user requested baud rate
> instead of the initial baud rate.
> ---
>  tools/hciattach.c       |    2 +-
>  tools/hciattach.h       |    3 +-
>  tools/hciattach_ath3k.c |   97 +++++++++++++++++++++++++++++++++-------------
>  3 files changed, 72 insertions(+), 30 deletions(-)

In general the patch looks ok'ish, but:

> +	if (set_speed(fd, ti, speed) < 0) {
> +		perror("Can't set required baud rate");
> +		return -1;
> +	}

To be consistent with the other return values, instead of -1 you should
be returning a proper errno here. I.e. probably something like:

	if (set_speed(fd, ti, speed) < 0) {
		err = -errno;
		perror("Can't set required baud rate");
		return err;
	}


> +exit:

Could you use a label name that's more consistent with the rest of the
BlueZ code base. I think "failed" would be the most suitable one here.

Johan
