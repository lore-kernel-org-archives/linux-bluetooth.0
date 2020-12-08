Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906B4C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 23:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DAA123AAC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 23:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgLHXeP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbgLHXeO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 18:34:14 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B619FC0613CF
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Dec 2020 15:33:34 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id s6so98936qvn.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Dec 2020 15:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3f5TnmOfi4AzoedjKIruFg9Jn60UKTH8F/sarIxwyy8=;
        b=nermSj1G9Vd4Np66KIkR9zp0kqDtfnzIeqW59g5EUOJIPeWX2PHo6oUZt9eoMIVPQ4
         /7SG136vtGZIFJXbEODO9HrmM2/9VIFbmXWXMqK9dyQcn0Bz4IAyplv+XpPrIlxIU5Vv
         TNfXWTq+jyBboBDbjZNiOLpKrZHi7pKDhW3YNeul1bDjIv1aAQ0+QVcfYmJ5Kz0PUyQo
         1YU8HDxQwMlQ4nittnj8N5GG3+8S7LHrrwtoABqAcqvKI0pJMEhgHHtEw0O6QzeBfedC
         aeqFzW0QqGyFeixKpUf8Auap1oeDX/3YaTj5f3n+Ran3hj/vMTYBWZHP+L+bCC3sUtDE
         4K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3f5TnmOfi4AzoedjKIruFg9Jn60UKTH8F/sarIxwyy8=;
        b=dNJaWA2Q69fjfBTwH2WeyiFaZkI5B1yKjjKKEn+ivioKLM41Lnla85WIGnIuFCYb2B
         x7Qvgqt6pj1K2saXEjSDYPWefPIUV2AktCpVZYc6uKAYFt9EdEnpU0WvVBP3Kx4MLyDw
         Rl8dskg7X/M+/+FT4h8rP+Z/zCr0kwrkmCPyO5YR5JLs8nW2mASBaXTwuaM0qSmo+Kah
         /hVGDRxo0LxENR9owqYPVwQhSvLrzOV/Om+AWDZoL3gX6ce2Bin22z+slY2LdmY1G+zj
         YkVu/EX6NExAHIlroTRXSa/ZfPYV5jkbIoJZRgHTmUHahcMd7VA6ebbJbgBKGhS+3D7R
         yNhA==
X-Gm-Message-State: AOAM532O0RMeUY1kPQvwJSU7O837kf21/GU3wZLUJcKzIR6pqYTdj+X/
        jHd78m4fftl9TuWHNqfr9VMFWEzVrjCW7A==
X-Google-Smtp-Source: ABdhPJzSFRGR+O2O7YPYBgMZ35XMUekgT1bKG34fO7tMpwE0Uutkpu9jXWYRtmShLqJusv8BcMJNiQ==
X-Received: by 2002:a0c:ee87:: with SMTP id u7mr694589qvr.21.1607470413843;
        Tue, 08 Dec 2020 15:33:33 -0800 (PST)
Received: from [172.17.0.2] ([52.177.72.32])
        by smtp.gmail.com with ESMTPSA id p58sm254567qte.38.2020.12.08.15.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:33:33 -0800 (PST)
Message-ID: <5fd00d4d.1c69fb81.c5561.1985@mx.google.com>
Date:   Tue, 08 Dec 2020 15:33:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8816507925108071109=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [bluez,v1] test: add test app for Advertisement Monitor API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201208145756.bluez.v1.1.I515e5e94cf334f64cd9e3b091684212f056147f8@changeid>
References: <20201208145756.bluez.v1.1.I515e5e94cf334f64cd9e3b091684212f056147f8@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8816507925108071109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=398547

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


--===============8816507925108071109==--
