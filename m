Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7037FC388F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 20:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F9B2087D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 20:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="Qka1YZr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgKKULu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKULt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 15:11:49 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59837C0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 12:11:49 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4CWbVC1rsCzQlQP;
        Wed, 11 Nov 2020 21:11:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1605125505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2lpMCgq8u64SEzwyHbXGNzfP/FjvV0Ta+BGGEmCYsvs=;
        b=Qka1YZr2Bn1sqFPQn8ymAdlk6MgtZVNwC3yuyR5bEt8YHoneCjIYcGlkDLt9hQCYJ92Wpt
        ypRT07Fz3VON7rDRbtRjvpuw+xPi32nPhZEmIx7ffWxkD0gJl6lxlU2nXYPQEhm7A/2Y08
        C7QMZdDM0UDpzQsRottqnGVvv6O2UTLKNqTz4wIa3JsL+JMpkWCSk57kzlPC3xLEHT05HT
        kN968/Xee6Vv+P6JJUPaeRcjJd6f5ZYce92zYfvdErmiltS/NS2ankybjZgeuAyJXCqOFL
        Pv5NK/+l3c94XY6jkOnPg+2CUU3lpgovyNEKBr+zMgjQAQyrfJwGrJD7CMszEw==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id r13QZm6ujSQl; Wed, 11 Nov 2020 21:11:44 +0100 (CET)
Subject: Re: LE Advertising: Command Disallowed
To:     "Michael N. Moran" <mike@mnmoran.org>,
        linux-bluetooth@vger.kernel.org
References: <d343e320-b368-e85b-d428-d5c000eb69df@doubly.so>
 <b86e5449-d784-deee-87d8-4bcf1b4b6308@mnmoran.org>
From:   Devin Bayer <dev@doubly.so>
Message-ID: <d2ebb802-3bb6-63ed-de42-e1a2b0c38f36@doubly.so>
Date:   Wed, 11 Nov 2020 21:11:43 +0100
MIME-Version: 1.0
In-Reply-To: <b86e5449-d784-deee-87d8-4bcf1b4b6308@mnmoran.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.87 / 15.00 / 15.00
X-Rspamd-Queue-Id: 45FB7171A
X-Rspamd-UID: e273aa
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 11/11/2020 21.04, Michael N. Moran wrote:
> Hi Devin,
> 
> If I recall correctly, you get this if advertising is already enabled.

For the first error (Advertise Enable), this makes sense. I also saw that on
another host which seemed to be working.

But the following seem to prevent advertisements from being sent:

>> HCI Event: Command Complete (0x0e) plen 4      #16 [hci0] 3.407380
>       LE Set Advertising Parameters (0x08|0x0006) ncmd 1
>         Status: Command Disallowed (0x0c)

>> HCI Event: Command Complete (0x0e) plen 4      #20 [hci0] 1.613980
>       LE Set Advertising Data (0x08|0x0008) ncmd 1
>         Status: Command Disallowed (0x0c)

~ Devin
