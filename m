Return-Path: <cyrus@holtmann.org>
Message-id: <3812CD379FC54325B4581BDDAA0A97D4@sisodomain.com>
From: "chethan.tn" <chethan.tn@samsung.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
References: <1332309849-4303-1-git-send-email-chethan.tn@samsung.com>
 <CAMOw1v5ESJsFm0oyvU6gAL735J+Eq7ft6OO1cANn4meawrfeww@mail.gmail.com>
In-reply-to: <CAMOw1v5ESJsFm0oyvU6gAL735J+Eq7ft6OO1cANn4meawrfeww@mail.gmail.com>
Subject: Re: [PATCH] avrcp: Handle of GetPlayerApplicationSettingAttributeText
 pdu
Date: Wed, 28 Mar 2012 08:17:33 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

--------------------------------------------------
From: "Lucas De Marchi" <lucas.demarchi@profusion.mobi>
Sent: Thursday, March 22, 2012 6:41 AM
To: "Chethan T N" <chethan.tn@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] avrcp: Handle of 
GetPlayerApplicationSettingAttributeText pdu

> Hi Chethan,
>
> On Wed, Mar 21, 2012 at 3:04 AM, Chethan T N <chethan.tn@samsung.com> 
> wrote:
>> Support for TG role GetPlayerApplicationSettingAttributeText added
>> to pass PTS test case TP/PAS/BV-04-C
>> ---
>>  audio/avrcp.c |   93 
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 92 insertions(+), 1 deletions(-)
>
> I started reviewing this and it looked very familiar to me, including
> the comments... It turned out that this implementation is very similar
> to avrcp_handle_get_current_player_value() and then it made me wonder
> why I didn't implement it last year. See comment below.
>
>
>>
>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>> index c9ec314..b09a777 100644
>> --- a/audio/avrcp.c
>> +++ b/audio/avrcp.c
>> @@ -800,6 +800,97 @@ err:
>>        return AVC_CTYPE_REJECTED;
>>  }
>>
>> +static const char *attr_to_str(uint8_t attr)
>> +{
>> +       switch (attr) {
>> +       case AVRCP_ATTRIBUTE_EQUALIZER:
>> +               return "Equalizer";
>> +       case AVRCP_ATTRIBUTE_REPEAT_MODE:
>> +               return "Repeat";
>> +       case AVRCP_ATTRIBUTE_SHUFFLE:
>> +               return "Shuffle";
>> +       case AVRCP_ATTRIBUTE_SCAN:
>> +               return "Scan";
>> +       }
>> +
>> +       return NULL;
>> +}
>
> We can't have these values hardcoded here. CT is asking the TG: "what
> should I display in my pane?" - it's meaningless to answer this since
> CT already knows that for the settings from the spec.
>

ok. I agree for the default settings like Equalizer, Shuffle, Repeat and 
Scan values TG need
not to send to CT.

> See section 5.2.5 of AVRCP 1.3 spec:
>
> "NOTE: This command is expected to be used only for extended attributes 
> for menu
> navigation. It is assumed that all <attribute, value> pairs used for
> menu extensions are
> statically defined by TG."
>

ok, But the <attribute, value> pair for extended attributes may vary for 
different TG's.
So TG application register their extended attributes to bluez, and when CT 
requests for
these values TG shall send the <attribute, value> based on the attribute ID.

> Therefore we should only implement that for settings that extend the
> "default ones". If you want that, take a look in the comments below
> (besides having to extend the current API for getting values, etc).
>
>
>> +
>> +static uint8_t avrcp_handle_get_player_attribute_text(struct 
>> avrcp_player *player,
>> +                                               struct avrcp_header *pdu,
>> +                                               uint8_t transaction)
>> +{
>> +       uint16_t len = ntohs(pdu->params_len);
>> +       uint8_t *settings = NULL;
>> +       unsigned int i = 0;
>> +       uint8_t no_of_attr = 0;
>> +       const char *attstr = NULL;
>
> Review useless initialization...

I will modify the initializations.
>
>
>> +
>> +       if (player == NULL || len <= 1 || pdu->params[0] != len - 1)
>> +               goto err;
>> +
>> +       /*
>> +        * Save a copy of requested settings because we can override them
>> +        * while responding
>> +        */
>> +       settings = g_memdup(&pdu->params[1], pdu->params[0]);
>> +       len = 0;
>> +
>> +       /*
>> +        * From sec. 5.7 of AVRCP 1.3 spec, we should ignore non-existent 
>> IDs
>> +        * and send a response with the existent ones.
>> +        */
>> +       for (i = 0; i < pdu->params[0]; i++) {
>> +
>> +               if (settings[i] < AVRCP_ATTRIBUTE_EQUALIZER ||
>> +                                       settings[i] > 
>> AVRCP_ATTRIBUTE_SCAN) {
>> +                       DBG("Ignoring %u", settings[i]);
>> +                       continue;
>> +               }
>
> We would change this loop and pass the setting to player.

ok.

>
>> +
>> +               if (player_get_attribute(player, settings[i]) < 0)
>> +                       continue;
>
> You are asking the value of that setting to the player only to know if
> player supports that setting. But you actually have to respond with
> the _name_ of the key. Pretty confusing here. We should ask the _name_
> of the key, not its value.

ok, I will modify based on the _name_.
>
>> +
>> +               /*
>> +                * No of attributes that are supported by the player
>> +                */
>> +               no_of_attr++;
>> +               pdu->params[++len] = settings[i];
>> +
>> +               /*
>> +                * As per the MIBenum defined in IANA character set
>> +                * document the value of displayable UTF-8 charater set
>> +                * value is 0x006A
>> +                */
>> +               pdu->params[++len] = 0x00;
>> +               pdu->params[++len] = 0x6A;
>> +               attstr = attr_to_str(settings[i]);
>> +
>> +               if (NULL != attstr) {
> reverse order...
>
> and you already incremented no_of_attr, CT will be very confused

ok, I will modify the increment of no_of_attr after copying the _name_.

>
>> +                       pdu->params[++len] = strlen(attstr);
>
> 1
>
>> +                       len = len + 1;
>> +                       strncpy((char *) (pdu->params + len), attstr, 
>> strlen(attstr));
>
> 2
>
>> +                       len = len + strlen(attstr);
>
> 3
>
> 3 calls to strlen() ( + 1 inside strncpy()).... not good - cache it in
> variable and use that instead (in this case it could even be hardcoded
> in attr_to_str(), but this can't be as is because of the first comment
> above..
>

ok. I will modify.

>
> Regards,
> Lucas De Marchi


Thanks and Regards
Chethan 

