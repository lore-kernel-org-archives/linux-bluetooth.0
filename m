Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408617025-6841-1-git-send-email-vikram.pal@samsung.com>
References: <1408617025-6841-1-git-send-email-vikram.pal@samsung.com>
Date: Fri, 22 Aug 2014 10:47:36 +0300
Message-ID: <CABBYNZJgE055ROKUEHZZbYmaf7gpdnML3qUp+uEoR56CKWrSXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] monitor: Add AVRCP ListPlayerApplicationSettingValues
 support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikrampal,

On Thu, Aug 21, 2014 at 1:30 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for decoding AVRCP ListPlayerApplicationSettingValues
> added in Bluetooth monitor.
> ---
>  monitor/avctp.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index ec2adcd..35eca02 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -429,6 +429,60 @@ static const char *attr2str(uint8_t attr)
>         }
>  }
>
> +static const char *value2str(uint8_t attr, uint8_t value)
> +{
> +       switch (attr) {
> +       case AVRCP_ATTRIBUTE_ILEGAL:
> +               return "Illegal";
> +       case AVRCP_ATTRIBUTE_EQUALIZER:
> +               switch (value) {
> +               case 0x01:
> +                       return "OFF";
> +               case 0x02:
> +                       return "ON";
> +               default:
> +                       return "Reserved";
> +               }
> +       case AVRCP_ATTRIBUTE_REPEAT_MODE:
> +               switch (value) {
> +               case 0x01:
> +                       return "OFF";
> +               case 0x02:
> +                       return "Single Track Repeat";
> +               case 0x03:
> +                       return "All Track Repeat";
> +               case 0x04:
> +                       return "Group Repeat";
> +               default:
> +                       return "Reserved";
> +               }
> +       case AVRCP_ATTRIBUTE_SHUFFLE:
> +               switch (value) {
> +               case 0x01:
> +                       return "OFF";
> +               case 0x02:
> +                       return "All Track Suffle";
> +               case 0x03:
> +                       return "Group Suffle";
> +               default:
> +                       return "Reserved";
> +               }
> +       case AVRCP_ATTRIBUTE_SCAN:
> +               switch (value) {
> +               case 0x01:
> +                       return "OFF";
> +               case 0x02:
> +                       return "All Track Scan";
> +               case 0x03:
> +                       return "Group Scan";
> +               default:
> +                       return "Reserved";
> +               }
> +       default:
> +               return "Unknown";
> +       }
> +}
> +
>  static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
>  {
>  }
> @@ -504,6 +558,31 @@ static void avrcp_list_player_values(const struct l2cap_frame *frame,
>                                         uint8_t ctype, uint8_t len,
>                                         uint8_t indent)
>  {
> +       static uint8_t attr = 0;
> +       uint8_t num, i;
> +
> +       if (len < 1) {
> +               print_text(COLOR_ERROR, "PDU malformed");
> +               packet_hexdump(frame->data, frame->size);
> +               return;
> +       }
> +
> +       if (ctype > AVC_CTYPE_GENERAL_INQUIRY) {
> +               num = *((uint8_t *) frame->data);
> +               print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
> +
> +               for (i = 0; num > 0; num--, i++) {
> +                       uint8_t value;
> +
> +                       value = *((uint8_t *) (frame->data + 1 + i));
> +                       print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
> +                                       ' ', value, value2str(attr, value));
> +               }
> +       } else {
> +               attr = *((uint8_t *) frame->data);
> +               print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
> +                                                       attr, attr2str(attr));
> +       }
>  }

What I suggested regarding the goto is valid for all the patches, also
you seem to disregard my comment about advancing in the frame instead
of an offset for the very begging of the frame.

-- 
Luiz Augusto von Dentz
