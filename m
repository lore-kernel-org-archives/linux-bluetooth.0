Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1411640303-8491-1-git-send-email-vikram.pal@samsung.com>
References: <1411640303-8491-1-git-send-email-vikram.pal@samsung.com>
Date: Fri, 26 Sep 2014 10:09:23 +0300
Message-ID: <CABBYNZKtb34nuBnsM7Mzwgmu5BHbjvPXnKwRuXh0587+2F9K2A@mail.gmail.com>
Subject: Re: [PATCH 1/6] Monitor: Add AVRCP GetPlayStatus support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 25, 2014 at 1:18 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for decoding AVRCP GetPlayStatus added in Bluetooth
> monitor.
> ---
>  monitor/avctp.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index c331a66..3356cf9 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -168,6 +168,14 @@
>  #define AVRCP_MEDIA_ATTRIBUTE_GENRE    0x06
>  #define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x07
>
> +/* play status */
> +#define AVRCP_PLAY_STATUS_STOPPED      0x00
> +#define AVRCP_PLAY_STATUS_PLAYING      0x01
> +#define AVRCP_PLAY_STATUS_PAUSED       0x02
> +#define AVRCP_PLAY_STATUS_FWD_SEEK     0x03
> +#define AVRCP_PLAY_STATUS_REV_SEEK     0x04
> +#define AVRCP_PLAY_STATUS_ERROR                0xFF
> +
>  struct avctp_frame {
>         uint8_t hdr;
>         uint8_t pt;
> @@ -563,6 +571,26 @@ static const char *mediattr2str(uint32_t attr)
>         }
>  }
>
> +static const char *playstatus2str(uint8_t status)
> +{
> +       switch (status) {
> +       case AVRCP_PLAY_STATUS_STOPPED:
> +               return "STOPPED";
> +       case AVRCP_PLAY_STATUS_PLAYING:
> +               return "PLAYING";
> +       case AVRCP_PLAY_STATUS_PAUSED:
> +               return "PAUSED";
> +       case AVRCP_PLAY_STATUS_FWD_SEEK:
> +               return "FWD_SEEK";
> +       case AVRCP_PLAY_STATUS_REV_SEEK:
> +               return "REV_SEEK";
> +       case AVRCP_PLAY_STATUS_ERROR:
> +               return "ERROR";
> +       default:
> +               return "Unknown";
> +       }
> +}
> +
>  static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame)
>  {
>         struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
> @@ -1071,6 +1099,38 @@ failed:
>         return false;
>  }
>
> +static bool avrcp_get_play_status(struct avctp_frame *avctp_frame,
> +                                       uint8_t ctype, uint8_t len,
> +                                       uint8_t indent)
> +{
> +       struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
> +       uint32_t interval;
> +       uint8_t status;
> +
> +       if (ctype <= AVC_CTYPE_GENERAL_INQUIRY)
> +               return true;
> +
> +       if (!l2cap_frame_get_be32(frame, &interval))
> +               return false;
> +
> +       print_field("%*cSongLength: 0x%08x (%u miliseconds)",
> +                                       (indent - 8), ' ', interval, interval);
> +
> +       if (!l2cap_frame_get_be32(frame, &interval))
> +               return false;
> +
> +       print_field("%*cSongPosition: 0x%08x (%u miliseconds)",
> +                                       (indent - 8), ' ', interval, interval);
> +
> +       if (!l2cap_frame_get_u8(frame, &status))
> +               return false;
> +
> +       print_field("%*cPlayStatus: 0x%02x (%s)", (indent - 8),
> +                                       ' ', status, playstatus2str(status));
> +
> +       return true;
> +}
> +
>  struct avrcp_ctrl_pdu_data {
>         uint8_t pduid;
>         bool (*func) (struct avctp_frame *avctp_frame, uint8_t ctype,
> @@ -1087,6 +1147,7 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
>         { 0x16, avrcp_get_player_value_text             },
>         { 0x17, avrcp_displayable_charset               },
>         { 0x20, avrcp_get_element_attributes            },
> +       { 0x30, avrcp_get_play_status                   },
>         { }
>  };
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
