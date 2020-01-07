Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59CFC33C8C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 13:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B652120656
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 13:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gq51lt5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgAGNtW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:49:22 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:56087 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGNtW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 08:49:22 -0500
Received: by mail-wm1-f53.google.com with SMTP id q9so19021241wmj.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sxkg0xlNPC2K/knXuQ++in8aGGMBYeXUp2zUaYdGV40=;
        b=gq51lt5zzizNxK97PrMkUbgrWPS85X2SkhmV+9ds94Nmo8axxgR01ssozU68d9qMed
         +UiU5S+y2zjYuBI5SPTQM+X+zUD+QrP/7+ShrVZkLvHA9N5P9OazmJXKAe2BJ0+wLYHj
         nQfnaJOsm0LYXgx8DEbmnubMj/r7t/QXIWEy2P5RuZOvW97/50Grg9ythOO89R6Dju7y
         tM7ilLwL5P/flZRkys5tCYIa49QvVBzMpXAV1Yahrc5lpXUVlf6ErD8DKG9uFR05IdOF
         BHS9VjjwdeQpOebsh3WimltZCD5hwWNS34jxven/ELXtxaUJS07nsBtUpts9tQBLWiMn
         jwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxkg0xlNPC2K/knXuQ++in8aGGMBYeXUp2zUaYdGV40=;
        b=mv7Y3X6nbsE55VRlibn1/KSUvM5Y0db/rn/VwPH7hnJoJ4D/njrs7oXCWOdfW0Idy7
         5gDPqJO9Mnv68CNuHn7CngjMaXdN74XeboVJzcHnDnlp/28USrmFHivscmRZaekTkc2t
         2Hha+GDINtXak484zCB3OiKno5gQd/M//9OpIloDdNxWYBI8c3Wcwuultm0tvcNx/b4U
         R3IUyjxuFEP4l0qZA04pgC1QDSgz7HxdR38dR0ZKPRaubjVskJB4MG3B+gnslADpUoMO
         DHKFrW4PfJ+ZQSM7CSKVPOAHh9jRMt9aShKvtOJSDWEooqjORvTCy8r3W5NMXegeGxEx
         L6jg==
X-Gm-Message-State: APjAAAVXFdl11pjOg8mt5hIbFjK+ymc6ONYcUmcQV4O+iLKC9rjJtx3J
        1jZXY2uJ7U7m0YR1eLtCd+l+HIJt
X-Google-Smtp-Source: APXvYqyVPC4gr6jsnS8rMQyBKCsKXsfs1pNGtOtx6gJ/klVtXtDA8szgVNA/RnURtolwiVakKJUudA==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr39021439wma.139.1578404960052;
        Tue, 07 Jan 2020 05:49:20 -0800 (PST)
Received: from [192.168.201.5] (p4FD25D76.dip0.t-ipconnect.de. [79.210.93.118])
        by smtp.googlemail.com with ESMTPSA id t190sm26735803wmt.44.2020.01.07.05.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 05:49:19 -0800 (PST)
Subject: Re: deprecated tools: rfcomm, can we un-deprecate it?
To:     BlueZ devel list <linux-bluetooth@vger.kernel.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
References: <0aad7250-65f9-3e4c-e5ca-434139a9ae64@message-id.googlemail.com>
 <2203E98B-B581-4C14-94DF-164D7E036234@holtmann.org>
 <fa70a57e-d5f0-a47d-f987-27b46d8275c4@message-id.googlemail.com>
 <cb73add2-cb8c-353a-5d10-134a13553cf4@message-id.googlemail.com>
 <7192C77E-BFF5-4507-A004-3684EDE489AC@gmail.com>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
Message-ID: <0524896a-fedc-463d-14ac-370de38467de@message-id.googlemail.com>
Date:   Tue, 7 Jan 2020 14:49:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <7192C77E-BFF5-4507-A004-3684EDE489AC@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

Am 04.01.20 um 14:18 schrieb Johan Hedberg:
> Hi Stefan,
> 
> On 4. Jan 2020, at 13.45, Stefan Seyfried <stefan.seyfried@googlemail.com> wrote:
>>> This would be for creating a "rfcomm service" for other devices to
>>> connect to, right? (The equivalent of "rfcomm listen...")
>>>
>>> But how would I connect e.g. to my serial module (I got this for trying
>>> it by myself instead of relying on bugreporters results...), so what's
>>> the dbus equivalent of "rfcomm connect hci0 <bdaddr> <channel>"?
>>
>> OK, now I found https://github.com/tonyespy/bluez5-spp-example which
>> explains how to do this.
>>
>> I'd still think an example in the bluez documentation would be useful,
>> because…
> 
> Doesn’t test/test-profile give a pretty good overview of both server- and client-role usage of the Profile D-Bus API?

You are right, now that I know what I am looking for, this is exactly the example code that I need ;-)

> The main difference to the RFCOMM ioctls is that instead of a TTY you get a file descriptor (which I guess you could convert to a TTY using a pty). For client, another difference is that it’s a two-step process, i.e. first you register the client role profile and then you call e.g. ConnectProfile (which test-profile doesn’t cover).

I'll try to cook up an example application (if I get some spare time...) for the
(apparently) #1 wanted application of old rfcomm:
connecting to a "serial console" via bluetooth and then starting a terminal program on /dev/rfcomm0

This should be possible by either providing a local socket that can be connected to or a pty.

We can then decide if we include this in the bluez examples or if I provide it as a
separate project.

Best regards ans thanks for the info,

	Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
 public relations, for nature cannot be fooled." -- Richard Feynman
