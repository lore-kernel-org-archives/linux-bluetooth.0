Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C67C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Feb 2021 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF7564E77
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Feb 2021 18:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBSSiL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSSiK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Feb 2021 13:38:10 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479AEC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Feb 2021 10:37:30 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id x14so6533414qkm.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Feb 2021 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=GOZwiEVZS6aMmd3KE34mw+7MJIYbxVQWnK+8IgqemDI=;
        b=WyQFs1VMx8IXp3Cq703g4HXXrMZmoi65X46ohVGulnH+vRZndVRnOvKsNvPunXEonA
         IfhOe0Wocga567+dk6qRLCNJ+8uFXmyAKeQ++HcKqclFesSioY4W/L2DIuJfFNx75D2n
         Rmk9kGZ0fcpj30D6M3GquUcdct87E/Rwx7B5lXGdjtABYDMAHme9cXpYXXx/waxUbLon
         I1JgHF6ZNzzjLAso5FMW8J+Owax7GiL+c2oiyqODg30WaQuafBrc/6KDuYCuLfDsYz9P
         MDgcR/r3XbC/iyz0jbquoNA/TVpzJqGQDGJf2GU/3mfcQMNFax0/NCJ42OR+Di67ChRG
         4cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=GOZwiEVZS6aMmd3KE34mw+7MJIYbxVQWnK+8IgqemDI=;
        b=oWtI/JFHarw6ybYhZLbtDUgF9P/6G5ywwCZZ/Kh3DfMUD+i5dLB7AMkQfgu/cLtuKq
         URXCfLRw/3GQJ0RAiX1NDKEamh/PN4Ztcc/j0FdC757V5VQ3Y5xvsIovZUgQHBZMUZ3G
         teXCpdkaeBporV7gIuC4+Ja48M2ODPa7Yv4UmD+JMdr/sKTzBzrxZKmg86C3wVPzIC0X
         +12xBJ6OMWu+Xmh3r3PY0GwjWCR2AV7i7Ncd6SXDYUC5hg4oWmcQzDARiv4ZZZKFzeSl
         P2O9QcER4TkumDezdKSbtDEyaKpbhLBtcSu8eJg0CZam0/zHrGQJx5vjVyY1TIKVhnyb
         koew==
X-Gm-Message-State: AOAM531qXbif5HX6kKSelhRGI6yyqc51Y8MAeeNJcfjn71ez/hwbhlbi
        mpz/9jDB3lB+5zOfHns661WgKsN/Qe6mlA==
X-Google-Smtp-Source: ABdhPJyq/yq4mnmhrDgcCBUuipdEKCcsGp+5h/3P4OJXyBlCua3lN7f2ulScQhwWj98QfdT8ZfyYbA==
X-Received: by 2002:a37:c93:: with SMTP id 141mr10242599qkm.206.1613759849417;
        Fri, 19 Feb 2021 10:37:29 -0800 (PST)
Received: from [172.17.0.2] ([52.167.228.201])
        by smtp.gmail.com with ESMTPSA id q20sm6951514qke.26.2021.02.19.10.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:37:29 -0800 (PST)
Message-ID: <60300569.1c69fb81.def58.bf67@mx.google.com>
Date:   Fri, 19 Feb 2021 10:37:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2112957709207603591=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, curtis@maves.io
Subject: RE: [BlueZ] gatt-database: Fix notifying on indicatable attr
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210219174946.599144-1-curtis@maves.io>
References: <20210219174946.599144-1-curtis@maves.io>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2112957709207603591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=435711

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


--===============2112957709207603591==--
