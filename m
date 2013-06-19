Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jun 2013 12:56:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bruna Moreira <bruna.moreira@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: Re: [RFC BlueZ 05/35] emulator: Search virtual devices in LE
 advertising mode
Message-ID: <20130619095630.GA6370@x220>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
 <1371041841-21793-6-git-send-email-bruna.moreira@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371041841-21793-6-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jun 12, 2013, Bruna Moreira wrote:
> From: Jefferson Delfes <jefferson.delfes@openbossa.org>
> 
> After LE scan is enabled, the emulator search virtual devices that are
> in advertising mode, in order to copy adv data.
> ---
>  emulator/btdev.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index a7af6b3..160e5bf 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -876,6 +876,19 @@ static void remote_version_complete(struct btdev *btdev, uint16_t handle)
>  							&rvc, sizeof(rvc));
>  }
>  
> +static void le_set_scan_enable_complete(struct btdev *btdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_BTDEV_ENTRIES; i++) {
> +		if (!btdev_list[i] || btdev_list[i] == btdev)
> +			continue;
> +
> +		if (!btdev_list[i]->le_adv_enable)
> +			continue;
> +	}
> +}

What's the purpose of this function? It doesn't seem to do anything but
iterate through the btdev list. Should it be merged with some later
patch (which actually does something useful)?

Johan
