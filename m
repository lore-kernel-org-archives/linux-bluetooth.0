Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD2DC64ED6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 00:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjB1A6S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 19:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1A6R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 19:58:17 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06BE1CF4F
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 16:58:16 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y10so4215812qtj.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677545895;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SoXLzqUddS2wZntFrwJVowEOTk9nvr/wgmogBPscNaE=;
        b=aKLozqUqS1PdISk590eDQmgd3+BjJWQBT2ZfAu76B34At2DHPVLalf/Umv1pQJqW81
         FSYGBFlBrPYnMrf7Y2VA+cjIhnafs6r+R65dDbA/cn+mgMvR+qG1XovYwmxE5c05c/CP
         YXPMb2YfrgGl445Jqj37uJrym0rRp+ggPrvG4Ky1EF1UI0M9xFOX6AXvAErlbVYW7F8w
         P96L/fOl3YIAWDXpgSPfvJ1IX0eNhzmySJ77WfjXd45+7jjCS4uI9XBoOQKBkqnOjx+Z
         TIvopxm3A9a2T0wzr/aIXv3ljjQYo6V9bLmnjzstHTLyeSxsmTi6LLmJ4PKocd9h63iC
         CqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677545895;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoXLzqUddS2wZntFrwJVowEOTk9nvr/wgmogBPscNaE=;
        b=EGjBW+XcfzOReIuAUPibxP2x9de0PXZIMIQzesAVWj1EhLjiLmjlbhmhGMKVQsmYqY
         /sU15XfgHDbcYkXfq6VQuaH+QwCMZ2w3j8wvtcuA84UkweT7xfVvxYdrRzNlHWLKnBcK
         r1ePiSAq3VzzQgLnAAz7B5eO9+oXZakgsSUoFxhbwC6gAB9+a+pzDKSir1R5DWmk4iWe
         PmZo/shTtiB7vHUNpoi+cAeE3sHTvasO7SXphOS6pISfeiOa8FwZdCLH9UTkmxk0iJ7e
         NlLp2ZHAVzPNLsI8CNzhZOHAChuSDwEC2JFy3/+XRXiZzB0RQL/Ke4YyNgd1nxy7JBGB
         Oeqg==
X-Gm-Message-State: AO0yUKW2FcMB5DazxtWSfDB1j1UFME7gk3H1xbqI1tr572R/Mf03y4rh
        Fofl91S/Z+cfnyR2mgoSX1uX24R5iM4=
X-Google-Smtp-Source: AK7set9xZSH3pLs6kUyeWcmiKkin4cYM6ZUnEV51VXeDKPH+o8HwaS/6w2Gn9PJkw3hjr5vKuUGzeQ==
X-Received: by 2002:a05:622a:2:b0:3bf:c86b:3d2a with SMTP id x2-20020a05622a000200b003bfc86b3d2amr2442906qtw.9.1677545895681;
        Mon, 27 Feb 2023 16:58:15 -0800 (PST)
Received: from [172.17.0.2] ([172.176.205.113])
        by smtp.gmail.com with ESMTPSA id n3-20020ac86743000000b003bfbf3afe51sm5494291qtp.93.2023.02.27.16.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 16:58:15 -0800 (PST)
Message-ID: <63fd51a7.c80a0220.8275f.0163@mx.google.com>
Date:   Mon, 27 Feb 2023 16:58:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3667870730235111779=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v4] Bluetooth: hci_sync: Resume adv with no RPA when active scan
In-Reply-To: <20230227161320.kernel.v4.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
References: <20230227161320.kernel.v4.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3667870730235111779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:2402
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3667870730235111779==--
