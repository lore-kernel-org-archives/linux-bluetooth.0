Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <01a05144-a446-cf88-4f16-ce230c27474c@jp.fujitsu.com>
References: <01a05144-a446-cf88-4f16-ce230c27474c@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 21 Jul 2017 15:04:41 +0300
Message-ID: <CABBYNZLuM=2tQwJ2FYnz__LL_HhOWJWh98+SmCy=PnHL8MmtSA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] plugins: Fix reconnect_interval for cases of
 improper main.conf
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Thu, Jul 20, 2017 at 9:22 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> There are two problems:
>
>  - When main.conf is not found, bluetoothd copies short the default set
>    of reconnecting intervals to reconnect_interval. It does not match
>    the reconnct_interval_len used as the array length.
>    So if a link of device is disconnected, bluetoothd is run over
>    reconnect_interval as time proceeds and will not time out as expected.
>
>    bluetooothd with --debug option outputed the following log in my box:
>
>      plugins/policy.c:reconnect_set_timer() attempt 1/7 1 seconds
>      plugins/policy.c:reconnect_timeout() Reconnecting profiles
>      plugins/policy.c:conn_fail_cb() status 4
>      plugins/policy.c:reconnect_set_timer() attempt 2/7 2 seconds
>      plugins/policy.c:reconnect_timeout() Reconnecting profiles
>      plugins/policy.c:conn_fail_cb() status 4
>      plugins/policy.c:reconnect_set_timer() attempt 3/7 0 seconds
>      plugins/policy.c:reconnect_timeout() Reconnecting profiles
>      plugins/policy.c:conn_fail_cb() status 4
>      plugins/policy.c:reconnect_set_timer() attempt 4/7 0 seconds
>
>  - When ReconnectIntervals in main.conf includes invalid characters,
>    reconnct_interval_len value is bigger than the default array length.
>    So if ReconnectAttempts value in main.conf is bigger than
>    reconnct_interval_len value and a link of device is disconnected,
>    bluetoothd is run over reconnect_interval as time proceeds and will
>    not time out as expected.
>
>    bluetooothd with --debug option outputed the following log in my box,
>    if ReconnectAttempts value was 28 and ReconnectIntervals was inproper:
>
>      ...
>      plugins/policy.c:reconnect_set_timer() attempt 6/28 32 seconds
>      plugins/policy.c:reconnect_timeout() Reconnecting profiles
>      plugins/policy.c:conn_fail_cb() status 4
>      plugins/policy.c:reconnect_set_timer() attempt 7/28 64 seconds
>      plugins/policy.c:reconnect_timeout() Reconnecting profiles
>      plugins/policy.c:conn_fail_cb() status 4
>      plugins/policy.c:reconnect_set_timer() attempt 8/28 0 seconds
>      ...
>      plugins/policy.c:reconnect_set_timer() attempt 25/28 1 seconds
>      plugins/policy.c:reconnect_timeout() Reconnecting profiles
>      plugins/policy.c:conn_fail_cb() status 4
>      plugins/policy.c:reconnect_set_timer() attempt 26/28 3 seconds
>      plugins/policy.c:reconnect_timeout() Reconnecting profiles
>      plugins/policy.c:conn_fail_cb() status 4
>      plugins/policy.c:reconnect_set_timer() attempt 27/28 110683472 seconds
>
> This fix properly uses the default set of reconnecting intervals.
> ---
>  plugins/policy.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/plugins/policy.c b/plugins/policy.c
> index c54878a..1f5a506 100644
> --- a/plugins/policy.c
> +++ b/plugins/policy.c
> @@ -778,7 +778,7 @@ static int policy_init(void)
>                 reconnect_intervals_len = sizeof(default_intervals) /
>                                                 sizeof(*reconnect_intervals);
>                 reconnect_intervals = g_memdup(default_intervals,
> -                                               reconnect_intervals_len);
> +                                               sizeof(default_intervals));
>                 goto done;
>         }
>
> @@ -806,9 +806,10 @@ static int policy_init(void)
>                                         &gerr);
>         if (gerr) {
>                 g_clear_error(&gerr);
> -               reconnect_intervals_len = sizeof(default_intervals);
> +               reconnect_intervals_len = sizeof(default_intervals) /
> +                                               sizeof(*reconnect_intervals);
>                 reconnect_intervals = g_memdup(default_intervals,
> -                                               reconnect_intervals_len);
> +                                               sizeof(default_intervals));
>         }
>
>         auto_enable = g_key_file_get_boolean(conf, "Policy", "AutoEnable",
> --
> 2.7.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
