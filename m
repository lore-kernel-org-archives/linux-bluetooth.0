Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB5BC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 00:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCNA5N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 20:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCNA5M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 20:57:12 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796128C957
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 17:57:09 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id BAA5C24075D
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 01:57:07 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PbFVB5Rx9z6trY;
        Tue, 14 Mar 2023 01:57:06 +0100 (CET)
Date:   Tue, 14 Mar 2023 00:57:04 +0000
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     linux-bluetooth@vger.kernel.org,
        =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?= <frederic.danis@collabora.com>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
In-Reply-To: <CABBYNZKv68ybD3YVKFtHUARh6H+TVY=2_P9TdNWEbZ4FbTX31w@mail.gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com> <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org> <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com> <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi> <CABBYNZKv68ybD3YVKFtHUARh6H+TVY=2_P9TdNWEbZ4FbTX31w@mail.gmail.com>
Message-ID: <A02E43E3-63E3-4F75-AB99-FB355180DD2B@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

14. maaliskuuta 2023 2.18.21 GMT+02:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com> kirjoitti:
>Hi Pauli,
>
>On Mon, Mar 13, 2023 at 4:30 PM Pauli Virtanen <pav@iki.fi> wrote:
>>
>> Hi,
>>
>> su, 2023-03-12 kello 22:36 -0700, Luiz Augusto von Dentz kirjoitti:
>> > Hi Pauli, Frederic,
>> >
>> > On Fri, Mar 10, 2023 at 4:40 PM <patchwork-bot+bluetooth@kernel.org> wrote:
>> > >
>> > > Hello:
>> > >
>> > > This series was applied to bluetooth/bluez.git (master)
>> > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>> > >
>> > > On Tue,  7 Mar 2023 14:24:11 -0800 you wrote:
>> > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> > > >
>> > > > This adds bt_crypto_sirk which attempts to generate a unique SIRK using
>> > > > the following steps:
>> > > >
>> > > >  - Generate a hash (k) using the str as input
>> > > >  - Generate a hash (sirk) using vendor, product, version and source as input
>> > > >  - Encrypt sirk using k as LTK with sef function.
>> > > >
>> > > > [...]
>> > >
>> > > Here is the summary with links:
>> > >   - [RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c1dd94cc7f81
>> > >   - [RFC,v2,02/12] shared/ad: Add RSI data type
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2e99aefd337
>> > >   - [RFC,v2,03/12] doc: Add set-api
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6477522e92e3
>> > >   - [RFC,v2,04/12] device-api: Add Set property
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5bac4cddb191
>> > >   - [RFC,v2,05/12] core: Add initial implementation of DeviceSet interface
>> > >     (no matching commit)
>> > >   - [RFC,v2,06/12] core: Check if device has RSI
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f95ffcc8b1fe
>> > >   - [RFC,v2,07/12] main.conf: Add CSIP profile configurable options
>> > >     (no matching commit)
>> > >   - [RFC,v2,08/12] shared/csip: Add initial code for handling CSIP
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d297a03b7a61
>> > >   - [RFC,v2,09/12] profiles: Add initial code for csip plugin
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e1eb0a62b3f
>> > >   - [RFC,v2,10/12] tools: Add support to generate RSI using SIRK
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c446a64d461b
>> > >   - [RFC,v2,11/12] client: Add support for DeviceSet proxy
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=373bafc34ce6
>> > >   - [RFC,v2,12/12] client: Use AdvertisingFlags when available
>> > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=815f779aa8e4
>> > >
>> > > You are awesome, thank you!
>> > > --
>> > > Deet-doot-dot, I am a bot.
>> > > https://korg.docs.kernel.org/patchwork/pwbot.html
>> >
>> > Let me know if you guys are happy with this interface to detect
>> > Coordinated Sets, it still experimental so we can experiment with it
>> > until we think it is stable, regarding the implementation of the
>> > transports one major difference here is that we will need to encode
>> > left and right separately, not sure how hard it is to do that in
>> > pipewire?
>>
>> As far as the device set DBus interface is concerned, it seems to work
>> fine for me currently (in wip implementation for PW [0]). Don't right
>> now see something that would need to be added/changed in it.
>>
>> Channel splitting/merging is generally easy in PW. How the playback
>> synchronization is going to work on socket level may determine a bit at
>> what level in PW it is convenient to do though.
>>
>>
>> ---
>>
>> Laundry list for PW related to this:
>>
>> * How to do TX syncronization properly with the ISO sockets needs still
>> some thinking. I have some wip patches [2] that add the timestamps and
>> other socket API that provide timing information to allow
>> synchronization to the Number of Completed packets events.
>> Corresponding Pipewire implementation [3] rate matches to keep the time
>> difference between those events and our audio reference time fixed at
>> e.g. 25ms (2 packets in controller). Not really clear yet if this is a
>> right thing to do to help the controller send packets at the right
>> time.
>
>I have to check with our controller folks, I do recall someone saying
>that perhaps we should use framed instead of unframed so the
>controller can better keep up with timings, but it is not yet clear
>why.
>
>> Here I see LE Read ISO TX Sync with Intel AX210 returning only zero
>> values in Command Complete in btmon for running CIS, so that command
>> doesn't seem to help here.
>
>Yeah, I don't think it is implemented yet.
>
>> * BlueZ doesn't seem to pass on the PAC audio location it reads via
>> read_sink/source_pac_loc, probably very easy to fix.
>
>Will take a look, afaik we fixed something like this not long ago but
>perhaps you are talking about something different.
>
>> * The CIS in a CIG cannot be started one by one, or connected to same
>> destination. The kernel appears to wait until all CIS sockets in same
>> CIG go to connect state before proceeding to create CIS. The spec does
>> not seem to require this (I have some pre-rfc patches to make it more
>> flexible [1].)
>
>It used to be like that but I actually have to fix it because the
>controller don't accept multiple CreateCIS in parallel:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_conn.c#n1907
>
>And it would actually create a relatively big window if we queue and
>wait for CIS established, because then the controller may set up its
>scheduling without taking into account the second CIS which will then
>fail when it comes to its setup, so I think it is better to program
>them together to avoid having only one side working.

Hmm, I made it queue and wait for the previous Create CIS to fully complete before emitting the next one, and that did seem to also work (also with TWS playback to the Samsung device).
However did not extensively test, so even if allowed by spec risks running to controller issues?

The problem here is that the second CIS is not necessarily going to come, as it may be unrelated device put to same CIG since controller doesn't support multiple CIG.

In principle sound server can acquire always all CIS, but then we should expose also the cig/cis properties on transports so they know which ones are needed.

It could also make sense for BlueZ do it, when any cis in cig is started.

>Btw, take a look at how it was done with bluetoothctl>
>transport.acquire <transport_left> <transport_right>, we have been
>able to use it to acquire both left/right earbuds and then send
>pre-encoded files.
>
>> * PW currently does transport acquires synchronously and fails because
>> of that with multiple CIS, but it probably should do them async.
>>
>>
>> [0] https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/1564
>> [1] https://github.com/pv/linux/commits/iso-fix-multicis
>> [2] https://github.com/pv/linux/commits/iso-timestamp
>> [3] https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-timestamp-test
>>
>> --
>> Pauli Virtanen
>
>
>

Hi,
