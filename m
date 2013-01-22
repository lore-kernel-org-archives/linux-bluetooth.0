Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358775211-31005-1-git-send-email-s.syam@samsung.com>
References: <1358775211-31005-1-git-send-email-s.syam@samsung.com>
Date: Tue, 22 Jan 2013 14:04:14 +0200
Message-ID: <CABBYNZ+84Yi8C6M+41U8HiyMhyMh4+rypR7ZQJhnM=Be_9=K0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] health: Fix possible use after free
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Mon, Jan 21, 2013 at 3:33 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> A pointer to freed memory is dereferenced if we call function
> hdp_get_dcpsm_cb() with out any earlier reference.
> ---
>  profiles/health/hdp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
> index c15f06a..a42ca48 100644
> --- a/profiles/health/hdp.c
> +++ b/profiles/health/hdp.c
> @@ -542,9 +542,9 @@ static void hdp_get_dcpsm_cb(uint16_t dcpsm, gpointer user_data, GError *err)
>                                         hdp_tmp_dc_data_destroy, &gerr))
>                 return;
>
> -       hdp_tmp_dc_data_unref(hdp_conn);
>         hdp_conn->cb(hdp_chann->mdl, err, hdp_conn);
>         g_error_free(gerr);
> +       hdp_tmp_dc_data_unref(hdp_conn);
>  }
>
>  static void device_reconnect_mdl_cb(struct mcap_mdl *mdl, GError *err,
> --
> 1.7.9.5

All 3 patches are now upstream, thanks.


--
Luiz Augusto von Dentz
