Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281D322482
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 09:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAFJwW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 04:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhAFJwV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 04:52:21 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D3C06134D
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 01:51:41 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n4so2142685iow.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 01:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ldCz9Hkh0UIHgIhvQey4qeTQ51iIa9EqdwI8pxneJt0=;
        b=j1Lb7VFxYtwP9zjLhNkkmTgr053SPVcY7ZvDYbtHzgQqRzO/n0jJeVjvZp44OmV0dT
         oItlD8tl1We1u+B6ewspxhYRdsJTvCMli6MLVarjMSo/ces82c5n96c0Hvi6QdRsKWhz
         chNwPXzOXDafClISMHjj/4xXj33bvMtjzfgxFsuLt0OIjN5qT/+lKjB9OTdGubFE/AUw
         Y2PohCLCuk3CJV9hjxgogleI73u/622DspIzDLMS5aeA5RyuTYGg5qKzjwhfpdJNIhuY
         EYbigT3GEMYnbX2T8ZLSaDIBLQGsm6B0vx0xScwXNga2lUK/sxqPQABaTaGMcW53E0gL
         LIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ldCz9Hkh0UIHgIhvQey4qeTQ51iIa9EqdwI8pxneJt0=;
        b=D4HTSxEVddEeK+QwC5uIUiY5i6UwOwo2c1gbI+yXtGHTSHiPSf7IqYGVl90ReJjnF8
         JR2IqJ6eaYpIUuQMafsXclj0Q8+906lDLZujzfuXBNSoJGnwDUihTBJEYd6faFD1Y1zn
         pAMiv8R13MvMBgGSQm7AyM9iC0mHs+QiDKwa7nlpipe/c0uxTLj0jhiabkSvpUCnVZGJ
         IGWZo/7L8epuU/+GAsr+2lekcyrVs4jx880a8m/ylZysu/aIaCfIGwMPKQxU0VQSPWKw
         RL4UvpuU40MqIPGOE27E14BwIzPtqdR2ry9C0Qh9taC1NjsqNTjCWipIoxMyMfaMzS77
         djGw==
X-Gm-Message-State: AOAM530GyWDuksVE0S10DHHGRyaeBSRYMXZfnoqqe0XHLQnXdAunGU0e
        fxdkDeFEhBKBUabl+fCl4pTYY8rvL9s=
X-Google-Smtp-Source: ABdhPJx0/yZg6XMxpqvlqcOxJKZWp3uz45Vtu+JH9gdJRwcvus0LweKhmheOmuNJ05m0p4CwcM0Omw==
X-Received: by 2002:a05:6602:1608:: with SMTP id x8mr2315085iow.72.1609926700520;
        Wed, 06 Jan 2021 01:51:40 -0800 (PST)
Received: from [172.17.0.2] ([40.65.229.19])
        by smtp.gmail.com with ESMTPSA id w9sm1574811ilq.43.2021.01.06.01.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 01:51:40 -0800 (PST)
Message-ID: <5ff5882c.1c69fb81.6da3a.6a7f@mx.google.com>
Date:   Wed, 06 Jan 2021 01:51:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7414665227040398123=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v1] adapter: Remove temporary devices before power off
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210106172647.Bluez.v1.1.If4056891c866780eba7b210887c6db468b8b55e9@changeid>
References: <20210106172647.Bluez.v1.1.If4056891c866780eba7b210887c6db468b8b55e9@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7414665227040398123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=409877

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7414665227040398123==--
