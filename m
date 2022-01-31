Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF56C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jan 2022 14:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349217AbiAaO7g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jan 2022 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiAaO7d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jan 2022 09:59:33 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F397C061714
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 06:59:33 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e17so19794368ljk.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 06:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=4oxw2yftup4zTZyREEGsuh0pigZ/icP5H9RySVtwFBQ=;
        b=MdSN9xIu71W+qfVC9ewzYL0Ehd62NlL4wfjD50+UWbfcB7SFiXmySFUCP1WH5cG/Q/
         WDmYVFxuyLAmCF2ksIzuDx38E/9JXUeNaQWZqaG+WHwAb0rVRGzHUvDqP8EonOYTyE+c
         3dakU7AhBd3V4F+nXfh1eP15F1KkVXRY2rsiGt1Jx4rCd2Zq4jL8fFLDPRZ41+qBmRj4
         wZDItaERYk9xxYafA7eLEtA0DJRIQj19zCh6EIruDpDffPmTLdkxNyUskgyBARd14a5Q
         AYTPFvSgCB+6tmz5uF5A+KEFwvpGD7w/V+uH/GdQjxEaoqlfWPGyvIaQd3r77M/ZXBLL
         4Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4oxw2yftup4zTZyREEGsuh0pigZ/icP5H9RySVtwFBQ=;
        b=6uAw0Vl2t5jjrU4m6f69vMY9a1eg/BPbhwHD+j/1/r7CHskc5f/lDbOyMld2XrC53m
         Ab6zzjh7FDbHB6KSpw/bKbYeRuHPWVuQ7VKkgmuJApGRavbgD9k91f6KsxOnwUnC1Qva
         SfE8xsFiTntqDszUEETp9Gooh6re8tZ0gLuQPv4L0dsh0Zi+eKWggRcf3KsLvYvdCAFd
         ZjB2Gg1mng3ai8oWkaK34/J4iYSAOM/wo9h2D/t2FSwIEN8bPtG3Po84xz+GyF639UJS
         /8SYN3udWbA3SoFSinjYMAPYdMtBn7imiwUfV+mEgpjCxFA8PvW2YUIatL4JNPejHsoS
         8JRg==
X-Gm-Message-State: AOAM531TvTieNXmnCwBW6V4dyJqMD5mqDjWNLTr5G9J9M2qA4gp9Nvht
        qIky4M7OfulKdvWJ5JW1biTUXzyJXUCityky
X-Google-Smtp-Source: ABdhPJz7Bwr8mWNMds0MsdqjK3kbd2owfecuEXeolrd0kWbSL4s6SSTcy5KLHGPhqboHZJy0lmPGsw==
X-Received: by 2002:a05:651c:1287:: with SMTP id 7mr13144673ljc.143.1643641171509;
        Mon, 31 Jan 2022 06:59:31 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.201])
        by smtp.gmail.com with ESMTPSA id u12sm3146643lfl.188.2022.01.31.06.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:59:31 -0800 (PST)
Message-ID: <ec9ac627-e49b-f668-a434-c1a5173c04db@gmail.com>
Date:   Mon, 31 Jan 2022 17:59:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: kernel 5.15.17: Spamming dmesg with "Malicious advertising data"
Content-Language: en-US
To:     Kai Krakow <kai@kaishome.de>, linux-bluetooth@vger.kernel.org
References: <CAC2ZOYu4zy0CPTW40qy3vJJDFuWEUvqqPJdMgtKL9=7Xh-YVEA@mail.gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <CAC2ZOYu4zy0CPTW40qy3vJJDFuWEUvqqPJdMgtKL9=7Xh-YVEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kai,

On 1/30/22 18:02, Kai Krakow wrote:
> Hello!
> 
> Since kernel 5.15.17, dmesg is spammed with the following log,
> sometimes multiple times per second:
> 
>> Bluetooth: hci0: Malicious advertising data. Stopping processing

Thanks for the report.

It's caused by one of my patches. Can you, please, try [1] and see if it 
works for you. It looks like we just need to backport that patch to fix 
the problem in stable kernels.


I am sorry for these false-positive messages :(


[1] 
https://lore.kernel.org/linux-bluetooth/20211124201628.405647-1-brian.gix@intel.com/ 




With regards,
Pavel Skripkin
