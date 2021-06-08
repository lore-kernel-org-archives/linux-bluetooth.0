Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F7C4743E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 09:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1E5F61008
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 09:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhFHJwH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFHJwE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 05:52:04 -0400
X-Greylist: delayed 39788 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Jun 2021 02:50:09 PDT
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A42C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jun 2021 02:50:09 -0700 (PDT)
Received: from [10.0.20.3] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E17791F539;
        Tue,  8 Jun 2021 11:50:06 +0200 (CEST)
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress
 one.
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
 <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org>
 <CABBYNZLXRK9TN_TKdj5T7oP3D_HaeQiBsaCaRtE7nAK9hYuh-w@mail.gmail.com>
From:   Marijn Suijten <marijn.suijten@somainline.org>
Message-ID: <f3e18adc-b1ad-2ab5-164e-43a1ae20f708@somainline.org>
Date:   Tue, 8 Jun 2021 11:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZLXRK9TN_TKdj5T7oP3D_HaeQiBsaCaRtE7nAK9hYuh-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 6/8/21 1:47 AM, Luiz Augusto von Dentz wrote:
> Hi Marijn,
> 
[..]
>> We've been running into a similar issue with PulseAudio.  There is no
>> way to track a Set call for the Volume property back to the
>> property-change notification, running into both jitter on quick
>> successive volume changes and the inability to reflect peer hardware
>> volume in case the peer rounds the requested volume to a coarser scale.
>>    This rounded value is supposedly returned from SetAbsoluteVolume
>> according to AVRCP spec 1.6.2, section 6.13.2:
>>
>>      The volume level which has actually been set on the TG is returned in
>>      the response.
>>
>> I would have proposed a new DBUS function SetAbsoluteVolume that accepts
>> volume as sole argument, blocks until the peer replies, and returns the
>> actual volume as per its namesake AVRCP command.  This should address
>> both issues.
>>
>> Note that it is also impossible to distinguish Volume property changes
>> from an action invoked on the peer (ie. the user pressing physical
>> buttons or using a volume slider on headphones) or the result of an
>> earlier Set(Volume) call as these to my knowledge all happen async, may
>> be intertwined, may involve rounding (on the peer) to make the resulting
>> number different, etc.
> 
> Yep, the volume may actually be rounded like you said, so Im not
> really sure how we can queue because we will not be able to verify the
> volume has been set properly, we could do a blocking call even in case
> of setting as a property we only need to delay the call to
> g_dbus_pending_property_success until we actually receive a response,
> that said there maybe some impact on the user experience since if you
> have the volume implemented with something like a slider it will not
> move smoothly anymore, but I guess that is better than have it
> flipping back and forth, well except that can still happens because
> the volume can be changed on the device in the meantime but I guess
> the client wont see those changes until the method returns if it is
> blocking waiting for the reply, which means it will only see that the
> value flipped to something else later when the signals are dispatched.


The main use-case is software volume compensation for devices with 
limited granularity, for which we need to know exactly what is replied 
to AVRCP's SetAbsoluteVolume call.  Delaying 
g_dbus_pending_property_success will only block the call longer but 
won't exactly let us know the resulting value.  We can immediately Get 
the new property after (or try and relate the change notification to 
it), but there's nothing preventing a change on the device intervening. 
  In that case we should discard requested volume (on the host) and 
software compensation, and take/display device volume as-is.
This seems unfortunate as the AVRCP spec provides exactly the 
consistency we're looking for here.

As for user experience it seems acceptable to make such a call block 
until the peer replies, if only for a much more predictable API.  It is 
then up to the caller (ie. PulseAudio) to deal with that by 
disabling/blocking the slider, or scheduling the most recent volume 
update to be sent as soon as a reply is received (the DBus call returns).

> 
> If you feel like that is acceptable I'm happy to review any patches in
> that direction.
> 

[..]

> --
> Luiz Augusto von Dentz
- Marijn
