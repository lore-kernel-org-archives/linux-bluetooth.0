Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1391EC4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A577320714
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 22:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvzob8W/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbgJ1W35 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387530AbgJ1W3z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D427C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:29:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id h24so1127799ejg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=NeBKMsyaOhwbafDqgThroGDniBUy61UYUZ4SjDBmGjQ=;
        b=rvzob8W/4f21SdU9dtwyDgV8EYW4YZW3RCa2o2mHXIyIdNLKCSFhtrvRkRV+mWSvtV
         qRP39LLPNx+R7rMnd7xhE2yN0IbQE4R+uni5RVsae5L78V3kfZi/xpEtl5LHwUYqFq8C
         Tp1CrMEl+QdVAXfRyho7dbkKyGUJ893Lt78U/IEvHMcUofYz/Of/5pn39umaNm1KxkZW
         xaYhzv41gx7t9zj9fuQ0MeImywha0c3RA/1sjQw0Pi0hAWe+k8fyt5bZoLRReyyOdMov
         AUuunAbp+6zdEgAf1Ys5niBNhqabCBfReSfMzi5BZ/6N7SijDIKz5hJfk2MHLcp7SFLS
         r9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NeBKMsyaOhwbafDqgThroGDniBUy61UYUZ4SjDBmGjQ=;
        b=uaMBpdt4o8Qi1DmaxVFpeEpG8QbY0H+1fAfIBw+6WvZo6enRVrUZGnyFOceAl0VwQN
         YhFw9AMB6Thig8MuUJUCTijnF/Eyqktkr2wtKPyRlwymEKZ58ZSdAaNV9C44RtupkBnc
         Er4vFbTTKTfnBw8lpcKpkzDn7HSwUPj+m7XkRq1xbPFF1usciS0LrzHhVianOU3NZ2h/
         0rIWVLqiNZHWkOeS2M/v9l8WMqHIbGfWrMt2KQWVTo5BAfjfxKRlqOXX6fOoqXJwFyyX
         67+ZxcaeRL8LzA1yk5plBHC9cW1NHK9HBNWX6+3EYwk5QvN96qUJWwie0PUEFs9Dzzal
         A9yg==
X-Gm-Message-State: AOAM533wdZiqfT3oPt5G9OrPXa/bXuBwHFDIyqAG4Ai+CWNmM3JHUjxz
        VKNqnvWICCkEDDKonNa02biUvUwESXnV6Q==
X-Google-Smtp-Source: ABdhPJzW0P9wT6/wtcvEwrpmORVpYOf86CNmAw4IcvnGpOzba1l61WudiVwyHkGS6ctk0qj7Y/1lqg==
X-Received: by 2002:aa7:c98b:: with SMTP id c11mr229128edt.24.1603909543200;
        Wed, 28 Oct 2020 11:25:43 -0700 (PDT)
Received: from jurupari (firewall.seitwerk.net. [80.155.46.66])
        by smtp.gmail.com with ESMTPSA id m16sm255226edj.37.2020.10.28.11.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:25:42 -0700 (PDT)
Message-ID: <01a23e10715b0be35dd4efba6a2bb7ab14cb4a4d.camel@gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
From:   Joschi 127 <127.joschi@gmail.com>
To:     Paul Stejskal <paul.stejskal@gmail.com>,
        linux-bluetooth@vger.kernel.org, pali@kernel.org
Date:   Wed, 28 Oct 2020 19:25:41 +0100
In-Reply-To: <0a520235-f1be-2b51-b047-4960f58e0715@gmail.com>
References: <0a520235-f1be-2b51-b047-4960f58e0715@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Am Mittwoch, den 28.10.2020, 11:29 -0500 schrieb Paul Stejskal:
> What can we do to get this published?
> 

As far as I understand Pali is waiting for feedback for his updated
suggestion from this email 
https://lore.kernel.org/linux-bluetooth/20191121224455.orhslaa6zdmlwe43@pali/
 with this patch attached 
https://lore.kernel.org/linux-bluetooth/20191121224455.orhslaa6zdmlwe43@pali/1.2-sco.patch

And as soon as this approach is confirmed I guess he could provide a
new updated patch in the required format and updated to the latest
mainline kernel version?

@Pali: Not sure if I got it right. Maybe you can check yourself and
confirm or correct me if I'm wrong.

Thanks to all!

