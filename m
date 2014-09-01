Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409571044-24724-2-git-send-email-luiz.dentz@gmail.com>
References: <1409571044-24724-1-git-send-email-luiz.dentz@gmail.com>
	<1409571044-24724-2-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 1 Sep 2014 14:32:00 +0300
Message-ID: <CABBYNZJCQs=56Hz9fdBV4KMWSkB5tWgusWe1BX7qxjYiW09ePA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Fix warnings when using l2cap_frame_get*
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 1, 2014 at 2:30 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  monitor/avctp.c | 48 +++++++++++++++++++++---------------------------
>  monitor/sdp.c   | 12 +++++-------
>  2 files changed, 26 insertions(+), 34 deletions(-)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index 5543a49..64d4b58 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -512,15 +512,13 @@ static bool avrcp_get_capabilities(struct l2cap_frame *frame, uint8_t ctype,
>         switch (cap) {
>         case 0x2:
>                 for (; count > 0; count--) {
> -                       uint8_t company[3] = {};
> +                       uint8_t company[3];
>
> -                       if (frame->size < 3)
> +                       if (!l2cap_frame_get_u8(frame, &company[0]) ||
> +                               !l2cap_frame_get_u8(frame, &company[1]) ||
> +                               !l2cap_frame_get_u8(frame, &company[2]))
>                                 return false;
>
> -                       l2cap_frame_get_u8(frame, &company[0]);
> -                       l2cap_frame_get_u8(frame, &company[1]);
> -                       l2cap_frame_get_u8(frame, &company[2]);
> -
>                         print_field("%*c%s: 0x%02x%02x%02x", (indent - 8), ' ',
>                                         cap2str(cap), company[0], company[1],
>                                         company[2]);
> @@ -645,12 +643,14 @@ static bool avrcp_pdu_packet(struct l2cap_frame *frame, uint8_t ctype,
>         int i;
>         const struct avrcp_ctrl_pdu_data *ctrl_pdu_data = NULL;
>
> -       if (frame->size < 4)
> +       if (!l2cap_frame_get_u8(frame, &pduid))
> +               return false;
> +
> +       if (!l2cap_frame_get_u8(frame, &pt))
>                 return false;
>
> -       l2cap_frame_get_u8(frame, &pduid);
> -       l2cap_frame_get_u8(frame, &pt);
> -       l2cap_frame_get_be16(frame, &len);
> +       if (!l2cap_frame_get_be16(frame, &len))
> +               return false;
>
>         print_indent(indent, COLOR_OFF, "AVRCP: ", pdu2str(pduid), COLOR_OFF,
>                                         " pt %s len 0x%04x", pt2str(pt), len);
> @@ -680,13 +680,11 @@ static bool avrcp_control_packet(struct l2cap_frame *frame)
>  {
>         uint8_t ctype, address, subunit, opcode, company[3], indent = 2;
>
> -       if (frame->size < 3)
> +       if (!l2cap_frame_get_u8(frame, &ctype) ||
> +                               !l2cap_frame_get_u8(frame, &address) ||
> +                               !l2cap_frame_get_u8(frame, &opcode))
>                 return false;
>
> -       l2cap_frame_get_u8(frame, &ctype);
> -       l2cap_frame_get_u8(frame, &address);
> -       l2cap_frame_get_u8(frame, &opcode);
> -
>         print_field("AV/C: %s: address 0x%02x opcode 0x%02x",
>                                 ctype2str(ctype), address, opcode);
>
> @@ -712,13 +710,11 @@ static bool avrcp_control_packet(struct l2cap_frame *frame)
>         case 0x7c:
>                 return avrcp_passthrough_packet(frame);
>         case 0x00:
> -               if (frame->size < 3)
> +               if (!l2cap_frame_get_u8(frame, &company[0]) ||
> +                               !l2cap_frame_get_u8(frame, &company[1]) ||
> +                               !l2cap_frame_get_u8(frame, &company[2]))
>                         return false;
>
> -               l2cap_frame_get_u8(frame, &company[0]);
> -               l2cap_frame_get_u8(frame, &company[1]);
> -               l2cap_frame_get_u8(frame, &company[2]);
> -
>                 print_field("%*cCompany ID: 0x%02x%02x%02x", indent, ' ',
>                                         company[0], company[1], company[2]);
>
> @@ -764,16 +760,14 @@ void avctp_packet(const struct l2cap_frame *frame)
>         struct l2cap_frame avctp_frame;
>         const char *pdu_color;
>
> -       if (frame->size < 3) {
> +       l2cap_frame_pull(&avctp_frame, frame, 0);
> +
> +       if (!l2cap_frame_get_u8(&avctp_frame, &hdr) ||
> +                               !l2cap_frame_get_be16(&avctp_frame, &pid)) {
>                 print_text(COLOR_ERROR, "frame too short");
>                 packet_hexdump(frame->data, frame->size);
>                 return;
> -        }
> -
> -       l2cap_frame_pull(&avctp_frame, frame, 0);
> -
> -       l2cap_frame_get_u8(&avctp_frame, &hdr);
> -       l2cap_frame_get_be16(&avctp_frame, &pid);
> +       }
>
>         if (frame->in)
>                 pdu_color = COLOR_MAGENTA;
> diff --git a/monitor/sdp.c b/monitor/sdp.c
> index d0ad688..c171b9d 100644
> --- a/monitor/sdp.c
> +++ b/monitor/sdp.c
> @@ -696,18 +696,16 @@ void sdp_packet(const struct l2cap_frame *frame)
>         const char *pdu_color, *pdu_str;
>         int i;
>
> -       if (frame->size < 5) {
> +       l2cap_frame_pull(&sdp_frame, frame, 0);
> +
> +       if (!l2cap_frame_get_u8(&sdp_frame, &pdu) ||
> +                               !l2cap_frame_get_be16(&sdp_frame, &tid) ||
> +                               !l2cap_frame_get_be16(&sdp_frame, &plen)) {
>                 print_text(COLOR_ERROR, "frame too short");
>                 packet_hexdump(frame->data, frame->size);
>                 return;
>         }
>
> -       l2cap_frame_pull(&sdp_frame, frame, 0);
> -
> -       l2cap_frame_get_u8(&sdp_frame, &pdu);
> -       l2cap_frame_get_be16(&sdp_frame, &tid);
> -       l2cap_frame_get_be16(&sdp_frame, &plen);
> -
>         if (sdp_frame.size != plen) {
>                 print_text(COLOR_ERROR, "invalid frame size");
>                 packet_hexdump(sdp_frame.data, sdp_frame.size);
> --
> 1.9.3

Sorry for the noise this has been applied already.


-- 
Luiz Augusto von Dentz
