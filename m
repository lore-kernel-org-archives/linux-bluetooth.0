Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE44C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 19 Dec 2021 22:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhLSWmC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 19 Dec 2021 17:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhLSWmC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 19 Dec 2021 17:42:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D293DC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Dec 2021 14:42:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z5so31046110edd.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Dec 2021 14:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=rdm+XPWdUTW9XBuM/z4dDE5n/0HU9NRKXZpF1Mk1bGE=;
        b=EIlZwhqlE9pjvD9ZRB/vzd85xKLNjQV679gj3BONRdQy8qPmAFkLc4lW/zuXYzy3B1
         MRa7vydgms50QkrwM7eqCG3psMZlkHI6Pg3Xf63bYBbzVSyO3HqwlPRCW+lraW6Sf+mT
         jTkum1EETs9engj0e6OK8P8MuDXKsl+bPFVOTiTLJO8e1j7GRGBwEYG9ACYpbU02X1Sv
         LSHJzGqBvP3ioEw6CXaTsxkWsdTmxO3OgBp5++H/P7X4uiUzDIk/bNQp+gOJza5T66Jl
         Y2P5HT030imJRgV2Dp6pSg/bgsZdrQfRRsKGOTgyvq3GQXLGqhzsgKItMewWhMuazptM
         G9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rdm+XPWdUTW9XBuM/z4dDE5n/0HU9NRKXZpF1Mk1bGE=;
        b=BLeg+/sla8YH33R4b7ZjvZI9cSGohn1yqBTKp1MVAxQllV9gxbScj/DzR6EfTPrclI
         8ZC7KK7dTJYzZx9rwMQzGQ0NioW31e1u7FcsVvIpf9XP1TZcrlpAGXRKsiltWkvvVAD0
         aV4NyxMW43b+mU/mf8W4Oq0S/NZnXmw9nXCPS9cLTGtkilljew8wobbpU/3ShWoEHzyM
         kfErn4F4Krt1LyexRECQgaqrCJGNmw5vPKJebswr6oXXtbvDeXlLzhUB9TTWpeAS7zRo
         +WMC7gegd4aB92QLweet4Rrv4Niq45x5tBXa5/L+TM+LzoE0VLup0+NKsYfEgo4CWMZs
         LfIg==
X-Gm-Message-State: AOAM530YmhL2bwiWlw4A+5Acfw/csK+66E/qR5+jhVgSmABPy+aDY5qP
        UmUUXEd5stAIkty4RcAdZ5G84gIKP2XnLXS/WrPe5m3WMaU=
X-Google-Smtp-Source: ABdhPJwMX+EaewouXJYkDzNtzU3aG7/JRoAbZJKcR+wj198Psw4sZ46/s7xuR6cEFRlXSIjuWYnWtto4zP60Y90ULOE=
X-Received: by 2002:aa7:cd9a:: with SMTP id x26mr13213999edv.159.1639953720122;
 Sun, 19 Dec 2021 14:42:00 -0800 (PST)
MIME-Version: 1.0
From:   Jeremy Slemp <slempjeremy68@gmail.com>
Date:   Sun, 19 Dec 2021 14:41:49 -0800
Message-ID: <CAHtsx2rK9SE5fn=1hnEZ_GZV6EPVvFLM-O+0HPAk+h+LvsxL2w@mail.gmail.com>
Subject: Trouble parsing HID reports from PDP PS4 remote
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I bought a PDP Bluetooth PS4 remote[0] in the hopes of using it to
send keypress events to my Python script via evdev[1].  I found that
some of the buttons on the remote generate HID events that are seen by
evdev, but others do not.  So I'd like to figure out the best way to
receive events from the currently-unsupported buttons.

bluetoothctl describes the device as:

Device 3E:09:EC:xx:xx:xx (public)
Name: PDP Media Remote
Alias: PDP Media Remote
Class: 0x0000250c
Paired: yes
Trusted: yes
Blocked: no
Connected: yes
LegacyPairing: no
UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34fb)
UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)

The main module inside the device is an BTM0612C2P[2].


The "good" buttons flip a bit in a mask in bytes 2-5:

SHARE button, press/release:

> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2232 [hci0] 4474.225390
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 10 00 09 00 16 73 47 06                 ........sG.
> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2233 [hci0] 4474.355396
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 09 00 89 24 5e 56                 ........$^V

UP ARROW, press/release:

> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2240 [hci0] 4536.493867
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 00 00 00 0a 00 8b 3c 03 4d                 ........<.M
> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2241 [hci0] 4536.727587
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 00 4a 77 73 7d                 .......Jws}

PINK SQUARE, press/release:

> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2259 [hci0] 4676.429686
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 18 00 00 0a 00 c8 e0 93 1d                 ...........
> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2260 [hci0] 4676.639687
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 00 4a 77 73 7d                 .......Jws}


The "bad" buttons seem to transmit a constant in byte 6 instead of a
bitmask in bytes 2-5:

REWIND, press/release:

> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2261 [hci0] 4696.955007
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 17 8d f2 a0 fe                 ...........
> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2262 [hci0] 4697.163765
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 00 4a 77 73 7d                 .......Jws}

PLAY, press/release:

> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2264 [hci0] 4710.348944
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 16 1b c2 a7 89                 ...........
> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2265 [hci0] 4710.531446
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 00 4a 77 73 7d                 .......Jws}

PAUSE, press/release:

> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2266 [hci0] 4717.501552
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 1a 30 8e 11 80                 .......0...
> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2267 [hci0] 4717.685317
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 00 4a 77 73 7d                 .......Jws}

ENTER, press/release:

> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2293 [hci0] 4844.683443
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 0d f7 0b c2 03                 ...........
> ACL Data RX: Handle 11 flags 0x02 dlen 15                           #2294 [hci0] 4844.867210
      Channel: 65 len 11 [PSM 19 mode 0] {chan 1}
        a1 01 08 00 00 0a 00 4a 77 73 7d                 .......Jws}

I tried to decode these reports according to the USB HID spec but they
didn't make much sense to me beyond the "collection (application)"
part.  Can anyone help understand what this remote is doing?


[0] https://www.amazon.com/dp/B072C7YZFC
[1] https://python-evdev.readthedocs.io/en/latest/
[2] https://www.oemblue.com/download/BTM0612C2P%20Hardware%20Datasheet.pdf
