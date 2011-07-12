Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1310458074-27360-2-git-send-email-luiz.dentz@gmail.com>
References: <1310458074-27360-1-git-send-email-luiz.dentz@gmail.com> <1310458074-27360-2-git-send-email-luiz.dentz@gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 12 Jul 2011 09:01:00 -0300
Message-ID: <CAMOw1v5HYDPTQXzfLgjpTJKXQraFzWp8=B=iEgkvBNy4DX9pfg@mail.gmail.com>
Subject: Re: [PATCH hcidump 2/2] Add parsing for AVRCP GetCapabilities
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 12, 2011 at 5:07 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  parser/avrcp.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 57 insertions(+), 1 deletions(-)
>
> diff --git a/parser/avrcp.c b/parser/avrcp.c
> index 43e8a8b..9529b33 100644
> --- a/parser/avrcp.c
> +++ b/parser/avrcp.c
> @@ -213,6 +213,54 @@ static const char *pdu2str(uint8_t pduid)
>        }
>  }
>
> +static char *cap2str(uint8_t cap)
> +{
> +       switch (cap) {
> +       case 0x2:
> +               return "CompanyID";
> +       case 0x3:
> +               return "EventsID";
> +       default:
> +               return "Unknown";
> +       }
> +}
> +
> +static void avrcp_get_capabilities_dump(int level, struct frame *frm, uint16_t len)
> +{
> +       uint8_t cap;
> +       uint8_t count;
> +
> +       p_indent(level, frm);
> +
> +       if (len < 1) {
> +               printf("PDU Malformed\n");
> +               raw_dump(level, frm);
> +               return;
> +       }
> +
> +       cap = get_u8(frm);
> +       printf("Capability ID: 0x%02x (%s)\n", cap, cap2str(cap));
> +
> +       if (len == 1)
> +               return;
> +
> +       p_indent(level, frm);
> +
> +       count = get_u8(frm);
> +       printf("Capability Count: 0x%02x\n", count);
> +
> +       for (; count > 0; count--) {
> +               int i;
> +
> +               p_indent(level, frm);
> +
> +               printf("%s: 0x", cap2str(cap));
> +               for (i = 0; i < 3; i++)
> +                       printf("0x%02x", get_u8(frm));

Whouldn't it be better to print the company id as a whole instead of split it?

Also, if it is a response to EVENTS_SUPPORTED, this field is not
3-byte long (table 5.5 of AVRCP 1.3).


Lucas De Marchi
