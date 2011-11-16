Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EC3B36F.5070109@bmw-carit.de>
References: <4EC3B36F.5070109@bmw-carit.de>
Date: Wed, 16 Nov 2011 15:28:47 +0200
Message-ID: <CABBYNZL8ZfP-hWQxPXujZSc_RW=4YWgdiDHr7xXHa31WiPDgFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: release transport locks on acquisition failure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Nov 16, 2011 at 2:58 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> ---
>  audio/transport.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/audio/transport.c b/audio/transport.c
> index 2739199..7bde32d 100644
> --- a/audio/transport.c
> +++ b/audio/transport.c
> @@ -670,6 +670,7 @@ static DBusMessage *acquire(DBusConnection *conn,
> DBusMessage *msg,
>        owner = media_owner_create(conn, msg, accesstype);
>        id = transport->resume(transport, owner);
>        if (id == 0) {
> +               media_transport_release(transport, accesstype);
>                media_owner_free(owner);
>                return btd_error_not_authorized(msg);
>        }
> --
> 1.7.6.4

Ack.

-- 
Luiz Augusto von Dentz
