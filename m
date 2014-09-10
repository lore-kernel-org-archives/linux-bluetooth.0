Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409754328-26783-1-git-send-email-vikram.pal@samsung.com>
References: <1409754328-26783-1-git-send-email-vikram.pal@samsung.com>
Date: Wed, 10 Sep 2014 12:12:21 +0300
Message-ID: <CABBYNZJOg2eekUsodRAb0eEvY8Cun8gq1b95YUeNvig19dxzJA@mail.gmail.com>
Subject: Re: [PATCH] monitor: Add AVRCP InformBatteryStatusOfCT support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Wed, Sep 3, 2014 at 5:25 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for decoding AVRCP InformBatteryStatusOfCT added in
> Bluetooth monitor.
> ---
>  monitor/avctp.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index 64d4b58..0a16b45 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -483,6 +483,24 @@ static const char *value2str(uint8_t attr, uint8_t value)
>         }
>  }
>
> +static const char *status2str(uint8_t status)
> +{
> +       switch (status) {
> +       case 0x0:
> +               return "NORMAL";
> +       case 0x1:
> +               return "WARNING";
> +       case 0x2:
> +               return "CRITICAL";
> +       case 0x3:
> +               return "EXTERNAL";
> +       case 0x4:
> +               return "FULL_CHARGE";
> +       default:
> +               return "Reserved";
> +       }
> +}
> +
>  static bool avrcp_passthrough_packet(struct l2cap_frame *frame)
>  {
>         packet_hexdump(frame->data, frame->size);
> @@ -609,6 +627,23 @@ response:
>         return true;
>  }
>
> +static bool avrcp_ct_battery_status(struct l2cap_frame *frame, uint8_t ctype,
> +                                       uint8_t len, uint8_t indent)
> +{
> +       uint8_t status;
> +
> +       if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
> +               return true;
> +
> +       if (!l2cap_frame_get_u8(frame, &status))
> +               return false;
> +
> +       print_field("%*cBatteryStatus: 0x%02x (%s)", (indent - 8),
> +                                       ' ', status, status2str(status));
> +
> +       return true;
> +}
> +
>  struct avrcp_ctrl_pdu_data {
>         uint8_t pduid;
>         bool (*func) (struct l2cap_frame *frame, uint8_t ctype, uint8_t len,
> @@ -619,6 +654,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
>         { 0x10, avrcp_get_capabilities                  },
>         { 0x11, avrcp_list_player_attributes            },
>         { 0x12, avrcp_list_player_values                },
> +       { 0x18, avrcp_ct_battery_status                 },
>         { }
>  };
>
> --
> 1.9.1

This does not seems to apply anymore.


-- 
Luiz Augusto von Dentz
