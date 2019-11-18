Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31792C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 17:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0567620409
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 17:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scewo-ch.20150623.gappssmtp.com header.i=@scewo-ch.20150623.gappssmtp.com header.b="lyNLe+yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKRRQZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:16:25 -0500
Received: from mail-io1-f43.google.com ([209.85.166.43]:36261 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRQZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 12:16:25 -0500
Received: by mail-io1-f43.google.com with SMTP id s3so19662272ioe.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scewo-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=gvgDXqLF6iADV5f8AOsRc1XjUu3dhu2/sHttCHrQzDQ=;
        b=lyNLe+ycYrfOoZNjRWxIagP2l4IWdNzCookIoWIsQqBreO0x20k3ADmJAz3VaI0BxF
         y5cuNDb7q8F6TOT42c1S+l2f4x5urAuFzBaD7n8fY+m80TQtMFzwBmi859urKDSDOnHw
         pNsmOxslaPUCri9ZiV8KAAQF8TZHyl22YxKez6oZh37pR0dEWoRHuUiRvn13Ex2HIwei
         85CQVqovZcJedw6E7iesEcVcOLJSASnX8/zzhGIQzT8lq76g5RQsTvfdzc5NT/vl/uQq
         ktbn6kFJFHiFmVhZvY4fPYjZvZyG/VDgGyiXk/89Lr3Y3MvYE8dDxAAVaTRqPh870tAB
         +1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gvgDXqLF6iADV5f8AOsRc1XjUu3dhu2/sHttCHrQzDQ=;
        b=WyzsPYIUgfLJt4yatf9dJtY7rhkTOzw6JIjDCj0S3dJ5YXGIk8oQCROZkX2phypGDY
         hJJ3YJgyVGETwFO4Hp8wqfGDv85Y9yjGv03aWz9Vx6c94iWGGJdJVnE9VLyvQjofV3se
         RU4iKFpy/5DhVVztFYLlV8lR7ZVItCRWyzfSa3qZ2bbiYnLkUk98j9iwCpKF/ZRaYaz2
         BcqpUzpm2KditLFYPZKpfoZgG1UzHS8UmP1VBI4tg5T7ZMQ6GrJMuOTrPK0VGUWDs6FA
         QM/oEd7pkALFA5UGvg2Mh7wsQmlsOMCq8kLAgQHFX/DvS1+FhzjEy+qXWoUVOmo7NfyR
         e2bg==
X-Gm-Message-State: APjAAAUBQzMM8Dd57eMSWQnAkixfZkAHBwcQeT4Q21K3qDd0HhVlE6pR
        gER/+Rv4IpxaOMvSJVOZNdswZTvQbwFcwHCvWA5Xv8XHKP7XnQ==
X-Google-Smtp-Source: APXvYqyZQkdbGtOdjkCks8MMyFj3Qdd9ugN2Qgtjg5wqFMu38+4efUtLaoa2Zx6v9m4r+WkOayzgjSpSKyUPJ5p4ozs=
X-Received: by 2002:a5d:8854:: with SMTP id t20mr14623036ios.301.1574097382603;
 Mon, 18 Nov 2019 09:16:22 -0800 (PST)
MIME-Version: 1.0
From:   Guy Morand <g.morand@scewo.ch>
Date:   Mon, 18 Nov 2019 18:16:11 +0100
Message-ID: <CAGssATiS=dpA=WOSfLek385o2g=C5sb0z+z=V7CDswn9_5Eu-g@mail.gmail.com>
Subject: Bluetooth disconnect event / Link layer monitoring
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello bluetooth developers,

We are developing a wheelchair that we can controle with a bluetooth
gamepad, the XBOX 360 controller to be more precise. It basically works
fine but when I remove the battery, I get the disconnect event in the
user space around 10 seconds later. That is not acceptable since the
wheelchair will keep rolling to potentially dangerous places!

I tried to implement a ping mechanism on the bluetooth layer, inspired
from bluez sources somewhere:
  int _socket_fd = socket(PF_BLUETOOTH, SOCK_RAW, BTPROTO_L2CAP);
  // bind on AF_BLUETOOTH
  // connect with AF_BLUETOOTH

  send_cmd->ident = PING_IDENT;
  send_cmd->len = htobs(PING_DATA_SIZE);
  send_cmd->code = L2CAP_ECHO_REQ;
  if (send(_socket_fd, send_buffer, PING_PACKET_SIZE, 0) <= 0) {
    // ...
  }

It basically works fine except when the signal gets bad. This will get
printed by the kernel:
[  859.629431] Bluetooth: hci0 link tx timeout
[  859.635482] Bluetooth: hci0 killing stalled connection 9c:aa:1b:6b:51:c9

In that case, I don't get event from the /dev/jsX device but the gamepad
seems to still answer to pings??!!

Since I haven't found any acceptable workaround and always find the same
pages again and again, I'm asking here:
* Is it possible to achieve what I want?
* Does it make sense that the ping work but the HID layer seems dead?
* Any recommendation, pointers?

Best regards,

Guy

-- 
Guy Morand
Software Engineer
Scewo AG, Technoparkstrasse 2, 8406 Winterthur

www.scewo.ch
www.facebook.com/scewo
www.instagram.com/scewo_official
