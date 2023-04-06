Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0583BC7618D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Apr 2023 20:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjDFUOn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Apr 2023 16:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjDFUOm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Apr 2023 16:14:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D94493
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Apr 2023 13:14:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h11so45324152lfu.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Apr 2023 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680812078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5/+g6IBOqMGAMPySqpfuwEz1JKWNorpjQ8sJF7uagw=;
        b=ZqoLDOqIA/auRaYeK2oFgO5Z0RNLD1CwqUx9BE1PMdXjy/rtyglFQ88Ech0zK1Tsx4
         YI1KpInM4AleCT//I3CIJQ1M93Rm0KXqVclhRiG7e2uV1zIxj92Tl7Mti0CSGGbaczmw
         /bL5q+GluDLadcBb3B8XKc2fNDBCnVQQRIggmgPIcOMBfSVg/EgeBcrxTduuliVRAOkR
         49nV9HLT76b3y0pXJ9TOFKt8oidTE5vZwkPD/TBik+hjW5000iJ7QhZyUnVyDnLuPjcz
         rt8Pe67TNnYrbs8Oj4pcZDXd/sXL1DwSlQKw5qH2BYQZ9op24Hd0C6aeju1RjTxmK9Jp
         BPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680812078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5/+g6IBOqMGAMPySqpfuwEz1JKWNorpjQ8sJF7uagw=;
        b=UGGuEjjp/rB/0liaylvHiZ9Wl3pbW3HUDbRXkG9lhqh5pES7Ta34sW9ZjuPPsn7fq7
         adb2dQsA/EMnroHO8AqdxJs41ryLhcaqGsPiPBFRO3eVJNIEm7BoGNi+TbqA3I9J1IME
         DVlDX9kgXGrwZ60OABawf+ZDVSgvoSvOf3gfe2/+Jl36OA3WDoBb67gL7hy9OuNWSaXM
         8QMtbmudY7bHJn3T4baKIo66LTcxPgWOLxQuD9ryY/B9kLkq+2V2CGwzL2TGdpX+gxWK
         D2L/vtX/aLE2iDSb9gNfTZAoVBC5smuza28tL0VS6dTK1ta5sik77iwzv5hfwU7JQUPd
         9weQ==
X-Gm-Message-State: AAQBX9eKMFkJwF1uunn+wch3J8Kuxz9PGvhImqkt4XFBIGjcrkkOzSNo
        U2lO3POxXnVFYxAg1S6YsnoA1x7tyJa6GU3JLsM=
X-Google-Smtp-Source: AKy350YExolFA9W9gLNl/TXCVQo0YTGp1JQwj0Q5ViaJA4cedAbRCsnW4vX9OeLhdfIyYpfhkRfCyL68gE+a1qB6TYY=
X-Received: by 2002:ac2:46e2:0:b0:4eb:50ba:cb05 with SMTP id
 q2-20020ac246e2000000b004eb50bacb05mr92910lfo.13.1680812077596; Thu, 06 Apr
 2023 13:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
 <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
 <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com>
 <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi> <CABBYNZKv68ybD3YVKFtHUARh6H+TVY=2_P9TdNWEbZ4FbTX31w@mail.gmail.com>
 <A02E43E3-63E3-4F75-AB99-FB355180DD2B@iki.fi> <CABBYNZJdjq2TZCpNVSC-za6e++GgeL2M3=G=11g7u33NDeEpgg@mail.gmail.com>
 <ca30b39204f49e793317a5008f825656e1f40c3f.camel@iki.fi>
In-Reply-To: <ca30b39204f49e793317a5008f825656e1f40c3f.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 6 Apr 2023 13:14:24 -0700
Message-ID: <CABBYNZK5h4Vn9_Y8S2WsK_DHb6jvWDMjP-u=Vgos6SO4fRUatA@mail.gmail.com>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org,
        =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Thu, Apr 6, 2023 at 11:08=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2023-04-05 kello 17:16 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Mon, Mar 13, 2023 at 6:05=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > 14. maaliskuuta 2023 2.18.21 GMT+02:00 Luiz Augusto von Dentz <luiz.d=
entz@gmail.com> kirjoitti:
> > > > Hi Pauli,
> > > >
> > > > On Mon, Mar 13, 2023 at 4:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > su, 2023-03-12 kello 22:36 -0700, Luiz Augusto von Dentz kirjoitt=
i:
> > > > > > Hi Pauli, Frederic,
> > > > > >
> > > > > > On Fri, Mar 10, 2023 at 4:40=E2=80=AFPM <patchwork-bot+bluetoot=
h@kernel.org> wrote:
> > > > > > >
> > > > > > > Hello:
> > > > > > >
> > > > > > > This series was applied to bluetooth/bluez.git (master)
> > > > > > > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> > > > > > >
> > > > > > > On Tue,  7 Mar 2023 14:24:11 -0800 you wrote:
> > > > > > > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > > >
> > > > > > > > This adds bt_crypto_sirk which attempts to generate a uniqu=
e SIRK using
> > > > > > > > the following steps:
> > > > > > > >
> > > > > > > >  - Generate a hash (k) using the str as input
> > > > > > > >  - Generate a hash (sirk) using vendor, product, version an=
d source as input
> > > > > > > >  - Encrypt sirk using k as LTK with sef function.
> > > > > > > >
> > > > > > > > [...]
> > > > > > >
> > > > > > > Here is the summary with links:
> > > > > > >   - [RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
c1dd94cc7f81
> > > > > > >   - [RFC,v2,02/12] shared/ad: Add RSI data type
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
c2e99aefd337
> > > > > > >   - [RFC,v2,03/12] doc: Add set-api
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
6477522e92e3
> > > > > > >   - [RFC,v2,04/12] device-api: Add Set property
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
5bac4cddb191
> > > > > > >   - [RFC,v2,05/12] core: Add initial implementation of Device=
Set interface
> > > > > > >     (no matching commit)
> > > > > > >   - [RFC,v2,06/12] core: Check if device has RSI
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
f95ffcc8b1fe
> > > > > > >   - [RFC,v2,07/12] main.conf: Add CSIP profile configurable o=
ptions
> > > > > > >     (no matching commit)
> > > > > > >   - [RFC,v2,08/12] shared/csip: Add initial code for handling=
 CSIP
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
d297a03b7a61
> > > > > > >   - [RFC,v2,09/12] profiles: Add initial code for csip plugin
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
9e1eb0a62b3f
> > > > > > >   - [RFC,v2,10/12] tools: Add support to generate RSI using S=
IRK
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
c446a64d461b
> > > > > > >   - [RFC,v2,11/12] client: Add support for DeviceSet proxy
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
373bafc34ce6
> > > > > > >   - [RFC,v2,12/12] client: Use AdvertisingFlags when availabl=
e
> > > > > > >     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D=
815f779aa8e4
> > > > > > >
> > > > > > > You are awesome, thank you!
> > > > > > > --
> > > > > > > Deet-doot-dot, I am a bot.
> > > > > > > https://korg.docs.kernel.org/patchwork/pwbot.html
> > > > > >
> > > > > > Let me know if you guys are happy with this interface to detect
> > > > > > Coordinated Sets, it still experimental so we can experiment wi=
th it
> > > > > > until we think it is stable, regarding the implementation of th=
e
> > > > > > transports one major difference here is that we will need to en=
code
> > > > > > left and right separately, not sure how hard it is to do that i=
n
> > > > > > pipewire?
> > > > >
> > > > > As far as the device set DBus interface is concerned, it seems to=
 work
> > > > > fine for me currently (in wip implementation for PW [0]). Don't r=
ight
> > > > > now see something that would need to be added/changed in it.
> > > > >
> > > > > Channel splitting/merging is generally easy in PW. How the playba=
ck
> > > > > synchronization is going to work on socket level may determine a =
bit at
> > > > > what level in PW it is convenient to do though.
> > > > >
> > > > >
> > > > > ---
> > > > >
> > > > > Laundry list for PW related to this:
> > > > >
> > > > > * How to do TX syncronization properly with the ISO sockets needs=
 still
> > > > > some thinking. I have some wip patches [2] that add the timestamp=
s and
> > > > > other socket API that provide timing information to allow
> > > > > synchronization to the Number of Completed packets events.
> > > > > Corresponding Pipewire implementation [3] rate matches to keep th=
e time
> > > > > difference between those events and our audio reference time fixe=
d at
> > > > > e.g. 25ms (2 packets in controller). Not really clear yet if this=
 is a
> > > > > right thing to do to help the controller send packets at the righ=
t
> > > > > time.
> > > >
> > > > I have to check with our controller folks, I do recall someone sayi=
ng
> > > > that perhaps we should use framed instead of unframed so the
> > > > controller can better keep up with timings, but it is not yet clear
> > > > why.
> > > >
> > > > > Here I see LE Read ISO TX Sync with Intel AX210 returning only ze=
ro
> > > > > values in Command Complete in btmon for running CIS, so that comm=
and
> > > > > doesn't seem to help here.
> > > >
> > > > Yeah, I don't think it is implemented yet.
> > > >
> > > > > * BlueZ doesn't seem to pass on the PAC audio location it reads v=
ia
> > > > > read_sink/source_pac_loc, probably very easy to fix.
> > > >
> > > > Will take a look, afaik we fixed something like this not long ago b=
ut
> > > > perhaps you are talking about something different.
> > > >
> > > > > * The CIS in a CIG cannot be started one by one, or connected to =
same
> > > > > destination. The kernel appears to wait until all CIS sockets in =
same
> > > > > CIG go to connect state before proceeding to create CIS. The spec=
 does
> > > > > not seem to require this (I have some pre-rfc patches to make it =
more
> > > > > flexible [1].)
> > > >
> > > > It used to be like that but I actually have to fix it because the
> > > > controller don't accept multiple CreateCIS in parallel:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth=
-next.git/tree/net/bluetooth/hci_conn.c#n1907
> > > >
> > > > And it would actually create a relatively big window if we queue an=
d
> > > > wait for CIS established, because then the controller may set up it=
s
> > > > scheduling without taking into account the second CIS which will th=
en
> > > > fail when it comes to its setup, so I think it is better to program
> > > > them together to avoid having only one side working.
> > >
> > > Hmm, I made it queue and wait for the previous Create CIS to fully co=
mplete before emitting the next one, and that did seem to also work (also w=
ith TWS playback to the Samsung device).
> > > However did not extensively test, so even if allowed by spec risks ru=
nning to controller issues?
> > >
> > > The problem here is that the second CIS is not necessarily going to c=
ome, as it may be unrelated device put to same CIG since controller doesn't=
 support multiple CIG.
> > >
> > > In principle sound server can acquire always all CIS, but then we sho=
uld expose also the cig/cis properties on transports so they know which one=
s are needed.
> > >
> > > It could also make sense for BlueZ do it, when any cis in cig is star=
ted.
> > >
> > > > Btw, take a look at how it was done with bluetoothctl>
> > > > transport.acquire <transport_left> <transport_right>, we have been
> > > > able to use it to acquire both left/right earbuds and then send
> > > > pre-encoded files.
> > > >
> > > > > * PW currently does transport acquires synchronously and fails be=
cause
> > > > > of that with multiple CIS, but it probably should do them async.
> > > > >
> > > > >
> > > > > [0] https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requ=
ests/1564
> >
> > Did you make any progress on these changes above? Looks like the pull
> > request is still open, I wonder if you hit some blocker?
>
> The device set part is fine now.
>
> However, I've been first looking at sorting out TWS playback
> synchronization, and ran to some issues there.
>
>
> Current laundry list:
>
> (1) The playback to the left/right earbuds can rarely desynchronize
> spontaneously during playback, even though we send packets to both ISO
> socket fds at the same time on ISO interval schedule.
>
> Possibly, it goes to a state where the two CIS are off by one packet
> due to some queue on controller side. Desynchronization by 10ms can be
> heard easily in TWS earbuds as it transforms click at stereo center to
> separate clicks on left and right as brain interprets it.
>
> It usually resynchronizes if we halt sending packets to both CIS for ~
> 50+ ms and then continue, and sometimes it resynchronizes
> spontaneously.
>
> I've been looking at the conn->sent values at packet completion event
> time, but it is not clear it's possible to distinguish the
> desynchronized state from synchronized one, as it appears in both you
> can have either 0 or 1 and occasionally 2 packets not yet acked by the
> controller.

Interesting, what is the presentation delay configured, in theory that
should be used to synchronize the streams, we may need a way to
measure this latency and attempt to compensate for it somehow if
transfer speed variates.

>
> (2) With the Samsung device, Intel AX210 fails LE Create CIS for the
> CIG with both earbuds with current kernel (btmon logs below).  It works
> if only one device is connected. As a workaround, I'm currently using a
> patch [1] that changes it to do LE Create CIS for the CIG one by one.
> Since that works, could be some controller issue.

I believe we fixed that, are you running with the latest firmware and
bluetooth-next? On the kernel side you may need the following:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D70eff70d453bdb529d8233f59e32c1ffedac7685

>
> (3) The playback from Intel AX210 -> Samsung device apparently has some
> issue with the radio link/etc, as playback sometimes has crackling and
> distortion. I thought earlier this was some TX sync issue on sender
> side, but keeping 1+ packets queued in controller all the time did not
> solve it. Since also RX appears to miss packets, it's maybe not related
> to that after all.

This might be hard to figure out without air traces, will need to
reproduce it internally.

>
> (4) The Samsung device has some issue in that disabling source ASEs
> does not complete. Workaround is to never release transports, but would
> need to take a look again at this to be sure if it's only device issue.

Make sure you have btmon to collect the traces when this happens.

>
> (5) Sometimes when connecting one earbud, the other earbud fails to
> connect. Haven't yet looked into this.

Ive seen that, this may actually be something like:

https://github.com/bluez/bluez/issues/340#issuecomment-1494877679

This is less pronounced when we use the auto-connect list, since that
attempts to connect whenever it sees the device advertising so it will
continue to attempt multiple times, with the latest bluez tree this is
now the default behavior:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Dca07d198f9c=
7d289e95091c30ed15bff2106a7db

>
> Because of (2) and (3), I'm not sure now if (1) is general issue or
> only for this device combination. However, how things are done right
> now, there doesn't seem to be a way for the user to detect CIS
> desynchronization or recover from it.
>
> Some things I tried: setting matching sequence numbers to the HCI ISO
> packets for the two CIS, but doesn't seem to do anything (maybe
> controller ignores them?). Setting packet timestamps does something,
> but appears to require synchronizing to the controller clock to produce
> any audio, which cannot be done since the controller does not have
> working LE Read ISO TX Sync.
>
> I also thought that maybe kernel hci_sched_iso could cause it, but at
> least changing it to send packets to controller in sequence number
> (provided by PW) order didn't seem to change anything.
>
> So right now at least this TWS device usually works OK, but not yet
> robustly enough to be non-experimental feature.

Yeah, I think there will be some time needed to mature the stacks and
firmware to match what we currently have in Classic, but it is great
to have this sort of feedback from the audio subsystem.

>
> The Intel AX210 problem:
>
> [ 1627.217064] usb 1-5: new full-speed USB device number 16 using xhci_hc=
d
> [ 1627.370401] usb 1-5: New USB device found, idVendor=3D8087, idProduct=
=3D0032, bcdDevice=3D 0.00
> [ 1627.370408] usb 1-5: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
> [ 1627.374671] Bluetooth: hci0: Device revision is 0
> [ 1627.374676] Bluetooth: hci0: Secure boot is enabled
> [ 1627.374678] Bluetooth: hci0: OTP lock is enabled
> [ 1627.374680] Bluetooth: hci0: API lock is enabled
> [ 1627.374681] Bluetooth: hci0: Debug lock is disabled
> [ 1627.374683] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [ 1627.374685] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 =
build 38
> [ 1627.410381] Bluetooth: hci0: Found device firmware: intel/ibt-0041-004=
1.sfi
> [ 1627.410446] Bluetooth: hci0: Boot Address: 0x100800
> [ 1627.410447] Bluetooth: hci0: Firmware Version: 107-51.22
> [ 1629.568723] Bluetooth: hci0: Waiting for firmware download to complete
> [ 1629.569770] Bluetooth: hci0: Firmware loaded in 2108786 usecs
> [ 1629.570011] Bluetooth: hci0: Waiting for device to boot
> [ 1629.595622] Bluetooth: hci0: Device booted in 25187 usecs
> [ 1629.595647] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> [ 1629.595923] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-004=
1-0041.ddc
> [ 1629.597711] Bluetooth: hci0: Applying Intel DDC parameters completed
> [ 1629.600707] Bluetooth: hci0: Firmware timestamp 2022.51 buildtype 1 bu=
ild 56683
> [ 1629.677307] Bluetooth: MGMT ver 1.22
>
> < HCI Command: LE Set Connect.. (0x08|0x0062) plen 33  #16903 [hci0] 802.=
544515
>         CIG ID: 0x00
>         Central to Peripheral SDU Interval: 10000 us (0x002710)
>         Peripheral to Central SDU Interval: 10000 us (0x002710)
>         SCA: 201 - 500 ppm (0x00)
>         Packing: Sequential (0x00)
>         Framing: Unframed (0x00)
>         Central to Peripheral Maximum Latency: 20 ms (0x0014)
>         Peripheral to Central Maximum Latency: 20 ms (0x0014)
>         Number of CIS: 2
>         CIS ID: 0x00
>         Central to Peripheral Maximum SDU Size: 120
>         Peripheral to Central Maximum SDU Size: 120
>         Central to Peripheral PHY: LE 2M (0x02)
>         Peripheral to Central PHY: LE 2M (0x02)
>         Central to Peripheral Retransmission attempts: 0x05
>         Peripheral to Central Retransmission attempts: 0x05
>         CIS ID: 0x01
>         Central to Peripheral Maximum SDU Size: 120
>         Peripheral to Central Maximum SDU Size: 120
>         Central to Peripheral PHY: LE 2M (0x02)
>         Peripheral to Central PHY: LE 2M (0x02)
>         Central to Peripheral Retransmission attempts: 0x05
>         Peripheral to Central Retransmission attempts: 0x05
> > HCI Event: Command Complete (0x0e) plen 10           #16904 [hci0] 802.=
547134
>       LE Set Connected Isochronous Group Parameters (0x08|0x0062) ncmd 1
>         Status: Success (0x00)
>         CIG ID: 0x00
>         Number of Handles: 2
>         Connection Handle #0: 2560
>         Connection Handle #1: 2561
> ...
> < HCI Command: LE Create Conne.. (0x08|0x0064) plen 9  #16928 [hci0] 833.=
626566
>         Number of CIS: 2
>         CIS Handle: 2560
>         ACL Handle: 3585
>         CIS Handle: 2561
>         ACL Handle: 3586
> > HCI Event: Command Status (0x0f) plen 4              #16929 [hci0] 833.=
628188
>       LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 29              #16930 [hci0] 833.=
670453
>       LE Connected Isochronous Stream Established (0x19)
>         Status: Unspecified Error (0x1f)
>         Connection Handle: 2561
>         CIG Synchronization Delay: 89856 us (0x015f00)
>         CIS Synchronization Delay: 4718843 us (0x4800fb)
>         Central to Peripheral Latency: 1 us (0x000001)
>         Peripheral to Central Latency: 0 us (0x000000)
>         Central to Peripheral PHY: Reserved (0x00)
>         Peripheral to Central PHY: Reserved (0x00)
>         Number of Subevents: 0
>         Central to Peripheral Burst Number: 0
>         Peripheral to Central Burst Number: 0
>         Central to Peripheral Flush Timeout: 0
>         Peripheral to Central Flush Timeout: 0
>         Central to Peripheral MTU: 1536
>         Peripheral to Central MTU: 0
>         ISO Interval: 10752
> =3D bluetoothd: profiles/audio/bap.c:iso_connect_cb() connect to 2..   83=
3.670831
>
> --
> Pauli Virtanen
>
>
>
> > > [1] https://github.com/pv/linux/commits/iso-fix-multicis
> > > [2] https://github.com/pv/linux/commits/iso-timestamp
> > > [3] https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-timest=
amp-test
>

https://gitlab.freedesktop.org/pvir/pipewire/-/commit/667ab3c693e0425568ac4=
05a6a311754ed798653

In the isotest/bluetoothctl we actually use the latency/interval to
determine how many packets we have to send at each ISO interval:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/isotest.c#n70=
4

--=20
Luiz Augusto von Dentz
