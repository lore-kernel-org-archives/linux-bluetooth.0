Return-Path: <SRS0=Qv9v=2X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC961C2D0DC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 13:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD172072C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 13:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLnPiDLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgABNGR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 08:06:17 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]:45285 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgABNGR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 08:06:17 -0500
Received: by mail-qv1-f41.google.com with SMTP id l14so14950129qvu.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 05:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jXNeDZe4IMGGR44jFBIfmCCGCKcUi/ZrlvbQA6OorJM=;
        b=DLnPiDLC9n2L8Fk5dkIYaWWPnnxveA8hi8oPd0545Wo6B4x2u65frh0ivK4DzmXxU3
         7sc6XPdnDE97GtzLBSEoalv+BTm5CLfLsHA+vgVpt8KqZvDgdYyoHBtszLt7OPnPpwas
         yzyklsr4kAuYlJ8gtddfyuLTGgcP4pWwpJsLKkfnmJzEiAuNFvx2d+qUPsFl+b4M3uGi
         znXjAcBGUGcJZcTBW8UBxk2uTBHAFElIofwPZQYPD6isqqEqG9zpG1xrEXF8V/71yNJY
         pprVBMwT3UimvvFcBLid73auCTaSAEbH1HR4FiI/DUMne9vcdPEgSR2cJk5ut8kh9kQj
         3XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jXNeDZe4IMGGR44jFBIfmCCGCKcUi/ZrlvbQA6OorJM=;
        b=L/Fcq8nfL0KSzNmMv6NIFmgNnwuz+RE46ukvV9SMxWei1ZVZE794gJU9J+rG/Rf+Px
         AMizfFN8rGR2jBAKdZnEViNBcXE3jf4oQY46U0xbX8jpvsa80eNC7BA/BkzxfPJKMKAB
         lvhTIl9UsMASkoJTFgY0vnpLXVEed3YVVHtFTd6BZiUYozWbqYHCHGiLduHTfqGMZFhb
         AbKgOHAZlOdqWJ7q+6xR+eonHzaXk2+ck5fwvR/XwUMkMWcRvM8rb77XJ7uHo2LxXjF/
         7COsWLADfd9W6NhuGax9LzJ4cALRAcg7WRck8FiNrnCNgIBboapmBgqt2wQEMipJcT92
         qIWw==
X-Gm-Message-State: APjAAAV1KYaLBi/4mIn/MiHkBVrB1ffe1TAj2R5MpSNB8eJ81gC04+SA
        q5pjNJ/V5pZyZQwT5kTYRlhX4yqbj6WGyoMmOd08GbIH
X-Google-Smtp-Source: APXvYqz5/0cZY3YV1i8TVL0PCFK5xp/OaYltpxjHhW0BT4ik4PHg2l45LruDM4dAmQohHesS/tM3nTjS89KoKFHdHKA=
X-Received: by 2002:a05:6214:9d2:: with SMTP id dp18mr61670397qvb.98.1577970375627;
 Thu, 02 Jan 2020 05:06:15 -0800 (PST)
MIME-Version: 1.0
From:   jonghwan Choi <jhbird.choi@gmail.com>
Date:   Thu, 2 Jan 2020 22:06:05 +0900
Message-ID: <CAGZ6kuPn4sZUf-VjtX0h4w8_53Gxxsfzn+LOw1ngkGN22e0iOA@mail.gmail.com>
Subject: how to test Bluez/profile?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all

 I would like to implement something new in the profile (Bluez 5.52)
So I'm testing how it works first.

A. btgatt-server test

I ran btgatt-server on pc and ble scanner app on mobile.
I can see the heart rate service in the ble scanner and read / write.
it works well!!!

But...

B. bluez/profile test
The tests were performed in the following order.

1.sudo ./bluetoothd --plugin=deviceinfo -nEd

2. run the hciconfig command

$ sudo hciconfig hci0 up

$ sudo hciconfig hci0 noleadv

$ sudo hciconfig hci0 noscan

$ sudo hciconfig hci0 pscan

$ sudo hciconfig hci0 leadv

In the ble scanner of mobile, other services except 0x1800 and 0x1801
are not visible.
Even if I change --plugin = xx, the service does not appear in the ble scanner.
 Not even in btgatt-client.


gatt_db_service_get_claimed () has also been modified, but it does not work.



Please guide me how to test bluez / profile.

 thanks.

best regards.!
