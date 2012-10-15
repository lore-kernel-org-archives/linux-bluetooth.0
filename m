Return-Path: <cyrus@holtmann.org>
Date: Mon, 15 Oct 2012 17:37:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 04/16] AVRCP: Don't respond with errors when no
 player is registered
Message-ID: <20121015143717.GA3393@x220.P-661HNU-F1>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
 <1350309936-31588-4-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350309936-31588-4-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 15, 2012, Luiz Augusto von Dentz wrote:
> +static void *player_get_metadata(struct avrcp_player *player, uint32_t attr)
> +{
> +	if (player != NULL)
> +		return player->cb->get_metadata(attr, player->user_data);
> +
> +	if (attr == AVRCP_MEDIA_ATTRIBUTE_TITLE)
> +		return "";

This is quite messed up. Using void pointers like that just obfuscates
what the code is doing. After a quick look at current git it seems to me
like struct metadata_value from media.c should be made public and that
should be the return type of this function instead of doing void pointer
magic.

Johan
