Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1297935077-25540-2-git-send-email-dmitriy.paliy@nokia.com>
References: <1297935077-25540-1-git-send-email-dmitriy.paliy@nokia.com>
	<1297935077-25540-2-git-send-email-dmitriy.paliy@nokia.com>
Date: Thu, 17 Feb 2011 12:57:55 +0200
Message-ID: <AANLkTinnEsz7EypxG5SmSBFCSoypfBjan-TCX7bgcpRN@mail.gmail.com>
Subject: Re: [PATCH v2] Fix no SEP if corresponding interface is disabled
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Feb 17, 2011 at 11:31 AM, Dmitriy Paliy <dmitriy.paliy@nokia.com> wrote:
> A2DP sink endpoint shall not be created if A2DP sink interface is disabled.
> Same holds for A2DP source endpoint and A2DP source interface.
>
> Such fixes bluetoothd crash when SDP record is registered and remote
> device tries to connect and stream to A2DP sink which is not initialized.
> Dereferencing of NULL happens in source_new_stream since device->source
> was not created.
> ---
>  audio/a2dp.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/audio/a2dp.c b/audio/a2dp.c
> index 012fce8..3407d6f 100644
> --- a/audio/a2dp.c
> +++ b/audio/a2dp.c
> @@ -110,6 +110,8 @@ struct a2dp_server {
>        uint32_t source_record_id;
>        uint32_t sink_record_id;
>        uint16_t version;
> +       gboolean sink_enabled;
> +       gboolean source_enabled;
>  };
>
>  static GSList *servers = NULL;
> @@ -1480,6 +1482,7 @@ proceed:
>        else
>                server->version = 0x0102;
>
> +       server->source_enabled = source;
>        if (source) {
>                for (i = 0; i < sbc_srcs; i++)
>                        a2dp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
> @@ -1489,7 +1492,7 @@ proceed:
>                        a2dp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
>                                        A2DP_CODEC_MPEG12, delay_reporting, NULL);
>        }
> -
> +       server->sink_enabled = sink;
>        if (sink) {
>                for (i = 0; i < sbc_sinks; i++)
>                        a2dp_add_sep(src, AVDTP_SEP_TYPE_SINK,
> @@ -1551,6 +1554,12 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
>        if (server == NULL)
>                return NULL;
>
> +       if (type == AVDTP_SEP_TYPE_SINK && !server->sink_enabled)
> +               return NULL;
> +
> +       if (type == AVDTP_SEP_TYPE_SOURCE && !server->source_enabled)
> +               return NULL;
> +
>        sep = g_new0(struct a2dp_sep, 1);
>
>        if (endpoint) {

Looks much better.

-- 
Luiz Augusto von Dentz
Computer Engineer
