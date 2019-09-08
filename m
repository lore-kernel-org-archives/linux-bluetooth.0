Return-Path: <SRS0=4P0p=XD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8360C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Sep 2019 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C86216C8
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Sep 2019 16:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=senic-com.20150623.gappssmtp.com header.i=@senic-com.20150623.gappssmtp.com header.b="Ah3i3Swm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbfIHQoW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:44:22 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45213 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbfIHQoW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Sep 2019 12:44:22 -0400
Received: by mail-ot1-f49.google.com with SMTP id 41so6437079oti.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Sep 2019 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=senic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hMAkwyQcTWVTaoTjHYK/sP7PbtlKrZIQtCgXaNISAwE=;
        b=Ah3i3SwmiecFCJc4r1gZCyEDbcjnZ/YpuiJdaz07V7Fl6JKGlySFbfoYIQZJ9jq5Jr
         BQGrgzz8HMdjaqkzViysFgzOtFvQ1hsnO5f8ndCzsn8+722ZlniFPjsbI3kkJBzBESMB
         cTR/3Ev/LiDBeQU4m32k+ll8iLQUaXiQc39Hgj2vvkKTEORTijnS1ytYlt+QQPOeTWGM
         3wAo8x31Acq7MaGxx4b+hFZtAyWd2FqGei/EhI8pqd+UUmorQyay0ArJdcqOzFO6R6OG
         +ieq2fD/mAn6CDt0j+58ez+UVGXjFSa0WavSJsh/sY15Mo+XqwBoTNV7JY2TXhR1RHoQ
         mJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hMAkwyQcTWVTaoTjHYK/sP7PbtlKrZIQtCgXaNISAwE=;
        b=J04leNhDvSgS5VAML07Y0j5xdJbZRAm2j44Rs+0v3pN9P3m5FzCgkBZ504TMsnMwJ2
         4rnxaTW04c50Ho+j6VIGS3XfEu7lYHYi91SdVzHVIpYFINJb4HZqPGXoruPXwobkY91j
         3hzys96Q1qHWkQ5Ytqpx8oK25TDlbjWzSx+/E26z0D/yNTX4rKoOyC7zK0SeZSJwVOgK
         kOwhi9BXbwbTTFBF+KuKMZkaU/WDX/xdLmK9vMKBjmAZuXK4K86QNdlAzuwxASAnnfas
         Mh/Cpu0mGa4nXNwrMRtdAnsW3q4VF2c+4Y/tt3SjN0zp00QareOcsFtW5ZwoSKle0FRD
         81Jg==
X-Gm-Message-State: APjAAAV1iwWq7PawHxAzzIrhgau/ssooP5Cpb4ijNiQAsF7rGlv2a1Rk
        CEIf9D152FXVzGeExixIaqDD1Fn/ES/SIXNygMhf67QymzM=
X-Google-Smtp-Source: APXvYqyQxdwPcZq+RyaH6muYjLskpxP+yZcqleE0+7wJnrSrXW4a4CH455NUXTP7XrB8yyj8iJ1GGhOfW1BSjmpiht4=
X-Received: by 2002:a9d:4103:: with SMTP id o3mr16360524ote.51.1567961059753;
 Sun, 08 Sep 2019 09:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOT_U5bDZwYLYsny9OpWs3HjQFLqYK2j3o3g2koKX_CwGUtMbw@mail.gmail.com>
 <CAOT_U5a-qBMnS0uaGx=O7Av_a0uVDWUaPxZb5HFbLijd+OQ6pA@mail.gmail.com>
 <CAOT_U5azR21Fu5a9OQ5grRW=ztmT273iba4+nHO03hoZyq-rew@mail.gmail.com> <CAOT_U5bzKdQRZJrRf7MbKMtkas6jfR2UHN0i50unoeUJXs_wWw@mail.gmail.com>
In-Reply-To: <CAOT_U5bzKdQRZJrRf7MbKMtkas6jfR2UHN0i50unoeUJXs_wWw@mail.gmail.com>
From:   Alan Martinovic <alan.martinovic@senic.com>
Date:   Sun, 8 Sep 2019 18:44:08 +0200
Message-ID: <CAOT_U5aHJxPDZe5Pb6B-YuKV7nrKCWTh8+JZs9hJuDQrsaw=yQ@mail.gmail.com>
Subject: Re: Locating /org/bluez/example/service from example-gatt-server
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey,
looks like no activity here on my question,
so in case someone is more into StackOverflow,
I have a bounty on this question
https://unix.stackexchange.com/questions/538107/locating-the-object-path-for-a-gatt-server-in-bluez

Be Well,
Alan


On Thu, Aug 29, 2019 at 6:37 PM Alan Martinovic
<alan.martinovic@senic.com> wrote:
>
> Hi,
> in the example-gatt-server which is provided in the
> sources there is a reference to the dbus object
> `/org/bluez/example/service`.
>
> When that example gets run successfully under what
>  "unique connection name" does that object end up living?
>
> It doesn't exist under org.bluez
>
> ~$ busctl --list tree org.bluez
> /
> /org
> /org/bluez
> /org/bluez/hci0
>
> Be Well,
> Alan
