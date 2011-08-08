Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLGOc3a1N4+j3sR+Qa46frL2Ajm2drzXwmbHfEHsY_JKw@mail.gmail.com>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1312568132-21112-10-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZLGOc3a1N4+j3sR+Qa46frL2Ajm2drzXwmbHfEHsY_JKw@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 8 Aug 2011 10:49:10 -0300
Message-ID: <CAMOw1v7xvyYO6VA33kZ_VYM=yYzZ+e703xOEDaE7nWmHmkLyig@mail.gmail.com>
Subject: Re: [PATCH 10/23] avrcp: handle GetCurrentPlayerAplicationSettingValue
 pdu
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 8, 2011 at 5:08 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Fri, Aug 5, 2011 at 9:15 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> Example response for PTS test TC_TG_PAS_BV_10_C:
>>
>>> ACL data: handle 11 flags 0x02 dlen 19
>>    L2CAP(d): cid 0x0043 len 15 [psm 23]
>>      AVCTP: Command : pt 0x00 transaction 3 pid 0x110e
>>        AV/C: Status: address 0x48 opcode 0x00
>>          Subunit: Panel
>>          Opcode: Vendor Dependent
>>          Company ID: 0x001958
>>          AVRCP: GetCurrentPlayerApplicationSettingValue: pt 0x00 len 0x0002
>>            AttributeCount: 0x01
>>            AttributeID: 0x01 (Equalizer ON/OFF Status)
>> < ACL data: handle 11 flags 0x02 dlen 20
>>    L2CAP(d): cid 0x0043 len 16 [psm 23]
>>      AVCTP: Response : pt 0x00 transaction 3 pid 0x110e
>>        AV/C: Stable: address 0x48 opcode 0x00
>>          Subunit: Panel
>>          Opcode: Vendor Dependent
>>          Company ID: 0x001958
>>          AVRCP: GetCurrentPlayerApplicationSettingValue: pt 0x00 len 0x0003
>>            ValueCount: 0x01
>>            AttributeID: 0x01 (Equalizer ON/OFF Status)
>>            ValueID: 0x02 (ON)
>> ---
>>  audio/control.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 77 insertions(+), 0 deletions(-)
>>
>> diff --git a/audio/control.c b/audio/control.c
>> index 2e910cd..22fb35a 100644
>> --- a/audio/control.c
>> +++ b/audio/control.c
>> @@ -115,6 +115,7 @@
>>  #define AVRCP_GET_CAPABILITIES         0x10
>>  #define AVRCP_LIST_PLAYER_ATTRIBUTES   0X11
>>  #define AVRCP_LIST_PLAYER_VALUES       0x12
>> +#define AVRCP_GET_CURRENT_PLAYER_VALUE 0x13
>>
>>  /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
>>  #define CAP_COMPANY_ID         0x02
>> @@ -759,6 +760,69 @@ err:
>>        return -EINVAL;
>>  }
>>
>> +static int avrcp_handle_get_current_player_value(struct control *control,
>> +                                               struct avrcp_spec_avc_pdu *pdu)
>> +{
>> +       uint16_t len = ntohs(pdu->params_len);
>> +       struct media_player *mp = control->mp;
>> +
>> +       if (!mp)
>> +               goto done;
>> +
>> +       if (len > 1 && pdu->params[0] == len - 1) {
>
> This if statement is quite long, perhaps you could do check the
> opposite e.g. if (len <=1 || pdu->params[0] != len - 1) goto done;

In all other parts of the code I do like you said because it's much
cleaner. Here however I can't because of the following declaration:

>> +               uint8_t settings[pdu->params[0]];

It depends on the value of pdu->params[0]


Lucas De Marchi
