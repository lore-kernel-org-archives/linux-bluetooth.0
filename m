Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1B4C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 08:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBB36143C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 08:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbhEGI1H convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 04:27:07 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60833 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhEGI1H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 04:27:07 -0400
Received: from smtpclient.apple (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id E79B0CECDB;
        Fri,  7 May 2021 10:33:57 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [Bluez PATCH v2] btmgmt: Fix enable adding irk when turining
 privacy on
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZJX+YrpFyDotc5uZUQLc5P6LiR_F-7AmOa3bPq1m97L=w@mail.gmail.com>
Date:   Fri, 7 May 2021 10:26:06 +0200
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <CE33C971-7C6F-4D1E-9031-77FE07200038@holtmann.org>
References: <20210504111454.29697-1-sathish.narasimman@intel.com>
 <CABBYNZJX+YrpFyDotc5uZUQLc5P6LiR_F-7AmOa3bPq1m97L=w@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> Unable to add the IRK in btmgmt when need to be updated. The option is
>> enabled now.
>> 
>> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
>> ---
>> tools/btmgmt.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
>> index 02fec1dca184..bf3b460d0f04 100644
>> --- a/tools/btmgmt.c
>> +++ b/tools/btmgmt.c
>> @@ -5277,7 +5277,7 @@ static const struct bt_shell_menu main_menu = {
>>        cmd_advertising,                "Toggle LE advertising",        },
>>        { "bredr",              "<on/off>",
>>                cmd_bredr,              "Toggle BR/EDR support",        },
>> -       { "privacy",            "<on/off>",
>> +       { "privacy",            "<on/off> [irk]",
>>                cmd_privacy,            "Toggle privacy support"        },
> 
> I wonder why you didn't incorporate in the first parameter though
> given that things like privacy off [irk] makes no send, or perhaps
> have a dedicated command for setting the irk so it would persist
> between privacy on/off.

that is not how the kernel API works. If you want to enable Privacy, you need to also provide the IRK. We just simplified the tool to use /dev/urandom in case it is not provided.

Regards

Marcel

