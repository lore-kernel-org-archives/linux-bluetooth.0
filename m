Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4DCC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 05:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F36461152
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 05:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhKJFvd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 00:51:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39935 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhKJFvd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 00:51:33 -0500
Received: from smtpclient.apple (p4fefc15c.dip0.t-ipconnect.de [79.239.193.92])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0D9E6CED34;
        Wed, 10 Nov 2021 06:48:45 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH BlueZ 2/6] mgmt-api: Add new Device Flag to use Device
 Privacy Mode
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLLpQK8v9zALGD1Br3C5wKH2QjSMtRxdSqZLaKArB6CmQ@mail.gmail.com>
Date:   Wed, 10 Nov 2021 06:48:44 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E1EECBDE-1857-473F-B9BA-7A2FA0AEC0D8@holtmann.org>
References: <20211105211245.424024-1-luiz.dentz@gmail.com>
 <20211105211245.424024-2-luiz.dentz@gmail.com>
 <CABBYNZLLpQK8v9zALGD1Br3C5wKH2QjSMtRxdSqZLaKArB6CmQ@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>> This adds a new flag to Get/Set Device Flag commands so it is possible
>> to set the Device Privacy Mode which allows to connect when the
>> remote device uses either identity or random address.
>> ---
>> doc/mgmt-api.txt | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index 97d33e30a..b7a152c14 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -3421,6 +3421,7 @@ Get Device Flags Command
>>        available bits:
>> 
>>                0       Remote Wakeup enabled
>> +               1       Device Privacy Mode enabled
>> 
>>        This command generates a Command Complete event on success
>>        or a Command Status event on failure.
>> --
>> 2.31.1
> 
> Any comments on this? I'd like to apply it if that's ok with you.

just go ahead with this.

Regards

Marcel

