Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1273486527-7855-3-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
	 <1273486527-7855-2-git-send-email-sancane@gmail.com>
	 <1273486527-7855-3-git-send-email-sancane@gmail.com>
Date: Tue, 11 May 2010 19:09:55 -0300
Message-ID: <AANLkTilMh75dW1rUlmOV_AZ7UZqGX1vv_nyZu9qaJgKX@mail.gmail.com>
Subject: Re: [PATCH 03/25] Release resources depending if MCAP should cache or
	not a MCL
From: Raul Herbster <raul.herbster@signove.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

2010/5/10 Santiago Carot-Nemesio <sancane@gmail.com>:
> From: Santiago Carot Nemesio <sancane@gmail.com>
>
> ---
>  mcap/mcap.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 81 insertions(+), 2 deletions(-)
>
> diff --git a/mcap/mcap.c b/mcap/mcap.c
> index 1c94452..7d34b95 100644
> --- a/mcap/mcap.c
> +++ b/mcap/mcap.c
> @@ -36,14 +36,93 @@
>
>  #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
>
> +#define RELEASE_TIMER(__mcl) do {      \
> +       g_source_remove(__mcl->tid);    \
> +       __mcl->tid = 0;                 \
> +} while(0)
> +
> +static void shutdown_mdl(struct mcap_mdl *mdl)
> +{
> +       mdl->state = MDL_CLOSED;
> +
> +       g_source_remove(mdl->wid);
> +
> +       if (mdl->dc) {
> +               g_io_channel_shutdown(mdl->dc, TRUE, NULL);
> +               g_io_channel_unref(mdl->dc);
> +               mdl->dc = NULL;
> +       }
> +}
> +
> +static void mcap_free_mdls(struct mcap_mcl *mcl, gboolean save)
> +{
> +       GSList *l;
> +       struct mcap_mdl *mdl;
> +
> +       if (!mcl->mdls)
> +               return;
> +
> +       for (l = mcl->mdls; l; l = l->next) {
> +               mdl = l->data;
> +               shutdown_mdl(mdl);
> +               if (!save)
> +                       g_free(mdl);
> +       }
> +
> +       if (!save) {
> +               g_slist_free(mcl->mdls);
> +               mcl->mdls = NULL;
> +       }
> +}
> +
> +static void mcap_mcl_free(struct mcap_mcl *mcl, gboolean save)
> +{
> +       gboolean store = ((!(mcl->ctrl & MCAP_CTRL_FREE)) && save);
> +
> +       if (mcl->tid) {
> +               RELEASE_TIMER(mcl);
> +       }
> +
> +       if (mcl->cc) {
> +               g_io_channel_shutdown(mcl->cc, TRUE, NULL);
> +               g_io_channel_unref(mcl->cc);
> +               mcl->cc = NULL;
> +       }
> +
> +       g_source_remove(mcl->wid);
> +       if (mcl->lcmd) {
> +               g_free(mcl->lcmd);
> +               mcl->lcmd = NULL;
> +       }
> +
> +       if (mcl->priv_data) {
> +               g_free(mcl->priv_data);
> +               mcl->priv_data = NULL;
> +       }
> +
> +       mcap_free_mdls(mcl, store);
> +
> +       if (mcl->cb && !store) {
> +               g_free(mcl->cb);
> +               mcl->cb = NULL;
> +       }
> +
> +       mcl->state = MCL_IDLE;
> +
> +       if (store)
> +               return;
> +
> +       g_free(mcl);
> +}
> +

According to MCL state machine, if there're no more data channels (but
a control channel still exists), the current MCL state is CONNECTED.
Functions shutdown_mdl and mcap_free_mdls should update MCL state
machine properly.


[]' s
--Raul
