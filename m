Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH BlueZ v2 2/9] Add support for storing SMP keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 07 Jul 2011 10:28:02 +0200
In-Reply-To: <1309983041-23744-3-git-send-email-vinicius.gomes@openbossa.org>
References: <y>
	 <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1309983041-23744-3-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310027300.21109.55.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

>  plugins/mgmtops.c |    4 ++--
>  src/event.c       |   44 +++++++++++++++++++++++++++++++++++++++++---
>  src/storage.c     |   25 ++++++++++++++++++++++++-
>  src/storage.h     |    1 +
>  4 files changed, 68 insertions(+), 6 deletions(-)
> 
> diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
> index 6b5422e..f11ff50 100644
> --- a/plugins/mgmtops.c
> +++ b/plugins/mgmtops.c
> @@ -383,8 +383,8 @@ static void mgmt_new_key(int sk, uint16_t index, void *buf, size_t len)
>  	struct mgmt_ev_new_key *ev = buf;
>  	struct controller_info *info;
>  
> -	if (len != sizeof(*ev)) {
> -		error("new_key event size mismatch (%zu != %zu)",
> +	if (len < sizeof(*ev)) {
> +		error("new_key event size mismatch (%zu < %zu)",
>  							len, sizeof(*ev));
>  		return;
>  	}
> diff --git a/src/event.c b/src/event.c
> index 3f0f454..9cdb5e1 100644
> --- a/src/event.c
> +++ b/src/event.c
> @@ -395,6 +395,43 @@ proceed:
>  	adapter_set_state(adapter, STATE_IDLE);
>  }
>  
> +static gchar *buf2str(uint8_t *data, int datalen)
> +{
> +	gchar *buf;
> +	int i;

please that not use more gchar anymore. Just use plain char.

> +	buf = g_new0(gchar, (datalen * 2) + 1);

Is it okay to not use g_try_new0.

> +
> +	for (i = 0; i < datalen; i++)
> +		sprintf(buf + (i * 2), "%2.2x", data[i]);
> +
> +	return buf;
> +}

Regards

Marcel


