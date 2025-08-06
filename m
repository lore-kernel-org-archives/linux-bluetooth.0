Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397C5CDF1
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441454; cv=none; b=Q5Ldh1LiVMkWTL8CqB0BxWLA0i1TYCE4gOywdZoIfuNnKr3cKlJmEIr16wrdsEdPMvRBdr6+V/Hrm6nZ55GpMnNbNM/i6gxyTs5TEeaIZQ/9DAceIZQHE6g521oh6TQC/7HVEw5pj/1fnu9xMNqCEpFmGhKZowqgwPhNdUSIF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441454; c=relaxed/simple;
	bh=FW9MvDbDZkWMJHWNqAcTI7fSpRvTs8I3nyL0XLP22/o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ljYIXr2PtKSm4fAT/LUzmStIeHE52wxRkgPps24Mfr4/OAwxoPlEj5FX0ICXpOrYdJ7NQxyWPAC4WmJqjCh0V+oLyllTL9KAG+sf55utJGIvdagp/SBytT5/+/5bz0O0urRA1mii3d8HrMjXXJHl40r04l53Fh38jE8Gyu7d7Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=W//jZtkf; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="W//jZtkf"
Message-ID: <97f834ea-aaeb-42ee-8f6a-5a39e6bec0cf@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1754441450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrAgKBerlhcmLDMjnnR2xMuidcMxlbaYEuk3eQgX43U=;
	b=W//jZtkffWqkmLqsSVXg5BqCVkr10nIi0wdpsbAYBcCk1VZb6p6OraE5sEd5/D0uLjo9i1
	OSfEnoP8Zv4qipRHhq62pMn9G7ntWLzC5kSPqNa7JWgm/LOes6d2ISnUCDNFz24U76GRAU
	xY8xz7GsYkuZ9Fc4g/A2ULAmiXj6zOvf99Ao0hp/cNgK9UZDD7KGE/3ODfsH/vthKg9HSv
	DLAeJXKghdl3GpAF/dZwFUDeTI2an2RnDL+N866x7zheusIgJDsQAP1bW8LUHqH1CcVi3v
	Tsi2nHhoCWWRdHSFO53zr1enjmQ0g+UOVvbPaQ34g4Woj/INNAIIA8Ax4lqL4w==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Wed, 6 Aug 2025 07:50:46 +0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
Subject: Re: [PATCH bluez] audio: Don't initialize device volume from media
 player
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250805-audio-no-reuse-media-player-volume-v1-1-c9fdfaf74a71@qtmlabs.xyz>
 <CABBYNZJ=Kc_WMa2Srnci=20e+F+JZyPmWFXsjxt8sn_6g0coKQ@mail.gmail.com>
 <8e903ca0-aeb3-46c2-8da3-95173cb482e5@qtmlabs.xyz>
 <CABBYNZK+vMXgv6OZuCKABqFE+1Y0kojqd2d0EkhJ-3UFVnUq4w@mail.gmail.com>
 <961c1bd3-f829-4221-af36-07a343086483@qtmlabs.xyz>
Content-Language: en-US
In-Reply-To: <961c1bd3-f829-4221-af36-07a343086483@qtmlabs.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ---


On 8/5/25 23:08, Myrrh Periwinkle wrote:
> Hi,
>
> On 8/5/25 23:01, Luiz Augusto von Dentz wrote:
>> Hi Myrrh,
>>
>> On Tue, Aug 5, 2025 at 11:34 AM Myrrh Periwinkle
>> <myrrhperiwinkle@qtmlabs.xyz> wrote:
>>> Resent because I forgot to use "Reply All"
>>>
>>> On 8/5/25 22:24, Luiz Augusto von Dentz wrote:
>>>> Hi Myrrh,
>>>>
>>>> On Tue, Aug 5, 2025 at 6:29 AM Myrrh Periwinkle
>>>> <myrrhperiwinkle@qtmlabs.xyz> wrote:
>>>>> Media player objects may be shared between devices. As a result,
>>>>> a device without support for hardware volume that is connected 
>>>>> after one
>>>>> that does may end up being erroneously considered hardware
>>>>> volume-capable.
>>>> Don't quite follow, avrcp_player is per device, not sure how it can be
>>>> shared between devices?
>>>>
>>>>> fa7828bdd ("transport: Fix not being able to initialize volume 
>>>>> properly")
>>>>> introduced btd_device_{get,set}_volume that is used as an 
>>>>> alternative in
>>>>> case no media player objects are present. Therefore, we can remove
>>>>> media_player_get_device_volume and instead use 
>>>>> btd_device_get_volume to
>>>>> determine the initial volume.
>>>> Don't follow you here, why shouldn;t we use the media player if we 
>>>> have one?
>>>>
>>>>> ---
>>>>>    profiles/audio/avrcp.c |  2 +-
>>>>>    profiles/audio/media.c | 33 +--------------------------------
>>>>>    profiles/audio/media.h |  1 -
>>>>>    3 files changed, 2 insertions(+), 34 deletions(-)
>>>>>
>>>>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>>>>> index 
>>>>> e2797112fcd580c3fc56793f933e00b1c61e5205..ec07522e6a34eb1dc5f6f413f48f1087a609df9a 
>>>>> 100644
>>>>> --- a/profiles/audio/avrcp.c
>>>>> +++ b/profiles/audio/avrcp.c
>>>>> @@ -4284,7 +4284,7 @@ static void target_init(struct avrcp *session)
>>>>>                   target->player = player;
>>>>>                   player->sessions = 
>>>>> g_slist_prepend(player->sessions, session);
>>>>>
>>>>> -               init_volume = 
>>>>> media_player_get_device_volume(session->dev);
>>>>> +               init_volume = btd_device_get_volume(session->dev);
>>>>> media_transport_update_device_volume(session->dev, init_volume);
>>>>>           }
>>>>>
>>>>> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
>>>>> index 
>>>>> 8e62dca17070edbc5101677c6eebd3707492c824..55f1482d1d9ce52e104481bab3ede373f47aee0c 
>>>>> 100644
>>>>> --- a/profiles/audio/media.c
>>>>> +++ b/profiles/audio/media.c
>>>>> @@ -499,37 +499,6 @@ struct a2dp_config_data {
>>>>>           a2dp_endpoint_config_t cb;
>>>>>    };
>>>>>
>>>>> -int8_t media_player_get_device_volume(struct btd_device *device)
>>>>> -{
>>>>> -#ifdef HAVE_AVRCP
>>>>> -       struct avrcp_player *target_player;
>>>>> -       struct media_adapter *adapter;
>>>>> -       GSList *l;
>>>>> -
>>>>> -       if (!device)
>>>>> -               return -1;
>>>>> -
>>>>> -       target_player = avrcp_get_target_player_by_device(device);
>>>>> -       if (!target_player)
>>>>> -               goto done;
>>>>> -
>>>>> -       adapter = find_adapter(device);
>>>>> -       if (!adapter)
>>>>> -               goto done;
>>>>> -
>>>>> -       for (l = adapter->players; l; l = l->next) {
>>>>> -               struct media_player *mp = l->data;
>>>>> -
>>>>> -               if (mp->player == target_player)
>>>>> -                       return mp->volume;
>>> The `avrcp_player` object indeed is not shared between devices, but the
>>> volume is acquired from (and set for) the associated `media_player`
>>> object which is not tied to a specific device, and corresponds to 
>>> client
>>> `org.mpris.MediaPlayer2.Player` objects.
>> Ok, so what is the problem with that? If there are 2 headsets that
>> wants to control the same player registered via mpris-proxy(?) that
>> should be allowed, or the problem is that each device should control a
>> dedicated instance of the volume? I suspect the volume store in
>> mp->volume is only used as initial volume since the actual volume is
>
> I searched the codebase for all usages of `mp->volume` and seems like 
> this is solely used as a temporary storage for the initial volume. 
> This usage was first introduced in 
> 4b6153b0501cf18812cb869c2320c41e51f81adc and the field itself was 
> introduced in a282fff97dabbd3a814765a868e3367cb3dc1ce3 (with unclear 
> purposes).
>
>> stored in the Transport.Volume, the reason why we can't use the
>> Transport directly is that it is created on demand while there is a
>> stream so if the stream is not ready at time a volume has been set we
>> need to store it elsewhere, that said perhaps that should be store per
>> device not per media_player which seem to be registered per adapter in
>> media.c but then we should probably remove the volume field altogether
>> to avoid any confusion in the future.

For some additional context: This issue only started happening when I 
started using mpris-proxy. Without mpris-proxy the device without 
hardware volume support is always recognized as such. What I believe is 
happening is that the volume for the first device with hardware volume 
support is set on the media_player object which is then used as the 
initial volume for the second device that doesn't have hardware volume.

I will soon send a v2 that removes the media_player.volume field 
entirely since it doesn't appear to be used for anything else.

>>
>>>>> -       }
>>>>> -
>>>>> -done:
>>>>> -#endif /* HAVE_AVRCP */
>>>>> -       /* If media_player doesn't exists use device_volume */
>>>>> -       return btd_device_get_volume(device);
>>>>> -}
>>>>> -
>>>>>    static gboolean set_configuration(struct media_endpoint *endpoint,
>>>>>                                           uint8_t *configuration, 
>>>>> size_t size,
>>>>> media_endpoint_cb_t cb,
>>>>> @@ -556,7 +525,7 @@ static gboolean set_configuration(struct 
>>>>> media_endpoint *endpoint,
>>>>>           if (transport == NULL)
>>>>>                   return FALSE;
>>>>>
>>>>> -       init_volume = media_player_get_device_volume(device);
>>>>> +       init_volume = btd_device_get_volume(device);
>>>>>           media_transport_update_volume(transport, init_volume);
>>>>>
>>>>>           msg = dbus_message_new_method_call(endpoint->sender, 
>>>>> endpoint->path,
>>>>> diff --git a/profiles/audio/media.h b/profiles/audio/media.h
>>>>> index 
>>>>> 2b2e8e1572874d5f71abb28fdd5b92fa2d9efe83..d3954abd6de505a69cab3fcffc217d236a52d3e5 
>>>>> 100644
>>>>> --- a/profiles/audio/media.h
>>>>> +++ b/profiles/audio/media.h
>>>>> @@ -23,6 +23,5 @@ uint8_t media_endpoint_get_codec(struct 
>>>>> media_endpoint *endpoint);
>>>>>    struct btd_adapter *media_endpoint_get_btd_adapter(
>>>>>                                           struct media_endpoint 
>>>>> *endpoint);
>>>>>    bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
>>>>> -int8_t media_player_get_device_volume(struct btd_device *device);
>>>>>
>>>>>    const struct media_endpoint *media_endpoint_get_asha(void);
>>>>>
>>>>> ---
>>>>> base-commit: 2c0c323d08357a4ff3065fcd49fee0c83b5835cd
>>>>> change-id: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a
>>>>>
>>>>> Best regards,
>>>>> -- 
>>>>> Myrrh Periwinkle<myrrhperiwinkle@qtmlabs.xyz>
>>>>>
>>>>>
> -Myrrh

-Myrrh

