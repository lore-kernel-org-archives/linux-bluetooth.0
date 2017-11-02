Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <64c3c710-09a3-2379-9a5f-51f9001f2cc4@jp.fujitsu.com>
References: <64c3c710-09a3-2379-9a5f-51f9001f2cc4@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 2 Nov 2017 14:08:36 +0200
Message-ID: <CABBYNZJRG_qmTO_L_EHtRA-BmjELRB1W1izvXKHLXJZn0KjPsQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] client: Fix clearing advertising service data
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Thu, Nov 2, 2017 at 9:46 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Even if running set-advertise-manufacturer with data having an invalid
> value, client does not clear the advertising service data and clears the
> advertising manufacturer data.
> ---
>  client/advertising.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/client/advertising.c b/client/advertising.c
> index 7e4bb3643..76eda3c97 100644
> --- a/client/advertising.c
> +++ b/client/advertising.c
> @@ -517,7 +517,7 @@ void ad_advertise_manufacturer(DBusConnection *conn, const char *arg)
>                 val = strtol(w.we_wordv[i], &endptr, 0);
>                 if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
>                         rl_printf("Invalid value at index %d\n", i);
> -                       ad_clear_service();
> +                       ad_clear_manufacturer();
>                         goto done;
>                 }
>
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
