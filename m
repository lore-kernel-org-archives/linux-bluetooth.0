Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332178892-8987-2-git-send-email-luiz.dentz@gmail.com>
References: <1332178892-8987-1-git-send-email-luiz.dentz@gmail.com> <1332178892-8987-2-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 21 Mar 2012 22:22:21 -0300
Message-ID: <CAMOw1v5z++DD4RkM1krn7+3-g+JH3oCgFy0A_68H+-VERsJ1xQ@mail.gmail.com>
Subject: Re: [PATCH hcidump 2/2] AVRCP: Add parsing support for Volume Change notification
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 19, 2012 at 2:41 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  parser/avrcp.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/parser/avrcp.c b/parser/avrcp.c
> index d746937..9698934 100644
> --- a/parser/avrcp.c
> +++ b/parser/avrcp.c
> @@ -1198,6 +1198,10 @@ response:
>                                                value2str(attr, value));
>                }
>                break;
> +       case AVRCP_EVENT_VOLUME_CHANGED:
> +               status = get_u8(frm);
> +               printf("Volume: 0x%02x\n", status);
> +               break;

Ack.


Lucas De Marchi
