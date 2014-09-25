Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] shared/hciemu: Fix not handling failed read correctly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1411641514-5323-1-git-send-email-szymon.janc@tieto.com>
Date: Thu, 25 Sep 2014 13:43:06 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <412032E8-B57A-4F02-AF65-431CFD78463E@holtmann.org>
References: <1411641514-5323-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> If read failed due to signal or blocking watch was removed resulting
> in closing /dev/vhci and emulated adapter being removed.
> 
> This was affecting android-tester since premature removal of adapter
> is considered error on android daemon.
> ---
> src/shared/hciemu.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
> index 3892fea..c0b1eae 100644
> --- a/src/shared/hciemu.c
> +++ b/src/shared/hciemu.c
> @@ -179,8 +179,12 @@ static gboolean receive_btdev(GIOChannel *channel, GIOCondition condition,
> 	fd = g_io_channel_unix_get_fd(channel);
> 
> 	len = read(fd, buf, sizeof(buf));
> -	if (len < 1)
> +	if (len < 1) {
> +		if (len < 0 && (errno == EAGAIN || errno == EINTR))
> +			return TRUE;
> +
> 		return FALSE;
> +	}

	len = read(fd, buf, sizeof(buf));
	if (len < 0) {
		if (errno == EGAIN || errno == EINTR)
			return TRUE;

		return FALSE;
	}

	if (len < 1)
		return FALSE;

I prefer that we do not intermix error handling with minimum length check.

> 
> 	switch (buf[0]) {
> 	case BT_H4_CMD_PKT:

Regards

Marcel

