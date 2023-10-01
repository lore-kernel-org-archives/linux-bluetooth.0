Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B59E748ED
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 06:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjJAGYB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 02:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjJAGYA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 02:24:00 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC0BD
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Sep 2023 23:23:57 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d865c441a54so14287006276.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Sep 2023 23:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696141437; x=1696746237; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GFNe8sChStDbGpZZJIHILE3/VxnzexyiMeuagFjO2GY=;
        b=YfaPVNrtVJyZMMj1V+kmqgH1v2yWl4dvvKr86IkGrBdIx7si2DQ/yEDqNCfAldjqsk
         tj0kXNR0/xoLWYBxIrDG4mOz2hgFgIZNRa0VyCtnB7adeVssRpkNv2DlI6JWjW0D76pL
         t6UqN2YTANBQN+rOaKBCg9VPBWdFfHy4GrOwiaC86B33l6d4pqJGcZ6il0RJHIlepubu
         iaQm/lKEUpw7/UkhkAUKJFMsCM/ut8M+N57LaeaFPCPkx1RTjby5fMY7pHjmhSISgjhU
         OoTRobK+41meqJieQarIwYo9ieji372N8ZVTjnCBOMp+qVdye4OLw2eNNMAeolP312RM
         AFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696141437; x=1696746237;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFNe8sChStDbGpZZJIHILE3/VxnzexyiMeuagFjO2GY=;
        b=r0XItzzCGvYIj77nlUDRT1fkjq7kl/7U4ah3e8tnhEo/+RcBJvmkUMOnNKjAgFCpeh
         FH5HECHeuJwfv459jxO85bdvCE2bgg1S5H2X9WBMwN+2KxoQ++EesxWJ/WK1HhDTvtSl
         3la8yI2dJggnCgUP4nYEt1NK7AY22w6l7iQDhbnXY9sF9hTJFLYzec0dyvy7TqdO2Oyz
         UDwWnl/4s4AsaTboGKoKyPdPl3pRgrGB0vzOmiEGV0l3U5rJfZ1UV2v2RAq3mcVX2uZi
         ZxYKfnKu3+mYo4zVHhPK04bjIWfIzdhIsSPJjaCvqVBLUxs1lzWIwd0p1SD8FnZQB4qp
         vPvw==
X-Gm-Message-State: AOJu0YyYUfox+zlLViYeh0zV6S5Sbvri6MTr2AlrefKmavucIQ2aa/Gt
        hVFB2W5RAfY6fPUpDGeNGI9CYagV8jf+fS9f7aIWTtQikuI=
X-Google-Smtp-Source: AGHT+IHiXZLoj6c4jTONS5LIRx30Zz0OXtdDVDahuH872tgZdKCSagi3wd9t1IPqVHo8TS3Nc29bSKVP802wqc6MWXs=
X-Received: by 2002:a25:858c:0:b0:d7a:b8e1:eda3 with SMTP id
 x12-20020a25858c000000b00d7ab8e1eda3mr7567166ybk.29.1696141436923; Sat, 30
 Sep 2023 23:23:56 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Erik_Dob=C3=A1k?= <erik.dobak@gmail.com>
Date:   Sun, 1 Oct 2023 08:23:46 +0200
Message-ID: <CAH7-e5vbmXfNBPNRTUSuPit-ACxtM-4UwuJjXVjs9a5YRT1ibw@mail.gmail.com>
Subject: bluetooth issues since kernel 6.4 - not discovering other bt devices
 - /linux/drivers/bluetooth/btusb.c
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

I bought a new laptop fujitsu life book and everything is going fine
on artix just the bt makes trouble:

/var/log/error.log
Sep 30 18:43:48 nexus bluetoothd[2266]:
src/adapter.c:reset_adv_monito
rs_complete() Failed to reset Adv
Monitors: Failed (0x03)
Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to clear UUIDs: Failed (0x03)
Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to add UUID: Failed (0x03)
Sep 30 18:43:48 nexus bluetoothd[2266]: Failed to add UUID: Failed (0x03)

i searched a bit the webs and found a new commit at kernel org that
does do the trouble:
https://bugs.archlinux.org/task/78980

follow the linkeys inside the commits there or read this one:

---------------before------------------------------------
/* interface numbers are hardcoded in the spec */
        if (intf->cur_altsetting->desc.bInterfaceNumber != 0) {
                if (!(id->driver_info & BTUSB_IFNUM_2))
                        return -ENODEV;
                if (intf->cur_altsetting->desc.bInterfaceNumber != 2)
                        return -ENODEV;
        }
-----------after----------------------------------------------------
if ((id->driver_info & BTUSB_IFNUM_2) &&
    (intf->cur_altsetting->desc.bInterfaceNumber != 0) &&
    (intf->cur_altsetting->desc.bInterfaceNumber != 2))
return -ENODEV;
--------------------------------------------------------

the dude just hooked up 3 conditions in a row with && where before it
was 2 conditions in 1 condition. + the comment was removed.


please reconsider this commit.

Yours

E
