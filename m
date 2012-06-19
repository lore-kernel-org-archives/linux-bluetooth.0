Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Tue, 19 Jun 2012 09:39:42 +0300
Subject: RE: [PATCH hcidump 1/2] AVRCP: Add parsing for SetAddressedPlayer
 PDU
Message-ID: <E50901D4F2CF69428D43141B7C85867929DD8AD28D@EXMB03.eu.tieto.com>
References: <1340028563-8089-1-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340028563-8089-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Some cosmetic comments.

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  parser/avrcp.c |   35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/parser/avrcp.c b/parser/avrcp.c
> index 850741b..0f2f1e6 100644
> --- a/parser/avrcp.c
> +++ b/parser/avrcp.c
> @@ -1222,6 +1222,38 @@ static void avrcp_set_absolute_volume_dump(int level, struct frame *frm,
>         printf("Volume: %.2f%% (%d/127)\n", value/1.27, value);
>  }
> 
> +static void avrcp_set_addressed_player(int level, struct frame *frm,
> +                                               uint8_t ctype, uint16_t len)
> +{
> +       uint16_t id;
> +       uint8_t status;
> +
> +       p_indent(level, frm);
> +
> +       if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
> +               goto response;

This command type is only AVC_CTYPE_CONTROL with AVC_CTYPE_NOT_IMPLEMENTED, AVC_CTYPE_ACCEPTED, AVC_CTYPE_REJECTED responses, so maybe all other should be tread as malformed.

> +
> +       if (len < 2) {

What do you think about replace "<" by "!="? Large packet probably is not correct. But this can be what it is.

> +               printf("PDU Malformed\n");
> +               raw_dump(level, frm);
> +               return;
> +       }
> +
> +       id = get_u16(frm);
> +       printf("PlayerID: 0x%04x", id);
> +       return;

ID in hex? Decimal seems to be more natural.

> +
> +response:
> +       if (len < 1) {

The same. What do you think about replace "<" by "!="?

> +               printf("PDU Malformed\n");
> +               raw_dump(level, frm);
> +               return;
> +       }
> +
> +       status = get_u8(frm);
> +       printf("Status: 0x%02x (%s)\n", status, error2str(status));
> +}
> +
>  static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
>  {
>         uint8_t pduid, pt;
> @@ -1291,6 +1323,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
>         case AVRCP_SET_ABSOLUTE_VOLUME:
>                 avrcp_set_absolute_volume_dump(level + 1, frm, ctype, len);
>                 break;
> +       case AVRCP_SET_ADDRESSED_PLAYER:
> +               avrcp_set_addressed_player(level + 1, frm, ctype, len);
> +               break;
>         default:
>                 raw_dump(level, frm);
>         }
> --
> 1.7.10.2
> 



Regards / Pozdrawiam
-------------------------------------------------------------------------------------------------------------
Micha³ £abêdzki
ASCII: Michal Labedzki
e-mail: michal.labedzki@tieto.com
office communicator: michal.labedzki@tieto.com
location: Poland, Wroc³aw, Legnicka 55F
room: 315
phone: +48 717 740 340
---
Tieto Corporation / Tieto Poland
http://www.tieto.com / http://www.tieto.pl
---
Tieto Poland spó³ka z ograniczon± odpowiedzialno¶ci± z siedzib± w Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S±dzie Rejonowym Szczecin-Centrum w Szczecinie, XIII Wydzia³ Gospodarczy Krajowego Rejestru S±dowego pod numerem 0000124858. NIP: 8542085557. REGON: 812023656. Kapita³ zak³adowy: 4 271500 PLN