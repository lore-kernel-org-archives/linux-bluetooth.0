Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5VCTnzJyD2LLFO-oS=ZVf=Kv1AdGr8q_Xj10KQaBuqOw@mail.gmail.com>
References: <1350388692-15239-1-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v5VCTnzJyD2LLFO-oS=ZVf=Kv1AdGr8q_Xj10KQaBuqOw@mail.gmail.com>
Date: Tue, 16 Oct 2012 16:28:57 +0200
Message-ID: <CABBYNZLWYdC1RfLFScH-CFribYLxzG9a-F=zLD7+Cv0aVjA76A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] AVRCP: Fix using void * for metadata values
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Oct 16, 2012 at 3:56 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Luiz
>
> On Tue, Oct 16, 2012 at 8:58 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This replaces get_metadata callback with get_string and get_uint32
>> which uses proper types as return.
>> ---
>
> I fail to see what this commit is fixing. It seems more like
> refactoring void* to explicit types.
>
>
>>  audio/avrcp.c | 32 ++++++++++++++++++--------------
>>  audio/avrcp.h |  3 ++-
>>  audio/media.c | 31 ++++++++++++++++++++++++-------
>>  3 files changed, 44 insertions(+), 22 deletions(-)
>>
>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>> index 2f5df21..5a18cb4 100644
>> --- a/audio/avrcp.c
>> +++ b/audio/avrcp.c
>> @@ -501,23 +501,29 @@ static uint16_t player_write_media_attribute(struct avrcp_player *player,
>>         uint16_t len;
>>         uint16_t attr_len;
>>         char valstr[20];
>> -       void *value;
>> +       const char *value = NULL;
>> +       uint32_t num;
>>
>>         DBG("%u", id);
>>
>> -       value = player->cb->get_metadata(id, player->user_data);
>> -       if (value == NULL) {
>> -               *offset = 0;
>> -               return 0;
>> -       }
>> -
>>         switch (id) {
>>         case AVRCP_MEDIA_ATTRIBUTE_TRACK:
>>         case AVRCP_MEDIA_ATTRIBUTE_N_TRACKS:
>>         case AVRCP_MEDIA_ATTRIBUTE_DURATION:
>> -               snprintf(valstr, 20, "%u", GPOINTER_TO_UINT(value));
>> +               num = player->cb->get_uint32(id, player->user_data);
>> +               if (num == 0)
>> +                       break;
>> +
>> +               snprintf(valstr, 20, "%u", num);
>
> The downside here is that we loose the ability to differentiate
> attribute not present from the value 0. 0 doesn't make sense for
> duration, but is a valid value for the other 2.

Which ones? You mean track and track number, I guess we can skip those
if they are 0.

-- 
Luiz Augusto von Dentz
