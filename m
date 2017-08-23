Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170823064458.36961-1-yunhanw@google.com>
References: <20170823064458.36961-1-yunhanw@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Aug 2017 10:59:03 +0300
Message-ID: <CABBYNZJJ_roS++qMRY2VhFEv719SWdn33d_AD+AVzA3RK1ohWQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] advertising: Fix UUIDs in adv_parser
To: Yunhan Wang <yunhanw@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunhan,

On Wed, Aug 23, 2017 at 9:44 AM, Yunhan Wang <yunhanw@google.com> wrote:
> ---
>  src/advertising.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index f125ca5c8..b03c36fb6 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -496,7 +496,7 @@ static struct adv_parser {
>         bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
>  } parsers[] = {
>         { "Type", parse_type },
> -       { "UUIDs", parse_service_uuids },
> +       { "ServiceUUIDs", parse_service_uuids },
>         { "SolicitUUIDs", parse_solicit_uuids },
>         { "ManufacturerData", parse_manufacturer_data },
>         { "ServiceData", parse_service_data },
> --
> 2.14.1.480.gb18f417b89-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
