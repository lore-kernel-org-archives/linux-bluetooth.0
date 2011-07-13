Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6ue=3u1NfS7ZC+3g9q-XaqLi+8mm0ZW9k0rqJvfQaMLw@mail.gmail.com>
References: <1310482245-2734-1-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v6ue=3u1NfS7ZC+3g9q-XaqLi+8mm0ZW9k0rqJvfQaMLw@mail.gmail.com>
Date: Wed, 13 Jul 2011 22:37:46 +0300
Message-ID: <CABBYNZKQVzUEcZnEkf3QJpsf7iJJfU+KcapywiXBh-5UvRa53Q@mail.gmail.com>
Subject: Re: [PATCH hcidump 2/2 v2] Add parsing for AVRCP GetCapabilities
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Wed, Jul 13, 2011 at 9:01 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> On Tue, Jul 12, 2011 at 11:50 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  parser/avrcp.c |  124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 123 insertions(+), 1 deletions(-)
>>
>> diff --git a/parser/avrcp.c b/parser/avrcp.c
>> index 43e8a8b..ff6862d 100644
>> --- a/parser/avrcp.c
>> +++ b/parser/avrcp.c
>> @@ -111,6 +111,21 @@
>>  #define AVRCP_SEARCH                   0x80
>>  #define AVRCP_ADD_TO_NOW_PLAYING       0x90
>>
>> +/* notification events */
>> +#define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED            0x01
>> +#define AVRCP_EVENT_TRACK_CHANGED                      0x02
>> +#define AVRCP_EVENT_TRACK_REACHED_END                  0x03
>> +#define AVRCP_EVENT_TRACK_REACHED_START                        0x04
>> +#define AVRCP_EVENT_PLAYBACK_POS_CHANGED               0x05
>> +#define AVRCP_EVENT_BATT_STATUS_CHANGED                        0x06
>> +#define AVRCP_EVENT_SYSTEM_STATUS_CHANGED              0x07
>> +#define AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED 0x08
>> +#define AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED                0x09
>> +#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED          0x0a
>> +#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED           0x0b
>> +#define AVRCP_EVENT_UIDS_CHANGED                       0x0c
>> +#define AVRCP_EVENT_VOLUME_CHANGED                     0x0d
>> +
>>  static const char *ctype2str(uint8_t ctype)
>>  {
>>        switch (ctype & 0x0f) {
>> @@ -213,6 +228,105 @@ static const char *pdu2str(uint8_t pduid)
>>        }
>>  }
>>
>> +static char *cap2str(uint8_t cap)
>> +{
>> +       switch (cap) {
>> +       case 0x2:
>> +               return "CompanyID";
>> +       case 0x3:
>> +               return "EventsID";
>> +       default:
>> +               return "Unknown";
>> +       }
>> +}
>> +
>> +static char *event2str(uint8_t event)
>> +{
>> +       switch (event) {
>> +       case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
>> +               return "EVENT_PLAYBACK_STATUS_CHANGED";
>> +       case AVRCP_EVENT_TRACK_CHANGED:
>> +               return "EVENT_TRACK_CHANGED";
>> +       case AVRCP_EVENT_TRACK_REACHED_END:
>> +               return "EVENT_TRACK_REACHED_END";
>> +       case AVRCP_EVENT_TRACK_REACHED_START:
>> +               return "EVENT_TRACK_REACHED_START";
>> +       case AVRCP_EVENT_PLAYBACK_POS_CHANGED:
>> +               return "EVENT_PLAYBACK_POS_CHANGED";
>> +       case AVRCP_EVENT_BATT_STATUS_CHANGED:
>> +               return "EVENT_BATT_STATUS_CHANGED";
>> +       case AVRCP_EVENT_SYSTEM_STATUS_CHANGED:
>> +               return "EVENT_SYSTEM_STATUS_CHANGED";
>> +       case AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED:
>> +               return "EVENT_PLAYER_APPLICATION_SETTING_CHANGED";
>> +       case AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED:
>> +               return "EVENT_NOW_PLAYING_CONTENT_CHANGED";
>> +       case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
>> +               return "EVENT_AVAILABLE_PLAYERS_CHANGED";
>> +       case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
>> +               return "EVENT_ADDRESSED_PLAYER_CHANGED";
>> +       case AVRCP_EVENT_UIDS_CHANGED:
>> +               return "EVENT_UIDS_CHANGED";
>> +       case AVRCP_EVENT_VOLUME_CHANGED:
>> +               return "EVENT_VOLUME_CHANGED";
>> +       default:
>> +               return "Reserved";
>> +       }
>> +}
>> +
>> +static void avrcp_get_capabilities_dump(int level, struct frame *frm, uint16_t len)
>> +{
>> +       uint8_t cap;
>> +       uint8_t count;
>> +
>> +       p_indent(level, frm);
>> +
>> +       if (len < 1) {
>> +               printf("PDU Malformed\n");
>> +               raw_dump(level, frm);
>> +               return;
>> +       }
>> +
>> +       cap = get_u8(frm);
>> +       printf("CapabilityID: 0x%02x (%s)\n", cap, cap2str(cap));
>> +
>> +       if (len == 1)
>> +               return;
>> +
>> +       p_indent(level, frm);
>> +
>> +       count = get_u8(frm);
>> +       printf("CapabilityCount: 0x%02x\n", count);
>> +
>> +       switch (cap) {
>> +       case 0x2:
>> +               for (; count > 0; count--) {
>> +                       int i;
>> +
>> +                       p_indent(level, frm);
>> +
>> +                       printf("%s: 0x", cap2str(cap));
>> +                       for (i = 0; i < 3; i++)
>> +                               printf("%02x", get_u8(frm));
>
> Humn... I think this is not what you want. Since this information is
> always in big endian order, you may need to convert it to host
> architecture in order to see meaningful numbers. E.g.: if you do like
> you're doing, when receiving a packet with COMPANY_ID == IEEE_BTSIG,
> the information printed will be 0x581900 instead of the expected
> 0x001958.

It works just fine, we are printing byte by byte as it comes e.g. sony mw600:

> AVCTP: Command : pt 0x00 transaction 5 pid 0x110e
    AV/C: Status: address 0x48 opcode 0x00
      Subunit: Panel
      Opcode: Vendor Dependent
      Company ID: 0x001958
      AVRCP: GetCapabilities: pt 0x00 len 0x0001
        CapabilityID: 0x02 (CompanyID)

-- 
Luiz Augusto von Dentz
