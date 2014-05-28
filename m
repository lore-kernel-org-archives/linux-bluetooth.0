Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1401267002-6306-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401267002-6306-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Wed, 28 May 2014 15:19:44 +0300
Message-ID: <CABBYNZ+m5jVJfRrAad3zyTL1MEPjBpKsQdH+4zcvXomw_JccnQ@mail.gmail.com>
Subject: Re: [PATCH] tools/hcidump: Decode MPEG-1,2 Audio codec capabilities
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wed, May 28, 2014 at 11:50 AM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> ---
>  tools/parser/avdtp.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> index 14dc417..5969067 100644
> --- a/tools/parser/avdtp.c
> +++ b/tools/parser/avdtp.c
> @@ -222,6 +222,7 @@ static void capabilities(int level, struct frame *frm)
>                         uint8_t type, codec;
>                         uint16_t tmp, freq, vndcodec = 0;
>                         uint32_t bitrate, vendor = 0;
> +                       int i;
>
>                         type  = get_u8(frm);
>                         codec = get_u8(frm);
> @@ -288,6 +289,63 @@ static void capabilities(int level, struct frame *frm)
>                                 p_indent(level + 1, frm);
>                                 printf("Bitpool Range %d-%d\n", tmp, get_u8(frm));
>                                 break;
> +                       case 1:
> +                               tmp = get_u8(frm);
> +                               p_indent(level + 1, frm);
> +                               printf("Layers: ");
> +                               if (tmp & 0x80)
> +                                       printf("1 ");
> +                               if (tmp & 0x40)
> +                                       printf("2 ");
> +                               if (tmp & 0x20)
> +                                       printf("3 ");
> +                               printf("\n");
> +                               p_indent(level + 1, frm);
> +                               printf("CRC Protection: %s\n",
> +                                               tmp & 0x10 ? "Yes" : "No");
> +                               p_indent(level + 1, frm);
> +                               if (tmp & 0x08)
> +                                       printf("Mono ");
> +                               if (tmp & 0x04)
> +                                       printf("DualChannel ");
> +                               if (tmp & 0x02)
> +                                       printf("Stereo ");
> +                               if (tmp & 0x01)
> +                                       printf("JointStereo ");
> +                               printf("\n");
> +                               tmp = get_u8(frm);
> +                               p_indent(level + 1, frm);
> +                               printf("Media Payload Format: RFC-2250 %s\n",
> +                                               tmp & 0x40 ? "RFC-3119" : "");
> +                               p_indent(level + 1, frm);
> +                               if (tmp & 0x20)
> +                                       printf("16kHz ");
> +                               if (tmp & 0x10)
> +                                       printf("22.05kHz ");
> +                               if (tmp & 0x08)
> +                                       printf("24kHz ");
> +                               if (tmp & 0x04)
> +                                       printf("32kHz ");
> +                               if (tmp & 0x02)
> +                                       printf("44.1kHz ");
> +                               if (tmp & 0x01)
> +                                       printf("48kHz ");
> +                               printf("\n");
> +                               tmp = get_u16(frm);
> +                               p_indent(level + 1, frm);
> +                               printf("VBR: %s\n",
> +                                               tmp & 0x8000 ? "Yes" : "No");
> +                               p_indent(level + 1, frm);
> +                               printf("Bit Rate Indexes: ");
> +                               if (tmp & 0x8000) {
> +                                       printf("n/a");
> +                               } else {
> +                                       for (i = 0; i < 15; i++, tmp >>= 1)
> +                                               if (tmp & 0x0001)
> +                                                       printf("%d ", i);
> +                               }
> +                               printf("\n");
> +                               break;
>                         case 2:
>                                 tmp = get_u8(frm);
>                                 p_indent(level + 1, frm);
> --
> 1.9.3

Pushed, thanks.


-- 
Luiz Augusto von Dentz
