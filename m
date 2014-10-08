Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412676351-29503-1-git-send-email-vikram.pal@samsung.com>
References: <1412676351-29503-1-git-send-email-vikram.pal@samsung.com>
Date: Wed, 8 Oct 2014 17:24:22 +0300
Message-ID: <CABBYNZKqTgtU=1eD7rOr1u1-yV9oU4nr96CK_u-4kMjDZnznmw@mail.gmail.com>
Subject: Re: [PATCH] Monitor: Add AVRCP PASS THROUGH command support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Tue, Oct 7, 2014 at 1:05 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for decoding AVRCP PASS THROUGH command added in Bluetooth
> monitor.
> ---
>  monitor/avctp.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index 9de46d1..a4e34c5 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -182,6 +182,20 @@
>  #define AVRCP_MEDIA_SEARCH             0x02
>  #define AVRCP_MEDIA_NOW_PLAYING                0x03
>
> +/* operands in passthrough commands */
> +#define AVC_PANEL_VOLUME_UP            0x41
> +#define AVC_PANEL_VOLUME_DOWN          0x42
> +#define AVC_PANEL_MUTE                 0x43
> +#define AVC_PANEL_PLAY                 0x44
> +#define AVC_PANEL_STOP                 0x45
> +#define AVC_PANEL_PAUSE                        0x46
> +#define AVC_PANEL_RECORD               0x47
> +#define AVC_PANEL_REWIND               0x48
> +#define AVC_PANEL_FAST_FORWARD         0x49
> +#define AVC_PANEL_EJECT                        0x4a
> +#define AVC_PANEL_FORWARD              0x4b
> +#define AVC_PANEL_BACKWARD             0x4c
> +
>  struct avctp_frame {
>         uint8_t hdr;
>         uint8_t pt;
> @@ -631,9 +645,54 @@ static const char *scope2str(uint8_t scope)
>         }
>  }
>
> -static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame)
> +static char *op2str(uint8_t op)
> +{
> +       switch (op & 0x7f) {
> +       case AVC_PANEL_VOLUME_UP:
> +               return "VOLUME UP";
> +       case AVC_PANEL_VOLUME_DOWN:
> +               return "VOLUME DOWN";
> +       case AVC_PANEL_MUTE:
> +               return "MUTE";
> +       case AVC_PANEL_PLAY:
> +               return "PLAY";
> +       case AVC_PANEL_STOP:
> +               return "STOP";
> +       case AVC_PANEL_PAUSE:
> +               return "PAUSE";
> +       case AVC_PANEL_RECORD:
> +               return "RECORD";
> +       case AVC_PANEL_REWIND:
> +               return "REWIND";
> +       case AVC_PANEL_FAST_FORWARD:
> +               return "FAST FORWARD";
> +       case AVC_PANEL_EJECT:
> +               return "EJECT";
> +       case AVC_PANEL_FORWARD:
> +               return "FORWARD";
> +       case AVC_PANEL_BACKWARD:
> +               return "BACKWARD";
> +       default:
> +               return "UNKNOWN";
> +       }
> +}
> +
> +static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame,
> +                                                               uint8_t indent)
>  {
>         struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
> +       uint8_t op, len;
> +
> +       if (!l2cap_frame_get_u8(frame, &op))
> +               return false;
> +
> +       print_field("%*cOperation: 0x%02x (%s %s)", (indent - 2), ' ', op,
> +                               op2str(op), op & 0x80 ? "Released" : "Pressed");
> +
> +       if (!l2cap_frame_get_u8(frame, &len))
> +               return false;
> +
> +       print_field("%*cLength: 0x%02x", (indent - 2), ' ', len);
>
>         packet_hexdump(frame->data, frame->size);
>         return true;
> @@ -1555,7 +1614,7 @@ static bool avrcp_control_packet(struct avctp_frame *avctp_frame)
>
>         switch (opcode) {
>         case 0x7c:
> -               return avrcp_passthrough_packet(avctp_frame);
> +               return avrcp_passthrough_packet(avctp_frame, 10);
>         case 0x00:
>                 if (!l2cap_frame_get_u8(frame, &company[0]) ||
>                                 !l2cap_frame_get_u8(frame, &company[1]) ||
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
