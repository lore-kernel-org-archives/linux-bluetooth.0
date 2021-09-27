Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B28C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF61610A2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhI0Ukd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbhI0Ukc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:40:32 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F13C061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:38:54 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r16so17884103qtw.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=u172qMFkslB0Gsa7efxAzSycH5/cWxBWpuKZkHThRdo=;
        b=AKjOFjMe/6gmJS9bEf+/FQy3Wfj1tJX2P3sCVsxZYKD1K/7u3+PC/dDQLxd+oZa+Za
         XGHmnyCt8sfziYIbI+QqW3HAmNswjDnKh+vtSOsVfeLWXSWV+Z3ElcDRSg1eXkuJ8xaZ
         9Nyj83ZHSyH558xNsgyN0Z5JX15WKwg63PGgzbv3HzcYS775s4qYNg39R4rJRnKVV4Zx
         2zhpWTJa7B6KQcwVBOvXqR6Cp9oST9M3kmAvQh3RVblJOnpdLjI+IaciowvKitP627PX
         hX5FP4OadFFcFg1bmS4LhTaPcmG8cYctDo358QJPUtRZ9yn49U5fuebQIMOp81oJOWTf
         9brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=u172qMFkslB0Gsa7efxAzSycH5/cWxBWpuKZkHThRdo=;
        b=WXCusrQl04rQEFwPszwYH0wzpq1p7m0LvQaXbv+tcjzjwR5+MJkpZ5T6Y88cCBj7oc
         Hn7viLZdbBE7Q0At0bKDcvezSnPdug/fbH8dAb2+oJSz9+PBxdCaQgASPfmeOynCihW8
         QscY3zC8RooMKBesK5Ei4RLFNMhmceH0Bblm2WbTg9kHLXDkIKAC5BFt9baMflUFxonv
         ajihCQwAokxJEady/nKJwbBm6p418zPB4AvWKIDNISKICrfzTHKisl15sDyvYuMq5JkQ
         frzz+kCpsW0vGHrASUdBqpqc8WG3T/0CCW9m0FvMnwExZ1o05G92CoaMF26WCFekTf+/
         XE9g==
X-Gm-Message-State: AOAM530QjR16KTcp7nxhpEYNFlglPzNEo9LJTOAIgZjoL4UmUYoXe/yy
        8TVX6qwvjZ5pBCC/xX6Ni2oaLuevexD9Vg==
X-Google-Smtp-Source: ABdhPJzpl0LxTz1FphsvwHugboVsU1CPuDNtC78lRZWpNl70WOJd4tVJUP9YDo2xp1wHnE9llY1JpQ==
X-Received: by 2002:ac8:4589:: with SMTP id l9mr1925627qtn.338.1632775133260;
        Mon, 27 Sep 2021 13:38:53 -0700 (PDT)
Received: from [172.17.0.2] ([52.255.178.14])
        by smtp.gmail.com with ESMTPSA id o21sm7728054qtq.43.2021.09.27.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:38:52 -0700 (PDT)
Message-ID: <61522bdc.1c69fb81.40eba.511b@mx.google.com>
Date:   Mon, 27 Sep 2021 13:38:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4112368601884964439=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: Introduce Advertisement Monitor Device Tracking event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210927131456.BlueZ.v1.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
References: <20210927131456.BlueZ.v1.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4112368601884964439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=553715

---Test result---

Test Summary:
CheckPatch                    PASS      4.10 seconds
GitLint                       PASS      2.72 seconds
Prep - Setup ELL              PASS      50.41 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      9.43 seconds
Build - Make                  PASS      219.41 seconds
Make Check                    PASS      9.73 seconds
Make Distcheck                PASS      263.95 seconds
Build w/ext ELL - Configure   PASS      9.43 seconds
Build w/ext ELL - Make        PASS      203.37 seconds



---
Regards,
Linux Bluetooth


--===============4112368601884964439==--
