Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338283402-11085-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338283402-11085-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1338283402-11085-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 29 May 2012 16:43:25 +0300
Message-ID: <CABBYNZLt9BNvAnSSn+sOHbCsfYb6N=H5K+KKoOMn3tk=f=EedQ@mail.gmail.com>
Subject: Re: [PATCH obexd v2 03/17] client: Add progress property to transfer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, May 29, 2012 at 12:23 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The number of transferred bytes is exposed in D-Bus using a specific
> property for this purpose.
>
> Internally, the value of this property does not necessarily match the
> internal progress counter. In order to avoid D-Bus overhead, the
> property will be updated once per second.
> ---
>  client/transfer.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index 8292265..c1bd4be 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -75,6 +75,8 @@ struct obc_transfer {
>        guint xfer;
>        gint64 size;
>        gint64 transferred;
> +       gint64 transferred_dbus;
> +       guint progress_id;
>  };

I would call transferred_dbus just progress since the property is
Progress, the rest looks fine.

-- 
Luiz Augusto von Dentz
