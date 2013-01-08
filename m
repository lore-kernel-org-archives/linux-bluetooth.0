Return-Path: <cyrus@holtmann.org>
Message-ID: <1357615207.1806.17.camel@aeonflux>
Subject: Re: [PATCH 2/2] shared: Fix build break
From: Marcel Holtmann <marcel@holtmann.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 07 Jan 2013 19:20:07 -0800
In-Reply-To: <1357562033-26230-2-git-send-email-jaganath.k@samsung.com>
References: <1357562033-26230-1-git-send-email-jaganath.k@samsung.com>
	 <1357562033-26230-2-git-send-email-jaganath.k@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> This patch fixes the below build error
> 
> src/shared/mgmt.c: In function ‘mgmt_cancel_index’:
> src/shared/mgmt.c:559:30: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
> cc1: all warnings being treated as errors
> make[1]: *** [src/shared/bluetoothd-mgmt.o] Error 1
> make: *** [all] Error 2
> ---
>  src/shared/mgmt.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index 2297caf..c832a88 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -553,10 +553,12 @@ bool mgmt_cancel(struct mgmt *mgmt, unsigned int id)
>  
>  bool mgmt_cancel_index(struct mgmt *mgmt, uint16_t index)
>  {
> +	guint id = index;
> +

I changed this into unsigned int instead when applying the patch.

Regards

Marcel


