Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347621520-30411-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347621520-30411-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 17 Sep 2012 16:38:12 +0300
Message-ID: <CABBYNZJu3rznoasjKx35xNoZPy4Nwkqb7=p_E9CRg50BV9A1Eg@mail.gmail.com>
Subject: Re: [PATCH v0] media: Fix infinite loop due to release_endpoint()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Sep 14, 2012 at 2:18 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> release_endpoint() cannot succeed unless all transports are released
> first. For example a2dp_remove_sep() will ignore the call if the SEP is
> locked, leading to an infinite loop in path_free(), which expects to
> successfully release and remove the endpoint in each call to
> release_endpoint().
>
> This issue can easily be reproduced by shutting bluetoothd daemon
> during A2DP streaming (tested in sink role).
> ---
>  audio/media.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/audio/media.c b/audio/media.c
> index b0ea4e9..e4a7684 100644
> --- a/audio/media.c
> +++ b/audio/media.c
> @@ -454,6 +454,8 @@ static void release_endpoint(struct media_endpoint *endpoint)
>         if (endpoint->watch == 0)
>                 goto done;
>
> +       clear_endpoint(endpoint);
> +
>         msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
>                                                 MEDIA_ENDPOINT_INTERFACE,
>                                                 "Release");
> @@ -615,8 +617,6 @@ static void a2dp_destroy_endpoint(void *user_data)
>  {
>         struct media_endpoint *endpoint = user_data;
>
> -       clear_endpoint(endpoint);
> -
>         endpoint->sep = NULL;
>         release_endpoint(endpoint);
>  }
> --
> 1.7.7.6

Pushed, thanks.


-- 
Luiz Augusto von Dentz
