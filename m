Return-Path: <SRS0=OFBO=AG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 11:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9494E207BB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Jun 2020 11:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404125AbgFYLRD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:17:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404076AbgFYLRC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Jun 2020 07:17:02 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 25 Jun 2020 11:16:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: virtuousfox@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-60824-62941-GutNICIJ1N@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #91 from Sergey Kondakov (virtuousfox@gmail.com) ---
Created attachment 289883
  --> https://bugzilla.kernel.org/attachment.cgi?id=289883&action=edit
ISSC_ds4_pass.btsnoop

(In reply to Swyter from comment #90)
> Because it's what I know, plain and simple. It's what I have been using and
> it's what I've been comfortable recommending. As long as they are HCI logs
> and *they exist* it doesn't matter the format, doing `btmon -w my.log` is
> much nicer than `hcidump -X`, that's for sure, so thanks for that. I'm
> learning as I go, I figured that if no one was stepping up I might as well
> give it a try. Seems like a good way of submitting a first patch and
> learning a few things. ¯\_(ツ)_/¯

Sure, it's just that not only hcidump likely to not be installed by default or
even packaged, the fact that it's long time obsoleted means that it can also be
incorrect and no one is going to debug it. btmon's file dumps are binary
though, so you would need to use `tee` to dump text as it scrolls or use `btmon
-r`.

> I took a look at your DS4 logs. I would take similar captures on Windows to
> compare, maybe the role switch isn't really needed. If you could link your
> Windows drivers here it may also be useful, maybe the dongle needs to be
> configured with vendor commands before using it. **Update**: Tested DS4
> pairing myself with BlueZ and no, the `Accept Connection Request` packet
> doesn't show up and it connects normally, the spec says that this isn't
> non-fatal, and in this case the one erroring out due to timeout and
> disconnecting is the DS4, so that's something to keep in mind.
> 
> From what I see, HCI_OP_ACCEPT_CONN_REQ seems to be called by the SCO layer
> in sco_conn_defer_accept():
> https://github.com/torvalds/linux/blob/
> cb8e59cc87201af93dfbb6c3dccc8fcad72a09c2/net/bluetooth/sco.c#L741
> Or alternatively from here, I believe:
> https://github.com/torvalds/linux/blob/
> cb8e59cc87201af93dfbb6c3dccc8fcad72a09c2/net/bluetooth/hci_event.c#L2742
> 
> It's a wild guess, but it may be sound-related.
> 

I might have made that dump with '-S' option which adds SCO messages that
otherwise might be ignored, just for completeness.

DualShocks 3 and 4 are fiddly to connect, when connecting to "new" dongle you
need to:
1) Remove any OS entries of it.
2) Force DS4 into pairing mode by holding SELECT+PS until light flashes
rapidly, for DS3 you need to connect it to USB. It will write dongle's MAC/UID
into itself.
3) Now you can switch it on normally. I'm pretty sure DS wants to be the master
in that connection.

It works fine on my old 2.x ISSC dongle which I tried to replace with fancier
4.x dongles twice while having 2.x as backup. First 4.x dongle killed itself
for no reason a minute after plugging in, bastards didn't even refund me for
its corpse. And second one is this CSR. But timeouts seem irrelevant, sometimes
they just don't react properly fast enough during pairing and they also refuse
to connect to a dongle that's not in their memory.

On Windows I just use Windows' stock drivers and DS4Windows
https://github.com/Ryochan7/DS4Windows for polling rate / latency, lights
controls, battery state tracking and xinput emulation. On Linux there is no
control (polling/latency would be really nice for battery/responsiveness
balancing and parity with new generation of consoles that advertise 1ms
wireless latency which DS4 should be well capable of) but I'm trying out
https://github.com/TheDrHax/ds4drv-cemuhook now. 

I think that Windows' BT stack just not as picky. There is no way they would do
per-device workarounds for garbage bin dongles like that. They JUST recently
(like last year or something) added USB audio driver after years of relying on
crappy, often licensed separately, third-party per-device implementations.

> 
> Another thing to keep in mind is that the bluez-utils package has a nifty
> `bccmd` tool for CSR devices (a clone of a proprietary tool, actually) that
> is able to get and set most of the internal firmware properties and detect
> the chip type, in theory. It doesn't work for me, though. I'm guessing
> there's an alternative way of accessing the vendor commands via USB, or the
> interface has changed since then.
> 
> But at least worth a shot on your end. Maybe you guys have more luck doing
> `bccmd chiprev`.

Fails for me with "Can't execute command: No such device or address (6)"

-- 
You are receiving this mail because:
You are the assignee for the bug.
