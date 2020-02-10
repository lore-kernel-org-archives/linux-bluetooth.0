Return-Path: <SRS0=FZvY=36=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E303AC352A3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 11:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CEE20838
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 11:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv6Q5Rkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBJLQm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:16:42 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:36772 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJLQm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Feb 2020 06:16:42 -0500
Received: by mail-ua1-f46.google.com with SMTP id y3so2304652uae.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2020 03:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dD0B+nFAdSB4H6b3Lr964kOEvUAVTBOl705AiUD7lls=;
        b=iv6Q5Rkv9FHw8xy283BPloWp9kRppmSjLfJ9LG0IzGzhieKFWAEDpsSqZR0/uUF8LX
         cdGzrEFm6C7b/TNTJehMNpGKdxDxtPBV8IOuCOsS6afO/4O18ccOfFsvUcXiJCGBj8ln
         e3gusCWe26bvLnsdfdbJ78Yq4zgVIU+gRHuok02h18rnPRvxwJ4cfr5eNFKuvgOvOHiC
         5XoJevHB4MboL5Lrac91pOkwI5VLit1ewg7WaP68Z59bfQpZQ3ZcYRP/6mIeIZu/e9Us
         so2Vg//IVDexsMOewrJ3gfnhyfsF5btBz2T/Cxkusc1DqJD9FOH9Iw4bNWOe5F+psqP6
         SVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dD0B+nFAdSB4H6b3Lr964kOEvUAVTBOl705AiUD7lls=;
        b=cLci3dmy86lsRGoDeSKV6+dgATNEWmtq07r/V30ITm7AwA7rUaZFzEHMsS80rlj9L6
         fh7CrIvfe0GaVup4mlkM13ogU7xdtS7IZPVsT/BPOSoBHXbL7NbbI1xJigDX7P+WU+Nt
         4lqyQPuSIQacqW4lUfWDEgjYLkzQZrMfR12D9MzNklkJoqqT61yPWvggdD6cMUcCGJ9p
         nVsDP/koucLO4F7f3sx1fI5ZOZiRRsdOUgVHr+BAHaM4J/syj4Lj6kSlzHwvJu8xXvEo
         fqXlZyTDD1SCP/to8Jp3R6KOJTBnHGZNZjD2K/T8o3fYK1FWzQg7ZpN1uaDEPOw6DGkK
         hUfg==
X-Gm-Message-State: APjAAAWI5I7AbpiVIx8v65ps/eEmTv3dAsomzumK7MwMxfmIz3hXKPNg
        TF76tlkxfBQ0i5tGecQwb3gKbDpBHrDk92odqJ1i1g==
X-Google-Smtp-Source: APXvYqzXeQpYBlomKOiR2ZJeoRw7MGB+If8weIg8CdZNq+6AigIN0IY0Eek0nWnQ0lTXqp3iB/Bqk/W3RHNW6kcULKM=
X-Received: by 2002:ab0:2408:: with SMTP id f8mr358785uan.126.1581333401210;
 Mon, 10 Feb 2020 03:16:41 -0800 (PST)
MIME-Version: 1.0
References: <CAP6wrbWF=HysvTvKxj7R9_L-xigT_OD0UrSgvtWAKPfKe2P3Hg@mail.gmail.com>
In-Reply-To: <CAP6wrbWF=HysvTvKxj7R9_L-xigT_OD0UrSgvtWAKPfKe2P3Hg@mail.gmail.com>
From:   Marcin Kozlowski <marcinguy@gmail.com>
Date:   Mon, 10 Feb 2020 12:16:30 +0100
Message-ID: <CAP6wrbXRRK6o7GQvskpKyhowH9rm2yvwLNBtj1=SdBtUSiJuBA@mail.gmail.com>
Subject: Sending GAP ACL L2CAP Data Packets over HCI
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

New to Bluetooth under Linux. Maybe I am missing some info. Can
somebody more knowledgeable/experienced in this area (protocol, stack,
implementation) help me to write a program to send a sample data
packet over GAP BLE between 2 computers (Sending GAP ACL L2CAP Data
Packets over HCI).

So far have this code: 1) Client and 2) Server

https://stackoverflow.com/questions/60116790/sending-gap-acl-l2cap-data-packets

It does now work as expected. Can somebody guide me what is wrong
here. Is this possible?  How to achieve it?

Thanks,
