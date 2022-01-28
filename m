Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D85C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 13:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348719AbiA1NSX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jan 2022 08:18:23 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:37513 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348681AbiA1NR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jan 2022 08:17:59 -0500
Received: from smtpclient.apple (p4ff9fc34.dip0.t-ipconnect.de [79.249.252.52])
        by mail.holtmann.org (Postfix) with ESMTPSA id 91CA7CED37;
        Fri, 28 Jan 2022 14:17:56 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [BlueZ PATCH v2 1/4] doc: Add Bluetooth quality report event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZLLjHfGiM5W4S59B9bgLZaN3dgk-9WVBb_Fdm8F8jM9ZA@mail.gmail.com>
Date:   Fri, 28 Jan 2022 14:17:55 +0100
Cc:     Joseph Hwang <josephsih@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Joseph Hwang <josephsih@google.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <737A07DA-6FEC-4BC1-8834-442C2A9E6291@holtmann.org>
References: <20220127101609.3646316-1-josephsih@chromium.org>
 <F67144BA-E7CF-43B7-997C-576536BA5968@holtmann.org>
 <CABBYNZLLjHfGiM5W4S59B9bgLZaN3dgk-9WVBb_Fdm8F8jM9ZA@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> Add the Bluetooth quality report event in doc/mgmt-api.txt.
>>> 
>>> Signed-off-by: Joseph Hwang <josephsih@chromium.org>
>>> ---
>>> 
>>> Changes in v2:
>>> - This is a new patch for adding the event in doc/mgmt-api.txt
>>> 
>>> doc/mgmt-api.txt | 20 ++++++++++++++++++++
>>> 1 file changed, 20 insertions(+)
>>> 
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index ebe56afa4..a0e71a732 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -4978,3 +4978,23 @@ Advertisement Monitor Device Lost Event
>>>              2       LE Random
>>> 
>>>      This event will be sent to all management sockets.
>>> +
>>> +
>>> +Bluetooth Quality Report Event
>>> +==============================
>>> +
>>> +     Event code:             0x0031
>>> +     Controller Index:       <controller_id>
>>> +     Event Parameters:       Quality_Spec (1 Octet)
>>> +                             Report_Len (2 Octets)
>>> +                             Report (0-65535 Octets)
>>> +
>>> +     This event carries the Bluetooth quality report sent by the
>>> +     controller.
>>> +
>>> +     Possible values for the Quality_Spec parameter:
>>> +             0       Not Available
>>> +             1       Intel Telemetry Event
>>> +             2       AOSP Bluetooth Quality Report Event
>> 
>> can we swap this around please:
>> 
>>                0       AOSP Bluetooth Quality Report Event
>>                1       Intel Telemetry Event
>> 
>> Regards
>> 
>> Marcel
> 
> I wonder if we shouldn't have these as bit fields though, so one can
> select multiple reports if available.

the current code only allows for enabling one of these. If a driver specific one is specified, it takes precedence over the AOSP one, other AOSP is chosen (if supported).

Reality is that all major vendors are settling on the AOSP extension since they already have that in their firmwares. So actually I don’t expect to see any other than AOSP or Intel.

Regards

Marcel

