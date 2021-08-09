Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD2C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F33960E9B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhHIU0j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhHIU0i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 16:26:38 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B465C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 13:26:17 -0700 (PDT)
Received: from [10.0.20.3] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 30DA11F73A;
        Mon,  9 Aug 2021 22:26:12 +0200 (CEST)
Subject: Re: [PATCH BlueZ] audio/transport: Only store volume when also
 emitting DBus prop change
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
References: <20210808143555.100258-1-marijn.suijten@somainline.org>
 <CABBYNZK9Hsf3zL7t62hnOkF1hm=UZNvVj_SQDx2Hxj7d0sB0sA@mail.gmail.com>
From:   Marijn Suijten <marijn.suijten@somainline.org>
Message-ID: <f681b6d4-2a84-28cd-e779-268b0a5b32eb@somainline.org>
Date:   Mon, 9 Aug 2021 22:26:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZK9Hsf3zL7t62hnOkF1hm=UZNvVj_SQDx2Hxj7d0sB0sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 8/9/21 8:37 PM, Luiz Augusto von Dentz wrote:
> Hi Marijn,
> 
> On Sun, Aug 8, 2021 at 7:35 AM Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
>>
>> By setting a2dp->volume early in set_volume() the resulting call to
>> media_transport_update_volume() when an AVRCP reply is received will
>> likely see the same volume received (unless the peer rounded it to
>> another value) and bail on equality, before emitting a DBus property
>> change.  This results in DBus clients not being made aware of the change
>> unless the peer is an audio source (that receives a notification about
>> changed volume, instead of a command to _set_ a new volume), where
>> set_volume() immediately raises the DBus signal.
>>
>> This issue is observed when playing back audio to headphones through an
>> AbsoluteVolume-enabled audio server like PulseAudio, which does not
>> receive the "Volume" change (while the peer does change volume) when
>> setting this property externally using ie. dbus-send.
> 
> Have you confirmed this works with the likes of PulseAudio, afaik
> there was some problem when introducing this because the event may
> cause a double change on the volume so the server needs to be able to
> handle the volume == local volume, anyway if the headset rounds and
> the values doesn't match I guess the server will need to be smart
> enough to not trigger another volume change otherwise it could cause a
> loop where the server request x but the headset rounds to y over and
> over.


Thank you for your concerns.  I as the author of AVRCP Absolute Volume 
support in PulseAudio made sure to insert these equality checks against 
the last known Absolute Volume value (separate from user-visible volume 
managed by PA), both when Volume is received from the peer:

https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/blob/1a575bb0a708bc455e977629cb99412551867982/src/modules/bluetooth/bluez5-util.c#L614-621

And when sending a new Volume back:

https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/blob/1a575bb0a708bc455e977629cb99412551867982/src/modules/bluetooth/bluez5-util.c#L554-557

These together make it impossible to call ".Set" on a value that is 
identical to the last value received through the "PropertiesChanged" 
signal.  It was made this way to prevent round-trips in the first place, 
as receiving a Volume change and applying it to PA's sink/source would 
also trigger the "volume changed" handler.  Even if the peer decides to 
reply with Volume-1 for every request, there will still be no round-trip.

> If the server never reacts if volume != local volume and instead
> just updates the local volume, which is probably the behavior we want,
> then I should be safe to apply this change.
That is exactly what happens because PA cannot distinguish between 
replies to SetAbsoluteVolume and the ABSOLUTE_VOLUME_CHANGED 
notification caused by button presses, when just looking at the Volume 
property.

Finally, I don't know what PipeWire does.  Someone will have to look 
through the codebase and confirm that it performs the same checks, or 
loop in one of the authors in cc to confirm.  Sonny from CrOS is already 
included to make sure this doesn't break anything on their end.

> 
>> ---
>>   profiles/audio/transport.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
>> index 8248014ae..d158fc97a 100644
>> --- a/profiles/audio/transport.c
>> +++ b/profiles/audio/transport.c
>> @@ -659,14 +659,14 @@ static void set_volume(const GDBusPropertyTable *property,
>>          if (a2dp->volume == volume)
>>                  return;
>>
>> -       a2dp->volume = volume;
>> -
>>          notify = transport->source_watch ? true : false;
>> -       if (notify)
>> +       if (notify) {
>> +               a2dp->volume = volume;
>>                  g_dbus_emit_property_changed(btd_get_dbus_connection(),
>>                                                  transport->path,
>>                                                  MEDIA_TRANSPORT_INTERFACE,
>>                                                  "Volume");
>> +       }
>>
>>          avrcp_set_volume(transport->device, volume, notify);
>>          return;
>> --
>> 2.32.0
>>
> 
> 

Marijn
