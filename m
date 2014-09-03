Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409062763-29247-1-git-send-email-vikram.pal@samsung.com>
References: <1409062763-29247-1-git-send-email-vikram.pal@samsung.com>
Date: Wed, 3 Sep 2014 18:40:09 +0300
Message-ID: <CABBYNZKZuiSB5k2PRWwL1Z+avUN_Z-S2_7w4cEi4xZA7+L3n+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] monitor: Add AVRCP GetCurrentPlayerApplicationSettingValue
 support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikrampal,

On Tue, Aug 26, 2014 at 5:19 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for decoding AVRCP GetCurrentPlayerApplicationSettingValue
> added in Bluetooth monitor.
> ---
>  monitor/avctp.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index 5543a49..936c40d 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -611,6 +611,54 @@ response:
>         return true;
>  }
>
> +static bool avrcp_get_current_player_value(struct l2cap_frame *frame,
> +                                               uint8_t ctype, uint8_t len,
> +                                               uint8_t indent)
> +{
> +       uint8_t num;
> +
> +       if (!l2cap_frame_get_u8(frame, &num))
> +               return false;
> +
> +        if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
> +               goto response;
> +
> +       print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
> +
> +       for (; num > 0; num--) {
> +               uint8_t attr;
> +
> +               if (!l2cap_frame_get_u8(frame, &attr))
> +                       return false;
> +
> +               print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8),
> +                                               ' ', attr, attr2str(attr));
> +       }
> +
> +       return true;
> +
> +response:
> +       print_field("%*cValueCount: 0x%02x", (indent - 8), ' ', num);
> +
> +       for (; num > 0; num--) {
> +               uint8_t attr, value;
> +
> +               if (!l2cap_frame_get_u8(frame, &attr))
> +                       return false;
> +
> +               print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8),
> +                                               ' ', attr, attr2str(attr));
> +
> +               if (!l2cap_frame_get_u8(frame, &value))
> +                       return false;
> +
> +               print_field("%*cValueID: 0x%02x (%s)", (indent - 8),
> +                                       ' ', value, value2str(attr, value));
> +       }
> +
> +       return true;
> +}
> +
>  struct avrcp_ctrl_pdu_data {
>         uint8_t pduid;
>         bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
> @@ -621,6 +669,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
>         { 0x10, avrcp_get_capabilities                  },
>         { 0x11, avrcp_list_player_attributes            },
>         { 0x12, avrcp_list_player_values                },
> +       { 0x13, avrcp_get_current_player_value          },
>         { }
>  };
>
> --
> 1.9.1
>

Applying: monitor: Add AVRCP GetCurrentPlayerApplicationSettingValue support
ERROR:CODE_INDENT: code indent should use tabs where possible
#18: FILE: monitor/avctp.c:621:
+        if (ctype > AVC_CTYPE_GENERAL_INQUIRY)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#18: FILE: monitor/avctp.c:621:
+        if (ctype > AVC_CTYPE_GENERAL_INQUIRY)$

total: 1 errors, 1 warnings, 61 lines checked

-- 
Luiz Augusto von Dentz
