Return-Path: <SRS0=8ZYm=YJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF19CFA372A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFE321A49
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Oct 2019 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436655AbfJPS5J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:57:09 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34857 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436651AbfJPS5J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Oct 2019 14:57:09 -0400
Received: from surfer-172-29-2-69-hotspot.internet-for-guests.com (p578ac27a.dip0.t-ipconnect.de [87.138.194.122])
        by mail.holtmann.org (Postfix) with ESMTPSA id E5354CECDD;
        Wed, 16 Oct 2019 21:06:05 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: Is BT_VOICE_TRANSPARENT correctly defined?
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191014110704.l4xbyxrb2dgnk6jq@pali>
Date:   Wed, 16 Oct 2019 20:57:06 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <58BC6344-A2F9-4CAB-AD36-DCA87A7510E9@holtmann.org>
References: <20190519101854.2ygwxeqbixappks4@pali>
 <20190607125916.wswblh5nxrx7hapm@pali>
 <CABBYNZ+JPvvk1eACkp+cM9MtDZq+M78QLAtFcq-qrhR+8DsjnA@mail.gmail.com>
 <20190607152915.5m2z3gwvlkivr3ms@pali> <20191014110704.l4xbyxrb2dgnk6jq@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

>>>>> Now I'm looking at BT_VOICE_TRANSPARENT definition which comes from file
>>>>> include/net/bluetooth/bluetooth.h and it has value 0x0003. It is really
>>>>> correct? Because it means following format:
>>>>> 
>>>>>  Linear Coding, 8-bit without padding bits, 1's complement
>>>>> 
>>>>> I think that usage of 1's complement is not easy as there is no C type
>>>>> which matches it. Should not it be 2's complement or rather Unsigned
>>>>> type?
>>>>> 
>>>>> Seems that main usage of BT_VOICE_TRANSPARENT is mSBC codec and I doubt
>>>>> that it uses 1's complement signed format (specially as it should be
>>>>> modification of SBC codec which encode bytes as unsigned type).
>>>>> 
>>>>> There is another define BT_VOICE_CVSD_16BIT with value 0x0060 which
>>>>> seems to be correct as it means Linear Coding, 16-bit without padding
>>>>> bits, 2's complement and encoded by CVSD codec.
>>>> 
>>>> Hello, can somebody look at this BT_VOICE_TRANSPARENT definition and
>>>> verify that it really should be defined as unsigned or 2's complement?
>>> 
>>> Are you talking about these:
>>> 
>>> https://elixir.bootlin.com/linux/latest/source/include/net/bluetooth/bluetooth.h#L119
>> 
>> Yes, exactly.
>> 
>>> Which is used in ofono:
>>> 
>>> https://github.com/DynamicDevices/ofono/blob/master/src/handsfree-audio.c#L93
>>> 
>>> Afaik these values work as intended with mSBC/WBS.
>> 
>> And I suspect that definition is wrong. mSBC does not use 1's complement
>> format.
> 
> Any comments on this? Could either somebody confirm or not if current
> defined constant BT_VOICE_TRANSPARENT is correct? In previous emails I
> wrote why I think it is defined incorrectly...

so I do not recall why that has been chosen this way. Does it work any better if you chose a different value. I mean the air codec is transparent and so the input to the PCM interface must be treated transparent as well. Meaning whatever value you have for the other settings doesn’t matter.

However I did check the specs and can’t find any note in that direction. However we are feeding mSBC frames instead of PCM frames in the case of CVSD into the controller. So it should just work with whatever values the voice setting has.

Regards

Marcel

