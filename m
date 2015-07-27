Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1437747466-30230-1-git-send-email-bharat.panda@samsung.com>
References: <1437747466-30230-1-git-send-email-bharat.panda@samsung.com>
Date: Mon, 27 Jul 2015 14:06:33 +0300
Message-ID: <CABBYNZ+E7VQqfvjYcqni6uOW_NhkVv-KaemEkuzkbJ26z4xaLg@mail.gmail.com>
Subject: Re: [PATCH ] monitor: Add support for GetTotalNumOfItems
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Jul 24, 2015 at 5:17 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Support for AVRCP Get Total NUmber Of Items added to btmon.
>
>       Channel: 66 len 17 ctrl 0x060c [PSM 27 mode 3] {chan 2}
>       I-frame: Unsegmented TxSeq 6 ReqSeq 6
>       AVCTP Browsing: Command: type 0x00 label 6 PID 0x110e
>         AVRCP: GetTotalNumOfItems: len 0x000b
>               Scope: 0x01 (Media Player Virtual Filesystem)
>
>       Channel: 66 len 17 ctrl 0x070c [PSM 27 mode 3] {chan 2}
>       I-frame: Unsegmented TxSeq 6 ReqSeq 7
>       AVCTP Browsing: Response: type 0x00 label 6 PID 0x110e
>         AVRCP: GetTotalNumOfItems: len 0x0007
>           Status: 0x04 (Success)
>           UIDCounter: 0x332e (13102)
>           Number of Items: 0x0001 (1)
> ---
>  monitor/avctp.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index 556320c..a54b051 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -141,6 +141,7 @@
>  #define AVRCP_CHANGE_PATH              0x72
>  #define AVRCP_GET_ITEM_ATTRIBUTES      0x73
>  #define AVRCP_PLAY_ITEM                        0x74
> +#define AVRCP_GET_TOTAL_NUMBER_OF_ITEMS        0x75
>  #define AVRCP_SEARCH                   0x80
>  #define AVRCP_ADD_TO_NOW_PLAYING       0x90
>  #define AVRCP_GENERAL_REJECT           0xA0
> @@ -440,6 +441,8 @@ static const char *pdu2str(uint8_t pduid)
>                 return "GetItemAttributes";
>         case AVRCP_PLAY_ITEM:
>                 return "PlayItem";
> +       case AVRCP_GET_TOTAL_NUMBER_OF_ITEMS:
> +               return "GetTotalNumOfItems";
>         case AVRCP_SEARCH:
>                 return "Search";
>         case AVRCP_ADD_TO_NOW_PLAYING:
> @@ -2045,6 +2048,54 @@ response:
>         return true;
>  }
>
> +static bool avrcp_get_total_number_of_items(struct avctp_frame *avctp_frame)
> +{
> +       struct l2cap_frame *frame = &avctp_frame->l2cap_frame;
> +       uint32_t num_of_items;
> +       uint16_t uidcounter;
> +       uint8_t scope, status, indent = 2;
> +
> +       if (avctp_frame->hdr & 0x02)
> +               goto response;
> +
> +       if (frame->size < 4) {
> +               printf("PDU Malformed\n");
> +               packet_hexdump(frame->data, frame->size);
> +               return false;
> +       }
> +
> +       if (!l2cap_frame_get_u8(frame, &scope))
> +               return false;
> +
> +       print_field("%*cScope: 0x%02x (%s)", (indent - 8), ' ',
> +                                               scope, scope2str(scope));
> +
> +       return true;
> +
> +response:
> +       if (!l2cap_frame_get_u8(frame, &status))
> +               return false;
> +
> +       print_field("%*cStatus: 0x%02x (%s)", indent, ' ',
> +                               status, error2str(status));
> +
> +       if (frame->size == 1)
> +               return false;
> +
> +       if (!l2cap_frame_get_be16(frame, &uidcounter))
> +               return false;
> +
> +       print_field("%*cUIDCounter: 0x%04x (%u)", indent, ' ',
> +                               uidcounter, uidcounter);
> +
> +       if (!l2cap_frame_get_be32(frame, &num_of_items))
> +               return false;
> +
> +       print_field("%*cNumber of Items: 0x%04x (%u)", indent, ' ',
> +                               num_of_items, num_of_items);
> +
> +       return true;
> +}
>
>  static bool avrcp_search_item(struct avctp_frame *avctp_frame)
>  {
> @@ -2374,6 +2425,9 @@ static bool avrcp_browsing_packet(struct avctp_frame *avctp_frame)
>         case AVRCP_GET_ITEM_ATTRIBUTES:
>                 avrcp_get_item_attributes(avctp_frame);
>                 break;
> +       case AVRCP_GET_TOTAL_NUMBER_OF_ITEMS:
> +               avrcp_get_total_number_of_items(avctp_frame);
> +               break;
>         case AVRCP_SEARCH:
>                 avrcp_search_item(avctp_frame);
>                 break;
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
