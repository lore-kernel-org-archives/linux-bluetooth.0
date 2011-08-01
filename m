Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1312213432-4364-1-git-send-email-luiz.dentz@gmail.com>
References: <1312213432-4364-1-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 1 Aug 2011 12:45:02 -0300
Message-ID: <CAMOw1v4Uu=pcHKpRHOG8Nm3zq2EhZuGJcbPyNN8YfkViXucVOw@mail.gmail.com>
Subject: Re: [PATCH hcidump 01/13 v2] Don't parse response AVRCP pdu if ctype
 is NOT_IMPLETED
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 1, 2011 at 12:43 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  parser/avrcp.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/parser/avrcp.c b/parser/avrcp.c
> index ff6862d..1b3afad 100644
> --- a/parser/avrcp.c
> +++ b/parser/avrcp.c
> @@ -473,6 +473,12 @@ void avrcp_dump(int level, struct frame *frm)
>                return;
>        }
>
> +       /* Not implemented should not contain any operand */
> +       if (ctype == AVC_CTYPE_NOT_IMPLEMENTED) {
> +               raw_dump(level, frm);
> +               return;
> +       }
> +

Now it seems good.


thanks,
Lucas De Marchi
