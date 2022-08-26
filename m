Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A76FECAAA3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 09:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245566AbiHZJst (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243137AbiHZJss (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 05:48:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9DD5DE1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 02:48:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso7549653pjh.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=UCLnjccB784egIAS8aZhlfOQK0ztSZ4TlPY4ZSpfxQ0=;
        b=TdGmqMK55uHep4ywvWibaJdmNz9cayBncmzvfOJjOD6q5vmgH+b4aZBp0+pCqnOJb8
         th0xK4Z86hDU9/nTUkSVpQa3VH+soMsjYjluLwU+Fa1/dJO9HArexRVhPaBz5f1mhcJV
         G+GKwAFrMj1lTg0H+82ESsumtV4qY2BN5Yysp8AZYVLDmceHfx4C9xLW7JQS8J7gs7t4
         aCKOX4h0RkVL0QJH0Ls1FnnYDiHIuTUSgYvqJ7iBJd0Dz5mgb7zx2w4UNOHvgK6ixBAa
         E2wm7ut7ARqlM+Z4WXvNolaors4LbZ/nUYBdhGfAWY1uRhP+O5dfzLelteh1xE5CSjva
         b1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=UCLnjccB784egIAS8aZhlfOQK0ztSZ4TlPY4ZSpfxQ0=;
        b=OG4/AKmDSCwb8TczyQoHolMbH0w1oFToEBlpQrutaXTwrOKcvejxrdWFbbJFzuPg4d
         c8BRVaoLz4aF5c6SnmLz4nZFOlpO7XCg9fCUOW55NAl9ZIugh2wIZyXebx9IEqvjSH8J
         OmcCLLvvpnM2dM84JhS0H8nBEtwoknHaIj/vWlRqf0gyfODgZwAgXvys0LRiP0Ks3nn0
         JsJv/4qoFc5cTMKPyqZSlXP7bjoDTqFA9sRXdy89LMi995hFewJEkVhNJzCjUKUN4WWA
         c66jjIOcv4fN2NWW6Bc6jfGhGOdsXFKnksLSXLDjI/6ViZt1AvoTmVfA/SXzMnTAePQH
         ttbg==
X-Gm-Message-State: ACgBeo0fGdBICSA7dpMprO8hrhYNyhoxgFbhpJPHpI0m6JrnLpYQ3qta
        KGMF1b8AtLL2Kgz9JVDNMKPy3+3By3QvZg==
X-Google-Smtp-Source: AA6agR6JcW0SDwR4+tpBbpKMrS0OHzy3IF0rWnYtN6kaGLEuU5LZAkLcUm5pw3rsZD5+rJlplUmaEw==
X-Received: by 2002:a17:90b:4b42:b0:1fb:4e76:989a with SMTP id mi2-20020a17090b4b4200b001fb4e76989amr3534740pjb.120.1661507326359;
        Fri, 26 Aug 2022 02:48:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.110.70])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902e88200b0016f1aa00abbsm1123147plg.195.2022.08.26.02.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:48:45 -0700 (PDT)
Message-ID: <630896fd.170a0220.22cf2.1e15@mx.google.com>
Date:   Fri, 26 Aug 2022 02:48:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9214679753367360763=="
MIME-Version: 1.0
Subject: RE: [v2] adapter: Implement PowerState property
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
In-Reply-To: <0b75a14f14c0bdffd1d08f720438a4caf15c4c09.camel@hadess.net>
References: <0b75a14f14c0bdffd1d08f720438a4caf15c4c09.camel@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9214679753367360763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 12
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9214679753367360763==--
