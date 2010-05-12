Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1273486527-7855-7-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
	 <1273486527-7855-2-git-send-email-sancane@gmail.com>
	 <1273486527-7855-3-git-send-email-sancane@gmail.com>
	 <1273486527-7855-4-git-send-email-sancane@gmail.com>
	 <1273486527-7855-5-git-send-email-sancane@gmail.com>
	 <1273486527-7855-6-git-send-email-sancane@gmail.com>
	 <1273486527-7855-7-git-send-email-sancane@gmail.com>
Date: Wed, 12 May 2010 11:16:15 -0300
Message-ID: <AANLkTinyAAVOsKHK-oihWLjecYwz3iGSEzzRxntleyxw@mail.gmail.com>
Subject: Re: [PATCH 07/25] Initiate creation of MCLs
From: Raul Herbster <raul.herbster@signove.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago

2010/5/10 Santiago Carot-Nemesio <sancane@gmail.com>:
> From: Santiago Carot Nemesio <sancane@gmail.com>
>
> ---
>  mcap/mcap.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 115 insertions(+), 0 deletions(-)
>
> diff --git a/mcap/mcap.c b/mcap/mcap.c
> index ebfaf9e..0112154 100644
> --- a/mcap/mcap.c
> +++ b/mcap/mcap.c
> @@ -43,6 +43,12 @@
>        __mcl->tid = 0;                 \
>  } while(0)
>
> +struct connect_mcl {
> +       struct mcap_mcl         *mcl;           /* MCL for this operation */
> +       mcap_mcl_connect_cb     connect_cb;     /* Connect callback */
> +       gpointer                user_data;      /* Callback user data */
> +};
> +
>  /* MCAP finite state machine functions */
>  static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
>  static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
> @@ -419,6 +425,115 @@ fail:
>        return FALSE;
>  }
>
> +static void mcap_connect_mcl_cb(GIOChannel *chan, GError *conn_err,
> +                                                       gpointer user_data)
> +{
> +       char dstaddr[18];
> +       struct connect_mcl *con = user_data;
> +       struct mcap_mcl *aux, *mcl = con->mcl;
> +       mcap_mcl_connect_cb connect_cb = con->connect_cb;
> +       gpointer data = con->user_data;
> +       GError *gerr = NULL;
> +
> +       g_free(con);
> +
> +       mcl->ctrl &= ~MCAP_CTRL_CONN;
> +
> +       if (conn_err) {
> +               if (mcl->ctrl & MCAP_CTRL_FREE)
> +                       mcl->ms->mcl_uncached_cb(mcl, mcl->ms->user_data);
> +               mcap_mcl_check_del(mcl);
> +               connect_cb(NULL, conn_err, data);
> +               return;
> +       }
> +
> +       ba2str(&mcl->addr, dstaddr);
> +
> +       aux = find_mcl(mcl->ms->mcls, &mcl->addr);
> +       if (aux) {
> +               /* Double MCL connection case */
> +               if (aux != mcl) {
> +                       /* This MCL was not in cache */
> +                       mcap_mcl_unref(mcl);
> +               }
> +               error("MCL error: Device %s is already connected", dstaddr);
> +               g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_ALREADY_EXISTS,
> +                               "MCL %s is already connected", dstaddr);
> +               connect_cb(NULL, gerr, data);
> +               g_error_free(gerr);
> +               return;
> +       }
> +
> +       mcl->state = MCL_CONNECTED;
> +       mcl->role = MCL_INITIATOR;
> +       mcl->req = MCL_AVAILABLE;
> +       mcl->ctrl |= MCAP_CTRL_STD_OP;
> +
> +       if (mcl->ctrl & MCAP_CTRL_CACHED)
> +               mcap_uncache_mcl(mcl);
> +       else
> +               mcl->ms->mcls = g_slist_prepend(mcl->ms->mcls, mcl);
> +
> +       mcl->wid = g_io_add_watch(mcl->cc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
> +                               (GIOFunc) mcl_control_cb, mcl);


More than 80 characters.


[]´s
--Raul
