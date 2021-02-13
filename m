Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C93C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 07:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5996A64E71
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 07:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhBMHeo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Feb 2021 02:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBMHem (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Feb 2021 02:34:42 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A5C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 23:34:01 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id b9so2879568ejy.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Feb 2021 23:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6bpdOdIM8MR4hvXhJdNENlnrUF81I0BRfiQlkqMPL4s=;
        b=Sbf4dSoP91NXBIv7yMzGwAN6FY9MmyJa9tuf3YOoc5pW0AKWdiqyt1FVxeJ+Fumphs
         s+y4xF9M7qJFTm167jDrmKZwGWLXgYPvZ4X3/Gwh7C7Kv6ujX8WynaK6f4VKFm/5pAFH
         FzBDybwezUyv6iujXxioC5z16LLh/B6sFjNV1ASTBbX2ROsZ5VP3qUnPPJKjiNMosGxi
         8IWrl4ZpKbAq3C1pJBWnFl1d+J7dNDK8o+iAmRavtkWvEgESC7Fg7D6PiqF7t+gpc86a
         ClUsAJ+icGOMF5E7ZZL7ACSUDUXvJVlwE3vS++OcwNdl2sojKBeEdjBI6X5xAITzID9c
         UenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6bpdOdIM8MR4hvXhJdNENlnrUF81I0BRfiQlkqMPL4s=;
        b=W/MjbwTMqPEChaeFYnL6UWMK5IVIrbw9dxU9II77w1nO+lALA+FsOaLonxqxh51AuX
         OKWYLUg7Ck7r2QmaHohpX6rRo1yajkzWl/s0aemrlO05pJ1UO9XPzT5AvjHxgIeJW90M
         duatdAV1ajXFCpgUGPPLURtBYkNIfyOrzedBfk3j9OTdSQsIfJ3DeVmlFVb+7dBcXeLr
         /O6rkALcLLP9s+SD+3uvUSEdHrmAiz6Em6Dea2sifiv3+18A8bxYweajQ+MnIu4HBgtG
         yoaWsapgt+24kAE5K3uM6DxnXPL+OspnlSI6C8SEpaSmVywqzh3XQKFJVGL6eWRx7GV6
         P6zg==
X-Gm-Message-State: AOAM532DuFS6N05w2gMBeJaO7EsiDqsoY1ou0zNS6WPowwzxdXDWrEpn
        wcAZFgw2H4uPmRn6jUm7xzNIGx/IORpEhQ==
X-Google-Smtp-Source: ABdhPJw+zjHtGl0ij0AnzqfMau12PwiUtB9hjws+rHqOhH4Nv8Q35tSsxiFTafXnoTiXwCd68Qw2tw==
X-Received: by 2002:a17:906:2a8b:: with SMTP id l11mr6554464eje.1.1613201640305;
        Fri, 12 Feb 2021 23:34:00 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id bn2sm7408711ejb.35.2021.02.12.23.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 23:33:59 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 13 Feb 2021 08:33:58 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     =?utf-8?Q?Micha=C5=82?= Zegan <webczat_200@poczta.onet.pl>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth not working in 5.10 kernel?
Message-ID: <YCeA5hF+5yn4w/EY@eldamar.lan>
References: <ddf00862-515e-a295-dbcc-068592220e94@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddf00862-515e-a295-dbcc-068592220e94@poczta.onet.pl>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Michał,

On Thu, Feb 11, 2021 at 11:42:39PM +0100, Michał Zegan wrote:
> Hi,
> I have 5.10.13 kernel on archlinux and bluetooth seems to misbehave.
> Not sure if that is known or fixed?
> Namely, I have some atheros bluetooth using btusb driver or so it seems,
> laptop lenovo ideapat 310.
> I managed to turn it on, then when turning on bluetooth on my phone
> (devices are paired) it triggered connection with the pc, but my sound
> suddenly silenced, then after a minute I got a connection error on phone
> and pc went back to normal.
> Then I tried again, this time my sound started looping on the pc, and
> after some time went back to normal, phone showed errors again.
> I removed the pairing at phone side, disabled bluetooth from gnome and
> tried to reload the driver (btusb).
> However, now bluez does not detect my adapter, bluetoothctl command
> "list" shows nothing. Gnome tries to turn on bluetooth but shows it
> turned off each time.
> In addition, even though list is empty, I see the device in
> /sys/class/bluetooth.
> I have found some reddit thread about a similar issue,
> https://www.reddit.com/r/archlinux/comments/kwpw6j/bluetooth_not_working_anymore/

See both reports at

https://bugzilla.kernel.org/show_bug.cgi?id=210681
and
https://bugzilla.kernel.org/show_bug.cgi?id=211571

So the fix is now pending in bluetooth-next.

Regards
Salvatore
