Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1407844460-11497-6-git-send-email-vikram.pal@samsung.com>
References: <1407844460-11497-1-git-send-email-vikram.pal@samsung.com>
	<1407844460-11497-6-git-send-email-vikram.pal@samsung.com>
Date: Wed, 13 Aug 2014 11:23:17 +0300
Message-ID: <CABBYNZLAg1jvHZ2=EEf-6QdR38uhd6N8Qb9xkqQ9p8MGht8VfQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] monitor: Add AVRCP GetCapabilities support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikrampal,

On Tue, Aug 12, 2014 at 2:54 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Support for decoding AVRCP GetCapabilities added in
> Bluetooth monitor.
> ---
>  monitor/avctp.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index b07eea7..0b40d54 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -79,6 +79,21 @@
>  #define AVC_OP_SUBUNITINFO             0x31
>  #define AVC_OP_PASSTHROUGH             0x7c
>
> +/* notification events */
> +#define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED            0x01
> +#define AVRCP_EVENT_TRACK_CHANGED                      0x02
> +#define AVRCP_EVENT_TRACK_REACHED_END                  0x03
> +#define AVRCP_EVENT_TRACK_REACHED_START                        0x04
> +#define AVRCP_EVENT_PLAYBACK_POS_CHANGED               0x05
> +#define AVRCP_EVENT_BATT_STATUS_CHANGED                        0x06
> +#define AVRCP_EVENT_SYSTEM_STATUS_CHANGED              0x07
> +#define AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED 0x08
> +#define AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED                0x09
> +#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED          0x0a
> +#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED           0x0b
> +#define AVRCP_EVENT_UIDS_CHANGED                       0x0c
> +#define AVRCP_EVENT_VOLUME_CHANGED                     0x0d
> +
>  /* error statuses */
>  #define AVRCP_STATUS_INVALID_COMMAND                   0x00
>  #define AVRCP_STATUS_INVALID_PARAMETER                 0x01
> @@ -219,6 +234,52 @@ static const char *opcode2str(uint8_t opcode)
>         }
>  }
>
> +static char *cap2str(uint8_t cap)
> +{
> +       switch (cap) {
> +       case 0x2:
> +               return "CompanyID";
> +       case 0x3:
> +               return "EventsID";
> +       default:
> +               return "Unknown";
> +       }
> +}
> +
> +static char *event2str(uint8_t event)
> +{
> +       switch (event) {
> +       case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
> +               return "EVENT_PLAYBACK_STATUS_CHANGED";
> +       case AVRCP_EVENT_TRACK_CHANGED:
> +               return "EVENT_TRACK_CHANGED";
> +       case AVRCP_EVENT_TRACK_REACHED_END:
> +               return "EVENT_TRACK_REACHED_END";
> +       case AVRCP_EVENT_TRACK_REACHED_START:
> +               return "EVENT_TRACK_REACHED_START";
> +       case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
> +               return "EVENT_PLAYBACK_POS_CHANGED";
> +       case AVRCP_EVENT_BATT_STATUS_CHANGED:
> +               return "EVENT_BATT_STATUS_CHANGED";
> +       case AVRCP_EVENT_SYSTEM_STATUS_CHANGED:
> +               return "EVENT_SYSTEM_STATUS_CHANGED";
> +       case AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED:
> +               return "EVENT_PLAYER_APPLICATION_SETTING_CHANGED";
> +       case AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED:
> +               return "EVENT_NOW_PLAYING_CONTENT_CHANGED";
> +       case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
> +               return "EVENT_AVAILABLE_PLAYERS_CHANGED";
> +       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> +               return "EVENT_ADDRESSED_PLAYER_CHANGED";
> +       case AVRCP_EVENT_UIDS_CHANGED:
> +               return "EVENT_UIDS_CHANGED";
> +       case AVRCP_EVENT_VOLUME_CHANGED:
> +               return "EVENT_VOLUME_CHANGED";
> +       default:
> +               return "Reserved";
> +       }
> +}
> +
>  static const char *error2str(uint8_t status)
>  {
>         switch (status) {
> @@ -351,6 +412,45 @@ static void avrcp_get_capabilities(const struct l2cap_frame *frame,
>                                         uint8_t ctype, uint8_t len,
>                                         uint8_t indent)
>  {
> +       uint8_t cap, count;
> +       int i;
> +
> +       if (len < 1) {
> +               print_text(COLOR_ERROR, "PDU malformed");
> +               packet_hexdump(frame->data, frame->size);
> +               return;
> +       }
> +
> +       cap = *((uint8_t *) frame->data);
> +       print_field("%*cCapabilityID: 0x%02x (%s)", (indent - 8), ' ', cap,
> +                       cap2str(cap));

Align to the right.

> +       if (len == 1)
> +               return;
> +
> +       count = *((uint8_t *) (frame->data + 1));
> +       print_field("%*cCapabilityCount: 0x%02x", (indent - 8), ' ', count);
> +
> +       switch (cap) {
> +       case 0x2:
> +               for (; count > 0; count--) {
> +                       print_field("%s: 0x", cap2str(cap));
> +                       for (i = 0; i < 3; i++)
> +                               print_field("%*c%02x", (indent - 8), ' ',
> +                                       *((uint8_t *) (frame->data + 2 + i)));
> +               }
> +               break;
> +       case 0x3:
> +               for (i = 0; count > 0; count--, i++) {
> +                       uint8_t event;
> +                       event = *((uint8_t *) (frame->data + 2 + i));
> +                       print_field("%*c%s: 0x%02x (%s)", (indent - 8), ' ',
> +                                       cap2str(cap), event, event2str(event));
> +               }
> +               break;
> +       default:
> +               packet_hexdump(frame->data + 1, frame->size - 1);
> +       }
>  }
>
>  static void avrcp_list_player_attributes(const struct l2cap_frame *frame,
> --
> 1.9.1
>



-- 
Luiz Augusto von Dentz
