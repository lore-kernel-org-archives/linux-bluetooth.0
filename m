Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Dec 2011 15:22:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 3/6] Add support for SetFolder in MAP client
Message-ID: <20111209132206.GA31478@x220>
References: <1323349678-17905-1-git-send-email-bulislaw@linux.com>
 <1323349678-17905-3-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323349678-17905-3-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Dec 08, 2011, Bartosz Szatkowski wrote:
> ---
>  client/map.c       |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  doc/client-api.txt |    5 +++-
>  2 files changed, 60 insertions(+), 1 deletions(-)

The first two patches have been applied, but this had issues:

> +#define ERROR_INF MAP_INTERFACE ".Error"
> +#define ERROR_FAILED_PATH "org.openobex.Error.Failed"

First of all, this is not a path or an interface. It's the error name.
Secondly, do you really need these defines since in some places you
spell out the name inline in others you use a define. E.g. here it's
inline:

> +	else if (err_code != G_OBEX_RSP_SUCCESS)
> +		reply = g_dbus_create_error(map->msg,
> +						"org.openobex.Error.Response",
> +						"%s (0x%02x)",
> +						g_obex_strerror(err_code),
> +						err_code);

So please be consistent. Also think about whether we need MAP specific
errors at all or if we can just use generic ones for the entire client
(and maybe server too).

Johan
