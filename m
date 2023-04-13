Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEC3C77B6F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDMVOc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 17:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDMVOb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 17:14:31 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3E172C
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 14:14:30 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 2CBB82403BB
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 23:14:29 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PyC4m0CSxz6tm4;
        Thu, 13 Apr 2023 23:14:15 +0200 (CEST)
Message-ID: <71f5c4c6615ebce24526ac256f84abb6a2d95534.camel@iki.fi>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis 
        <frederic.danis@collabora.com>
Date:   Thu, 13 Apr 2023 21:14:15 +0000
In-Reply-To: <CABBYNZLbG2iWLUDH6A4Wbdb=o47Un8b_VGVV8y1v4hOwFyok4g@mail.gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
         <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
         <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com>
         <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi>
         <CABBYNZKv68ybD3YVKFtHUARh6H+TVY=2_P9TdNWEbZ4FbTX31w@mail.gmail.com>
         <A02E43E3-63E3-4F75-AB99-FB355180DD2B@iki.fi>
         <CABBYNZJdjq2TZCpNVSC-za6e++GgeL2M3=G=11g7u33NDeEpgg@mail.gmail.com>
         <ca30b39204f49e793317a5008f825656e1f40c3f.camel@iki.fi>
         <CABBYNZK5h4Vn9_Y8S2WsK_DHb6jvWDMjP-u=Vgos6SO4fRUatA@mail.gmail.com>
         <CABBYNZLbG2iWLUDH6A4Wbdb=o47Un8b_VGVV8y1v4hOwFyok4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

to, 2023-04-13 kello 11:48 -0700, Luiz Augusto von Dentz kirjoitti:
[clip]
> Btw, not sure you if are following the list but I'm working on adding
> support for handling multiple CIS to the same peer:
> 
> https://patchwork.kernel.org/project/bluetooth/list/?series=739574
> 
> That should allow you to set a different CIS ID if you want to use
> different sockets for input and output.

Great, I saw the patchset but didn't yet have time to take a proper look.

> Id also would like to discuss how we do some test automation using
> pipewire endpoints in the future, we probably want to enable it via
> test-runner but we probably need to enable it loading pipewire daemons
> etc under the vm that test-runner creates, Frederic started adding
> some support but it doesn't look like it loads pipewire so Im not
> really sure how it supposed to be loaded:
> 
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/test-runner.c#n1108
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/test-runner.c#n277

Yes, there'd be two daemons to start in the VM, pipewire and wireplumber,
and running with default config should then result to the endpoints being
created.

The interaction is probably simplest via the command-line tools.
In principle something more clever and better controlled is possible,
but I'd need to think a bit more what's best here.

Output from `pw-dump -m` can be polled and parsed for determining
when daemons are ready, what bluetooth sinks/devices appeared after
connect, etc. `pw-cat` can be used for playback and recording.

Some tests probably can be written along these lines, but without
trying now I don't know yet how well the above would work.

A separate question is how the virtual BT device that is going to
interact with the endpoints is going to be implemented. Hand-coded
data sent via emulator bthost?

-- 
Pauli Virtanen

