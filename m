Return-Path: <SRS0=Arr2=V4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF57C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DF9208E4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Jul 2019 18:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=orcam.com header.i=@orcam.com header.b="MFmAbxMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfGaSOw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:14:52 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:44555 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfGaSOv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Jul 2019 14:14:51 -0400
Received: by mail-io1-f51.google.com with SMTP id s7so138191984iob.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2019 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orcam.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UJmHMf3k5K8FHY7vHKRUUBymKMESq5q3UwXpDKOzwA0=;
        b=MFmAbxMv0ZArataLYQDjVDI0CRn5oqFiE2puS73XKHVtXXwe4GI8r5NzTNrMa0GXZy
         8wjpU/uYx2mpoIY3N1bcE/fltrLtJI/yuP52zPFpEzA4jdjT9tj5eUEgS1j+oTiCCfCM
         C2IMavuyxkGd19g2Um57DpT8XkSWOLK4v56x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UJmHMf3k5K8FHY7vHKRUUBymKMESq5q3UwXpDKOzwA0=;
        b=Nz8hXzzwTt6R1NU4bj+td+dmDAZZvVI+YUb3TkeO7+J03QdllHLOMWea7aQIgrQAvG
         gxckLySlrcgBzWMkkVgyu1Hq1J0YBUg/kAl45JmCOqCPeMcs53EA9kRDL0z9ksBu47VQ
         rIRr3K8VjN9+OCcQ/QvJYGvrCKb8zS+iuhdh85BZuJXlGCsIhsYvV285I6SImLDuHzRV
         EMEhD5OuSqLl/IruUN89ajJL2hT+lNr4xuNgjy1WOYv2K2+caGJdu4gapcPn0XXbmT9t
         wlFIphbOdi92EPesHiYoKfy9aMvNFeqyh3tuAoOx+4ZMiF8gV45MDMRhoXuSDrfSv5XP
         GYcQ==
X-Gm-Message-State: APjAAAU+q/HRxLrErMGGSCFQo91pw1GMBUz4g/8N4R81iQjJpmOTPdXw
        Ji285ZWH/RFfpwCE59OzRxWPjs26vbZnevT7EOiSqxKJmn0=
X-Google-Smtp-Source: APXvYqz6RLUO0BalCGwAHYMUZlhG//W5Z/dYNIEUIrKkLpfjNn+teOeCViiz5Q6PduFewsjX6UMo39Jb/7D5FM8JMjE=
X-Received: by 2002:a05:6638:52:: with SMTP id a18mr3613412jap.75.1564596890522;
 Wed, 31 Jul 2019 11:14:50 -0700 (PDT)
MIME-Version: 1.0
From:   Ordit Gross <ordit.gross@orcam.com>
Date:   Wed, 31 Jul 2019 21:14:41 +0300
Message-ID: <CAB+bgRb9YgAd5cbDz_8KVNDuxG6X=iHUmTVfjU07_pUNK24zhg@mail.gmail.com>
Subject: connectDevice - dbus adapter api
To:     linux-bluetooth@vger.kernel.org
Cc:     ordit Binshtok <ordit.b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi all,
I have an application that attempts to connect to a paired speaker every minute.
in case the remote speaker performs reset, the speaker side keys are gone.
the local device still attempts to reconnect to that device
(bluetoothd still have all credentials saved).

I would like to have a connect_reply "authentication failed" but am
only getting org.bluez.Error.Failed
I want to have that information so I could clear credentials from my
side (remove device)
** the failed connect might happen also if the speaker is not in
reach, so this alone isn't a good indication.

how can I overcome this issue?
(btmon shows the complete information authentication failed)

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt

I appreciate your help!
thanks in advance
Ordit
