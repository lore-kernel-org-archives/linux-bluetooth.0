Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Jul 2014 11:57:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/ipc: Rename connect_sco to get_fd
Message-ID: <20140721085730.GB27596@t440s.lan>
References: <1833630.zaps8haTKY@uw000953>
 <1405689994-27037-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405689994-27037-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jul 18, 2014, Andrei Emeltchenko wrote:
> SCO get connected through handsfree HAL and Audio SCO HAL only need to
> get SCO socket fd.
> ---
>  android/hal-sco.c       |  4 ++--
>  android/handsfree.c     | 10 +++++-----
>  android/sco-ipc-api.txt |  6 +++---
>  android/sco-msg.h       |  4 ++--
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/android/hal-sco.c b/android/hal-sco.c
> index 0e87aad..e07bb9a 100644
> --- a/android/hal-sco.c
> +++ b/android/hal-sco.c
> @@ -285,12 +285,12 @@ static int ipc_connect_sco(void)

Shouldn't you change the name of this ipc_connect_sco function too?

>  	pthread_mutex_lock(&sco_mutex);
>  
>  	if (sco_fd < 0) {
> -		struct sco_rsp_connect rsp;
> +		struct sco_rsp_get_fd rsp;
>  		size_t rsp_len = sizeof(rsp);
>  
>  		DBG("Connecting SCO");

And this debug log?

Johan
