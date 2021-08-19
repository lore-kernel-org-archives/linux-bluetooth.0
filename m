Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE84C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 19:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77EB561051
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 19:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhHSTcU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:32:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35100 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhHSTcT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 15:32:19 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 38CC8CED1B;
        Thu, 19 Aug 2021 21:31:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [RFC 1/3] adapter-api: Add Experimental property
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+5y_e6gSTekN3t_nzwn=16iwJMoFzcdNN0w3D5QhD=Fg@mail.gmail.com>
Date:   Thu, 19 Aug 2021 21:31:41 +0200
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <288A4D99-B8EA-4D08-8B4E-540B1E75994A@holtmann.org>
References: <20210817010237.1792589-1-luiz.dentz@gmail.com>
 <58749BBA-28F0-464E-8CE0-22FD1FEFBDD9@holtmann.org>
 <CABBYNZ+5y_e6gSTekN3t_nzwn=16iwJMoFzcdNN0w3D5QhD=Fg@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> This adds Experimental property which indicates what experimental
>>> features are currently enabled.
>>> ---
>>> doc/adapter-api.txt | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>> 
>>> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
>>> index 464434a81..13e904425 100644
>>> --- a/doc/adapter-api.txt
>>> +++ b/doc/adapter-api.txt
>>> @@ -335,3 +335,8 @@ Properties        string Address [readonly]
>>>                              "peripheral": Supports the peripheral role.
>>>                              "central-peripheral": Supports both roles
>>>                                                    concurrently.
>>> +
>>> +             array{string} Experimental [readonly, optional]
>>> +
>>> +                     List of 128-bit UUIDs that represents the experimental
>>> +                     features currently enabled.
>> 
>> I wonder if this is the best name.
>> 
>> Do we care about just the enabled experimental features or the overall supported experimental features as well. And please keep in mind that we also have per-adapter vs global experimental features. So we should distinguish here as well.
> 
> This is per-adapter and I guess the global one would could exposed on
> all adapters since we don't have a global object, or perhaps you are
> suggesting to use / for that?

if it is read-only, then yes, the global one could be exposed on all adapters.

>> We also need to document that this property is only available if bluetoothd is started with -E and otherwise this property is omitted.
> 
> Will add it.
> 
>> My proposal would be to at least name it ExperimentalSupport or ExperimentalFeatures to give us a path to nicely extend it if needed.
> 
> Sure, I do wonder if we should make it writable as well, so
> applications can enable/disable experimental features themselves? Or
> perhaps that is going too far as to enable unstable code by
> application, it would only work when -E is given thought which would
> enable everything anyway but I was thinking on having -E optionally
> take a list of UUIDs so one could enable just certain features
> instead.

Lets not make this writeable from applications. Some of them require power off etc. So that is going to far.

Regards

Marcel

