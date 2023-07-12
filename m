Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82584EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 10:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjGLKKc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 06:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjGLKKb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 06:10:31 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38E10FA
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 03:10:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a1d9b64837so5500116b6e.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1689156625; x=1691748625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7HKKrNMM+bNRXAnLw15TuFtkEXx69j/heSC81BxfGU=;
        b=fr+stdSNYewjvjPxJclgAsl05p827vvyRtKyz8Zs4k6fcV7C2QLlIU+tBIt1Tg+j6k
         YBrJh+IyH438RrL7E+UgoT9ZRSq3oMrQVclHwd7VGLQOvE0K1OgYKmxkXOuSRBu5g+8F
         H7FFun+LwU8TZ9UBjVopyn9VOlyYwGkH7ph1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689156625; x=1691748625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7HKKrNMM+bNRXAnLw15TuFtkEXx69j/heSC81BxfGU=;
        b=AscM9bruogpkges2nqZpnl78X7HFsL5YUHrGbI12/E16ngyl9a12HrlcCPwSISw4bt
         lW6u1P0hn1kS78bLmKc3c9hsehqZPm6wGGewoODHxYUpKSLe92Ecs8uArwz4letn288S
         EehU5SyZdTMYREY+S/dsREWJkfgKZ9VbbKSOYkRSzS4+QzHRu+/GpqiBu+HMRExp5AWT
         tprCM1DUWWphFvM0LjSoM3aeF/e4Vz4qTSThKvW5TDUF0nthMfFjSug5dZDUu+de6NRO
         IV8BwTzhc/I9hgy8zg7lt8kzdl67VZD0PfyGkAd42fiEIXQp7k7e893vv+NRkQj8BrUo
         9e/Q==
X-Gm-Message-State: ABy/qLaYVca4w9OW6g0HQZQeYpJIagGznRsbXDo6pLE38SbiTz02n0wo
        q3JdYm6fiWIEnq7d/KBGlEU08WYJDLAL7Cxp6FOGTg==
X-Google-Smtp-Source: APBJJlGvaV3S3ee5GsrfRrxC5/BuGf9LLENZgRvHsArUVxrI91+o2SqcNlzDn9064TtTzXVER1XTvA==
X-Received: by 2002:a05:6358:98a2:b0:134:c530:c2fa with SMTP id q34-20020a05635898a200b00134c530c2famr16942731rwa.30.1689156624639;
        Wed, 12 Jul 2023 03:10:24 -0700 (PDT)
Received: from 53c778cd7e6b ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id w1-20020a637b01000000b0053f06d09725sm3129806pgc.32.2023.07.12.03.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:10:24 -0700 (PDT)
Date:   Wed, 12 Jul 2023 10:10:20 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Russell Senior <russell@personaltelco.net>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: ell location bug/inconsistency with README
Message-ID: <ZK58DFhBZ9kVA1ts@53c778cd7e6b>
References: <CAHP3WfM2efs35fvQ+uOjy2awWgKosAfA7FbeAob8k6GhBwZvng@mail.gmail.com>
 <CAHP3WfMz1p4MHwwDGTeU6iyuPz3OhnoB2EZ62s4voZbjhBEocw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP3WfMz1p4MHwwDGTeU6iyuPz3OhnoB2EZ62s4voZbjhBEocw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jul 11, 2023 at 09:51:47PM -0700, Russell Senior wrote:
> I mentioned this on the irc channel recently, thought I'd escalate to
> the mailing list. Also, I am a total newbie with bluez, so please
> pardon what appears like and actually is pathetic ignorance.
> 
> I am building bluez 5.68 on OpenWrt and found that a recent commit
> 1106b28be8 seems to have made the configure script look for ell
> whether or not --enable-mesh or --enable-btpclient are used (I'm not
> using them), in contrast to the language in the README:
> 
> "When neither --enable-mesh nor --enable-btpclient is specified, then this
> part is irrelevant and Embedded Linux library is not required."
> 
> I worked around it by patching out the part of configure that errors
> on not finding ell, but this seems like a bug either in the code or
> the README.


Hi Russell,

Were you cross compiling? If so. This should fix the compile: 
https://patchwork.kernel.org/project/bluetooth/patch/20230701041252.139338-1-rudi@heitbaum.com/
https://lore.kernel.org/linux-bluetooth/20230701041252.139338-1-rudi@heitbaum.com/

Regards
Rudi

> Thanks,
> 
> -- 
> Russell Senior
> russell@personaltelco.net
