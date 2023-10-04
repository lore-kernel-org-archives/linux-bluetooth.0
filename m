Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35432E8FDD1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 06:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbjJDGse (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 02:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJDGsd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 02:48:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BE9E
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 23:48:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2774aa96947so1315015a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696402110; x=1697006910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23AGVAWCx64NlSwPlvRbIMj9BD4UvwLfDZ70pzkv7wo=;
        b=PEHWVe1H4rQjuiC5g5FE8z8OuS0DqKMy5aYJhv3oTdiPwVjJZYKvJIXgmVnSPWIrGR
         jiah2qqGRYye1sbVYmV4WSVjJi9iZSs6KQRnBftPxTgHHk8O4x3yFOXasIm8rNYt82Z7
         YUz59/exkcsdEhQLBPjQxVYOlyD83lEM5OloaJObnu1YhPloZKSTeoTavel0v7rHz78u
         sd41sy+H98etTqxLNh0D14087egLrLPB7bixjT9m7wbinEa9RPt6f558nWa+sFS58Xaz
         tx4MwIDEE3wRf3HJ/4ZGDbfyg8/bidxqaFE3filzbw5WRfkNAo0PONXjqRL55DjvOxEp
         vhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696402110; x=1697006910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23AGVAWCx64NlSwPlvRbIMj9BD4UvwLfDZ70pzkv7wo=;
        b=HQ44XBRxDQCMNI1IlYZvv74Ko3WacgNu2NwjGKi/mSoiaYV3PwjNMSOH5TEuEcvA0i
         HjMtgPkS9fFm+2xB4uGjK3fvEtVmK5bGwn/vJBeUfKjkLsxqK4kqQN+JUs2gHOmCq/sz
         yFN5HsSiXwwv6+z5b2LaG7UaP107DaUZ/SDsJUaqciQWCLJVxbqPk48Dg3WoT23Gw5t2
         05+Vx2X9yw4WJc0YxSfSb5VLVo3ly9JiQJf/C3KogG/rSQReJgVT0eTn+oloczUz8BKH
         xQzGbhIYSjKPYkV+d2Ha7fHVfvVaDWy7fJeVE57XdE8wtGVufRqGM+XP4LBDLD7/rG9e
         eO/Q==
X-Gm-Message-State: AOJu0YxrIBjs/UOz6XRL8mz3dMmr3AjFnkqV99R3V0rgH1jWl1pIutBC
        uH+EBnn7RZ+wSaBWbY3lr8M=
X-Google-Smtp-Source: AGHT+IGXW/NMBPkNnO9VKm//8nQQhh5XUC2SXJXHjrF4PYjXr48wJqNEjYrN84A+dyZZwJ6Yt1jS2g==
X-Received: by 2002:a17:90a:e60f:b0:26d:2d77:da7b with SMTP id j15-20020a17090ae60f00b0026d2d77da7bmr1396480pjy.6.1696402110051;
        Tue, 03 Oct 2023 23:48:30 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001c7373769basm2789290plo.88.2023.10.03.23.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 23:48:29 -0700 (PDT)
Message-ID: <7392af01-af99-4b42-b491-eb4f56120bc1@gmail.com>
Date:   Wed, 4 Oct 2023 13:48:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: ThinkPad T430 (BCM20702) Can't Detect Bluetooth Devices
 Starting from Kernel v6.1.0 Until Now v6.3.1
To:     Moh Oktavi Aziz Nugraha <moktavizzen@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        avisaziz123@gmail.com, linux-bluetooth@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>
References: <CAHCNbp3ztCcp31JdVYuxy+s1qXaa+Zy74eGJmfPmyrx_6Wjhhw@mail.gmail.com>
 <ZK32l3yQEMdmttOG@debian.me> <ZLyL7+IOqRSysJrl@debian.me>
 <CAHCNbp2BhCPe23XyM-x24NN=tcrhsETWy1eUMXHzTBXp3yu=qg@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAHCNbp2BhCPe23XyM-x24NN=tcrhsETWy1eUMXHzTBXp3yu=qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 04/10/2023 11:32, Moh Oktavi Aziz Nugraha wrote:
> hello, first i would like to say sorry because of this very very very
> late response. After this problem report i had a 6 month internship
> (college program) until december, so i had to switch to windows
> immediately after the initial report.
> but right now im writing this email in Fedora using the latest kernel
> and the problem seems to be fixed! my T430 can detect bluetooth
> devices fine right now

Please don't top-post; reply inline with appropriate context instead.
This allows readers to easily follow the conversation flow.

Anyway, telling regzbot:

#regzbot resolve: unbisected but fixed in v6.5.y

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

