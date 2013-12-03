Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 3 Dec 2013 21:53:43 +0200
Message-ID: <CABBYNZKRWtCvq_yg7dT+2iJFL5rvPauiOkqYP3diCc_6TN_SkA@mail.gmail.com>
Subject: Re: [PATCH 1/6] android/a2dp: Fix possible NULL dereference
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Dec 3, 2013 at 5:53 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Since a2dp_record may return NULL, check return value. This
> silences static analysers tools.
> ---
>  android/a2dp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/android/a2dp.c b/android/a2dp.c
> index cee4bfa..36a0714 100644
> --- a/android/a2dp.c
> +++ b/android/a2dp.c
> @@ -366,9 +366,10 @@ bool bt_a2dp_register(const bdaddr_t *addr)
>         }
>
>         rec = a2dp_record();
> -       if (bt_adapter_add_record(rec, SVC_HINT_CAPTURING) < 0) {
> +       if (!rec || bt_adapter_add_record(rec, SVC_HINT_CAPTURING) < 0) {

Usually we check the return individually, that means you do if (rec)
and perhaps handle the error path with goto, but first make sure that
a2dp_record can actually fail otherwise this is pointless.

>                 error("Failed to register on A2DP record");
> -               sdp_record_free(rec);
> +               if (rec)
> +                       sdp_record_free(rec);
>                 g_io_channel_shutdown(server, TRUE, NULL);
>                 g_io_channel_unref(server);
>                 server = NULL;
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
