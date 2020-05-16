Return-Path: <SRS0=p+wm=66=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7671C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 07:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B0C207D3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 16 May 2020 07:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnYEjNde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgEPHu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 16 May 2020 03:50:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgEPHu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 16 May 2020 03:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589615425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=pRwEis0UIltbYbwyabkgbYYLWsH6df9ctVjQ/g2IrIE=;
        b=gnYEjNdeR7ubtX3gX7z8iL0fqcuydHWTNID369pr6Gjo3Gb1Mg+QIEBsQGDFx3y1Wnxpzc
        Ye6dZUQyKvCEIxUokpUOSgdUJzc366EX/UE7wefK8Ab43jPT0Vu/qu9rwMfJT7iM5aOLHw
        XiTW3TvK5wBgfiPm6TC23XGywtO1MCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Nur9dp4vMgaPuFww5K3nHw-1; Sat, 16 May 2020 03:50:21 -0400
X-MC-Unique: Nur9dp4vMgaPuFww5K3nHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26A511009442;
        Sat, 16 May 2020 07:50:19 +0000 (UTC)
Received: from [10.40.192.25] (unknown [10.40.192.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A403F63B8B;
        Sat, 16 May 2020 07:50:15 +0000 (UTC)
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andrew Fuller <mactalla.obair@gmail.com>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        David Heidelberg <david@ixit.cz>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
References: <B6A143FD-717D-44F9-B62F-17CF357961A1@holtmann.org>
 <20200219120940.1509224-1-david@ixit.cz>
 <20200419234937.4zozkqgpt557m3o6@pali>
 <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
 <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
 <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
From:   Aleksandar Kostadinov <akostadi@redhat.com>
Autocrypt: addr=akostadi@redhat.com; prefer-encrypt=mutual; keydata=
 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
 i7qb30Fmhn6zUp82N7PZMQ==
Organization: Red Hat
Message-ID: <b90424be-115e-4a4a-a4fd-a6d0208d13d5@redhat.com>
Date:   Sat, 16 May 2020 10:50:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz Augusto von Dentz wrote on 16.05.20 г. 2:08 ч.:
> Hi Andrew, Aleksandar,
> 
> On Fri, May 15, 2020 at 3:46 PM Andrew Fuller <mactalla.obair@gmail.com> wrote:
>>
>> On Thu, 14 May 2020 at 13:09, Aleksandar Kostadinov <akostadi@redhat.com> wrote:
>>>
>>> Pali Rohár wrote on 20.04.20 г. 2:49 ч.:
>>> <...>
>>>> Please let me know what do you think about it. Thanks
>>>
>>> <...>
>>> Thus I and I assume all headphones users will appreciate very much any
>>> support to get things moving forward.
>>
>> To add to what Aleksandar said, a number of us would be more than
>> willing to help out in any way we can.  Certainly myself, but I expect
>> a number of others, too.  We have bluetooth cards in our computers
>> with wideband speech support.  We have bluetooth headsets with
>> wideband speech support.  Many of the links in the chain are in place.
>> If we can continue building that chain then we can have a higher
>> quality experience in this era of teleconferencing in particular.
>>
>> So if there's anything we can lend a hand with, then please let us
>> know and we can see this through.
> 
> Just to be clear here, WBS is already supported what is not supported
> is hardware based codecs, we spend a lot of time enabling WBS on oFono
> but it looks like people are now trying to come with their own
> solutions and complaining about lack of WBS is not really justified
> since the combination of BlueZ + oFono has been in use by the car
> industry for years but desktop folks has not been interested in a
> proper HFP solution so instead we have modem manager, network manager,
> etc, which doesn't even cover all desktop use cases properly as you
> are experience first hand here.

Hi Luiz. I'm not sure arguing on no-technical details here will help.
Still I feel it is important to say that I don't find it justified to
call it *complaining* when somebody is proposing patches which
apparently enable missing functionality and avoid necessity for running
with root privileges.

Now if patch is bad on the technical level, that would be valid point to
reject it. I see Pali trying to address any raised concerns though so I
hope it is alright.

But rejecting the patches on premises that it is not necessary for
solution X and blocking any alternative solutions is IMO unfair.

The needs of car industry are very different from the needs of desktop
users. I'm not a kernel or bluetooth developer but as a user of Network
Manager (that you gave as an example) I can say that it changed a lot
making network management at single point and changing networks easily
while moving around. I've been a network admin in the past and it has
not been a problem to only use static network setup. As a laptop user
though things dramatically changed.

Same goes with Pulse audio/ALSA. While everything could be done with
ALSA it has been much harder and up to the skills of a very few people
to manage audio inputs/outputs/redirection properly. Certainly since
Pulse became stable I never missed asoundrc.

Thus for users it is important what desktop developers are providing.
While we can assume they are all idiots doing things in all the wrong
ways, I'd rather prefer to think they may have a point when choosing
certain technology over another.

So I'm asking anybody that it depends on, to look from the desktop user
perspective and help move this forward.

Thank you.

