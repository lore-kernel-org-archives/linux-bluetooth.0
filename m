Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161201204030.27626-1-luiz.dentz@gmail.com>
References: <20161201204030.27626-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 2 Dec 2016 13:54:31 +0200
Message-ID: <CABBYNZL7e5KdrBzxaGcaQJJ6batGBJEc597mkawZ-cg4JLZsKw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] shared/gatt-client: Fix not checking ATT error properly
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 1, 2016 at 10:40 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  src/shared/gatt-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 4386692..c4102dd 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1052,7 +1052,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
>                                         "Primary service discovery failed."
>                                         " ATT ECODE: 0x%02x", att_ecode);
>                 /* Reset error in case of not found */
> -               if (BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
> +               if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND) {
>                         success = true;
>                         att_ecode = 0;
>                 }
> --
> 2.9.3

Ive skipped this one since Petri's patches are now applied, the other
2 were applied though.



-- 
Luiz Augusto von Dentz
