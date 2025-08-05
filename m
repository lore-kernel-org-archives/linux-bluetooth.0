Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC183CD1
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408090; cv=none; b=J5cDgy9YfSSGXjgwWZ/DGww23KMWDHJ5QiRqataUKLrU+Y7ZROHxnLnIIOJH3gYX4XANUGkLzKcmHE14RBU6IXk88lHNZgFmT5IvZFWiPouysSXGZ85Arvkqqo82NCeybM0rwbFlZyphwv1RmUbUhnogKh+6ZBlRxekjJPDXmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408090; c=relaxed/simple;
	bh=KxdxPfxpbkeLUrJicmEF0xfEe7HzoKI3mk0sFki1skI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cyHBQ8oWhjG+tdvF4wbgJz9nkjqy8YgdUSrcDLOXEkzplWWYdEWkQYVxzZH2ckVBOSggyGF7Edc41eAjI1pooNL4ptVTNaV7hAJ28/DQc3VBl88BQy2M610MxBsIIQxZYHxuv/wcP50N81Fh38wVydjEq+ZQrf+9RL41lR5hcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=Gak0wNT8; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="Gak0wNT8"
Message-ID: <8e903ca0-aeb3-46c2-8da3-95173cb482e5@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1754408086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3N8XVQSQwxqKCggIFm+XDkpikdWkHg3QoGf3GIYvjo=;
	b=Gak0wNT8lZVilj0/UxXp9QQ1oAYRgfiD2ok1/jzguDHk0BeVRogrtgXNmI/9r+eRlqxuqZ
	EqpkgasgN946bD7nYE/RPflygJWbOqN+g0Pyp6wXP9ahb7MBiF4VXmLpRJ4AKY4Vcd2IuU
	8gktZ6RbCneYOoXoiTvBWPW5yXw+eWxkhnWIegOGvZ82r0rckGWa70eX1ZxOGp0lXXwcoU
	v+sgXX/PCEwDVYlXS4B3O69/cHc8YC5QdkQ5uf1h8d8Ybjqs97ps7xTKWN5uT0l3D3HjFC
	C+MG6EZASsfvYKlfaQKZIfaGMT6ANMDxYHebG1oZpIEJtUbeFMgTNxqF1cJ9iw==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Tue, 5 Aug 2025 22:34:43 +0700
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
Content-Language: en-US
In-Reply-To: <CABBYNZJ=Kc_WMa2Srnci=20e+F+JZyPmWFXsjxt8sn_6g0coKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ---

Resent because I forgot to use "Reply All"

On 8/5/25 22:24, Luiz Augusto von Dentz wrote:
> Hi Myrrh,
>
> On Tue, Aug 5, 2025 at 6:29 AM Myrrh Periwinkle
> <myrrhperiwinkle@qtmlabs.xyz> wrote:
>> Media player objects may be shared between devices. As a result,
>> a device without support for hardware volume that is connected after one
>> that does may end up being erroneously considered hardware
>> volume-capable.
> Don't quite follow, avrcp_player is per device, not sure how it can be
> shared between devices?
>
>> fa7828bdd ("transport: Fix not being able to initialize volume properly")
>> introduced btd_device_{get,set}_volume that is used as an alternative in
>> case no media player objects are present. Therefore, we can remove
>> media_player_get_device_volume and instead use btd_device_get_volume to
>> determine the initial volume.
> Don't follow you here, why shouldn;t we use the media player if we have one?
>
>> ---
>>   profiles/audio/avrcp.c |  2 +-
>>   profiles/audio/media.c | 33 +--------------------------------
>>   profiles/audio/media.h |  1 -
>>   3 files changed, 2 insertions(+), 34 deletions(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index e2797112fcd580c3fc56793f933e00b1c61e5205..ec07522e6a34eb1dc5f6f413f48f1087a609df9a 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -4284,7 +4284,7 @@ static void target_init(struct avrcp *session)
>>                  target->player = player;
>>                  player->sessions = g_slist_prepend(player->sessions, session);
>>
>> -               init_volume = media_player_get_device_volume(session->dev);
>> +               init_volume = btd_device_get_volume(session->dev);
>>                  media_transport_update_device_volume(session->dev, init_volume);
>>          }
>>
>> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
>> index 8e62dca17070edbc5101677c6eebd3707492c824..55f1482d1d9ce52e104481bab3ede373f47aee0c 100644
>> --- a/profiles/audio/media.c
>> +++ b/profiles/audio/media.c
>> @@ -499,37 +499,6 @@ struct a2dp_config_data {
>>          a2dp_endpoint_config_t cb;
>>   };
>>
>> -int8_t media_player_get_device_volume(struct btd_device *device)
>> -{
>> -#ifdef HAVE_AVRCP
>> -       struct avrcp_player *target_player;
>> -       struct media_adapter *adapter;
>> -       GSList *l;
>> -
>> -       if (!device)
>> -               return -1;
>> -
>> -       target_player = avrcp_get_target_player_by_device(device);
>> -       if (!target_player)
>> -               goto done;
>> -
>> -       adapter = find_adapter(device);
>> -       if (!adapter)
>> -               goto done;
>> -
>> -       for (l = adapter->players; l; l = l->next) {
>> -               struct media_player *mp = l->data;
>> -
>> -               if (mp->player == target_player)
>> -                       return mp->volume;
The `avrcp_player` object indeed is not shared between devices, but the 
volume is acquired from (and set for) the associated `media_player` 
object which is not tied to a specific device, and corresponds to client 
`org.mpris.MediaPlayer2.Player` objects.
>> -       }
>> -
>> -done:
>> -#endif /* HAVE_AVRCP */
>> -       /* If media_player doesn't exists use device_volume */
>> -       return btd_device_get_volume(device);
>> -}
>> -
>>   static gboolean set_configuration(struct media_endpoint *endpoint,
>>                                          uint8_t *configuration, size_t size,
>>                                          media_endpoint_cb_t cb,
>> @@ -556,7 +525,7 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
>>          if (transport == NULL)
>>                  return FALSE;
>>
>> -       init_volume = media_player_get_device_volume(device);
>> +       init_volume = btd_device_get_volume(device);
>>          media_transport_update_volume(transport, init_volume);
>>
>>          msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
>> diff --git a/profiles/audio/media.h b/profiles/audio/media.h
>> index 2b2e8e1572874d5f71abb28fdd5b92fa2d9efe83..d3954abd6de505a69cab3fcffc217d236a52d3e5 100644
>> --- a/profiles/audio/media.h
>> +++ b/profiles/audio/media.h
>> @@ -23,6 +23,5 @@ uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
>>   struct btd_adapter *media_endpoint_get_btd_adapter(
>>                                          struct media_endpoint *endpoint);
>>   bool media_endpoint_is_broadcast(struct media_endpoint *endpoint);
>> -int8_t media_player_get_device_volume(struct btd_device *device);
>>
>>   const struct media_endpoint *media_endpoint_get_asha(void);
>>
>> ---
>> base-commit: 2c0c323d08357a4ff3065fcd49fee0c83b5835cd
>> change-id: 20250805-audio-no-reuse-media-player-volume-fbc2983a287a
>>
>> Best regards,
>> --
>> Myrrh Periwinkle<myrrhperiwinkle@qtmlabs.xyz>
>>
>>
