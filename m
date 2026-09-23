Received: from sender5-pp-e103.zoho.com (sender5-pp-e103.zoho.com [165.173.182.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29095326AB
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173633; cv=pass; b=tbsymypmggDMHHtTvvso99Nsp6GBIk8EuqnYxj9zatjSORs+dNnheCuq8zlWLp6kRTLaqxTO3FBFdJG96iofoRodCFc2GqAe7Og+9tcpo5CqlhOi6kYJMAp3ReTi/vYWXZfD/DR+Z9RG4L7NL01TxyAfRKxw8ptci+u1myb2J3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173633; c=relaxed/simple;
	bh=HlME1C0DyF+/6nDowtZzHMXL5JXKmSiNweQIyMAMCnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHW/9Mm1cFqzKF9dArFwlF5Dfy8ZE8ROmriKf9DhTElzmH7bgY7NERLAWEYKulTcyrGOyqc3RiN+1QdwYtAcSpK0myTQBqhtGaFneC8P8T6/mbyBmO19+6JCmkuu3wT3ek+snzJUJLWohUWL90ymPgYOeTTioYAO3g/Oxn239UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=fG5gLdjz; arc=pass smtp.client-ip=165.173.182.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="fG5gLdjz"
ARC-Seal: i=1; a=rsa-sha256; t=1790173629; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nqtiJDxB98HMjVk0GHid3UYnLNJ/SpW8bchNO+wncJP6AQI3zbnnw9zJoQqM9Le0djFGckcugypAE07+hzh19A03ACgBDrjcw8uXo64ZY7sE8BzYtMLBa0Up5XZlxgZpjqKCM3tWTKLfnV65OYCxynIF9NZt4oO4P2ksDmQKnnQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790173629; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7zpn2vVGBzcn6WKIUcm8cmcGIouPtZADQRFzx1tWiUY=; 
	b=JIzeppTQIIqCLuZunYxaFoIHonDwjBx9L+bnGWSCxZP0OlzHTmDSvEAKy3SMDdr+ql8pGjoRSq2lXUZnBgtdt/ep+kA8lDbQtbHJ8+ZkUhVmwfiOtjPRCFLCZilgRIzxB9A9x78eo61cGZ3zyzdJG1M2Y9D8SXfJ68JyqOk7Pgo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790173629;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7zpn2vVGBzcn6WKIUcm8cmcGIouPtZADQRFzx1tWiUY=;
	b=fG5gLdjzU5Moe6GPRWLzl+E56/5lBPCJLF/zl+/Fc3kdejd++HfXZWjVs16Zm0xq
	nH8tOVkv5lBhyxUkCrUSdaKQBTHOfdwErTK5FUxTKG+fCNDLX4D+8uYvE28JjYRO4DX
	+F4YRIa+etnGGVfTZ6jK+bQq+46Fn49JuaRHUXZc=
Received: by smtp.zohomail.com with SMTPS id 1790173627924227.31422876288696;
	Wed, 23 Sep 2026 07:27:07 -0700 (PDT)
Message-ID: <53355fb8-db74-427d-9135-cfeccb66e4b0@collabora.com>
Date: Wed, 23 Sep 2026 16:27:05 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] audio/avrcp: Poll GetPlayStatus when position
 changed event unsupported
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260923080003.317019-1-frederic.danis@collabora.com>
 <CABBYNZKN2C_65XH_LOptU_GVoarEa_BQmhvzr+7O68Y+Um9Zzg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZKN2C_65XH_LOptU_GVoarEa_BQmhvzr+7O68Y+Um9Zzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 23/09/2026 15:55, Luiz Augusto von Dentz wrote:
> Hi Frederic,
>
> On Wed, Sep 23, 2026 at 4:02 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> Some remote targets do not support the AVRCP_EVENT_PLAYBACK_POS_CHANGED
>> notification, meaning bluetoothd never learns about track position
>> updates for such devices.
>>
>> When this event is not present in the capabilities reported by the
>> remote, fall back to polling AVRCP_GET_PLAY_STATUS once a second so
>> the media player position stays in sync. Polling is only kept running
>> while playback is actively progressing (playing/forward-seek/
>> reverse-seek) and is stopped otherwise, and is torn down on session
>> destruction.
> Back in the days AVRCP was introduced we decided not to poll the
> status and instead have the upper layer trigger it via
> https://github.com/bluez/bluez/blob/master/doc/org.bluez.MediaPlayer.rst#uint32-position-readonly,
> that said I do agree that perhaps it is better to it with directly by
> bluetoothd since so many years have passed and some manufactorers
> insist in not having AVRCP_EVENT_PLAYBACK_POS_CHANGED implemented.
This property may be cached by the DBus framework used, and so iiuc 
reading it will not trigger GetPlayStatus.

>> Assisted-by: Copilot CLI:claude-sonnet-5
>> ---
>>   profiles/audio/avrcp.c | 64 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index df5f97eaf..105538cdc 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -247,7 +247,9 @@ struct avrcp {
>>          unsigned int control_id;
>>          unsigned int browsing_id;
>>          unsigned int browsing_timer;
>> +       unsigned int position_timer;
>>          uint16_t supported_events;
>> +       bool pos_changed_supported;
>>          uint8_t transaction;
>>          struct pending_pdu *pending_pdu;
>>   };
>> @@ -341,6 +343,7 @@ static const uint32_t company_ids[] = {
>>
>>   static void avrcp_register_notification(struct avrcp *session, uint8_t event);
>>   static GList *player_list_settings(struct avrcp_player *player);
>> +static void avrcp_get_play_status(struct avrcp *session);
>>
>>   static void avrcp_browsing_record(sdp_record_t *record, sdp_data_t *version)
>>   {
>> @@ -2224,6 +2227,56 @@ static const char *status_to_string(uint8_t status)
>>          }
>>   }
>>
>> +static bool avrcp_poll_play_status(gpointer user_data)
>> +{
>> +       struct avrcp *session = user_data;
>> +
>> +       avrcp_get_play_status(session);
>> +
>> +       return TRUE;
>> +}
>> +
>> +static void avrcp_stop_pos_polling(struct avrcp *session)
>> +{
>> +       if (session->position_timer == 0)
>> +               return;
>> +
>> +       timeout_remove(session->position_timer);
>> +       session->position_timer = 0;
>> +}
>> +
>> +static void avrcp_start_pos_polling(struct avrcp *session)
>> +{
>> +       if (session->position_timer > 0)
>> +               return;
>> +
>> +       session->position_timer = timeout_add_seconds(1,
>> +                                               avrcp_poll_play_status,
>> +                                               session, NULL);
>> +}
>> +
>> +/*
>> + * Poll GetPlayStatus once a second to resync position while playing when
>> + * the remote does not support AVRCP_EVENT_PLAYBACK_POS_CHANGED. Polling is
>> + * paused whenever playback is not actively progressing.
>> + */
>> +static void avrcp_update_pos_polling(struct avrcp *session, uint8_t status)
>> +{
>> +       if (session->pos_changed_supported)
>> +               return;
>> +
>> +       switch (status) {
>> +       case AVRCP_PLAY_STATUS_PLAYING:
>> +       case AVRCP_PLAY_STATUS_FWD_SEEK:
>> +       case AVRCP_PLAY_STATUS_REV_SEEK:
>> +               avrcp_start_pos_polling(session);
> Btw, if I recall correctly, position tracking really breaks when the
> user seeks the stream using the player progression bar, which
> interrupts the continuous timer. So, if the player does either
> AVRCP_PLAY_STATUS_FWD_SEEK or AVRCP_PLAY_STATUS_REV_SEEK then we can
> resink the position once, afaik iOS media player doesn't use them
> either, thus why the whole polling thing is needed to capture non
> continuguos skips that are not advertised.
>
>> +               break;
>> +       default:
>> +               avrcp_stop_pos_polling(session);
>> +               break;
>> +       }
>> +}
>> +
>>   static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
>>                                          uint8_t subunit, uint8_t transaction,
>>                                          uint8_t *operands, size_t operand_count,
>> @@ -2252,6 +2305,8 @@ static gboolean avrcp_get_play_status_rsp(struct avctp *conn, uint8_t code,
>>          media_player_set_position(mp, position);
>>          media_player_set_status(mp, status_to_string(status));
>>
>> +       avrcp_update_pos_polling(session, status);
>> +
>>          return FALSE;
>>   }
>>
>> @@ -4128,6 +4183,9 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
>>                  }
>>          }
>>
>> +       session->pos_changed_supported =
>> +                       !!(events & (1 << AVRCP_EVENT_PLAYBACK_POS_CHANGED));
>> +
>>          if (!session->controller || !session->controller->player)
>>                  return FALSE;
>>
>> @@ -4140,7 +4198,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
>>                          !(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>>                  avrcp_list_player_attributes(session);
>>
>> -       if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
>> +       if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)) ||
>> +                       !session->pos_changed_supported)
>>                  avrcp_get_play_status(session);
>>
>>          if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
>> @@ -4470,6 +4529,9 @@ static void session_destroy(struct avrcp *session, int err)
>>          if (session->browsing_timer > 0)
>>                  timeout_remove(session->browsing_timer);
>>
>> +       if (session->position_timer > 0)
>> +               timeout_remove(session->position_timer);
>> +
>>          if (session->controller != NULL)
>>                  controller_destroy(session);
>>
>> --
>> 2.43.0
>>
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


