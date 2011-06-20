Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308563100-18917-11-git-send-email-nami.li@atheros.com>
References: <1308563100-18917-1-git-send-email-nami.li@atheros.com>
	<1308563100-18917-11-git-send-email-nami.li@atheros.com>
Date: Mon, 20 Jun 2011 13:23:25 +0300
Message-ID: <BANLkTin11xUyUgF0VL4wD+fA7iPSZ=SXtA@mail.gmail.com>
Subject: Re: [PATCH obexd 11/14] Client parse server GoepL2capPsm attribute.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, haijun@qca.qualcomm.com,
	yongli@qca.qualcomm.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jun 20, 2011 at 12:44 PM, Nami <nami.li@atheros.com> wrote:
> ---
>  client/session.c |   52 +++++++++++++++++++++++++++++++++++++++++++++-------
>  client/session.h |    4 ++++
>  2 files changed, 49 insertions(+), 7 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index 8a6ee2c..0e21994 100755
> --- a/client/session.c
> +++ b/client/session.c
> @@ -282,6 +282,14 @@ static GIOChannel *rfcomm_connect(const bdaddr_t *src, const bdaddr_t *dst,
>        g_error_free(err);
>        return NULL;
>  }
> +static void l2cap_callback(GIOChannel *io, GError *err, gpointer user_data)
> +{
> +}
> +static GIOChannel *l2cap_connect(const bdaddr_t *src, const bdaddr_t *dst,
> +                                       uint16_t psm, BtIOConnect function,
> +                                       gpointer user_data)
> +{
> +}

Not sure why you have to create those empty functions, the real code
is in another patch I suppose?

>  static void search_callback(uint8_t type, uint16_t status,
>                        uint8_t *rsp, size_t size, void *user_data)
> @@ -291,6 +299,7 @@ static void search_callback(uint8_t type, uint16_t status,
>        unsigned int scanned, bytesleft = size;
>        int seqlen = 0;
>        uint8_t dataType, channel = 0;
> +       uint16_t l2capPsm = 0;
>        GError *gerr = NULL;
>
>        if (status || type != SDP_SVC_SEARCH_ATTR_RSP)
> @@ -305,7 +314,9 @@ static void search_callback(uint8_t type, uint16_t status,
>        do {
>                sdp_record_t *rec;
>                sdp_list_t *protos;
> +               sdp_data_t *data;
>                int recsize, ch = -1;
> +               int l2psm = -1;
>
>                recsize = 0;
>                rec = sdp_extract_pdu(rsp, bytesleft, &recsize);
> @@ -316,7 +327,11 @@ static void search_callback(uint8_t type, uint16_t status,
>                        sdp_record_free(rec);
>                        break;
>                }
> -
> +               data = sdp_data_get(rec, SDP_ATTR_GOEP_L2CAP_PSM);
> +               if(data != NULL){
> +                       l2psm = data->val.uint16;
> +                       DBG("sdp l2psm is %d,",l2psm);
> +               }
>                if (!sdp_get_access_protos(rec, &protos)) {
>                        ch = sdp_get_proto_port(protos, RFCOMM_UUID);
>                        sdp_list_foreach(protos,
> @@ -327,6 +342,11 @@ static void search_callback(uint8_t type, uint16_t status,
>
>                sdp_record_free(rec);
>
> +               if (l2psm > 0) {
> +                       l2capPsm = l2psm;
> +                       break;
> +               }

Not sure why you need l2capPsm, which iirc do not conform with our
code styling guidelines, why can't you move l2psm outside the do while
scope and just use it directly?

> +
>                if (ch > 0) {
>                        channel = ch;
>                        break;
> @@ -337,16 +357,28 @@ static void search_callback(uint8_t type, uint16_t status,
>                bytesleft -= recsize;
>        } while (scanned < size && bytesleft > 0);
>
> -       if (channel == 0)
> +       if ((l2capPsm == 0)&&(channel == 0))
>                goto failed;
>
> -       session->channel = channel;
> +       if(l2capPsm > 0){
> +               session->psm = l2capPsm;
>
> -       g_io_channel_set_close_on_unref(session->io, FALSE);
> -       g_io_channel_unref(session->io);
> +               g_io_channel_set_close_on_unref(session->io, FALSE);
> +               g_io_channel_unref(session->io);
> +
> +               session->io = l2cap_connect(&session->src, &session->dst, l2capPsm,
> +                                               l2cap_callback, callback);
> +       }else{
> +
> +               session->channel = channel;
> +
> +               g_io_channel_set_close_on_unref(session->io, FALSE);
> +               g_io_channel_unref(session->io);
> +
> +               session->io = rfcomm_connect(&session->src, &session->dst, channel,
> +                                               rfcomm_callback, callback);
> +       }
>
> -       session->io = rfcomm_connect(&session->src, &session->dst, channel,
> -                                       rfcomm_callback, callback);
>        if (session->io != NULL) {
>                sdp_close(callback->sdp);
>                return;
> @@ -611,6 +643,12 @@ proceed:
>        if (session->obex) {
>                g_idle_add(connection_complete, callback);
>                err = 0;
> +       } else if (session->psm > 0) {
> +               session->io = l2cap_connect(&session->src, &session->dst,
> +                                                       session->psm,
> +                                                       l2cap_callback,
> +                                                       callback);
> +               err = (session->io == NULL) ? -EINVAL : 0;
>        } else if (session->channel > 0) {
>                session->io = rfcomm_connect(&session->src, &session->dst,
>                                                        session->channel,
> diff --git a/client/session.h b/client/session.h
> index 9180e75..24b1ec5 100755
> --- a/client/session.h
> +++ b/client/session.h
> @@ -54,6 +54,10 @@ struct session_data {
>        void *priv;
>  };
>
> +#ifndef SDP_ATTR_GOEP_L2CAP_PSM
> +#define SDP_ATTR_GOEP_L2CAP_PSM                0x0200
> +#endif
> +
>  typedef void (*session_callback_t) (struct session_data *session,
>                                        GError *err, void *user_data);
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Luiz Augusto von Dentz
