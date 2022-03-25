Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E11C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354778AbiCYOxx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 10:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbiCYOxx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 10:53:53 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C6915DA46
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 07:52:11 -0700 (PDT)
Received: from smtpclient.apple (p4ff9fa3c.dip0.t-ipconnect.de [79.249.250.60])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8A8B2CECE0;
        Fri, 25 Mar 2022 15:52:09 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH BlueZ v2 4/9] adapter: Don't use DBG in mgmt_debug
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZK+Sh_r5SW7ot=QR2gweKf6MtGDsKjGdRGWOmKEP-ny5g@mail.gmail.com>
Date:   Fri, 25 Mar 2022 15:52:08 +0100
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EBCB6D05-4107-4CDE-BCD5-8E0374F90F63@holtmann.org>
References: <20220323000654.3157833-1-luiz.dentz@gmail.com>
 <20220323000654.3157833-4-luiz.dentz@gmail.com>
 <DE87AE95-85DD-4732-8D49-F6E212F836B6@holtmann.org>
 <CABBYNZK+Sh_r5SW7ot=QR2gweKf6MtGDsKjGdRGWOmKEP-ny5g@mail.gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

>>> mgmt_debug callback is used to print debug strings from mgmt instances
>>> which includes the file and function names so using DBG would add yet
>>> another set of file and function prefixes which makes the logs
>>> confusing.
>>> ---
>>> src/adapter.c | 8 +++-----
>>> 1 file changed, 3 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/src/adapter.c b/src/adapter.c
>>> index 97ce26f8e..6680c5410 100644
>>> --- a/src/adapter.c
>>> +++ b/src/adapter.c
>>> @@ -10327,9 +10327,8 @@ static void read_version_complete(uint8_t status, uint16_t length,
>>> 
>>> static void mgmt_debug(const char *str, void *user_data)
>>> {
>>> - const char *prefix = user_data;
>>> -
>>> - info("%s%s", prefix, str);
>>> + if (DBG_IS_ENABLED())
>>> + btd_debug(0xffff, "%s", str);
>>> }
>>> 
>>> int adapter_init(void)
>>> @@ -10342,8 +10341,7 @@ int adapter_init(void)
>>> return -EIO;
>>> }
>>> 
>>> - if (getenv("MGMT_DEBUG"))
>>> - mgmt_set_debug(mgmt_primary, mgmt_debug, "mgmt: ", NULL);
>>> + mgmt_set_debug(mgmt_primary, mgmt_debug, NULL, NULL);
>> 
>> oh no. This is crazy. Please re-think this and what computational overhead you are introducing.
> 
> I considered moving DBG_IS_ENABLED() in place of getenv("MGMT_DEBUG")
> so that would be use just once per adapter, the problem is that
> wouldn't work with:

why do you need this in the first place. The mgmt protocol is also added to btmon traces. Unless you work on src/shared/mgmt.c directly, you don’t need to the debug feature at all. Just let btmon decode it for you.

Regards

Marcel

