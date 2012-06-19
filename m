Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <E50901D4F2CF69428D43141B7C85867929DD8AD28D@EXMB03.eu.tieto.com>
References: <1340028563-8089-1-git-send-email-luiz.dentz@gmail.com>
	<E50901D4F2CF69428D43141B7C85867929DD8AD28D@EXMB03.eu.tieto.com>
Date: Tue, 19 Jun 2012 10:04:21 +0300
Message-ID: <CABBYNZLHJ=eAxxhgNgE=TmKU_yODDEotQvBDOYzFB99kQ=t_6w@mail.gmail.com>
Subject: Re: [PATCH hcidump 1/2] AVRCP: Add parsing for SetAddressedPlayer PDU
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal.Labedzki@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Tue, Jun 19, 2012 at 9:39 AM,  <Michal.Labedzki@tieto.com> wrote:
> Hi Luiz,
>
> Some cosmetic comments.
>
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  parser/avrcp.c |   35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/parser/avrcp.c b/parser/avrcp.c
>> index 850741b..0f2f1e6 100644
>> --- a/parser/avrcp.c
>> +++ b/parser/avrcp.c
>> @@ -1222,6 +1222,38 @@ static void avrcp_set_absolute_volume_dump(int level, struct frame *frm,
>>         printf("Volume: %.2f%% (%d/127)\n", value/1.27, value);
>>  }
>>
>> +static void avrcp_set_addressed_player(int level, struct frame *frm,
>> +                                               uint8_t ctype, uint16_t len)
>> +{
>> +       uint16_t id;
>> +       uint8_t status;
>> +
>> +       p_indent(level, frm);
>> +
>> +       if (ctype > AVC_CTYPE_GENERAL_INQUIRY)
>> +               goto response;
>
> This command type is only AVC_CTYPE_CONTROL with AVC_CTYPE_NOT_IMPLEMENTED, AVC_CTYPE_ACCEPTED, AVC_CTYPE_REJECTED responses, so maybe all other should be tread as malformed.

This is a dumping tool, so the purpose to print as much as possible.

>
>> +
>> +       if (len < 2) {
>
> What do you think about replace "<" by "!="? Large packet probably is not correct. But this can be what it is.

Again the purpose is to print as much as possible.

>
>> +               printf("PDU Malformed\n");
>> +               raw_dump(level, frm);
>> +               return;
>> +       }
>> +
>> +       id = get_u16(frm);
>> +       printf("PlayerID: 0x%04x", id);
>> +       return;
>
> ID in hex? Decimal seems to be more natural.

This was taken from the spec, but either way is fine.

-- 
Luiz Augusto von Dentz
