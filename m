Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jun 2013 12:57:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: Re: [RFC BlueZ 06/35] emulator: Search virtual devices in LE scan
 mode
Message-ID: <20130619095717.GB6370@x220>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
 <1371041841-21793-7-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371041841-21793-7-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 12, 2013, Bruna Moreira wrote:
> From: Jefferson Delfes <jefferson.delfes@openbossa.org>
> 
> When a virtual device starts an LE advertising, emulator search other
> devices that are in scan mode, in order to send adv data to these
> devices.
> ---
>  emulator/btdev.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 160e5bf..2725c76 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -876,6 +876,19 @@ static void remote_version_complete(struct btdev *btdev, uint16_t handle)
>  							&rvc, sizeof(rvc));
>  }
>  
> +static void le_set_adv_enable_complete(struct btdev *btdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
> +		if (!btdev_list[i] || btdev_list[i] == btdev)
> +			continue;
> +
> +		if (!btdev_list[i]->le_scan_enable)
> +			continue;
> +	}
> +}

Same thing as with my earlier comment. This function doesn't seem to do
anything useful and should probably be merged with some later patch that
actually does something (assuming such a patch exists).

Johan
