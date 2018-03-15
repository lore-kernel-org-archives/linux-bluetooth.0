Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180314131726.24945-1-luiz.dentz@gmail.com>
References: <20180314131726.24945-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Mar 2018 11:01:12 +0200
Message-ID: <CABBYNZJA_xakoD8Q2k5K3YOuP1=gWFNq0YmFoJCFp4s=2athig@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/gatt-client: Omit valid errors for
 primary discovery
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Mar 14, 2018 at 3:17 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND shall not cause anything to be printed
> since it is a valid response and just mark the end of primary discovery.
> ---
>  src/shared/gatt-client.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 1285c37ef..d61668df7 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1023,9 +1023,6 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
>         discovery_req_clear(client);
>
>         if (!success) {
> -               util_debug(client->debug_callback, client->debug_data,
> -                                       "Primary service discovery failed."
> -                                       " ATT ECODE: 0x%02x", att_ecode);
>                 /* Reset error in case of not found */
>                 switch (att_ecode) {
>                 case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
> @@ -1033,6 +1030,9 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
>                         att_ecode = 0;
>                         goto secondary;
>                 default:
> +                       util_debug(client->debug_callback, client->debug_data,
> +                                       "Primary service discovery failed."
> +                                       " ATT ECODE: 0x%02x", att_ecode);
>                         goto done;
>                 }
>         }
> --
> 2.14.3

Applied.


-- 
Luiz Augusto von Dentz
