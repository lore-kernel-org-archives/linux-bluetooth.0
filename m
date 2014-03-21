Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1395403104-10344-1-git-send-email-luiz.dentz@gmail.com>
References: <1395403104-10344-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 21 Mar 2014 16:15:16 +0200
Message-ID: <CABBYNZ+Z=2Cyqs=__fdrL0P3cJAJ8MyZk08KOcg_Q9qBLGT0DQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] gobex: Add g_obex_disconnect
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Mar 21, 2014 at 1:58 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds g_obex_disconnect function which can be used to send OBEX
> Disconnect command.
> ---
>  gobex/gobex.c | 12 ++++++++++++
>  gobex/gobex.h |  3 +++
>  2 files changed, 15 insertions(+)
>
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index d7d325b..ca15941 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -1445,6 +1445,18 @@ guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
>         return g_obex_send_req(obex, req, -1, func, user_data, err);
>  }
>
> +guint g_obex_disconnect(GObex *obex, GObexResponseFunc func, gpointer user_data,
> +                                                               GError **err)
> +{
> +       GObexPacket *req;
> +
> +       g_obex_debug(G_OBEX_DEBUG_COMMAND, "");
> +
> +       req = g_obex_packet_new(G_OBEX_OP_DISCONNECT, TRUE, G_OBEX_HDR_INVALID);
> +
> +       return g_obex_send_req(obex, req, -1, func, user_data, err);
> +}
> +
>  guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
>                                         gpointer user_data, GError **err)
>  {
> diff --git a/gobex/gobex.h b/gobex/gobex.h
> index 76a224e..7c47590 100644
> --- a/gobex/gobex.h
> +++ b/gobex/gobex.h
> @@ -75,6 +75,9 @@ void g_obex_unref(GObex *obex);
>  guint g_obex_connect(GObex *obex, GObexResponseFunc func, gpointer user_data,
>                                 GError **err, guint8 first_hdr_id, ...);
>
> +guint g_obex_disconnect(GObex *obex, GObexResponseFunc func, gpointer user_data,
> +                                                               GError **err);
> +
>  guint g_obex_setpath(GObex *obex, const char *path, GObexResponseFunc func,
>                                         gpointer user_data, GError **err);
>
> --
> 1.8.5.3

Pushed.


-- 
Luiz Augusto von Dentz
