Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413817469-4255-1-git-send-email-gowtham.ab@samsung.com>
References: <1413817469-4255-1-git-send-email-gowtham.ab@samsung.com>
Date: Wed, 22 Oct 2014 13:44:14 +0300
Message-ID: <CABBYNZ+J=K_Cvh9QPUsR-r1ub5RYawsT=Bg=wD4AF4n0Lor-ZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] obexd/map: Add support for MAP feature bits
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 20, 2014 at 6:04 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Handles MAP supported feature bits as per the
> MAP 1.2 specs section 7.1.1.
> ---
>  obexd/client/map.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index 44db96c..43b0471 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -100,6 +100,7 @@ struct map_data {
>         GHashTable *messages;
>         int16_t mas_instance_id;
>         uint8_t supported_message_types;
> +       uint32_t supported_features;
>  };
>
>  struct pending_request {
> @@ -2003,6 +2004,14 @@ static void parse_service_record(struct map_data *map)
>                 map->supported_message_types = *(uint8_t *)data;
>         else
>                 DBG("Failed to read supported message types");
> +
> +       /* Supported Feature Bits */
> +       data = obc_session_get_attribute(map->session,
> +                                       SDP_ATTR_MAP_SUPPORTED_FEATURES);
> +       if(data != NULL)
> +               map->supported_features = *(uint32_t *)data;
> +       else
> +               map->supported_features = 0x0000001f;
>  }
>
>  static int map_probe(struct obc_session *session)
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
