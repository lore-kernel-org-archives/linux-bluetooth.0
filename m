Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1407923015-26468-1-git-send-email-vikram.pal@samsung.com>
References: <1407923015-26468-1-git-send-email-vikram.pal@samsung.com>
Date: Wed, 13 Aug 2014 13:16:22 +0300
Message-ID: <CABBYNZL2wQAHCP8wCYUxTvEO-7HXKw3qkt3UO3CNZPnACMFjQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] monitor: Add AVRCP specific AV/C commands support
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 13, 2014 at 12:43 PM, Vikrampal Yadav
<vikram.pal@samsung.com> wrote:
> Support for decoding AVRCP specific AV/C commands added in
> Bluetooth monitor.
> ---
>  monitor/avctp.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index d7f461f..c151c08 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -43,10 +43,101 @@
>  #include "sdp.h"
>  #include "avctp.h"
>
> +static const char *ctype2str(uint8_t ctype)
> +{
> +       return "Unknown";
> +}
> +
> +static const char *subunit2str(uint8_t subunit)
> +{
> +       return "Reserved";
> +}
> +
> +static const char *opcode2str(uint8_t opcode)
> +{
> +       return "Unknown";
> +}
> +
> +static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
> +{
> +}
> +
> +static void avrcp_pdu_packet(const struct l2cap_frame *frame, uint8_t ctype,
> +                               uint8_t indent)
> +{
> +}
> +
> +static void avrcp_control_packet(const struct l2cap_frame *frame)
> +{
> +       uint8_t ctype, address, subunit, opcode, indent = 2;
> +       struct l2cap_frame avrcp_frame;
> +
> +       ctype = *((uint8_t *) frame->data);
> +       address = *((uint8_t *) (frame->data + 1));
> +       opcode = *((uint8_t *) (frame->data + 2));
> +
> +       print_field("AV/C: %s: address 0x%02x opcode 0x%02x",
> +                               ctype2str(ctype), address, opcode);
> +
> +       subunit = address >> 3;
> +
> +       print_field("%*cSubunit: %s", indent, ' ', subunit2str(subunit));
> +
> +       print_field("%*cOpcode: %s", indent, ' ', opcode2str(opcode));
> +
> +       /* Skip non-panel subunit packets */
> +       if (subunit != 0x09) {
> +               packet_hexdump(frame->data, frame->size);
> +               return;
> +       }
> +
> +       /* Not implemented should not contain any operand */
> +       if (ctype == 0x8) {
> +               packet_hexdump(frame->data, frame->size);
> +               return;
> +       }
> +
> +       switch (opcode) {
> +       case 0x7c:
> +               avrcp_passthrough_packet(frame);
> +               break;
> +       case 0x00:
> +               print_field("%*cCompany ID: 0x%02x%02x%02x", indent, ' ',
> +                                       *((uint8_t *) (frame->data + 3)),
> +                                       *((uint8_t *) (frame->data + 4)),
> +                                       *((uint8_t *) (frame->data + 5)));
> +
> +               l2cap_frame_pull(&avrcp_frame, frame, 6);
> +               avrcp_pdu_packet(&avrcp_frame, ctype, 10);
> +               break;
> +       default:
> +               packet_hexdump(frame->data, frame->size);
> +       }
> +}
> +
> +static void avrcp_browsing_packet(const struct l2cap_frame *frame, uint8_t hdr)
> +{
> +}
> +
> +static void avrcp_packet(const struct l2cap_frame *frame, uint8_t hdr)
> +{
> +       switch (frame->psm) {
> +       case 0x17:
> +               avrcp_control_packet(frame);
> +               break;
> +       case 0x1B:
> +               avrcp_browsing_packet(frame, hdr);
> +               break;
> +       default:
> +               packet_hexdump(frame->data, frame->size);
> +       }
> +}
> +
>  void avctp_packet(const struct l2cap_frame *frame)
>  {
>         uint8_t hdr;
>         uint16_t pid;
> +       struct l2cap_frame avctp_frame;
>         const char *pdu_color;
>
>         if (frame->size < 3) {
> @@ -70,5 +161,10 @@ void avctp_packet(const struct l2cap_frame *frame)
>                                 hdr & 0x02 ? "Response" : "Command",
>                                 hdr & 0x0c, hdr >> 4, pid);
>
> -       packet_hexdump(frame->data + 3, frame->size - 3);
> +       l2cap_frame_pull(&avctp_frame, frame, 3);
> +
> +       if (pid == 0x110e || pid == 0x110c)
> +               avrcp_packet(&avctp_frame, hdr);
> +       else
> +               packet_hexdump(frame->data + 3, frame->size - 3);
>  }
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
