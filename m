Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618344;
	b=DX9dvXIa1h+xw+YiarsiJWgBD6wSbZ6PG2t2HhvNFbFEIZvLmDRGTXNlvGZRhprGE3St
	 8OoO73730TtlTjs25ZEeys6ajC5JSGeMbcTZVRWC9NBESXv2nx2sN7/I8huHKX5hj711b
	 k3EfbZ3OreRrJF4xr9AZqVNs8tugvrdRZ3GTnzHjRF/OpY8QJLhCRNIrwcgrUodjO4H+r
	 rL/2QaU983eL2fDQAK8OsCww1gXp/O4bnxH6nu2gswYdje6M0Xf1on40nbHSwmYw6vd8u
	 pyb3ApeN5z3Q9shsOPl41lOXp7Xg//l4kGJDSegZ/uYw8JCtzIXTgHTOWQWLU4E23sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AwuVOJaZNdU5KtTHzIORLk7WYXEDBjijnn4sWXXxfBQ=;
	b=1OQvUfAJoKdA7Bb/yc6FAekJ2DQv7jA78HEKHwZ1noNO+eKBnRt62Ers1fYmTPHK4fOj
	 KC1x851VPnkhM+0GRED5DZzLwmFK8d0Guwh1L0qa93X3cG9t8zN4C17Ihjn+eAkRZUoD+
	 h8Qn+dAvBZG3D9rsLgU5ZsNjyBwFXOBx205fmMJXbwiQYOG3bacBpUPl67SV30/nOWRgs
	 naCAWX+Bhhx/Oq2junQLqELiE+iB6SjBMaXyDR1PoUVjOTaFBbWRzfF6M8V3X3Y/MSEuF
	 /LvXflyXQ+GNrc2ukLwKoWaaQwHf/7KcD1v5XfEke8NEpuEs/D6dGRaOmbutk2hZ5Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cRggvxaz;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D2606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B4D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cRggvxaz
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e47347279so3552138f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 06:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795618341; x=1796223141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwuVOJaZNdU5KtTHzIORLk7WYXEDBjijnn4sWXXxfBQ=;
        b=cRggvxazQzAxcBIHQD/iuBttEPCPxTVggzC+hw+Cz5+ztu7Q8zY2dAkIP1gzHa0EGy
         8TCzJdNFFt1iCal6bB1fR8CYKUyRJYlyO0KWKbTMXqQnbQKPs9d49BPnrHBj0rl/ieA5
         oOs2W09BcHyxN+lO2ru47Lzm5Ck/GZmPgfs2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618341; x=1796223141;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwuVOJaZNdU5KtTHzIORLk7WYXEDBjijnn4sWXXxfBQ=;
        b=VaAM9wQRZXJctj9Q8ysfScEPpBy4dRx+LaNFHprRVPCqXnWfJGnLnnPuyAZ7XaDMlz
         W0OEgShdWlsx6wm3UGHTws/xA79SBmr1XoasWHi8Nojs3Xo3nNdXGJRxmB7SqI7TMfkd
         ozKaJ4+vetibdLlRKddX795bX2Aa4kGwFuFT9tJATjM4XjKnzEqk8uw6iTOqp+FDP+5Z
         ngo0f1dyUrFTLI4RmnDw/1NZRtKoBwx6eWXwdHLrJMWItZpAvzMf2YjUIUiQ/rqvoH39
         KesvfREXMCdAQRn3ocTBlytQwx1YeuZr7JwxGvDWL1X/mxqEd/2jGUkN0MRxM925/Kfd
         6L0w==
X-Gm-Message-State: APuU4Z9SmH/PwkhIU8j7/oB70RCLTtcQ9Ss3jGCyJo4t62Jp1Xcxqa/F
	W4ZBH7qQdX+9xQEN7A0WoZGUOQWUfNah33vDs5z5VpGfzB3GCI4EMZbXeiSkjA6kCWAe0vuKCaf
	0HI0u
X-Gm-Gg: AZFdTZePVnIhM5y0UrxL5LSDNKljZFQchTI1+rYqDIOr2VUhuQOgj4ZT2iXGLN0LHAB
	xEZYljAj5dfDSnpkOb+MMacjhDcshVXtIPlrKmQd3KzhXk2IYwz5dO1MKFrwdEWsx6gcynOfGt1
	PsJdOtpdJU6oHJZUcf9JEyvzi9CqgWtZVoD0NqXU9wkAeYQPd25q4MfU7bbPY5eN+V1lzqeg+Eo
	Rq77g9zKc7XkvpgPg3bL+zYqL8exw7b3Un+XX6tk5xWvZvWAsq0Cejp6Jq6zVHscDvwRhmsf/Wg
	3ecgi3IhxraFNRzJ9j7cBRDyWbWfLh7U3/jgCgcaYU0hCX2YHU3qETVvjXa5OdlLg+VBMSS3N37
	pVwmfwF15vBBPGEty7gPZ0KZcW9n/7gipkoAR09/QHVmUiYD/gtCrJTeWEGb+7fgFJ94+c4lW2t
	N6nRkAxfKHAYE4XGOr0TjATWeqXUtFNJtmIqfOqxVxO7Y/e3gu3DQA6qIc7gilslLFItJiT9gQN
	4+dOfRyN/EDzZt312/cLn0JF0B636FSLEPvyH7cCewaPaZ6or9kINt7uITRvkLHM/dBwHRTO+Vz
	ErPxx1ypW/4innhwOJ+Xnal+7j94r66cVkJvQnGdbcNt8qaXaHlDbW46VNSXT8UcvKob0N9Ob26
	sgQYW1aU=
X-Received: by 2002:a05:6000:4809:b0:4aa:842f:5f78 with SMTP id ffacd0b85a97d-4abb759e947mr34409206f8f.46.1795618341353;
        Wed, 25 Nov 2026 06:52:21 -0800 (PST)
Received: from ?IPV6:2a01:390:0:101:641b:80e1:c5fc:b7eb? ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm41148873f8f.21.2026.11.25.06.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 06:52:20 -0800 (PST)
Message-ID: <95e7ae51-6025-4b32-a712-7a3de01faf4f@streamunlimited.com>
Date: Wed, 25 Nov 2026 15:52:20 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/2] avrcp: Defer init until service discovery
 completes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20261124133954.4009535-1-simon.mikuda@streamunlimited.com>
 <CABBYNZL7ekOUHtuvw5e-J_b+AESLYJ5E=gABnNfjaELhBoo_Og@mail.gmail.com>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <CABBYNZL7ekOUHtuvw5e-J_b+AESLYJ5E=gABnNfjaELhBoo_Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Good point Luiz.

I have re-run all AVRCP test cases and they passed with these changes 
fine (on RPi5 with Intel BE200 chip)

BR
Simon

On 11/24/26 17:15, Luiz Augusto von Dentz wrote:
> Hi Simon,
>
> On Tue, Nov 24, 2026 at 8:40 AM Simon Mikuda
> <simon.mikuda@streamunlimited.com> wrote:
>> When the remote connects AVCTP before SDP has found its AVRCP records,
>> as iOS does on the first connection after pairing, neither controller
>> nor target is initialized and the session stays without them. Wait for
>> the service discovery with device_wait_for_svc_complete() instead.
>>
>> The remote uses the session meanwhile: iOS asks for the supported
>> events and registers for EVENT_VOLUME_CHANGED right away, and would
>> not get absolute volume otherwise. Report every supported event from
>> the start, the remote registers only those it uses, and create the
>> target when the control channel connects so these registrations are
>> kept; target_init() completes it from the SDP record. A volume
>> registration with no volume set yet starts at max volume, which
>> target_init() set only for 1.4 controllers with category 2.
>>
>> Assisted-by: Claude:claude-opus-5-5
>> ---
>>   profiles/audio/avrcp.c | 102 ++++++++++++++++++++++-------------------
>>   1 file changed, 55 insertions(+), 47 deletions(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index 2f214e982..f7c988ec0 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -252,6 +252,7 @@ struct avrcp {
>>          bool pos_changed_supported;
>>          uint8_t transaction;
>>          struct pending_pdu *pending_pdu;
>> +       unsigned int svc_complete_id;
>>   };
>>
>>   struct passthrough_handler {
>> @@ -1614,12 +1615,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>>          if (!(session->supported_events & (1 << pdu->params[0])))
>>                  goto err;
>>
>> -       if (!session->target) {
>> -               pdu->params_len = cpu_to_be16(1);
>> -               pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
>> -               return AVC_CTYPE_REJECTED;
>> -       }
>> -
>>          switch (pdu->params[0]) {
>>          case AVRCP_EVENT_STATUS_CHANGED:
>>                  len = 2;
>> @@ -1648,6 +1643,10 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>>                  len = 1;
>>                  break;
>>          case AVRCP_EVENT_VOLUME_CHANGED:
>> +               /* Start at max volume if none has been set yet */
>> +               if (media_transport_get_a2dp_volume(dev) < 0)
>> +                       media_transport_set_a2dp_volume(dev, 127);
>> +
>>                  volume = media_transport_get_a2dp_volume(dev);
>>                  if (volume < 0)
>>                          goto err;
>> @@ -4263,16 +4262,15 @@ static void session_init_browsing(struct avrcp *session)
>>                                                          destroy_browsing);
>>   }
>>
>> -static struct avrcp_data *data_init(struct avrcp *session, const char *uuid)
>> +static struct avrcp_data *data_init(struct avrcp *session,
>> +                                       struct avrcp_data *data,
>> +                                       const char *uuid)
>>   {
>> -       struct avrcp_data *data;
>>          const sdp_record_t *rec;
>>          sdp_list_t *list, *protos;
>>          sdp_profile_desc_t *desc;
>>          int port = 0;
>>
>> -       data = g_new0(struct avrcp_data, 1);
>> -
>>          rec = btd_device_get_record(session->dev, uuid);
>>          if (rec == NULL)
>>                  return data;
>> @@ -4348,14 +4346,9 @@ static void avrcp_connect_browsing(struct avrcp *session)
>>
>>   static void target_init(struct avrcp *session)
>>   {
>> -       struct avrcp_server *server = session->server;
>>          struct avrcp_data *target;
>> -       struct avrcp_player *player;
>>          struct btd_service *service;
>>
>> -       if (session->target != NULL)
>> -               return;
>> -
>>          service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
>>
>>          if (service == NULL) {
>> @@ -4363,47 +4356,22 @@ static void target_init(struct avrcp *session)
>>                  return;
>>          }
>>
>> -       target = data_init(session, AVRCP_REMOTE_UUID);
>> -       session->target = target;
>> +       target = data_init(session, session->target, AVRCP_REMOTE_UUID);
>>
>>          DBG("%p version 0x%04x", target, target->version);
>>
>>          btd_service_connecting_complete(service, 0);
>>
>> -       player = g_slist_nth_data(server->players, 0);
>> -       if (player != NULL) {
>> +       if (target->player != NULL) {
>>                  int8_t init_volume;
>> -               target->player = player;
>> -               player->sessions = g_slist_prepend(player->sessions, session);
>>
>>                  init_volume = btd_device_get_volume(session->dev);
>>                  media_transport_set_a2dp_volume(session->dev, init_volume);
>>          }
>>
>> -       session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
>> -                               (1 << AVRCP_EVENT_TRACK_CHANGED) |
>> -                               (1 << AVRCP_EVENT_TRACK_REACHED_START) |
>> -                               (1 << AVRCP_EVENT_TRACK_REACHED_END) |
>> -                               (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>> -
>>          if (target->version < 0x0104)
>>                  return;
>>
>> -       if (avrcp_volume_supported(target)) {
>> -               session->supported_events |=
>> -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
>> -               /* Check if transport volume hasn't been initialized then set it
>> -                * to max so it works properly if the controller attempts to
>> -                * subscribe to AVRCP_EVENT_VOLUME_CHANGED.
>> -                */
>> -               if (media_transport_get_a2dp_volume(session->dev) < 0)
>> -                       media_transport_set_a2dp_volume(session->dev, 127);
>> -       }
>> -
>> -       session->supported_events |=
>> -                               (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
>> -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
>> -
>>          /* Only check capabilities if controller is not supported */
>>          if (session->controller == NULL)
>>                  avrcp_get_capabilities(session);
>> @@ -4430,7 +4398,8 @@ static void controller_init(struct avrcp *session)
>>                  return;
>>          }
>>
>> -       controller = data_init(session, AVRCP_TARGET_UUID);
>> +       controller = data_init(session, g_new0(struct avrcp_data, 1),
>> +                                                       AVRCP_TARGET_UUID);
>>          session->controller = controller;
>>
>>          DBG("%p version 0x%04x", controller, controller->version);
>> @@ -4460,8 +4429,35 @@ static void controller_init(struct avrcp *session)
>>          avrcp_connect_browsing(session);
>>   }
>>
>> +static void session_svc_complete(struct btd_device *dev, int err,
>> +                                                       void *user_data)
>> +{
>> +       struct avrcp *session = user_data;
>> +
>> +       session->svc_complete_id = 0;
>> +
>> +       if (btd_device_get_service(session->dev, AVRCP_TARGET_UUID) != NULL)
>> +               controller_init(session);
>> +
>> +       if (btd_device_get_service(session->dev, AVRCP_REMOTE_UUID) != NULL)
>> +               target_init(session);
>> +}
>> +
>>   static void session_init_control(struct avrcp *session)
>>   {
>> +       struct avrcp_player *player;
>> +
>> +       /* The remote may register for events before its records are known,
>> +        * target_init() completes the target from them.
>> +        */
>> +       session->target = g_new0(struct avrcp_data, 1);
>> +
>> +       player = g_slist_nth_data(session->server->players, 0);
>> +       if (player != NULL) {
>> +               session->target->player = player;
>> +               player->sessions = g_slist_prepend(player->sessions, session);
>> +       }
>> +
>>          session->passthrough_id = avctp_register_passthrough_handler(
>>                                                          session->conn,
>>                                                          handle_passthrough,
>> @@ -4473,11 +4469,19 @@ static void session_init_control(struct avrcp *session)
>>                                                          session);
>>          session->control_handlers = control_handlers;
>>
>> -       if (btd_device_get_service(session->dev, AVRCP_TARGET_UUID) != NULL)
>> -               controller_init(session);
>> +       /* Report every event supported: the remote registers those it uses */
>> +       session->supported_events |= (1 << AVRCP_EVENT_STATUS_CHANGED) |
>> +                               (1 << AVRCP_EVENT_TRACK_CHANGED) |
>> +                               (1 << AVRCP_EVENT_TRACK_REACHED_START) |
>> +                               (1 << AVRCP_EVENT_TRACK_REACHED_END) |
>> +                               (1 << AVRCP_EVENT_SETTINGS_CHANGED) |
>> +                               (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
>> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
>> +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> So this seems to disregard what version we are operating on so we
> don't foresee any problems with sessions getting unknown event bits
> being set? I guess we can only do that if we are absolutely sure
> PTS/Qualification will never ever be updated to check bits considered
> RFU (e.g 1.3).
>
>> -       if (btd_device_get_service(session->dev, AVRCP_REMOTE_UUID) != NULL)
>> -               target_init(session);
>> +       session->svc_complete_id = device_wait_for_svc_complete(session->dev,
>> +                                                       session_svc_complete,
>> +                                                       session);
>>   }
>>
>>   static void controller_destroy(struct avrcp *session)
>> @@ -4513,6 +4517,10 @@ static void session_destroy(struct avrcp *session, int err)
>>
>>          session_abort_pending_pdu(session);
>>
>> +       if (session->svc_complete_id)
>> +               device_remove_svc_complete_callback(session->dev,
>> +                                               session->svc_complete_id);
>> +
>>          service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
>>          if (service != NULL) {
>>                  if (session->control_id == 0)
>>
>> base-commit: 1608f836188610aabeff5a3164169ebe0360e443
>> --
>> 2.43.0
>>
>>
>
