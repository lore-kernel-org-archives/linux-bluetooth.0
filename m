Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8651DC6FD20
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 03:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjCXDSg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 23:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCXDSd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 23:18:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BC27EC8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 20:18:28 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bi31so393086oib.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 20:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679627907;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N5fRyQQ2BepjZ7GZSPQDLRFWf31APDKi89JiNe6mAXg=;
        b=hsO4d0Fe4+OYbhgFMeEi6wKlulDakmX/4SV97r7uXWjNenEdgI43y4KttlJYx0vNLS
         baRCJyDQsamy+PIWB/LlTzf8U8wCfQs4Ersxr3hM0ic0w+Oe+DtwTKRzpBPYn2fZfo2+
         hv7IW7WEfgGr4YdXaCgU5RSOclJ/1tUJIuUoi7+3wxlM8ZhEjUljSp3+HEYH96F7X05J
         c5O/JYIYB6gLPIjiryUcqQHgaX6WU1kNW07oOy95e1EOskGXFnK65UlyTTLXlNh3YmHC
         arKVwXTJEBCtMwKC11b1/f+CxBGdPcswrre2V0hYsHVirX9vCQR4BCrQku/SEbmxR+s+
         hG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679627907;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5fRyQQ2BepjZ7GZSPQDLRFWf31APDKi89JiNe6mAXg=;
        b=3NDEnMBpBEEHDK+yKkYANW5iWFdGJdhPWGBv/9X8E9NeIGFRoFGQhFXcy8fIp4GjpJ
         leAKmI07eH46+n9eT2LiFyFduS/cRcbIagVeAs9vu2YFpUXk4ZbDk2jc/Mcuf8tShe3o
         r0xaAkl1CCo5HSiOlthO7ZxeIGbxGw+R3mgwI/PKLQnxm/o2OyGqiIMyOOYiLbe+mBmY
         ple1PTZM3fh2Lr/GlwwbPRfPOq2j42/C+Kme5g1rcYhDVbnVdH/Ig2V+ghBu0R1sROq8
         dN4ClfJ0IZzWhMJbjiEDK4e9Sup+ZYb1hMQuDb5N/YLjk3u3Up2BLFTcU6uZny0Rxmnh
         1SlA==
X-Gm-Message-State: AO0yUKUkszPocZcB8e0gOam/aBe8fDE0AWKmZYHpBbMTxcWIKCkHie0P
        gYxQ3jyxrxSsGf9AOKzTYajcG1xBPgGaYpy9CLcXzxlByzV/wQ==
X-Google-Smtp-Source: AK7set9gwVIAUX+V4XA5ejVnU+9FgdNNwpIjNwnOs73Tz5rcF9bV+mVCkP5QpQbFj7HHJSLIT47Jtx8W8OWSV6JoRG4=
X-Received: by 2002:a54:4082:0:b0:386:c6f0:9e18 with SMTP id
 i2-20020a544082000000b00386c6f09e18mr263894oii.10.1679627907564; Thu, 23 Mar
 2023 20:18:27 -0700 (PDT)
MIME-Version: 1.0
From:   Raul Cheleguini <raul.cheleguini@gmail.com>
Date:   Fri, 24 Mar 2023 00:17:51 -0300
Message-ID: <CACk7upyDgd8kCY+8j+RMJz35GXrF=bwRzDNH76Oh8q4nB8i0KQ@mail.gmail.com>
Subject: unexpected SMP command errors with controller ATS2851
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everyone,

I'm trying to understand and narrow down a pairing problem with this
controller that I'm trying to make it work in Linux.

When pairing, the negotiation does not complete and the system logs
the following messages:

Bluetooth: hci0: unexpected SMP command 0x08 from dd:5e:b9:fe:49:3f
Bluetooth: hci0: unexpected SMP command 0x09 from dd:5e:b9:fe:49:3f
Bluetooth: hci0: Opcode 0x200d failed: -110
Bluetooth: hci0: request failed to create LE connection: err -110

(dd:5e:b9:fe:49:3f is my bluetooth mouse)

After some debug I found the condition that refuses the SMP commands and
drops them:

net/bluetooth/smp.c in smp_sig_channel()

if (smp && !test_and_clear_bit(code, &smp->allow_cmd))
    goto drop;

The interesting part is that if I disable this condition with comments,
the pairing process manages to complete and my bluetooth mouse starts to work
(even with some errors in logs):

Bluetooth: hci0: Opcode 0x200d failed: -110
Bluetooth: hci0: request failed to create LE connection: err -110
hid: raw HID events driver (C) Jiri Kosina
input: Logi M650 L Mouse as /devices/virtual/misc/uhid/0005:046D:B02A.0001/
input/input6
hid-generic 0005:046D:B02A.0001: input,hidraw0: BLUETOOTH HID v0.09 Mouse
[Logi M650 L] on f4:4e:fc:c0:de:5e
Bluetooth: hci0: Opcode 0x200d failed: -110
Bluetooth: hci0: request failed to create LE connection: err -110

Logs from bluetoothd receiving the mouse data events:

bluetoothd[576]: src/shared/att.c:can_read_data() (chan 0x55f8ad8db380)
ATT PDU received: 0x1b
bluetoothd[576]: src/shared/att.c:can_read_data() (chan 0x55f8ad8db380)
ATT PDU received: 0x1b
bluetoothd[576]: src/shared/att.c:can_read_data() (chan 0x55f8ad8db380)
ATT PDU received: 0x1b

I kindly ask guidance on what could be done in these cases or any hints
how to further debug this issue.

For context, the controller works in other systems using generic drivers.

Regards,
Raul.
