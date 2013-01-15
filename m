Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1358179829-29684-1-git-send-email-jprvita@openbossa.org>
References: <CAAngNMa=ZS0d-yWhpEVUGD3FZaWb_E6awVnwJoO68tje2fdEtA@mail.gmail.com>
	<1358179829-29684-1-git-send-email-jprvita@openbossa.org>
Date: Tue, 15 Jan 2013 20:12:13 +0200
Message-ID: <CABBYNZ+b1JdC5wWdq4P4XedOx_VLkbfoYQLCLzeLteNqSt8+sA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 01/11] transport: Initialize the "Volume" property
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

On Mon, Jan 14, 2013 at 6:10 PM, João Paulo Rechi Vita
<jprvita@openbossa.org> wrote:
> ---
>  profiles/audio/transport.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index a4370a5..8defc6f 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -787,7 +787,6 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
>                 struct a2dp_transport *a2dp;
>
>                 a2dp = g_new0(struct a2dp_transport, 1);
> -               a2dp->volume = -1;
>
>                 transport->resume = resume_a2dp;
>                 transport->suspend = suspend_a2dp;
> @@ -795,14 +794,17 @@ struct media_transport *media_transport_create(struct media_endpoint *endpoint,
>                 transport->data = a2dp;
>                 transport->destroy = destroy_a2dp;
>
> -               if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0)
> +               if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
> +                       a2dp->volume = -1;
>                         transport->sink_watch = sink_add_state_cb(
>                                                         sink_state_changed,
>                                                         transport);
> -               else
> +               } else {
> +                       a2dp->volume = 127;
>                         transport->source_watch = source_add_state_cb(
>                                                         source_state_changed,
>                                                         transport);
> +               }
>         } else
>                 goto fail;
>
> --
> 1.7.11.7
>

This set is now upstream, thanks.

--
Luiz Augusto von Dentz
