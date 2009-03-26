Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Implement AVDTP get configuration command
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <35c90d960903261651w285302fco5eb12bd23bcf3a8e@mail.gmail.com>
References: <35c90d960903261651w285302fco5eb12bd23bcf3a8e@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Mar 2009 01:28:50 +0100
Message-Id: <1238027330.8206.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index f276eef..297b578 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -1280,7 +1280,47 @@ failed:
>  static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t
> transaction,
>                                         struct seid_req *req, int
> size)
>  {
> -       return avdtp_unknown_cmd(session, transaction, (void *) req,
> size);
> +       GSList *l;
> +       struct avdtp_local_sep *sep = NULL;
> +       int rsp_size;
> +       uint8_t err;
> +       uint8_t buf[1024];
> +       uint8_t *ptr = buf;
> +
> +       if (size < sizeof(struct seid_req)) {
> +               error("Too short getconf request");
> +               return FALSE;
> +       }
> +
> +       memset(buf, 0, sizeof(buf));
> +
> +       sep = find_local_sep_by_seid(session->server, req->acp_seid);
> +       if (!sep) {
> +               err = AVDTP_BAD_ACP_SEID;
> +               goto failed;
> +       }
> +       if (!sep->stream || !sep->stream->caps) {
> +               err = AVDTP_UNSUPPORTED_CONFIGURATION;
> +               goto failed;
> +       }
> +
> +       for (l = sep->stream->caps, rsp_size = 0; l != NULL; l =
> g_slist_next(l)) {
> +               struct avdtp_service_capability *cap = l->data;
> +
> +               if (rsp_size + cap->length + 2 > sizeof(buf))
> +                       break;
> +
> +               memcpy(ptr, cap, cap->length + 2);
> +               rsp_size += cap->length + 2;
> +               ptr += cap->length + 2;
> +       }
> +
> +       return avdtp_send(session, transaction, AVDTP_MSG_TYPE_ACCEPT,
> +                               AVDTP_GET_CONFIGURATION, buf,
> rsp_size);
> +
> +failed:
> +       return avdtp_send(session, transaction, AVDTP_MSG_TYPE_REJECT,
> +                               AVDTP_GET_CONFIGURATION, &err,
> sizeof(err));
>  }

this patch creates a compiler warning:

cc1: warnings being treated as errors
avdtp.c: In function ‘avdtp_getconf_cmd’:
avdtp.c:1301: error: comparison between signed and unsigned
avdtp.c:1321: error: comparison between signed and unsigned

Before sending patches you should make sure it compiles without any
warning with --enable-maintainer-mode active. That will enable extra
compiler warnings and turn them into errors.

If fixed them up and pushed all of your patches.

Johan, if you don't like my (int) casts here, then please fix this up.

Regards

Marcel


