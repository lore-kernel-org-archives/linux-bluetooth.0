Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1391088223-2586-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391088223-2586-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Sun, 2 Feb 2014 08:05:55 -0800
Message-ID: <CABBYNZ+-BF0Ovb36PrDCZ5-qvAT2VUSDWbevgO2GWSMia5aeZA@mail.gmail.com>
Subject: Re: [PATCH] android/avrcp: Close AVRCP channel on error
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jan 30, 2014 at 5:23 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> This fixes resource leak.
> ---
>  android/avrcp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/android/avrcp.c b/android/avrcp.c
> index 485b485..ef833df 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -248,13 +248,13 @@ bool bt_avrcp_register(const bdaddr_t *addr)
>         rec = avrcp_record();
>         if (!rec) {
>                 error("Failed to allocate AVRCP record");
> -               return false;
> +               goto fail;
>         }
>
>         if (bt_adapter_add_record(rec, 0) < 0) {
>                 error("Failed to register AVRCP record");
>                 sdp_record_free(rec);
> -               return false;
> +               goto fail;
>         }
>         record_id = rec->handle;
>
> @@ -262,6 +262,12 @@ bool bt_avrcp_register(const bdaddr_t *addr)
>                                                 G_N_ELEMENTS(cmd_handlers));
>
>         return true;
> +fail:
> +       g_io_channel_shutdown(server, TRUE, NULL);
> +       g_io_channel_unref(server);
> +       server = NULL;
> +
> +       return false;
>  }
>
>  void bt_avrcp_unregister(void)
> --
> 1.8.3.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
