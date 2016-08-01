Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1469195785-8907-1-git-send-email-luiz.dentz@gmail.com>
References: <1469195785-8907-1-git-send-email-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Aug 2016 14:49:56 +0300
Message-ID: <CABBYNZKriUJXF=Msg3vw1O78cmzY6Aw97UeEOBPQbg_FWGaaew@mail.gmail.com>
Subject: Re: [PATCH BlueZ] core/advertising: Fix not adding local name and
 appearance flags
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Jul 22, 2016 at 4:56 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If the advertisement is cause the connectable flag to be set add local
> name and appearance so the scan response is generated properly as the
> remote may attempt connect/pair these information shall be made available
> as well.
> ---
>  src/advertising.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index d2019de..52b536d 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -473,7 +473,8 @@ static DBusMessage *refresh_advertisement(struct advertisement *ad)
>         DBG("Refreshing advertisement: %s", ad->path);
>
>         if (ad->type == AD_TYPE_PERIPHERAL)
> -               flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV;
> +               flags = MGMT_ADV_FLAG_CONNECTABLE | MGMT_ADV_FLAG_DISCOV |
> +                       MGMT_ADV_FLAG_APPEARANCE | MGMT_ADV_FLAG_LOCAL_NAME;
>
>         if (ad->include_tx_power)
>                 flags |= MGMT_ADV_FLAG_TX_POWER;
> --
> 2.7.4

This does not work since the kernel does not even check those flags,
instead it seems to expect the scan data to come directly from
userspace.


-- 
Luiz Augusto von Dentz
