Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120320091502.GA6356@uw000554.eu.tieto.com>
References: <1332178892-8987-1-git-send-email-luiz.dentz@gmail.com>
	<20120320091502.GA6356@uw000554.eu.tieto.com>
Date: Tue, 20 Mar 2012 08:22:08 -0300
Message-ID: <CABBYNZ+hhXH7879kUN-CuYjiSDdxEuA1AVSgdnQSTYN2FX=6pA@mail.gmail.com>
Subject: Re: [PATCH hcidump 1/2] AVRCP: Add parsing for SetAbsoluteVolume PDU
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

On Tue, Mar 20, 2012 at 6:15 AM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> Hi Luiz,
>
> On Mon, Mar 19, 2012 at 07:41:31PM +0200, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  parser/avrcp.c |   20 ++++++++++++++++++++
>>  1 files changed, 20 insertions(+), 0 deletions(-)
>>
>> diff --git a/parser/avrcp.c b/parser/avrcp.c
>> index 643e494..d746937 100644
>> --- a/parser/avrcp.c
>> +++ b/parser/avrcp.c
>> @@ -1201,6 +1201,23 @@ response:
>>       }
>>  }
>>
>> +static void avrcp_set_absolut_volume_dump(int level, struct frame *frm,
>> +                                             uint8_t ctype, uint16_t len)
>
> Typo? "absolut" --> "absolute"

Yep, gonna fix that.

>> +{
>> +     uint8_t value;
>> +
>> +     p_indent(level, frm);
>> +
>> +     if (len < 1) {
>> +             printf("PDU Malformed\n");
>> +             raw_dump(level, frm);
>> +             return;
>> +     }
>> +
>> +     value = get_u8(frm);
>
> "value" is only lower seven bits. You should use mask 0x80.
> The same for Patch 2/2.

Actually the mask is 0x7F, although as hcidump is not actually
implementing this but dumping letting it print the full value would
catch bugs when reserved bit is used.

>> +     printf("Value: 0x%02x\n", value);
>
> "Value"? "Volume" seems to be better, and why hex value? I propose
> decimal and percent value, for example: "Volume: 38% (48/127)"

Sounds good


-- 
Luiz Augusto von Dentz
