Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5C5mOE4Rr6zseaMUff6nWOHC_5Kpo1J_mSgY+u_USZiA@mail.gmail.com>
References: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
	<1337958168-9875-2-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v5C5mOE4Rr6zseaMUff6nWOHC_5Kpo1J_mSgY+u_USZiA@mail.gmail.com>
Date: Mon, 28 May 2012 13:38:09 +0300
Message-ID: <CABBYNZK6YH2ZZuLYGTrvSmM3JA=_HdN9yVX6AEZXG+fz2mz4Sg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/6] AVRCP: Fix not registering to VolumeChanged
 event again when notified
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, May 25, 2012 at 7:17 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> On Fri, May 25, 2012 at 12:02 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> The spec says:
>>
>> "A registered notification gets changed on receiving CHANGED event
>> notification. For a new notification additional NOTIFY command is
>> expected to be sent."
>> ---
>>  audio/avrcp.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/audio/avrcp.c b/audio/avrcp.c
>> index 2f96f27..30d696a 100644
>> --- a/audio/avrcp.c
>> +++ b/audio/avrcp.c
>> @@ -176,6 +176,8 @@ static uint32_t company_ids[] = {
>>        IEEEID_BTSIG,
>>  };
>>
>> +static void register_volume_notification(struct avrcp_player *player);
>> +
>>  static sdp_record_t *avrcp_ct_record(void)
>>  {
>>        sdp_list_t *svclass_id, *pfseq, *apseq, *root;
>> @@ -1154,6 +1156,11 @@ static gboolean avrcp_handle_volume_changed(struct avctp *session,
>>
>>        player->cb->set_volume(volume, player->dev, player->user_data);
>>
>> +       if (code == AVC_CTYPE_CHANGED) {
>
> if code != AVC_CTYPE_CHANGED you shouldn't even set the volume
> above... you need to return early if code is not what it's expecting
> because you can't trust the other side.

I suppose we can do the other way round, just return early if the
response type is not changed or interim. Btw, the purpose of the check
above was for not trigger registration on interim response since that
is already a registration response and we should keep the handler
around in that case for changed response.

-- 
Luiz Augusto von Dentz
