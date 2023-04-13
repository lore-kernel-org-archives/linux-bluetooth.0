Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CF6C77B6E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 20:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDMULZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 16:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMULY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 16:11:24 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD22F3C21
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 13:11:21 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 5EB2D2402EF
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 22:11:20 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Py9h72rN5z9rxL;
        Thu, 13 Apr 2023 22:11:19 +0200 (CEST)
Message-ID: <1d53ff91f48028eb4cb8e67cd6ccbf59546eadf5.camel@iki.fi>
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis 
        <frederic.danis@collabora.com>
Date:   Thu, 13 Apr 2023 20:11:18 +0000
In-Reply-To: <CABBYNZK5h4Vn9_Y8S2WsK_DHb6jvWDMjP-u=Vgos6SO4fRUatA@mail.gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
         <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
         <CABBYNZJ8GbCic4+dAz-04vji3xgtqYnXRUjTuWHSk3oGjXxA=Q@mail.gmail.com>
         <f86f2896be923a9caa5625457fea46d1c32b3114.camel@iki.fi>
         <CABBYNZKv68ybD3YVKFtHUARh6H+TVY=2_P9TdNWEbZ4FbTX31w@mail.gmail.com>
         <A02E43E3-63E3-4F75-AB99-FB355180DD2B@iki.fi>
         <CABBYNZJdjq2TZCpNVSC-za6e++GgeL2M3=G=11g7u33NDeEpgg@mail.gmail.com>
         <ca30b39204f49e793317a5008f825656e1f40c3f.camel@iki.fi>
         <CABBYNZK5h4Vn9_Y8S2WsK_DHb6jvWDMjP-u=Vgos6SO4fRUatA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> Hi Pauli,
> 
> On Thu, Apr 6, 2023 at 11:08 AM Pauli Virtanen <pav@iki.fi> wrote:
> > ke, 2023-04-05 kello 17:16 -0700, Luiz Augusto von Dentz kirjoitti:
[clip]
> > > > [0] https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/1564
> > >
> > > Did you make any progress on these changes above? Looks like the pull
> > > request is still open, I wonder if you hit some blocker?
> >
> > The device set part is fine now.
> >
> > However, I've been first looking at sorting out TWS playback
> > synchronization, and ran to some issues there.
> >
> >
> > Current laundry list:
> >
> > (1) The playback to the left/right earbuds can rarely desynchronize
> > spontaneously during playback, even though we send packets to both ISO
> > socket fds at the same time on ISO interval schedule.
> >
> > Possibly, it goes to a state where the two CIS are off by one packet
> > due to some queue on controller side. Desynchronization by 10ms can be
> > heard easily in TWS earbuds as it transforms click at stereo center to
> > separate clicks on left and right as brain interprets it.
> >
> > It usually resynchronizes if we halt sending packets to both CIS for ~
> > 50+ ms and then continue, and sometimes it resynchronizes
> > spontaneously.
> >
> > I've been looking at the conn->sent values at packet completion event
> > time, but it is not clear it's possible to distinguish the
> > desynchronized state from synchronized one, as it appears in both you
> > can have either 0 or 1 and occasionally 2 packets not yet acked by the
> > controller.
> 
> Interesting, what is the presentation delay configured, in theory that
> should be used to synchronize the streams, we may need a way to
> measure this latency and attempt to compensate for it somehow if
> transfer speed variates.

The presentation delay is configured as 40ms, the device also reports
max=min=40ms limits for the delay.

The CIG configuration is

< HCI Command: LE Set Connected.. (0x08|0x0062) plen 33 #686 [hci1]
    CIG ID: 0x00
    Central to Peripheral SDU Interval: 10000 us (0x002710)
    Peripheral to Central SDU Interval: 10000 us (0x002710)
    SCA: 201 - 500 ppm (0x00)
    Packing: Sequential (0x00)
    Framing: Unframed (0x00)
    Central to Peripheral Maximum Latency: 100 ms (0x0064)
    Peripheral to Central Maximum Latency: 100 ms (0x0064)
    Number of CIS: 2
    CIS ID: 0x00
    Central to Peripheral Maximum SDU Size: 120
    Peripheral to Central Maximum SDU Size: 120
    Central to Peripheral PHY: LE 2M (0x02)
    Peripheral to Central PHY: LE 2M (0x02)
    Central to Peripheral Retransmission attempts: 0x05
    Peripheral to Central Retransmission attempts: 0x05
    CIS ID: 0x01
    Central to Peripheral Maximum SDU Size: 120
    Peripheral to Central Maximum SDU Size: 120
    Central to Peripheral PHY: LE 2M (0x02)
    Peripheral to Central PHY: LE 2M (0x02)
    Central to Peripheral Retransmission attempts: 0x05
    Peripheral to Central Retransmission attempts: 0x05

Sometimes the desynchronization appears immediately after connect, or
randomly during playback.  It can also be part of the time be triggered
by walking away from the transmitter, or covering the earpieces by hands
until it starts to stutter. This last one is the most reliable reproducer,
but still not high success rate so a bit hard to debug.

In one case this persisted also over device disconnect + reconnect.

From the ISO socket user side, nothing unusual seems to happen, all
writes succeed so we're not dropping data. In one case I checked where
the playback was desynchronized after start, we were writing to both
sockets every 10ms with max +-0.2ms jitter.

Not sure how to debug this further right now. Maybe should check with
different devices.

> > (2) With the Samsung device, Intel AX210 fails LE Create CIS for the
> > CIG with both earbuds with current kernel (btmon logs below).  It works
> > if only one device is connected. As a workaround, I'm currently using a
> > patch [1] that changes it to do LE Create CIS for the CIG one by one.
> > Since that works, could be some controller issue.
> 
> I believe we fixed that, are you running with the latest firmware and
> bluetooth-next? On the kernel side you may need the following:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=70eff70d453bdb529d8233f59e32c1ffedac7685

I missed that patch, seems to work fine with it.

> > (3) The playback from Intel AX210 -> Samsung device apparently has some
> > issue with the radio link/etc, as playback sometimes has crackling and
> > distortion. I thought earlier this was some TX sync issue on sender
> > side, but keeping 1+ packets queued in controller all the time did not
> > solve it. Since also RX appears to miss packets, it's maybe not related
> > to that after all.
> 
> This might be hard to figure out without air traces, will need to
> reproduce it internally.

This might be partly due to bad QoS.

good:

< HCI Command: LE Set Connected.. (0x08|0x0062) plen 33 #686 [hci1]
...
 Central to Peripheral Maximum Latency: 100 ms (0x0064)
 Peripheral to Central Maximum Latency: 100 ms (0x0064)

bad:

< HCI Command: LE Set Connected.. (0x08|0x0062) plen 33 #862 [hci1]
...
 Central to Peripheral Maximum Latency: 20 ms (0x0014)
 Peripheral to Central Maximum Latency: 20 ms (0x0014)

In the "good" case there is sometimes crackling, but in the "bad" case
it's continuous.

However, also in the "good" case it seems we are not receiving all RX
packets we should get. The average RX rate in btmon seems to be 183
packets/s for two devices instead of 200/s. (Suspiciously close to
200*44100/48000...)

The "bad" case occurred because BlueZ does not pass the Latency parameter (or
any other QoS parameters) to SelectProperties if it has not connected to the
device before, so we ended up configuring the QoS with low-latency value from
BAP Table 5.2, which apparently the devices couldn't handle. (I switched this
now to use the "high-reliability" values from the table as fallback, but it's a
workaround.)

IIUC the max latency is supposed to be configured as

1. Target_Latency -> Config Codec -> Max_Transport_Latency
2. select good Max_Transport_Latency -> Config QoS

Currently SelectProperties is supposed to select QoS parameters, but it
is called before Config Codec, so Max_Transport_Latency, preferred
Presentation_Delay, etc. are not known at that time if bluez didn't
cache them somewhere.

I see there are some TODOs in BlueZ sources on this, so looks like known issue.

> > (4) The Samsung device has some issue in that disabling source ASEs
> > does not complete. Workaround is to never release transports, but would
> > need to take a look again at this to be sure if it's only device issue.
> 
> Make sure you have btmon to collect the traces when this happens.

I'll try to come back to this.

> > (5) Sometimes when connecting one earbud, the other earbud fails to
> > connect. Haven't yet looked into this.
> 
> Ive seen that, this may actually be something like:
> 
> https://github.com/bluez/bluez/issues/340#issuecomment-1494877679
> 
> This is less pronounced when we use the auto-connect list, since that
> attempts to connect whenever it sees the device advertising so it will
> continue to attempt multiple times, with the latest bluez tree this is
> now the default behavior:
> 
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=ca07d198f9c7d289e95091c30ed15bff2106a7db
> 
> >
> > Because of (2) and (3), I'm not sure now if (1) is general issue or
> > only for this device combination. However, how things are done right
> > now, there doesn't seem to be a way for the user to detect CIS
> > desynchronization or recover from it.
> >
> > Some things I tried: setting matching sequence numbers to the HCI ISO
> > packets for the two CIS, but doesn't seem to do anything (maybe
> > controller ignores them?). Setting packet timestamps does something,
> > but appears to require synchronizing to the controller clock to produce
> > any audio, which cannot be done since the controller does not have
> > working LE Read ISO TX Sync.
> >
> > I also thought that maybe kernel hci_sched_iso could cause it, but at
> > least changing it to send packets to controller in sequence number
> > (provided by PW) order didn't seem to change anything.
> >
> > So right now at least this TWS device usually works OK, but not yet
> > robustly enough to be non-experimental feature.
> 
> Yeah, I think there will be some time needed to mature the stacks and
> firmware to match what we currently have in Classic, but it is great
> to have this sort of feedback from the audio subsystem.
> 
> >
> > The Intel AX210 problem:
> >
> > [ 1627.217064] usb 1-5: new full-speed USB device number 16 using xhci_hcd
> > [ 1627.370401] usb 1-5: New USB device found, idVendor=8087, idProduct=0032, bcdDevice= 0.00
> > [ 1627.370408] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > [ 1627.374671] Bluetooth: hci0: Device revision is 0
> > [ 1627.374676] Bluetooth: hci0: Secure boot is enabled
> > [ 1627.374678] Bluetooth: hci0: OTP lock is enabled
> > [ 1627.374680] Bluetooth: hci0: API lock is enabled
> > [ 1627.374681] Bluetooth: hci0: Debug lock is disabled
> > [ 1627.374683] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> > [ 1627.374685] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
> > [ 1627.410381] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.sfi
> > [ 1627.410446] Bluetooth: hci0: Boot Address: 0x100800
> > [ 1627.410447] Bluetooth: hci0: Firmware Version: 107-51.22
> > [ 1629.568723] Bluetooth: hci0: Waiting for firmware download to complete
> > [ 1629.569770] Bluetooth: hci0: Firmware loaded in 2108786 usecs
> > [ 1629.570011] Bluetooth: hci0: Waiting for device to boot
> > [ 1629.595622] Bluetooth: hci0: Device booted in 25187 usecs
> > [ 1629.595647] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
> > [ 1629.595923] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0041-0041.ddc
> > [ 1629.597711] Bluetooth: hci0: Applying Intel DDC parameters completed
> > [ 1629.600707] Bluetooth: hci0: Firmware timestamp 2022.51 buildtype 1 build 56683
> > [ 1629.677307] Bluetooth: MGMT ver 1.22
> >
> > < HCI Command: LE Set Connect.. (0x08|0x0062) plen 33  #16903 [hci0] 802.544515
> >         CIG ID: 0x00
> >         Central to Peripheral SDU Interval: 10000 us (0x002710)
> >         Peripheral to Central SDU Interval: 10000 us (0x002710)
> >         SCA: 201 - 500 ppm (0x00)
> >         Packing: Sequential (0x00)
> >         Framing: Unframed (0x00)
> >         Central to Peripheral Maximum Latency: 20 ms (0x0014)
> >         Peripheral to Central Maximum Latency: 20 ms (0x0014)
> >         Number of CIS: 2
> >         CIS ID: 0x00
> >         Central to Peripheral Maximum SDU Size: 120
> >         Peripheral to Central Maximum SDU Size: 120
> >         Central to Peripheral PHY: LE 2M (0x02)
> >         Peripheral to Central PHY: LE 2M (0x02)
> >         Central to Peripheral Retransmission attempts: 0x05
> >         Peripheral to Central Retransmission attempts: 0x05
> >         CIS ID: 0x01
> >         Central to Peripheral Maximum SDU Size: 120
> >         Peripheral to Central Maximum SDU Size: 120
> >         Central to Peripheral PHY: LE 2M (0x02)
> >         Peripheral to Central PHY: LE 2M (0x02)
> >         Central to Peripheral Retransmission attempts: 0x05
> >         Peripheral to Central Retransmission attempts: 0x05
> > > HCI Event: Command Complete (0x0e) plen 10           #16904 [hci0] 802.547134
> >       LE Set Connected Isochronous Group Parameters (0x08|0x0062) ncmd 1
> >         Status: Success (0x00)
> >         CIG ID: 0x00
> >         Number of Handles: 2
> >         Connection Handle #0: 2560
> >         Connection Handle #1: 2561
> > ...
> > < HCI Command: LE Create Conne.. (0x08|0x0064) plen 9  #16928 [hci0] 833.626566
> >         Number of CIS: 2
> >         CIS Handle: 2560
> >         ACL Handle: 3585
> >         CIS Handle: 2561
> >         ACL Handle: 3586
> > > HCI Event: Command Status (0x0f) plen 4              #16929 [hci0] 833.628188
> >       LE Create Connected Isochronous Stream (0x08|0x0064) ncmd 1
> >         Status: Success (0x00)
> > > HCI Event: LE Meta Event (0x3e) plen 29              #16930 [hci0] 833.670453
> >       LE Connected Isochronous Stream Established (0x19)
> >         Status: Unspecified Error (0x1f)
> >         Connection Handle: 2561
> >         CIG Synchronization Delay: 89856 us (0x015f00)
> >         CIS Synchronization Delay: 4718843 us (0x4800fb)
> >         Central to Peripheral Latency: 1 us (0x000001)
> >         Peripheral to Central Latency: 0 us (0x000000)
> >         Central to Peripheral PHY: Reserved (0x00)
> >         Peripheral to Central PHY: Reserved (0x00)
> >         Number of Subevents: 0
> >         Central to Peripheral Burst Number: 0
> >         Peripheral to Central Burst Number: 0
> >         Central to Peripheral Flush Timeout: 0
> >         Peripheral to Central Flush Timeout: 0
> >         Central to Peripheral MTU: 1536
> >         Peripheral to Central MTU: 0
> >         ISO Interval: 10752
> > = bluetoothd: profiles/audio/bap.c:iso_connect_cb() connect to 2..   833.670831
> >
> > --
> > Pauli Virtanen
> >
> >
> >
> > > > [1] https://github.com/pv/linux/commits/iso-fix-multicis
> > > > [2] https://github.com/pv/linux/commits/iso-timestamp
> > > > [3] https://gitlab.freedesktop.org/pvir/pipewire/-/commits/iso-timestamp-test
> >
> 
> https://gitlab.freedesktop.org/pvir/pipewire/-/commit/667ab3c693e0425568ac405a6a311754ed798653
> 
> In the isotest/bluetoothctl we actually use the latency/interval to
> determine how many packets we have to send at each ISO interval:
> 
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/isotest.c#n704

In realtime context it seems what isotest.c does (or intends to --- does
it actually skip the first sleep to have extra packets queued in
controller?) probably is equivalent to pushing num extra packets of
silence to the socket when playback starts.

Looking at Core v5.3, Part G, Fig 3.2, it seems to me this increases
latency by the number of extra packets pushed, on top of the transport
latency. If it is so, I think we'd like to use as few as possible or
none.

OTOH, if the statement is that we should write num=latency/interval packets
every num intervals, I don't quite understand why, and it seems also
this should increase latency because we need to gather all that audio
data before we can send it to the socket?

-- 
Pauli Virtanen
