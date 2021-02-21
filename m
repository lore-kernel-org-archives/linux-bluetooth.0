Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB39C433E9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Feb 2021 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2A864F03
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Feb 2021 17:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBURKs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Feb 2021 12:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBURKr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Feb 2021 12:10:47 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0895C061786
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 09:10:06 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so16637080wrx.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LUwq9McKGOH7NmhhUxJz0Q2jGTHs6WYitlmw6zqnvkA=;
        b=ng6YZ5AcO4FJQqk/qbyJMzHE4mDbg+P7n2Fh1bs/dqQ9E0eBKEPCiROL4yBqd/Ib3t
         ssLV0Vn4nW+uKMb8dXWTVywGmYAwVRbG4+dwX+GbLf5orhK6B55XWjpIq+0XobQ8GXU7
         b2/RIXJxrlx+frcInjOw+h67bwdm9Ec+5olwICc7PxtsND0M7GoWBc8E4vasRetS4xh7
         R/52VRzjlF7MVkqK76gDAEFwLKKY5iO+3xX87KyIMxuuKnEM75XgmhbWJcUIw+vWUiEa
         c88CUDf3Tl6nOOXWRAPC+otXS8KW2rV1fMmqUvIcnBlwxvCj6HRk8x4/na4m5vIZJf5G
         wkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LUwq9McKGOH7NmhhUxJz0Q2jGTHs6WYitlmw6zqnvkA=;
        b=oymgUf3chZeoNaX4g4PUCUChC9FPjEIIdfWaxWF6C8Zu2AgK9zNGSxB0Z7Nfd5ubkO
         ElpVdUJ387zovpCoWyi4r3bpF5hMtu6zo4Tnfiii1B7RK1le/l0rOxJ32qBsV4UgT31z
         9i+CwkmMJTYp8ji/wETDzJMqqtgS/rTbLfhvWrP4soqi46XaCn2nyLZRmPGfQ8LRG36D
         MEruBJrvsM8M/niJVVTf1XpOcKA0o4uQqcxoQ+k4CxCOQLCmntqeKt1M33B9wAzI4NWA
         wssAfxZqjJbWj+3dToVC05bWrfr3lk4iFVQPC30dXiOB+rWNDONSTGskd6fnhJBi5ttE
         jR2Q==
X-Gm-Message-State: AOAM533dkKUUaE1MotBJkOGzmw2Wo6ufBhIxHqbza1EgnOVNbZ3T1HMe
        kCeJMVmMu2uG+X4q/yes2H3lt7eAp7bShMsj0CZIy/EcS/1aEoBK
X-Google-Smtp-Source: ABdhPJzGbsSeoXyObag7wATvIet9iqpm8HzWG/iN416AcaGBG+Qf7i6eGe6zYHIn4+csyouFqDMWrVUMsN3c3V2JaTo=
X-Received: by 2002:adf:ee0a:: with SMTP id y10mr14323625wrn.79.1613927404991;
 Sun, 21 Feb 2021 09:10:04 -0800 (PST)
MIME-Version: 1.0
From:   Mihai Emilian <be.mihai22@gmail.com>
Date:   Sun, 21 Feb 2021 18:09:54 +0100
Message-ID: <CAP_L5iP4vuasHk6qF4KYrPUwE33n3NVzwA28E559bykM9+GnOw@mail.gmail.com>
Subject: How to receive notifications after calling StartNotify
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear linux-bluetooth community,

I am writing a bluetooth client in C which receives notifications from
a bluetooth device (server). I am able to call StartNotify() from the
bluez api and the Notifying property changes to true. However, I am
not sure how I should listen for the notifications, or where.

There are several questions:
a) How do I provide a callback function to this?
b) async or sync method call? Does it matter?
c) Do I need the main loop to do this and why?

Here's my source code https://pastebin.com/KEGTatsL

Is there an example? I tried looking at the different files such as
client in bluez kernel source and gatttool source, but I couldn't
figure this out.

Many thanks,
Regards,
Mihai
