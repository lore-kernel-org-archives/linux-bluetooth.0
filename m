Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95EC77B70
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Apr 2023 14:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDOO51 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Apr 2023 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDOO50 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Apr 2023 10:57:26 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EEB35AE
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Apr 2023 07:57:24 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 13F00240237
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Apr 2023 16:57:23 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PzGcy49ZFz9rxD;
        Sat, 15 Apr 2023 16:57:22 +0200 (CEST)
Message-ID: <311d30efa5f7d27d65b07f4dc5958e2a8ca5b7a2.camel@iki.fi>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis 
        <frederic.danis@collabora.com>
Date:   Sat, 15 Apr 2023 14:57:22 +0000
In-Reply-To: <CABBYNZLGP3FPXOfQ1uWF1pSSiWk+1ZBJdxHm9rXSSfEH+7f15Q@mail.gmail.com>
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
         <71f5c4c6615ebce24526ac256f84abb6a2d95534.camel@iki.fi>
         <CABBYNZLGP3FPXOfQ1uWF1pSSiWk+1ZBJdxHm9rXSSfEH+7f15Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

pe, 2023-04-14 kello 14:56 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Thu, Apr 13, 2023 at 2:14 PM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Hi Luiz,
> > 
> > to, 2023-04-13 kello 11:48 -0700, Luiz Augusto von Dentz kirjoitti:
> > [clip]
> > > Btw, not sure you if are following the list but I'm working on adding
> > > support for handling multiple CIS to the same peer:
> > > 
> > > https://patchwork.kernel.org/project/bluetooth/list/?series=739574
> > > 
> > > That should allow you to set a different CIS ID if you want to use
> > > different sockets for input and output.
> > 
> > Great, I saw the patchset but didn't yet have time to take a proper look.
> > 
> > > Id also would like to discuss how we do some test automation using
> > > pipewire endpoints in the future, we probably want to enable it via
> > > test-runner but we probably need to enable it loading pipewire daemons
> > > etc under the vm that test-runner creates, Frederic started adding
> > > some support but it doesn't look like it loads pipewire so Im not
> > > really sure how it supposed to be loaded:
> > > 
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/test-runner.c#n1108
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/test-runner.c#n277
> > 
> > Yes, there'd be two daemons to start in the VM, pipewire and wireplumber,
> > and running with default config should then result to the endpoints being
> > created.
> > 
> > The interaction is probably simplest via the command-line tools.
> > In principle something more clever and better controlled is possible,
> > but I'd need to think a bit more what's best here.
> > 
> > Output from `pw-dump -m` can be polled and parsed for determining
> > when daemons are ready, what bluetooth sinks/devices appeared after
> > connect, etc. `pw-cat` can be used for playback and recording.
> 
> Yep, in terms of tests the ideal solution would be simulate BAP
> qualification tests:
> 
> https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=524716
> 
> Ive started to write them as unit tests:
> 
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/unit/test-bap.c
> 
> It is somewhat laborious to write all the PDUs manually like that but
> if we managed to write all the tests we could perhaps enable it
> working with the full stack rather than limiting it bt_bap instance,
> but perhaps it is overkill since we could instead automate
> qualification tests via auto-pts.
> > 
> > Some tests probably can be written along these lines, but without
> > trying now I don't know yet how well the above would work.
> > 
> > A separate question is how the virtual BT device that is going to
> > interact with the endpoints is going to be implemented. Hand-coded
> > data sent via emulator bthost?
> 
> We can do both a hand-coded tests with bthost or hook a second
> instance of btdev to BlueZ so we test BlueZ vs BlueZ, well in theory
> we could even bring another stack as well like zephyr into the
> picture, anyway what we need to know is how to setup the environment
> for pipewire and wireplumber, note that we don't have the so called
> user session under test-runner environment, so I wonder if we need
> wireplumber?

I sent an example patch to the list that adds an option to launch PW
with tools/test-runner so that you get the endpoints registered. You
have to disable a few things for it to run in plain environment (ALSA
device reservations and flatpak portal want DBus user session, logind
integration wants logind).

The "session manager" is some JACK terminology, not really related to
user sessions, in PW it is what coordinates audio device discovery, and
connects clients to devices, so you have to run one.

-- 
Pauli Virtanen
