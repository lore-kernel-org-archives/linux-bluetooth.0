Return-Path: <cyrus@holtmann.org>
From: <Michal.Labedzki@tieto.com>
To: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Tue, 19 Jun 2012 09:52:51 +0300
Subject: RE: [PATCH hcidump 2/2] AVRCP: Add support for Addressed Player
 Changed event
Message-ID: <E50901D4F2CF69428D43141B7C85867929DD8AD28E@EXMB03.eu.tieto.com>
References: <1340028563-8089-1-git-send-email-luiz.dentz@gmail.com>,<1340028563-8089-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340028563-8089-2-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz, 

One important comment and one cosmetic.

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  parser/avrcp.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/parser/avrcp.c b/parser/avrcp.c
> index 0f2f1e6..6fa3742 100644
> --- a/parser/avrcp.c
> +++ b/parser/avrcp.c
> @@ -1107,6 +1107,7 @@ static void avrcp_register_notification_dump(int level, struct frame *frm,
>                                                  uint8_t ctype, uint16_t len)
>  {
>          uint8_t event, status;
> +       uint16_t uid;
>          uint32_t interval;
>          uint64_t id;
> 
> @@ -1202,6 +1203,15 @@ response:
>                  status = get_u8(frm) & 0x7F;
>                  printf("Volume: %.2f%% (%d/127)\n", status/1.27, status);
>                  break;
> +       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> +               uid = get_u16(frm);
> +               printf("PlayerID: 0x%04x", uid);

uid? You can use "id" to replace "uid" in this place.
ID can be decimal.

> +
> +               p_indent(level, frm);
> +
> +               uid = get_u16(frm);
> +               printf("UID: 0x%04x", uid);
> +               break;

This is not "UID". This is "UID Counter".

>          }
>  }
> 
> --
> 1.7.10.2

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