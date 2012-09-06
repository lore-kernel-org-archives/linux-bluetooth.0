Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1346922908-16016-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346922908-16016-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Thu, 6 Sep 2012 10:59:03 -0300
Message-ID: <CAKT1EBfTpu+GKOSd=jY53rBv3PkvQYqvpnz=2k3m6xV4=ytsew@mail.gmail.com>
Subject: Re: [PATCH] gatt: Fix reading Service Changed CCC
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej:

On Thu, Sep 6, 2012 at 6:15 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> Find Information Request is only sent when there are no more attributes
> following Service Changed Value (incorrect) and thus will never find CCC.
> ---
>  profiles/gatt/gas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
> index ddd4e70..28d7fbf 100644
> --- a/profiles/gatt/gas.c
> +++ b/profiles/gatt/gas.c
> @@ -245,7 +245,7 @@ static void gatt_characteristic_cb(GSList *characteristics, guint8 status,
>         start = chr->value_handle + 1;
>         end = gas->gatt.end;
>
> -       if (start <= end) {
> +       if (start > end) {
>                 error("Inconsistent database: Service Changed CCC missing");
>                 return;
>         }
> --
> 1.7.11.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

ack!

Regards,
Claudio
