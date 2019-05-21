Return-Path: <SRS0=xYxd=TV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14C8C04AAF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 May 2019 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3D2173E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 May 2019 10:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkhUEx5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfEUKAh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 May 2019 06:00:37 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:44240 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfEUKAg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 May 2019 06:00:36 -0400
Received: by mail-vs1-f50.google.com with SMTP id w124so2796076vsb.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2019 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=FhZY7qwY/Gwa3py/OFz+0ZCs7qGhip0OTFaocO31LOo=;
        b=TkhUEx5CN8HyZJBeRLWg9K+YohtBNMY5evOjp2QyVgSQgrT6CqsfTGtbm7LVD630+7
         xFhfwS48gBbP/uAxySvyj3npDbQzxgF4WiyByWvCKNbXmzXfIfXwnJYZ/pi2h7G1rXGc
         hjXv5G/hOON6WWONSJ4FAK9U9vu0XVVYrlDPljMXdYMHtdCXqY6aGv3j8/8HfmZGPYqV
         e9PmkDYznEe8BBJ+sRTAZPV59kcMn5kXqQVmg7l9KSoEfwtyypZtP3BGGu2FvaiLUuUG
         89X+RENq26A+rI7SKQ8ydqy2Z0EXypi0x9eL9TpaQuP5IwOToELOi2MQfGkP2BNiQ0Z9
         4KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FhZY7qwY/Gwa3py/OFz+0ZCs7qGhip0OTFaocO31LOo=;
        b=Q+GRSExyzR2rahAWtn+dwcj54MBjioK+yfzxwYKlfMGLW/cE4mfyijsQnIdfAm3e+w
         JvQRy168juMaFUQfo/6dY4hSzVppp/7/4Q0KWPb4gNz1NLoZzayo5/LMXsDEcxOnx3Kn
         6RT5zi3MenOZeZqH4F/A7FaPWdo8O+X3hR3jv3Br3LkmOp2Wnf8ZXw82LIfbAmQvIpUs
         hPOGvEopDbTzkD5ZBT10MfW/MCYyvfwUQhixKbUM6cSKrqQuIbnDDqqucCw0+CgJQIie
         az5pz6b6VCjOMNEYyDHuwsSy/Acefzfvc9feZbL1zt735nsLGh9XEtk7wetosTXn2htA
         cKJg==
X-Gm-Message-State: APjAAAXFJOeZRc0hciVo6QUQL8Hn2+uQoOiwKKh18pN+5YbJKkhO1h3Y
        vBpFS04gBnlRHQ20ES1S6/ZAHqPs+2ORboWmqIuHMo3S
X-Google-Smtp-Source: APXvYqyyLcIyqmtBaKmOBi0qjrQWubibFUXU6uvIDBWP/D1V6tdM1Y5KzDZCWEKs/WAn5TDH1yQdRxJ9i/u2G5/UHgM=
X-Received: by 2002:a67:c508:: with SMTP id e8mr3662149vsk.18.1558432835642;
 Tue, 21 May 2019 03:00:35 -0700 (PDT)
MIME-Version: 1.0
From:   Moreno <morrolinux@gmail.com>
Date:   Tue, 21 May 2019 12:00:24 +0200
Message-ID: <CAOJ+TdvyHxe7OAgzJsg7Ar1QmoSyWuGqWn0b2rbFXq7xW3B6yA@mail.gmail.com>
Subject: a2dp sink delay via AVDTP
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I am building an ffmpeg-based audio sink system to use a Raspberry Pi
as a bluetooth speaker.

Since the audio takes quite a long time to get past the processing on
the Pi, I need to tell the bluetooth "client" device how much delay
should be added (eg. for video playback) for it to be in sync.

I've looked at the code and it looks like it's fully supported, but I
don't understand how to signal bluez (running a2dp sbc sink profile)
an extra latency for the source device to be aware.

Can anyone help?
