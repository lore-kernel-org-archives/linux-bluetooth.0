Return-Path: <SRS0=oHG9=PL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8818C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jan 2019 09:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC50206BB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jan 2019 09:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNHB8sIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfACJp1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:45:27 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:39794 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfACJp1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jan 2019 04:45:27 -0500
Received: by mail-pf1-f179.google.com with SMTP id r136so16450210pfc.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jan 2019 01:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qFp59PAuM+Z265wtAvafmOhS4x2VdwoC4b3wRRZYg9I=;
        b=tNHB8sIocl2MctnTJsTAmHUzrxOn/m6mF0pRWM9vvnvyE8hETbCljImZKt55QSamD+
         T5R/j0zY7GSFkxsgjPrWfkFLkTbR+VPW4iLcpYLG0lIRhOw1rqBmj5Nyau/eaNFiVhIQ
         L4Y+4k49DwweEFuMZCEWUafZWPl6sO0eFEPM8wC2XEhzxmBZ5M0kchQ7cL7WwbBnBbBU
         e3pLJvZBKbziWoY+SwSBXabMWI+Zr3MaQhQc7r9xrovfUJGmlBIQq0vf4j76OV66oiCL
         ZwxSC9/lQ9NQa4QcYwluPCi9nNSfDltPlfkAWcyhHvCr2LcaSz/Bsp28KE1Dkh89MDJK
         4xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qFp59PAuM+Z265wtAvafmOhS4x2VdwoC4b3wRRZYg9I=;
        b=Cexsu8ZvqknQxQvF92luGiDa01z077NiVLcwYxOuspu+poQbc4UhffYAD1ldu0B/kF
         5xIAH7dDU1Gdmmb1uUytmQPPg6FfOV+vlDT+Y13WpzptLYgbQ67UtqSUtkZkMQXoqi9M
         iIIkQQG+kbD63n0IzX/wD2/bGY/Es/lp77HItXjB9M8wiap+J569Vp4+QtlsPi7/o9yI
         JyePci7EAZzODZCrw/ZDPrSzAhC5Tt92cRnD2m8U6Jq9xyMQ/tYuSV03eRNT2w8DpgtW
         xr3VKDE42THKHqsEYC5QrqciBS+sSEn/4Y8/0CaV+Ww+C4lWQRgQUExIxOLpYTkpDoT5
         7FRQ==
X-Gm-Message-State: AJcUukfCDvZrKygAMPqqmK3gsEusUaLfY2NtsWUZkHMHkfZMFPi8kB+L
        aiivtqBM5zGoL61FLGTZtPQluUhnNgUbTYyAsorHngB/
X-Google-Smtp-Source: ALg8bN5E7mIco1tPqtWfR0AALdncEbwsHu4CJWHS8FSqeHQ62aA948TSomLIwAcRuRsD8EobdiwN4mBGB68FBmOp34U=
X-Received: by 2002:a63:ed15:: with SMTP id d21mr16345613pgi.305.1546508726084;
 Thu, 03 Jan 2019 01:45:26 -0800 (PST)
MIME-Version: 1.0
From:   Bhushan S <bhushan.az@gmail.com>
Date:   Thu, 3 Jan 2019 15:15:13 +0530
Message-ID: <CAG2NicL6Us_Bys=GnLn7SAvLJ4PAXPO5Nwvik4+eCJRTN+=xPg@mail.gmail.com>
Subject: Getting Started with Bluez
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

I have just started working on bluetooth on Raspberry Pi 3 (model B).
I am successfully able to build Bluez(5.43) with debug enabled.

My intention is to
1. limit access (say only able to play music but no HFP support) to
selected User.
2. Add 2-way authentication for new User (via already registered Primary User).

I'm currently going through the debug logs for different cases.

While I am exploring Bluez for the same, I would appreciate if someone
could tell me if the above idea is feasible and if so, any pointers to
start with.

Regards,
--bhushan
