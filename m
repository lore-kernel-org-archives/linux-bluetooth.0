Return-Path: <SRS0=Zhcm=6P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E5C4724C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 18:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3821320787
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 May 2020 18:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgEASA5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 May 2020 14:00:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52903 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730210AbgEASA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 May 2020 14:00:56 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8816BCED24;
        Fri,  1 May 2020 20:10:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [BlueZ PATCH v1] shared/gatt-client:Ignore orphaned
 characteristics
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_XG7PG8KCy0rraZZm0L12baSyWzxfCJnUkNBJX=APhQ_A@mail.gmail.com>
Date:   Fri, 1 May 2020 20:00:54 +0200
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <D425C825-409E-47B2-9DDE-C7FD98EE1AF4@holtmann.org>
References: <20200501144037.1684-1-alainm@chromium.org>
 <4195BFB9-1586-435F-8FC2-ED215959A591@holtmann.org>
 <CALWDO_W4AquYjw5LZR+pbFnPEB=shYKDH7_JDGHexpsXUnC7aA@mail.gmail.com>
 <215E5E68-A360-4DD7-8DBC-E46278729FC6@holtmann.org>
 <CALWDO_XG7PG8KCy0rraZZm0L12baSyWzxfCJnUkNBJX=APhQ_A@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>>>> The gatt discovery proceedure simplification to discover all
>>>>> characteristics at once has exposed a device side issue where some
>>>>> device implementation reports orphaned characteristics.  While this
>>>>> technically shouldn't be allowed, some instances of this were observed
>>>>> (namely on some Android phones).
>>>>> 
>>>>> The fix is to simply skip over orphaned characteristics and continue
>>>>> with everything else that is valid.
>>>>> 
>>>>> This has been tested as part of the Android CTS tests against an
>>>>> affected platform and was confirmed to have worked around the issue.
>>>>> ---
>>>>> 
>>>>> src/shared/gatt-client.c | 5 ++++-
>>>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
>>>>> index 963ad619f..d604c77a3 100644
>>>>> --- a/src/shared/gatt-client.c
>>>>> +++ b/src/shared/gatt-client.c
>>>>> @@ -632,7 +632,10 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
>>>>>                     util_debug(client->debug_callback, client->debug_data,
>>>>>                             "Failed to insert characteristic at 0x%04x",
>>>>>                             chrc_data->value_handle);
>>>>> -                     goto failed;
>>>>> +
>>>>> +                     /* Skip over invalid characteristic */
>>>>> +                     free(chrc_data);
>>>>> +                     continue;
>>>>>             }
>>>> 
>>>> should we add a warning here?
>>> Is there a good way other than the util_debug mechanism to write  a warning?
>> 
>> you could just use btd_warn() here. If this gets too noisy, we either remove it later or we introduce a btd_warn_ratelimited() or btd_warn_once().
> This being under src/shared, I wasn't sure if that was acceptable to
> add a btd dependency here, especially with the work to avoid it via
> the util_debug.  Happy to do either way, just want to make sure the
> guidance is clear.

good point. My bad. You better leave the logging out then.

Regards

Marcel

