Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+amA0pcN0jEdE_dT4r-bcBJ59SgG1vqdZPneAoy8xeHg@mail.gmail.com>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1312568132-21112-2-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZ+amA0pcN0jEdE_dT4r-bcBJ59SgG1vqdZPneAoy8xeHg@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 8 Aug 2011 10:50:57 -0300
Message-ID: <CAMOw1v7rPDjpsgAjEaQxRPP8WT=F2Tb7ubVeYYJTuyL5mYtd2w@mail.gmail.com>
Subject: Re: [PATCH 02/23] avrcp: use C99 instead of gcc extension
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 8, 2011 at 5:41 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Fri, Aug 5, 2011 at 9:15 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> ---
>>  audio/control.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/audio/control.c b/audio/control.c
>> index c3ef737..1ec736f 100644
>> --- a/audio/control.c
>> +++ b/audio/control.c
>> @@ -134,7 +134,7 @@ struct avrcp_spec_avc_pdu {
>>        uint8_t packet_type:2;
>>        uint8_t rsvd:6;
>>        uint16_t params_len;
>> -       uint8_t params[0];
>> +       uint8_t params[];
>>  } __attribute__ ((packed));
>>  #define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
>>
>> @@ -164,7 +164,7 @@ struct avrcp_spec_avc_pdu {
>>        uint8_t rsvd:6;
>>        uint8_t packet_type:2;
>>        uint16_t params_len;
>> -       uint8_t params[0];
>> +       uint8_t params[];
>>  } __attribute__ ((packed));
>>  #define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
>
> Not sure if this is really necessary, there several places where we do
> that and we normally use __attribute__((packed)) is we still depend on
> gcc extension in one way or the other.

Fair enough. I just try to use C99 whenever possible.


Lucas De Marchi
