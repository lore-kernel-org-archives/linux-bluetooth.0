Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E956C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07842204EA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFJIzN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:55:13 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49217 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgFJIzN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 04:55:13 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 086BDCECE0;
        Wed, 10 Jun 2020 11:05:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v3 4/4] fixing const decoration warnins on options.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_UoNKFcFgTNUgY691Lj61udG0WsL9vdxbSF4Q0fpqBwEg@mail.gmail.com>
Date:   Wed, 10 Jun 2020 10:55:10 +0200
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B735F98B-8EB8-4FA3-B0C1-52A8C2CC8C60@holtmann.org>
References: <20200529153814.213125-1-alainm@chromium.org>
 <20200529153814.213125-5-alainm@chromium.org>
 <CABBYNZJJ751fxpjpZ0MFvUsQ21H9CptM_gySAgZbcGPwz76W2Q@mail.gmail.com>
 <CALWDO_UoNKFcFgTNUgY691Lj61udG0WsL9vdxbSF4Q0fpqBwEg@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> ---
>>> 
>>> Changes in v3: None
>>> Changes in v2: None
>>> 
>>> src/main.c | 12 ++++++------
>>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/src/main.c b/src/main.c
>>> index ca27f313d..cea50a3d2 100644
>>> --- a/src/main.c
>>> +++ b/src/main.c
>>> @@ -80,7 +80,7 @@ static enum {
>>>        MPS_MULTIPLE,
>>> } mps = MPS_OFF;
>>> 
>>> -static const char *supported_options[] = {
>>> +static const char * const supported_options[] = {
>>>        "Name",
>>>        "Class",
>>>        "DiscoverableTimeout",
>>> @@ -129,7 +129,7 @@ static const char * const controller_options[] = {
>>>        NULL
>>> };
>>> 
>>> -static const char *policy_options[] = {
>>> +static const char * const policy_options[] = {
>>>        "ReconnectUUIDs",
>>>        "ReconnectAttempts",
>>>        "ReconnectIntervals",
>>> @@ -137,7 +137,7 @@ static const char *policy_options[] = {
>>>        NULL
>>> };
>>> 
>>> -static const char *gatt_options[] = {
>>> +static const char * const gatt_options[] = {
>>>        "Cache",
>>>        "KeySize",
>>>        "ExchangeMTU",
>>> @@ -146,8 +146,8 @@ static const char *gatt_options[] = {
>>> };
>>> 
>>> static const struct group_table {
>>> -       const char *name;
>>> -       const char **options;
>>> +       const char * const name;
>>> +       const char * const * const options;
>>> } valid_groups[] = {
>>>        { "General",    supported_options },
>>>        { "Controller", controller_options },
>>> @@ -243,7 +243,7 @@ static enum jw_repairing_t parse_jw_repairing(const char *jw_repairing)
>>> 
>>> 
>>> static void check_options(GKeyFile *config, const char *group,
>>> -                                               const char **options)
>>> +                                       const char * const * const options)
>>> {
>>>        char **keys;
>>>        int i;
>>> --
>>> 2.27.0.rc0.183.gde8f92d652-goog
>>> 
>> 
>> I wonder how usufull is to tell it is a constant pointer to a constant
>> character given that is so rarely in the kernel and userspace,
>> something like const char * const * const would be very hard to keep
>> it readable.
> 
> I'm personally a big fan of leveraging the compiler to find bugs, but
> in this case it also allows the compiler to put all the strings into
> read only sections.  In this example, it will catch code trying to
> write into the string or prevent code execution in the read only
> sections if there is ever a bug that leverages this data section to
> store code that can be manipulated.  For readability, I've seen other
> platforms use type definitions LPCSTR to typedef const char * const
> etc..  I'm happy to follow guidance here.

I am a big fan of letting the compiler help us, but the readability concerns me a bit in this case. Can we explore what kind of macros we might be able to introduce to make this easier on the eyes.

Regards

Marcel

