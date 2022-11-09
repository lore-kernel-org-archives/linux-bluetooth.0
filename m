Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF8CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 21:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKIVOn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKIVOm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 16:14:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B7A15A37
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 13:14:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso2192948wms.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 13:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSow1iSgDx9D9KqdJs7nmJay12dkI7I2nKqIj9hVm/c=;
        b=lf78YKYPxheIEjQmwU9QuUqMyTsW5IytdT0GBuzTPrDDOXYdbFZq9zkNI+dS87icfg
         Uvx8IuadfuSllmJmI5i9fVNJ1hOT17LSqZpadwcff0Yo/p/qkvhugMBLCqMx3I/AvHzv
         RyslUglvL/ZGZg78k+HJy3JqUbsfuwcOArFyTwn7UOY21fHIpRlAile+s+uw+F26qIZt
         XMLCdIDxrkvNjywnVU9Ns+LJnBQvhsjlq4ZHBEheXZY8TnMNmW8E5uSFHl2M3BxfJcAQ
         Ox4uMKAqvrUPSOp2d7YjsbwYaLSi3lzc+LkijXrR/qMhtlKPIIb9IfPjx7XL9Yp1hfBR
         dqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSow1iSgDx9D9KqdJs7nmJay12dkI7I2nKqIj9hVm/c=;
        b=D5pOh0tbwEI68+noBxpNIg7WHMK7B5NtAayL69AqWLE+uSzGIyCnUSyzyqWix5tKaS
         sHxq1NHteYe0dQTYdxrg4nyEYu11cxnSzoOzOlMOnhUaNGF0cfhugWIfr/o100sUDvKY
         8Av5PwVaxvQ1nhutM57OYdAf2GaeN8BydhTTkX06cwWMb5Cu5bYQDkcyyAFuC0KoFkFb
         AiCeuHb/9TDrsPjiftoRcdqmB/awdAj7cLcGLZv8hoOd6ZeBEU2mbzw2SkWFEUme9QmW
         wGgGItvXyek3duonuzHU9GeaCLhxjem0n1muUj7rtdldVoHTiYgYKtvUt5cVN/cHqueP
         26IQ==
X-Gm-Message-State: ACrzQf2F7GPWUv+k1MmBIlM8eFX4k5SbzOilqx2kTTkLX4aA1uAfxfqM
        sItp3AtlC9Qwl769G9xPHyQ=
X-Google-Smtp-Source: AMsMyM7WR5xZdf/GPv/TGBI1rSifLjiyTJZHocaDqKyFed7YCUPkBTL1RJi4dDDLyAv/oUTgpTKEfw==
X-Received: by 2002:a05:600c:2044:b0:3cf:570f:db5e with SMTP id p4-20020a05600c204400b003cf570fdb5emr47309248wmg.57.1668028480249;
        Wed, 09 Nov 2022 13:14:40 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id bn9-20020a056000060900b00228cd9f6349sm14075767wrb.106.2022.11.09.13.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:14:39 -0800 (PST)
Message-ID: <7ea187e5-7c70-db36-1fa8-148507b2e7c5@gmail.com>
Date:   Wed, 9 Nov 2022 22:14:36 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
Subject: Re: [Regression] Cambridge Silicon Radio, Ltd Bluetooth Dongle
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jack <ostroffjh@users.sourceforge.net>
Cc:     linux-bluetooth@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <76cd4547-a68d-9d52-1d87-8299e29406ff@gmail.com>
 <LWPL3AC7.RRTERTU2.B5FO44IX@4YQH7VT3.DY2DZPQX.S6LIZ6VV>
 <CABBYNZKDEjYOW+b1snUsvBgidW37+tPbsidq0pXaOqWKvRC8uQ@mail.gmail.com>
From:   Swyter <swyterzone@gmail.com>
In-Reply-To: <CABBYNZKDEjYOW+b1snUsvBgidW37+tPbsidq0pXaOqWKvRC8uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>> In case it helps any, I have applied Swyter's patch referenced at
>> comment #243 of the bug referenced above, and it does restore function
>> to my particular dongle (Gentoo linux, with gentoo-sources kernel
>> 6.0.6.)  (I believe I provided the git bisect quoted at the top of this
>> message.)
>
> Ive applied the first 2 patches, the third one I'm not so sure I'd
> like to introduce another module parameter.

Thanks for that, Luiz. The module parameter does help a lot and it
has been requested a few times in the Bugzilla thread.

I have been thinking about this problem for a long time.

Essentially nulls-out any potential drawback the suspend workaround
may ever cause. In the past for this we used a very spotty whitelist,
but we can't really work with that here. When I'm talking about hundreds
to thousands of dongles in various states of brokenness I mean it.

The generic catch-all-as-best-as-we-can is the best way forward here.

Detecting fakes is hard enough, detecting dongles that don't like
the suspend workaround is essentially impossible. As they all
share the same identifiers than the ones that do.

Some fakes NEED the suspend workaround to work at all while a *much*
smaller subset of otherwise identical dongles have trouble with it.

Thanks to this last-effort parameter we can cover that last mile
without people having to recompile custom versions of btusb.

My dongle doesn't work? Easy, add this here. Most people won't
have to bother with this, but that final ~3% would be screwed.
