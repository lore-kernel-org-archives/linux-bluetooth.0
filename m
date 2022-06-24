Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF00C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 07:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiFXHBz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 03:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiFXHBz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 03:01:55 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC55D69270
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 00:01:53 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb79.dynamic.kabel-deutschland.de [95.90.235.121])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E7F461EA1928;
        Fri, 24 Jun 2022 09:01:52 +0200 (CEST)
Message-ID: <b53ba2e5-7de5-91ad-2f2f-d2869b61994f@molgen.mpg.de>
Date:   Fri, 24 Jun 2022 09:01:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: third time
Content-Language: en-US
To:     Thomas Green <TGreen2@Sorenson.com>
References: <BN7PR04MB52674E1CAADA5B0550C3F6959FB39@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CABBYNZLaPxBMvVXWx+yqQz-SyxptdMfEZ5TPQVP7q4otpcbErg@mail.gmail.com>
 <BN7PR04MB526737063784913B34568C009FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CABBYNZ+Ak=U1UUmYvWwfGOMMQNBAFKpbNm_ZoUTcGvCw7EYxpQ@mail.gmail.com>
 <BN7PR04MB5267899C0B47D40E28784BC09FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
 <BN7PR04MB526754264668121B190EB50E9FB59@BN7PR04MB5267.namprd04.prod.outlook.com>
Cc:     linux-bluetooth@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <BN7PR04MB526754264668121B190EB50E9FB59@BN7PR04MB5267.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Thomas,


Am 23.06.22 um 22:00 schrieb Thomas Green:

> I've updated (at least my testing system) to version 5.64 and are
> having other problems now too.  For example the first time I attach
> one of these devices it works well, subsequent attempts to pair other
> of the same type of device fails with and AuthenticationFailed error.
> On 5.50, I could pair as many of these devices as I wanted.  Should
> we take this offline and perhaps we could discuss this more?

Can you please (git) bisect the issue? It’s often the fastest way to 
find the cause, and then figuring out a fix.


Kind regards,

Paul
