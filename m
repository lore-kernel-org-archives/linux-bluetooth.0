Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F68AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 19:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EC364DDA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 19:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhBMTbe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Feb 2021 14:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMTbc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Feb 2021 14:31:32 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AE4C061756
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Feb 2021 11:30:51 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a1so1415032qvd.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Feb 2021 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaishome.de; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=mdlGtuXhv/dUj5N7XOYaetNNgIQNOD97PuKooJ4INBA=;
        b=Aq1ezFu8sLyxw3s/zhkFRwCqO4yN8v9LFVwh7CwsmrsVL567jhlyA+Mwi0568uNyIQ
         beHYx3IzoSn8k+xTOi7+J76lplNYHaHgHTC/w2sylqVAKXYuH1bN956PsSAXJGzj0BT5
         bzLOn6kcnQA1T7/HW+AIrJrsfAVBQZSA5C1kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mdlGtuXhv/dUj5N7XOYaetNNgIQNOD97PuKooJ4INBA=;
        b=kxnAk4drdkC//3ZnajuI1qFTm/8faHxKweYDmVW3iw4XwWvwbEDgE3di5FIRB3XqlN
         TiJNRKDPfa9Lhh+bCufObAt1AXIf/d4feKAB9U4A0RrpRdEfOe764wWgRR1FetqptKZ8
         6hJaeVZiqE123eJZmq+bQ+RBTUjfkMhfIHdSGm+bwCZV32FRyznSORUmZyxn8vaJF7vG
         9gqrFHkTN6TvdC9D/RtOYekDbMCPG1WpROvD+5FLSHTpzc2822r5aIKR05ClUwCVnMou
         Ym4yqBqBdtc03PaJklUWA9XSCOYlWV5GkrNm1QPX+x1lw1H9C+kyoTHiUlVa7g6IbnwJ
         FfsQ==
X-Gm-Message-State: AOAM5316YIqxi8PwZ8s5hkHyqTgf815rMafSddi8QOPvHYWwbYwW3vtG
        L9dIHrqfpmLXO/N1YpdkbFqppC7grL/KzmpJsgJZn8wQlFLDmg==
X-Google-Smtp-Source: ABdhPJzeiU/eIOF8X2YAwF4UtVfTHXqqYMbcOhPXTXfr/9m+dVHjEFzjcP7eyCcQE7nWnWU8ldcm9ASC+R3rFfk0txc=
X-Received: by 2002:ad4:542b:: with SMTP id g11mr8339908qvt.47.1613244649269;
 Sat, 13 Feb 2021 11:30:49 -0800 (PST)
MIME-Version: 1.0
From:   Kai Krakow <kai@kaishome.de>
Date:   Sat, 13 Feb 2021 20:30:37 +0100
Message-ID: <CAC2ZOYuG_BBG0uisXkoTtroxwgvv+JO-yMFC2+bRQZjsvwK1qw@mail.gmail.com>
Subject: Xbox Elite 2 controller stops sending data during inquiries from
 nearby devices
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

I'm the maintainer of the xpadneo driver for Xbox controllers in
Bluetooth mode. I'm currently testing two different models of the
controllers:

Xbox One S (model 1708)
Xbox Elite Series 2 (model 1797)

With commit 98d2c3e17310 ("Bluetooth: L2CAP: Try harder to accept
device not knowing options") we can finally connect the controllers
without disabling ERTM. Without the patch, all the controllers will
fail to connect most of the time if not always.

Here's what works since ERTM can stay enabled:

With ERTM enabled, the controllers no longer crash in their firmware
when sending rumble packets at specific varying rates. Previously, the
controller tended to stop sending back input data, eventually
rebooting after some time (but not always).

Some history / context about the problems (with ERTM disabled):

That looks like a crash or race condition in the firmware. The results
looked pretty random but consistently between kernel or Bluez versions
so it probably depends on some implementation detail: Sometimes the
controller would stop sending any input data, sometimes at least one
axis still worked, sometimes rumble would still work, or any
combination of those. This problem does not seem to exist when using
the Android bluetooth stack (fluoride?) - tho I didn't really test it
there extensively. At least in Android, the controllers establish the
Bluetooth connection instantly while in Linux, it may take up to 30
seconds to establish the connection / pairing. Often, it would not
exchange the link key, resulting in pairing failing (but still able to
connect manually with `bluetoothctl connect MAC`). But finally, this
seems fixed when we enable ERTM after the patch referenced above is
applied.

Now let's get to the core of this report (after applying the above
referenced patch, and enabling ERTM):

From all what I could test, model 1708 works correctly now with some
quirks: It may take some time / effort pairing the controller.
Usually, it works fine using the KDE GUI client for pairing while it
doesn't using `bluetoothctl` alone. I'm not sure why that is but once
it's paired (with a link key in `/var/lib/bluetooth`, it reconnects
fine in later attempts, tho it may take 20-30s to do that. After this,
the gamepad runs just fine in games, rumble works flawlessly, no input
lag, no loss of input data. Good work.

Model 1797 is a different story: This model now connects instantly,
this is a success. Previously, it would show the same behavior as
model 1708, often taking 20-30s to connect, or failing every once in a
while, often even losing the connection again after being connected
for a few seconds.

But now I'm seeing the following odd behavior: When running `btmon`, I
see a constant flow of input data while moving the sticks in a circle
(thus generating a constant stream of input events). Now, when a
nearby device starts some inquiry, the gamepad stops sending any data
until some time after the inquiry is done. Some of the last events
then get sent back resembling the current state of the device as if
the gamepad flushed some buffers. Often, that's exactly three input
state buffers if you put the gamepad idle on your desk while the
inquiry is running. This observation is repeatable. Also, during
gaming, I may have seen issues where input events of the device may
lag behind several seconds, however, I'm not sure if this was caused
by a nearby device as I didn't log any data with `btmon` (neither I
could associate that on a timeline with lagging events in the game).

Here's a (rather lengthy) btmon log of such an incident (packets
starting with `a1 01` are input event packets from the controller,
part of the constant stream of input data I generated using the
sticks):
```
... [multiple seconds of big amounts of input data before here]
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1018 [hci0] 14.917844
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 11 8e ff ff 00 00 00 00 00 00  .....y..........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1019 [hci0] 14.927824
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 6c 6b ff ff 00 00 00 00 00 00  .....ylk........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1020 [hci0] 14.937827
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 e5 67 ff ff 00 00 00 00 00 00  .....y.g........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
@ MGMT Command: Start Service Disc.. (0x003a) plen 4  {0x0001} [hci0] 14.946337
        Address type: 0x01
          BR/EDR
        RSSI: invalid (0x7f)
        UUIDs: 0
< HCI Command: Inquiry (0x01|0x0001) plen 5              #1021 [hci0] 14.946384
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4                #1022 [hci0] 14.947699
      Inquiry (0x01|0x0001) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4        {0x0001} [hci0] 14.947758
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x01
          BR/EDR
@ MGMT Event: Discovering (0x0013) plen 2             {0x0001} [hci0] 14.947764
        Address type: 0x01
          BR/EDR
        Discovery: Enabled (0x01)
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1023 [hci0] 14.947929
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 de 4b 58 ff 00 00 00 00 00 00  .....y.KX.......
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1024 [hci0] 14.957878
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 1f 48 94 fd 00 00 00 00 00 00  .....y.H........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1025 [hci0] 14.967867
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 68 2c ff f9 00 00 00 00 00 00  .....yh,........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1026 [hci0] 14.977852
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 73 2a 0f e0 00 00 00 00 00 00  .....ys*........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1027 [hci0] 14.987828
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 a2 26 48 de 00 00 00 00 00 00  .....y.&H.......
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1028 [hci0] 14.997829
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 40 22 cd da 00 00 00 00 00 00  .....y@"........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1029 [hci0] 15.017840
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 f2 07 23 c0 00 00 00 00 00 00  .....y..#.......
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1030 [hci0] 15.118729
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -71 dBm (0xb9)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 15.118782
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -71 dBm (0xb9)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1031 [hci0] 15.300714
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -82 dBm (0xae)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 15.300795
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -82 dBm (0xae)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1032 [hci0] 15.951737
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -77 dBm (0xb3)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 15.951803
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -77 dBm (0xb3)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1033 [hci0] 16.873673
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -82 dBm (0xae)
@ MGMT Event: Device Found (0x0012) plen 19           {0x0001} [hci0] 16.873706
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -82 dBm (0xae)
        Flags: 0x00000000
        Data length: 5
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1034 [hci0] 17.034695
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -74 dBm (0xb6)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 17.034747
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -74 dBm (0xb6)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1035 [hci0] 17.074695
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -82 dBm (0xae)
@ MGMT Event: Device Found (0x0012) plen 19           {0x0001} [hci0] 17.074745
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -82 dBm (0xae)
        Flags: 0x00000000
        Data length: 5
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1036 [hci0] 17.725662
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -72 dBm (0xb8)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 17.725697
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -72 dBm (0xb8)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1037 [hci0] 18.245667
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c7
        RSSI: -72 dBm (0xb8)
@ MGMT Event: Device Found (0x0012) plen 19           {0x0001} [hci0] 18.245699
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -72 dBm (0xb8)
        Flags: 0x00000000
        Data length: 5
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1038 [hci0] 20.628660
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -84 dBm (0xac)
@ MGMT Event: Device Found (0x0012) plen 19           {0x0001} [hci0] 20.628670
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -84 dBm (0xac)
        Flags: 0x00000000
        Data length: 5
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1039 [hci0] 20.669660
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -74 dBm (0xb6)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 20.669668
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -74 dBm (0xb6)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1040 [hci0] 21.120638
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -74 dBm (0xb6)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 21.120657
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -74 dBm (0xb6)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1041 [hci0] 21.932648
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -84 dBm (0xac)
@ MGMT Event: Device Found (0x0012) plen 19           {0x0001} [hci0] 21.932670
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -84 dBm (0xac)
        Flags: 0x00000000
        Data length: 5
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1042 [hci0] 22.052643
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -80 dBm (0xb0)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 22.052663
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -80 dBm (0xb0)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1043 [hci0] 22.493650
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -74 dBm (0xb6)
@ MGMT Event: Device Found (0x0012) plen 19           {0x0001} [hci0] 22.493662
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -74 dBm (0xb6)
        Flags: 0x00000000
        Data length: 5
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1044 [hci0] 22.534661
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -84 dBm (0xac)
@ MGMT Event: Device Found (0x0012) plen 19           {0x0001} [hci0] 22.534684
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -84 dBm (0xac)
        Flags: 0x00000000
        Data length: 5
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1045 [hci0] 23.035642
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c6
        RSSI: -72 dBm (0xb8)
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
@ MGMT Event: Device Found (0x0012) plen 70           {0x0001} [hci0] 23.035660
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -72 dBm (0xb8)
        Flags: 0x00000000
        Data length: 56
        Device ID: Bluetooth SIG assigned (0x0001)
          Vendor: STABILO International (1256)
          Product: 0x8080
          Version: 0.0.0 (0x0000)
        Name (complete): [TV]Samsung LED55
        16-bit Service UUIDs (complete): 3 entries
          Audio Source (0x110a)
          A/V Remote Control Target (0x110c)
          PnP Information (0x1200)
        3D Information Data: 0348
          Features: 0x03
            Association Notification
            Battery Level Reporting
          Path Loss Threshold: 72
        Company: Broadcom Corporation (15)
          Data: 002148
        TX power: 0 dBm
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Extended Inquiry Result (0x2f) plen 255     #1046 [hci0] 23.555656
        Num responses: 1
        Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        Page scan repetition mode: R1 (0x01)
        Page period mode: P2 (0x02)
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
        Clock offset: 0x70c7
        RSSI: -72 dBm (0xb8)
@ MGMT Event: Device Found (0x0012) plen 19           {0x0001} [hci0] 23.555680
        BR/EDR Address: C4:57:6E:39:F1:36 (Samsung Electronics Co.,Ltd)
        RSSI: -72 dBm (0xb8)
        Flags: 0x00000000
        Data length: 5
        Class: 0x08043c
          Major class: Audio/Video (headset, speaker, stereo, video, vcr)
          Minor class: Video Display and Loudspeaker
          Capturing (Scanner, Microphone)
> HCI Event: Inquiry Complete (0x01) plen 1              #1047 [hci0] 25.197642
        Status: Success (0x00)
@ MGMT Event: Discovering (0x0013) plen 2             {0x0001} [hci0] 25.197656
        Address type: 0x01
          BR/EDR
        Discovery: Disabled (0x00)
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1048 [hci0] 25.199137
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 6b 81 f6 7f 00 00 00 00 00 00  .....yk.........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1049 [hci0] 25.207888
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 6b 81 f6 7f 00 00 00 00 00 00  .....yk.........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
> ACL Data RX: Handle 74 flags 0x02 dlen 44              #1050 [hci0] 25.217897
      Channel: 65 len 40 [PSM 0 mode Basic (0x00)] {chan 65535}
        a1 01 e0 81 ea 79 6b 81 f6 7f 00 00 00 00 00 00  .....yk.........
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00                          ........
```

As you can see, input data is received roughly around every 0.01s
(which seems to be some internal heartbeat of the firmware, around 100
Hz, which matches with the maximum rate of rumble programming we may
send to the controller without crashing it). But when the C4:57:6E
device starts to show up in the log, the controller pauses sending any
more data for multiple seconds. This behavior cannot be observed when
connected to an Android device so we probably cannot say that this is
a bug of the gamepad firmware (tho, it still has a lot of quirks I'd
consider a bug).

Windows users may report similar problems, tho there's no indication
of it being the same problem as there are no logs provided:
https://answers.microsoft.com/de-de/xbox/forum/xba_wowpc-xba_gowpc/xbox-elite-series-2-disconnecting-from-pc/7e5a964a-16cc-4e83-8dec-aa8c858b875c

I've linked some more reports in the xpadneo project:
https://github.com/atar-axis/xpadneo/issues/198

I'd happily provide more data / details to debug this.

Thanks,
Kai
