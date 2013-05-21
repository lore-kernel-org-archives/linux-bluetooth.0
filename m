Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369149984-1953-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1369149984-1953-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Tue, 21 May 2013 18:46:26 +0200
Message-ID: <CANT-zCUPxKA3qx9nZ5wtVwvV8=OS9jHByHQqhkYSY1YF4t6wkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] profile: Fix incoming connections without SDP record
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Tue, May 21, 2013 at 5:26 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> After commit 7bd3626b6715ac6a117d56b95b455960f7cf34de, incoming connections
> require the service being available from SDP. This is not always guaranteed
> because some services might not be listed in SDP (like MNS).
> ---
>  src/profile.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/profile.c b/src/profile.c
> index 8fd0424..9f98d65 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -1056,6 +1056,7 @@ static struct ext_io *create_conn(struct ext_io *server, GIOChannel *io,
>                 return NULL;
>         }
>
> +       btd_device_add_uuid(device, server->ext->remote_uuid);
>         service = btd_device_get_service(device, server->ext->remote_uuid);
>         if (service == NULL) {
>                 ba2str(dst, addr);
> --

Ack from my side.

A comment might be helpful to clarify that the condition below (i.e.
service == NULL) is now unlikely and only possible due to issues
during profile probe.

Cheers,
Mikel
