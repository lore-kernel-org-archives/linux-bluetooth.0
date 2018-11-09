Return-Path: <SRS0=dX+b=NU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0935DC43441
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Nov 2018 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C3220825
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Nov 2018 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0EueJm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C3220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeKJCNg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:13:36 -0500
Received: from mail-it1-f179.google.com ([209.85.166.179]:54203 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbeKJCNg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Nov 2018 21:13:36 -0500
Received: by mail-it1-f179.google.com with SMTP id r12-v6so3830217ita.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Nov 2018 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=V9Bhy2LloLkK4xc1bWcaqrthVrbDxDAvmKGNAPK/6WM=;
        b=O0EueJm4J9TTBx939ZTtw4neQv3ZlRtF9K1B0ouqW3hvj3OaDujkdAtZn3P2pTFGK/
         M1gtR5e6f/L1nB9KkUh9bnB1ughwjSFwrHzEsNEwvV8tjw6e18Wyv21iUTR6SxA/FOxx
         YTZb0Ap4nsMpfTVnVrOd9xbPjORQfPNlOxNlbWic/TkaYAAqLcQATvn9zAc8B5YSaIft
         dQYV7Oj6HfEbbSmM5cEGM7cWGqEdmZFC7mjBXPFtkf9y2HibOQLmy3JWXY+HnTxL3W0q
         rGe2jL+6bZdsNG4csmxdjMy/hGi23t4Blfd3C1uFlTIulJ6ShWvaMx66pXrPJehk75bw
         Lx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V9Bhy2LloLkK4xc1bWcaqrthVrbDxDAvmKGNAPK/6WM=;
        b=XPDMFN9IOioA45WhoHgYsOcy10HXYHWNVefMS5PuFkudbgFkw6UMVFjhBRNXIgyWEi
         krktjvqndJPyfuiu/mGYjuqMGLDi3ENct9hzKF7u/Hd4cY1jSQZpqb+8JROZ0cziP0bw
         YjOK6im+MyUKQ/zBvHghGGuOzOzrZAJnX0h7bmYzI9nXKlVubeU9Zp9SvMlPuwZ2ntwh
         X6nzWrBHO4KAmrgKSXBtIQrqmkyiixhwG/XNO/DWFxNNr+Wf9tle69uipuI7CphGwMRk
         tFqQ2gFHwptFYcKZLs1ivzu9hGlUDbqQQcF4+FUqP1LuAKdKPG0CWP4l/+Kpyy1GM69b
         QXJA==
X-Gm-Message-State: AGRZ1gLY7cRisQs0iIU4NX57lec5PZjLT8NAEHT5mQamCHeTuARClMc/
        QedCjaMER5+TZCBXW3XF7JON4i4ybmRVEJ7xmiEdmD21
X-Google-Smtp-Source: AJdET5ejyHOk8ly14VlLB4g5vsEgbLo4Hy2bc9ufCFR1nuRO4cnmRffxM3MPihadb07optU3tkvZgECMwcUYqXwKjx4=
X-Received: by 2002:a02:5543:: with SMTP id e64-v6mr3443280jab.113.1541781136615;
 Fri, 09 Nov 2018 08:32:16 -0800 (PST)
MIME-Version: 1.0
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Fri, 9 Nov 2018 16:32:04 +0000
Message-ID: <CABatt_x1aNftgFVuDxrhyZVs4bGmOZFccjPKU_BpfbGmMWTazA@mail.gmail.com>
Subject: Operating central and peripheral roles concurrently
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I see someone has already asked this question not long ago but I am
seeing the same problem.  I have an embedded platform running 4.9
kernel and Bluez 5.50 and the bluetooth device is the BroadCom
BCM4343W which supports bluetooth 4.1.

I can run the btgatt-server and example-gatt-server fine and connect
to it from my phone using nRF and read the relevant attributes.  This
I believe is where my device is in the peripheral role.  If I close
the GATT server down I can use gatttool to query the characteristics
of another GATT server setup on my PC, I think this is then acting as
central role.

But if I can't do both at the same time, once the GATT server is
running and I try and query the other GATT server, I get
root@mach-cw-rnet-ppm-1717:~# gatttool -b 5D:3C:72:B5:23:BE -t random
--characteristics
connect error: Connection refused (111)

I've noticed that if I start bluetoothctl whilst the GATT server is
running it looks as if it has connected to my phone

root@mach-cw-rnet-ppm-1717:~# bluetoothctl
Agent registered
[LG K8 (2017)]#

Maybe this is expected but it does look like it has made a connection
back to the phone and I'm wondering if this is stopping it from acting
in the central role?

Not really knowing much about the bluetooth stack I was wondering if
anyone has any pointers on how to debug this or let me know if I'm
doing something wrong?  I'm quite comfortable putting debug code into
the kernel and/or bluez5 and recompiling to get more information if
required.

Any help would be greatly appreciated,
Martin.
