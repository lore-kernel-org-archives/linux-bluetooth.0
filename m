Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB3C5519F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 16:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499E720B80
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 16:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="SE7oORnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgKLQYm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 11:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgKLQYm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 11:24:42 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B28C0613D1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2020 08:24:42 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4CX6Pg51NszQlVP;
        Thu, 12 Nov 2020 17:24:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
        t=1605198278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIc0TqkmLC+M9zSCkLOlwLPkn7B296OTaZ80qiXyVwU=;
        b=SE7oORnlRXEcVYwzyQsgOvNEfO9edboT7ZLuSYeE5lhkzhO6ph0HFYI3W5Txyqq3kkXJ5p
        8BsT9NJYRIS5bPT5RFm0lJ3AIuQsdw7Te/Bj0dbYduibQjjSqs8P0rq5xX/axajlPcK+ro
        khQ/aoFNTN6JhJw9PB1syZPcS6VB2Sup9/lE434a+gkh0rwmq5XlxnVkZUfGE7AGwB6S2H
        wk/YNxd7ts0T8pWMRwqb3e+iCos4rev511TNpbGgm+Zsk3OOZhcEQ5gN4da+ITUdo8Tnjn
        gKbREsjfQ4RXKPxWiLbFEF5aUyc5BhGrTJewOB68F4iNI7LCpi/u0B+380UFTw==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id Cs8gZMFXUhdw; Thu, 12 Nov 2020 17:24:36 +0100 (CET)
Date:   Thu, 12 Nov 2020 17:24:35 +0100
From:   Devin Bayer <dev@doubly.so>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "Michael N. Moran" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: LE Advertising: Command Disallowed
Message-ID: <20201112162435.z6yty3uuijp5zywg@orac>
References: <d343e320-b368-e85b-d428-d5c000eb69df@doubly.so>
 <b86e5449-d784-deee-87d8-4bcf1b4b6308@mnmoran.org>
 <d2ebb802-3bb6-63ed-de42-e1a2b0c38f36@doubly.so>
 <CABBYNZKh2FBwVamTqznqaEO=1ksuhY=K9D4pQTbDszneLg1dag@mail.gmail.com>
 <cfee49fe-f4c1-e37a-64e2-94e2df927999@doubly.so>
 <CAO1O6sefGxgwcesfu8qEFSX_HDRFFf8NW7ugyvXT=rSBVUMGYw@mail.gmail.com>
 <20201112121614.c5kko4iofg32ckxs@orac>
 <CAO1O6se6UF9Ao516xudciGBYtA9j=i-PMEbrsAhjga10ujxacg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO1O6se6UF9Ao516xudciGBYtA9j=i-PMEbrsAhjga10ujxacg@mail.gmail.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -1.88 / 15.00 / 15.00
X-Rspamd-Queue-Id: 9613B17EB
X-Rspamd-UID: 9fac2f
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Nov 12, 2020 at 02:53:05PM +0100, Emil Lenngren wrote:
> 
> It's as Luiz said, you're mixing two different stacks and hence mixing
> legacy advertising commands with extended ones. The HCI standard says:
> 
> "If, since the last power-on or reset, the Host has ever issued a legacy
> advertising command and then issues an extended advertising command, or
> has ever issued an extended advertising command and then issues a legacy
> advertising command, the Controller shall return the error code Command
> Disallowed (0x0C)."
> 
> After Reset, you can see "LE Set Extended Advertising Parameters"
> during the `hciconfig` runs. Then later, when `python` runs, a "LE Set
> Advertise Enable" is sent. This is disallowed behaviour.
> 
> One solution is that your python program sends a "Reset" command as
> the first thing, otherwise you don't know which state the controller
> is in. The other solution is to use BlueZ only.
> 

Thanks Emil,

that did help and I was able to finally get a basic service working. I
would be happy to use BlueZ but I was never able to get discovery /
connection to work more than 10% of the time, so that's why I'm trying
something else.

I was also getting disconnects every 3 seconds from an unknown source. I
think I fixed that with the module parameter enable_autosuspend=N. 

This was also a subsequent "Set Extended Advertising Parameters"
command. These aren't sent from my program and nothing running on my
system seems to be talking to bluetooth.

Is this part of the BlueZ stack that's running in the kernel?
Can it be disabled?

This is the last command received:

> HCI Event: LE Meta Event (0x3e) plen 10                              #413 [hci0] 1319.142290
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 3585
        Connection interval: 45.00 msec (0x0024)
        Connection latency: 0 (0x0000)
        Supervision timeout: 5000 msec (0x01f4)

Then after 3 seconds (consistently):

< HCI Command: Disconnect (0x01|0x0006) plen 3                         #414 [hci0] 1322.227590
        Handle: 3585
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                              #415 [hci0] 1322.346055
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                         #416 [hci0] 1322.472321
        Status: Success (0x00)
        Handle: 3585
        Reason: Connection Terminated By Local Host (0x16)
@ MGMT Event: Device Disconnected (0x000c) plen 8                  {0x0001} [hci0] 1322.472381
        LE Address: 40:AD:0E:98:D7:F6 (Resolvable)
        Reason: Connection terminated by local host (0x02)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1            #417 [hci0] 1322.519512
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                            #418 [hci0] 1322.521048
      LE Set Advertise Enable (0x08|0x000a) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Advertising Pa.. (0x08|0x0036) plen 25  #419 [hci0] 1322.521089
        Handle: 0x00
        Properties: 0x0013
          Connectable
          Scannable
          Use legacy advertising PDUs: ADV_IND
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Channel map: 37, 38, 39 (0x07)
        Own address type: Public (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:00:00:00:00:00 (OUI 00-00-00)
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)
        TX power: 127 dbm (0x7f)
        Primary PHY: LE 1M (0x01)
        Secondary max skip: 0x00
        Secondary PHY: LE 1M (0x01)
        SID: 0x00
        Scan request notifications: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 5                            #420 [hci0] 1322.522027
      LE Set Extended Advertising Parameters (0x08|0x0036) ncmd 1
        Status: Command Disallowed (0x0c)
        TX power (selected): 48 dbm (0x30)

~ Devin
