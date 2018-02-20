Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180220151358.20781-1-szymon.janc@codecoup.pl>
References: <20180220151358.20781-1-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Feb 2018 18:21:54 +0200
Message-ID: <CABBYNZ+gAGOHFyJ+gCDiTf_cJMF_+g5cyx2JtQ5S4nh_eUGGzQ@mail.gmail.com>
Subject: Re: [PATCH] advertising: Fix setting discoverable flag only for peripheral
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Feb 20, 2018 at 5:13 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> General Discoverable mode can also be set for non-connectable
> advertising. This was affecting GAP/DISC/GENM/BV-03-C qualification
> testcase.
> ---
>  src/advertising.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 38d2a2d1f..6e227d4d1 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -622,12 +622,11 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func)
>
>         DBG("Refreshing advertisement: %s", client->path);
>
> -       if (client->type == AD_TYPE_PERIPHERAL) {
> +       if (client->type == AD_TYPE_PERIPHERAL)
>                 flags = MGMT_ADV_FLAG_CONNECTABLE;
>
> -               if (btd_adapter_get_discoverable(client->manager->adapter))
> -                       flags |= MGMT_ADV_FLAG_DISCOV;
> -       }
> +       if (btd_adapter_get_discoverable(client->manager->adapter))
> +               flags |= MGMT_ADV_FLAG_DISCOV;

iirc there were something saying that non-connectable advertisement
should not set these flags, if I recall this right this was why
beacons used to not show on the discovery or something like that.

-- 
Luiz Augusto von Dentz
