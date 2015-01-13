Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1421141528-32053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1421141528-32053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 13 Jan 2015 15:39:37 -0200
Message-ID: <CABBYNZ+qe2ivohzpE_8baa1ys=Ngdmzeprna27CwWB=OLrP2wA@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt: Fix typo in request_create check
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Jan 13, 2015 at 7:32 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Fixes typo, check for req instead of client.
> ---
>  src/shared/gatt-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 2c14c3a..42dc504 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1895,7 +1895,7 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
>                 return 0;
>
>         req = request_create(client);
> -       if (!client) {
> +       if (!req) {
>                 free(op);
>                 return 0;
>         }
> --
> 2.1.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
