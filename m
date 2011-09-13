Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJnJkBcKqe0SghJUhMYDar2Kg4mZMEi5VDepnDfevJAvg@mail.gmail.com>
References: <1315923685-30574-1-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZJnJkBcKqe0SghJUhMYDar2Kg4mZMEi5VDepnDfevJAvg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 13 Sep 2011 13:33:51 -0300
Message-ID: <CAMOw1v79gZoWifNOv5Ppc1APO7PGnU8N_pJKzRO9=1Bk3r8Mcg@mail.gmail.com>
Subject: Re: [PATCH] Fix parser of AVRCP continuing messages
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Sep 13, 2011 at 11:40 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Tue, Sep 13, 2011 at 5:21 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> If packet_type is not START or SINGLE, we have to continue where we
>> stopped from previous packet. Therefore we must store where we left on
>> previous packet due to packet size limit. We store both the number of
>> attributes missing and the lenght of the last attribute that is missing.
>>
>> An example interaction for this implementation, obtained with PTS test
>> TC_TG_MDI_BV_04_C (I reduced the MTU in order to reproduce it here and
>> values between brackets I added now):
>>
>>> AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
>>    AV/C: Status: address 0x48 opcode 0x00
>>      Subunit: Panel
>>      Opcode: Vendor Dependent
>>      Company ID: 0x001958
>>      AVRCP: GetElementAttributes: pt Single len 0x0009
>>        Identifier: 0x0 (PLAYING)
>>        AttributeCount: 0x00
>> < AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
>>    AV/C: Stable: address 0x48 opcode 0x00
>>      Subunit: Panel
>>      Opcode: Vendor Dependent
>>      Company ID: 0x001958
>>      AVRCP: GetElementAttributes: pt Start len 0x0118
>>        AttributeCount: 0x04
>>        Attribute: 0x00000001 (Title)
>>        CharsetID: 0x006a (UTF-8)
>>        AttributeValueLength: 0x001b
>>        AttributeValue: isso eh um titulo mei longo
>>        Attribute: 0x00000003 (Album)
>>        CharsetID: 0x006a (UTF-8)
>>        AttributeValueLength: 0x00fe
>>        AttributeValue: super-long-album-name super-long-album-name
>>        super-long-album-name super-long-album-name super-long-album
>>        super-long-album-name [... snip... ] super-long-album-name-1234
>>> AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
>>    AV/C: Control: address 0x48 opcode 0x00
>>      Subunit: Panel
>>      Opcode: Vendor Dependent
>>      Company ID: 0x001958
>>      AVRCP: RequestContinuingResponse: pt Single len 0x0001
>> < AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
>>    AV/C: Stable: address 0x48 opcode 0x00
>>      Subunit: Panel
>>      Opcode: Vendor Dependent
>>      Company ID: 0x001958
>>      AVRCP: GetElementAttributes: pt End len 0x002a
>>        ContinuingAttributeValue: 678900000000000000
>>        Attribute: 0x00000005 (Track Total)
>>        CharsetID: 0x006a (UTF-8)
>>        AttributeValueLength: 0x0002
>>        AttributeValue: 30
>>        Attribute: 0x00000006 (Genre)
>>        CharsetID: 0x006a (UTF-8)
>>        AttributeValueLength: 0x0006
>>        AttributeValue: Gospel
>> ---
>>  parser/avrcp.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++---------
>>  1 files changed, 79 insertions(+), 15 deletions(-)
>>
>> diff --git a/parser/avrcp.c b/parser/avrcp.c
>> index 0b98a3e..65d3bda 100644
>> --- a/parser/avrcp.c
>> +++ b/parser/avrcp.c
>> @@ -87,6 +87,12 @@
>>  #define AVC_PANEL_FORWARD              0x4b
>>  #define AVC_PANEL_BACKWARD             0x4c
>>
>> +/* Packet types */
>> +#define AVRCP_PACKET_TYPE_SINGLE       0x00
>> +#define AVRCP_PACKET_TYPE_START                0x01
>> +#define AVRCP_PACKET_TYPE_CONTINUING   0x02
>> +#define AVRCP_PACKET_TYPE_END          0x03
>> +
>>  /* pdu ids */
>>  #define AVRCP_GET_CAPABILITIES         0x10
>>  #define AVRCP_LIST_PLAYER_ATTRIBUTES   0x11
>> @@ -176,6 +182,11 @@
>>  #define AVRCP_PLAY_STATUS_REV_SEEK     0x04
>>  #define AVRCP_PLAY_STATUS_ERROR                0xFF
>>
>> +static struct avrcp_continuing {
>> +       uint16_t num;
>> +       uint16_t size;
>> +} avrcp_continuing;
>> +
>>  static const char *ctype2str(uint8_t ctype)
>>  {
>>        switch (ctype & 0x0f) {
>> @@ -224,6 +235,22 @@ static const char *opcode2str(uint8_t opcode)
>>        }
>>  }
>>
>> +static const char *pt2str(uint8_t pt)
>> +{
>> +       switch (pt) {
>> +       case AVRCP_PACKET_TYPE_SINGLE:
>> +               return "Single";
>> +       case AVRCP_PACKET_TYPE_START:
>> +               return "Start";
>> +       case AVRCP_PACKET_TYPE_CONTINUING:
>> +               return "Continuing";
>> +       case AVRCP_PACKET_TYPE_END:
>> +               return "End";
>> +       default:
>> +               return "Unknown";
>> +       }
>> +}
>> +
>>  static const char *pdu2str(uint8_t pduid)
>>  {
>>        switch (pduid) {
>> @@ -917,7 +944,8 @@ static const char *mediattr2str(uint32_t attr)
>>  }
>>
>>  static void avrcp_get_element_attributes_dump(int level, struct frame *frm,
>> -                                               uint8_t ctype, uint16_t len)
>> +                                               uint8_t ctype, uint16_t len,
>> +                                               uint8_t pt)
>>  {
>>        uint64_t id;
>>        uint8_t num;
>> @@ -953,18 +981,45 @@ static void avrcp_get_element_attributes_dump(int level, struct frame *frm,
>>        return;
>>
>>  response:
>> -       if (len < 1) {
>> -               printf("PDU Malformed\n");
>> -               raw_dump(level, frm);
>> -               return;
>> -       }
>> +       if (pt == AVRCP_PACKET_TYPE_SINGLE || pt == AVRCP_PACKET_TYPE_START) {
>> +               if (len < 1) {
>> +                       printf("PDU Malformed\n");
>> +                       raw_dump(level, frm);
>> +                       return;
>> +               }
>>
>> -       num = get_u8(frm);
>> -       printf("AttributeCount: 0x%02x\n", num);
>> +               num = get_u8(frm);
>> +               avrcp_continuing.num = num;
>> +               printf("AttributeCount: 0x%02x\n", num);
>> +               len--;
>> +       } else {
>> +               num = avrcp_continuing.num;
>> +
>> +               if (avrcp_continuing.size > 0) {
>> +                       uint16_t size;
>> +
>> +                       if (avrcp_continuing.size > len) {
>> +                               size = len;
>> +                               avrcp_continuing.size -= len;
>> +                       } else {
>> +                               size = avrcp_continuing.size;
>> +                               avrcp_continuing.size = 0;
>> +                       }
>> +
>> +                       printf("ContinuingAttributeValue: ");
>> +                       for (; size > 0; size--) {
>> +                               uint8_t c = get_u8(frm);
>> +                               printf("%1c", isprint(c) ? c : '.');
>> +                       }
>> +                       printf("\n");
>>
>> -       for (; num > 0; num--) {
>> +                       len -= size;
>> +               }
>> +       }
>> +
>> +       while (num > 0 && len > 0) {
>>                uint32_t attr;
>> -               uint16_t charset, len;
>> +               uint16_t charset, attrlen;
>>
>>                p_indent(level, frm);
>>
>> @@ -978,19 +1033,26 @@ response:
>>                                                        charset2str(charset));
>>
>>                p_indent(level, frm);
>> +               attrlen = get_u16(frm);
>> +               printf("AttributeValueLength: 0x%04x\n", attrlen);
>>
>> -               len = get_u16(frm);
>> -               printf("AttributeValueLength: 0x%04x\n", len);
>> +               len -= sizeof(attr) + sizeof(charset) + sizeof(attrlen);
>> +               num--;
>>
>>                p_indent(level, frm);
>>
>>                printf("AttributeValue: ");
>> -               for (; len > 0; len--) {
>> +               for (; attrlen > 0 && len > 0; attrlen--, len--) {
>>                        uint8_t c = get_u8(frm);
>>                        printf("%1c", isprint(c) ? c : '.');
>>                }
>>                printf("\n");
>> +
>> +               if (attrlen > 0)
>> +                       avrcp_continuing.size = attrlen;
>>        }
>> +
>> +       avrcp_continuing.num = num;
>>  }
>>
>>  static const char *playstatus2str(uint8_t status)
>> @@ -1153,7 +1215,8 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
>>        pt = get_u8(frm);
>>        len = get_u16(frm);
>>
>> -       printf("AVRCP: %s: pt 0x%02x len 0x%04x\n", pdu2str(pduid), pt, len);
>> +       printf("AVRCP: %s: pt %s len 0x%04x\n", pdu2str(pduid),
>> +                                                       pt2str(pt), len);
>>
>>        if (len != frm->len) {
>>                p_indent(level, frm);
>> @@ -1198,7 +1261,8 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
>>                avrcp_ct_battery_status_dump(level + 1, frm, ctype, len);
>>                break;
>>        case AVRCP_GET_ELEMENT_ATTRIBUTES:
>> -               avrcp_get_element_attributes_dump(level + 1, frm, ctype, len);
>> +               avrcp_get_element_attributes_dump(level + 1, frm, ctype, len,
>> +                                                                       pt);
>>                break;
>>        case AVRCP_GET_PLAY_STATUS:
>>                avrcp_get_play_status_dump(level + 1, frm, ctype, len);
>> --
>> 1.7.6.1
>
> Ack, please remember to add hcidump to prefix next time.

sorry, my git config was not configured right.

Lucas De Marchi
