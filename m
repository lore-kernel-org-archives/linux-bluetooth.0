Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1359401256-14512-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359401256-14512-1-git-send-email-vinicius.gomes@openbossa.org>
Date: Mon, 28 Jan 2013 14:20:06 -0600
Message-ID: <CABBYNZ+VSTZhc_mARXiW6riLHz5Z4vR3Rzv7ObLxFysAuV9gxg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] media: Fix not finding endpoints with different
 case UUIDs
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Jan 28, 2013 at 1:27 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> When multiple Endpoints are registered with different case UUIDs,
> the only UUIDs found were those with matching case.
> ---
>  profiles/audio/media.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 0ae9932..59fc840 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -170,7 +170,7 @@ static struct media_endpoint *media_adapter_find_endpoint(
>                 if (path && g_strcmp0(endpoint->path, path) != 0)
>                         continue;
>
> -               if (uuid && g_strcmp0(endpoint->uuid, uuid) != 0)
> +               if (uuid && strcasecmp(endpoint->uuid, uuid) != 0)
>                         continue;
>
>                 return endpoint;
> @@ -692,7 +692,7 @@ static bool endpoint_properties_get(const char *uuid,
>         for (l = adapter->endpoints; l; l = l->next) {
>                 struct media_endpoint *endpoint = l->data;
>
> -               if (g_strcmp0(endpoint->uuid, uuid) != 0)
> +               if (strcasecmp(endpoint->uuid, uuid) != 0)
>                         continue;
>
>                 append_endpoint(endpoint, &dict);
> --
> 1.8.1.1

Applied, thanks


--
Luiz Augusto von Dentz
