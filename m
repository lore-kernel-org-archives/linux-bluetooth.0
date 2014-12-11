Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418212008-8594-2-git-send-email-gowtham.ab@samsung.com>
References: <1418212008-8594-1-git-send-email-gowtham.ab@samsung.com>
	<1418212008-8594-2-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 11 Dec 2014 14:18:57 +0200
Message-ID: <CABBYNZJrV1viDu62Ndr2Davv_52tKmByLwNtQqSRUXN0j1mZww@mail.gmail.com>
Subject: Re: [PATCH 1/3] monitor/packet: Fix ERROR CODES as per core_v4.2
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wed, Dec 10, 2014 at 1:46 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Modified the error codes as per core V4.2, Vol 2, Part D.
> ---
>  monitor/packet.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 885c4b1..87b97ad 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -317,9 +317,10 @@ static const struct {
>         { 0x1b, "SCO Offset Rejected"                                   },
>         { 0x1c, "SCO Interval Rejected"                                 },
>         { 0x1d, "SCO Air Mode Rejected"                                 },
> -       { 0x1e, "Invalid LMP Parameters"                                },
> +       { 0x1e, "Invalid LMP Parameters / Invalid LL Parameters"        },
>         { 0x1f, "Unspecified Error"                                     },
> -       { 0x20, "Unsupported LMP Parameter Value"                       },
> +       { 0x20, "Unsupported LMP Parameter Value / "
> +               "Unsupported LL Parameter Value"                        },

Perhaps just having LMP/LL instead of duplicating the whole string is
a better idea, usually the spec would not change a meaning of an error
or is LL LE specific?

>         { 0x21, "Role Change Not Allowed"                               },
>         { 0x22, "LMP Response Timeout / LL Response Timeout"            },
>         { 0x23, "LMP Error Transaction Collision"                       },
> @@ -346,7 +347,7 @@ static const struct {
>         { 0x38, "Host Busy - Pairing"                                   },
>         { 0x39, "Connection Rejected due to No Suitable Channel Found"  },
>         { 0x3a, "Controller Busy"                                       },
> -       { 0x3b, "Unacceptable Connection Interval"                      },
> +       { 0x3b, "Unacceptable Connection Parameters"                    },

This as well need a bit more explanation, when this has changed or
perhaps we got it wrong to begin with?

>         { 0x3c, "Directed Advertising Timeout"                          },
>         { 0x3d, "Connection Terminated due to MIC Failure"              },
>         { 0x3e, "Connection Failed to be Established"                   },
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
