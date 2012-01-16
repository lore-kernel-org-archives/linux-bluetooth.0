Return-Path: <cyrus@holtmann.org>
Message-id: <895415989D644B5AB712230EEFE0904B@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <1326534835-6995-1-git-send-email-luiz.dentz@gmail.com>
Subject: Re: [PATCH obexd] client: fix parsing of apparam on pbap driver
Date: Mon, 16 Jan 2012 20:22:48 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

----- Original Message ----- 
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: <linux-bluetooth@vger.kernel.org>
Sent: Saturday, January 14, 2012 3:23 PM
Subject: [PATCH obexd] client: fix parsing of apparam on pbap driver


> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Header pointer need to be updated otherwise the code will be stuck in the
> first parameter even though the size is updated.
> ---
> client/pbap.c |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/client/pbap.c b/client/pbap.c
> index 9e9eb05..1da0ae5 100644
> --- a/client/pbap.c
> +++ b/client/pbap.c
> @@ -364,7 +364,7 @@ static void read_return_apparam(struct obc_session 
> *session,
> {
>  struct obc_transfer *transfer = obc_session_get_transfer(session);
>  struct obc_transfer_params params;
> - unsigned char *buf;
> + struct apparam_hdr *hdr;
>  size_t size = 0;
>
>  *phone_book_size = 0;
> @@ -376,9 +376,9 @@ static void read_return_apparam(struct obc_session 
> *session,
>  if (params.size < APPARAM_HDR_SIZE)
>  return;
>
> - while (size > APPARAM_HDR_SIZE) {
> - struct apparam_hdr *hdr = (struct apparam_hdr *) params.data;
> + hdr = (struct apparam_hdr *) params.data;
>
> + while (size > APPARAM_HDR_SIZE) {
>  if (hdr->len > size - APPARAM_HDR_SIZE) {
>  error("Unexpected PBAP pullphonebook app"
>  " length, tag %d, len %d",
> @@ -404,7 +404,7 @@ static void read_return_apparam(struct obc_session 
> *session,
>  hdr->tag, hdr->len);
>  }
>
> - buf += APPARAM_HDR_SIZE + hdr->len;
> + hdr += APPARAM_HDR_SIZE + hdr->len;
>  size -= APPARAM_HDR_SIZE + hdr->len;
>  }
> }

Here one more changes is required. Since we are not updating the size
while (size > APPARAM_HDR_SIZE) statement will always evaluate as false
and it will never enter into the loop. So we need to have a statement
size = params.size; before checking for the while() condition. Correct me if 
I 'm wrong here.

Thanks,
Syam

> -- 
> 1.7.7.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html 

