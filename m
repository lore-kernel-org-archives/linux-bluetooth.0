Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <op.v0av2bteh52hc0@dhcp-25-209.brq.redhat.com>
References: <op.v0av2bteh52hc0@dhcp-25-209.brq.redhat.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 16 Aug 2011 13:48:38 -0300
Message-ID: <CAMOw1v5S+hcmvBW=_6h1RUsXt9af7fUm_eVmcdBP1vrif_t-Fg@mail.gmail.com>
Subject: Re: [PATCH 2/8] Missing comma
To: Pavel Raiskup <praiskup@redhat.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ovasik@redhat.com" <ovasik@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 16, 2011 at 6:45 AM, Pavel Raiskup <praiskup@redhat.com> wrote:
> Missing comma in static array chassis_map definition between
> "Blade" and "Blade Enclosure" field.
>
> Typing error fixed.
>
> ---
>  plugins/formfactor.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/plugins/formfactor.c b/plugins/formfactor.c
> index 3b31927..0e19ac6 100644
> --- a/plugins/formfactor.c
> +++ b/plugins/formfactor.c
> @@ -73,10 +73,10 @@ static const char *chassis_map[] = {
>        "Rack Mount Chassis",    "unknown",
>        "Sealed-case PC",        "unknown",
>        "Multi-system",          "unknown",
> -       "CompactPCI",            "unknonw",
> +       "CompactPCI",            "unknown",
>        "AdvancedTCA",           "unknown",
>        "Blade",                 "server",
> -       "Blade Enclosure"        "unknown", /* 0x1D */
> +       "Blade Enclosure",       "unknown", /* 0x1D */
>        NULL
>  };

Nice catch, but because of errors like this, I think it'd be better to
use a struct with 2 "char *" fields, isn't it?


Lucas De Marchi
