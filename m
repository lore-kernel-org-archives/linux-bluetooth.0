Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31726C388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 21:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F8C20825
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 21:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="l/zN0N6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKKVHP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKVHP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 16:07:15 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB79C0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 13:07:14 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4CWck90DWgzQlJ0;
        Wed, 11 Nov 2020 22:07:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1605128831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s30YDkngrAg7T3Tl5jDV/Da0lz7jwSdLg9moxHE+dTo=;
        b=l/zN0N6aNUjXktm4l1NUyOsn2Y5xSxuXAe0SB8PYdX/TVYKMGbegU1WcdiJUw+6vJJMnKD
        se8UXiJ5kSs3db3Wb/Vp5jFqQme+jyfjfvUkIOifrlCsn81wHkB/ptwrNoBiU4SRUssVDS
        NMyZM4fN6jEmzDp3SW5aqcsL2smLT4Ny0dv0unU00PWycEubCtfqndiCGFTQYR2JLzE/Lb
        9w+eSQIW0TSAc401x3OJbZ44xM7uC31W1ZfXdgZup3z5eVWEoe9uWIB6Zu0NmrjElm3ICL
        jvj6ygR6NfXa2BZXC1Yz4ZdIUwt8/RJNf49ZBka2k+2ZNLv691XH/A4epclxhA==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id V-yEdXakR_JK; Wed, 11 Nov 2020 22:07:09 +0100 (CET)
Subject: Re: LE Advertising: Command Disallowed
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "Michael N. Moran" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d343e320-b368-e85b-d428-d5c000eb69df@doubly.so>
 <b86e5449-d784-deee-87d8-4bcf1b4b6308@mnmoran.org>
 <d2ebb802-3bb6-63ed-de42-e1a2b0c38f36@doubly.so>
 <CABBYNZKh2FBwVamTqznqaEO=1ksuhY=K9D4pQTbDszneLg1dag@mail.gmail.com>
From:   Devin Bayer <dev@doubly.so>
Message-ID: <cfee49fe-f4c1-e37a-64e2-94e2df927999@doubly.so>
Date:   Wed, 11 Nov 2020 22:07:08 +0100
MIME-Version: 1.0
In-Reply-To: <CABBYNZKh2FBwVamTqznqaEO=1ksuhY=K9D4pQTbDszneLg1dag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.71 / 15.00 / 15.00
X-Rspamd-Queue-Id: 15D35170E
X-Rspamd-UID: e94ddc
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



On 11/11/2020 21.53, Luiz Augusto von Dentz wrote:
> 
> You also need to ensure you are not mixing with extended advertisement
> commands, iirc if the stack does send
> BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS it would already prevent the
> legacy version to work. Bottom line here is, either use entire stack
> or switch to user-channel with a proper stack, mixed handling won't
> cut anymore, and for the most part we should be covering all the
> advertisement features over D-Bus if we don't please let us know if
> there are still gaps.
> 

Hi Luiz,

I am not sure what you mean about mixed handling, but I am not using bluetoothd.
As you can see the entire log, I don't see any indication of
BT_HCI_CMD_LE_READ_NUM_SUPPORTED_ADV_SETS. Could that be a default from boot
that I need to disable?

BTW, what is "user-channel with a proper stack" ?

My issue with the D-BUS API is that I could never get reliable behavior of even
basic discovering and connecting; it's not about missing features.

~ Devin
