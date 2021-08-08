Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC631C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Aug 2021 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23B060E9B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Aug 2021 10:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhHHKYV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Aug 2021 06:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhHHKYT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Aug 2021 06:24:19 -0400
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Aug 2021 03:24:01 PDT
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C9C061760
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 Aug 2021 03:24:00 -0700 (PDT)
Received: from [10.0.20.3] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5A6861F4B6;
        Sun,  8 Aug 2021 12:15:29 +0200 (CEST)
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress
 one.
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
 <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org>
 <CABBYNZLXRK9TN_TKdj5T7oP3D_HaeQiBsaCaRtE7nAK9hYuh-w@mail.gmail.com>
 <f3e18adc-b1ad-2ab5-164e-43a1ae20f708@somainline.org>
 <CAO271mkpy5W0KB60X5G1mwp92bB+K2Ru3ODP8K2APCkjfkX70w@mail.gmail.com>
From:   Marijn Suijten <marijn.suijten@somainline.org>
Message-ID: <391e3587-bb19-05be-cc36-08a8c91916de@somainline.org>
Date:   Sun, 8 Aug 2021 12:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAO271mkpy5W0KB60X5G1mwp92bB+K2Ru3ODP8K2APCkjfkX70w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On 6/8/21 8:37 PM, Sonny Sasaka wrote:
> Hi Marijn,
> 
> Thanks for your inputs. Having a separate SetAbsoluteVolume API that
> blocks (until the peer acknowledges the change) is certainly more
> featureful than this patch's approach, since the media player can
> decide what to do with pending SetAbsoluteVolume calls and have the
> flexibility to handle the situation. However, there is also a value in
> the shorter term approach that this patch without any changes in the
> media player part and has been tested to solve the janky slider issue
> in Chrome OS. I believe that this would also solve PulseAudio's
> similar janky slider issue for the short term.
> 
> If Marijn and Luiz are okay with the shorter term approach first, I
> will continue updating this patch according to Luiz's comments, but
> otherwise I will abandon this patch in favor of the separate
> SetAbsoluteVolume API that Marijn will provide.


With no acknowledgement from Luiz yet I've gone ahead and added an 
experimental `uint16 SetVolume(uint16)` call to "MediaTransport1" to 
start testing this behaviour. You can find the commits here:

https://github.com/MarijnS95/bluez/commits/master

This has only been tested with dbus-send, the PA changes still have to 
be written.  Given the original review on Sonny's patches we might want 
to replace the allocation with `pending` members on the session instead, 
so that we can possibly do some debouncing if multiple .Set calls 
arrive.  Seems like we need three members then:

volume: 	current known volume between BlueZ and the peer.
pending_volume: an active AVRCP SetAbsoluteVolume call is in progress
		with this value.  Though this could also be a non-null
		DBusMessage *volume_reply; as we don't need the
		requested volume anymore.
next_volume:	a client already queued a new value through .Set, while
		SetAbsoluteVolume (pending_volume != -1) is still in
		flight.

While putting this together I noticed that manually calling `.Set 
"MediaTransport1" "Volume" XX` doesn't notify other applications.  What 
happens is that `a2dp->volume` is set to the actual volume (in 
set_volume), and no "PropertiesChanged" is emitted unless we're in 
"notify" mode ("we are the headphones").  Then, as soon as the peer 
replies (avrcp_handle_set_volume, media_transport_update_device_volume, 
media_transport_update_volume) we see that `a2dp->volume == volume` and 
never emit "PropertiesChanged" either, leaving all other clients unaware 
of the change.

This seems simply addressed by not setting `a2dp->volume` set_volume() 
and instead rely on that to happen in avrcp_handle_set_volume, just like 
I'm doing in the handler for this new SetVolume function.
That might already solve your problem in CrOS, by simply waiting for a 
property change notification before sending the next volume change.  We 
however won't be able to distinguish it from a button-press on the 
headphones by the user, but I'm not entirely sure anymore if that's 
still needed.

Marijn

PS: Since these messages seem to come through, Luiz have you received my 
patch to address AVRCP Absolute Volume missing when connected to Android 
phones?
