Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DE5C54EBE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 06:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjAJGm3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 01:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjAJGm1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 01:42:27 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ADDCE3A
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jan 2023 22:42:26 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r194so2235426oie.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jan 2023 22:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=erRocgB0hISRBeqoJBbgmWHmFaLlSd2tA8hufgUfvPw=;
        b=qh1zpPMSd5Xhp3IT2VWsoemkeu52D8SJvRnZYRphh12hlKkg14DGp5ChowQLxIIcuh
         3MzBw1GyYj4Vdg6bC74CY76ZImY2Y+47/yOg2QtSACSGBfDZgmuTGpnl2R3yd2bWqZjI
         bZe5Q3u/gKaTl+u/9tHjuVVD3qjsnu1uwWhgMYGhQa9ESJVkb9ndeKCzO1DBBw4aoSJc
         XypY1kKwHv7ftwa5YI6EMsDFjTfjpgHYgl4ch3xehUIq1TsrSVMvLJPgAJ/tR3dYLBxQ
         WY6WawSD1TtEs5DQ5PN6FBtemLBxQsia3590/11mGDt0522ktTHmNhhM06k/ECyfWDQ+
         WGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=erRocgB0hISRBeqoJBbgmWHmFaLlSd2tA8hufgUfvPw=;
        b=QgwUA4jQ3ObrJTVppaKW1LNatqbodaAHxVbuMstdcgqMGCBra5qI0XTPLWdBQonkP8
         yru7w/CLnwWdjRXR5Gvgyq6B1vkqjJB9MLH1yE7lJC9+r+QiHZvSbfJpEE6KciBOV1Xz
         FPohELsIGh8KS76264fAsIJnxuvRctCME4o9q6p+Wrx56TldCqMmbakLJq8lQJAapAm3
         gQb2ruYxq6zuv8894QVde3gTfPuSpBe4dk6xxGu2ZmnZ9Si+VgSPcxDZIy5+fruOGqxA
         VU4gU3zLvDSxJ95NTwxL6vDWes2sVpz1B9n+R8OHhiwFYR6u96y21VElawbpIObWX0eq
         shWw==
X-Gm-Message-State: AFqh2koN7cO/5plYCOyKssOtwNYvrBvaQ7kCssCaogK6e6lxVFG2KDcJ
        71nUHneld2ODY4JqjqgTRoFP4aLm/Kw=
X-Google-Smtp-Source: AMrXdXvhXwZ4GDlp5DK/i3fdm4ZGcT6Vrg0lwVApOX41BIyLESbmU2nO0JR7lX63twTTgyt94L0f3Q==
X-Received: by 2002:a05:6808:14c1:b0:35b:9e91:305c with SMTP id f1-20020a05680814c100b0035b9e91305cmr39635389oiw.9.1673332946037;
        Mon, 09 Jan 2023 22:42:26 -0800 (PST)
Received: from [172.17.0.2] ([104.210.132.80])
        by smtp.gmail.com with ESMTPSA id bl6-20020a056830370600b00670461b8be4sm5579409otb.33.2023.01.09.22.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 22:42:25 -0800 (PST)
Message-ID: <63bd08d1.050a0220.e3420.1787@mx.google.com>
Date:   Mon, 09 Jan 2023 22:42:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2490246059844738308=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, shaozhengchao@huawei.com
Subject: RE: [v2] Bluetooth: hci_sync: fix memory leak in hci_update_adv_data()
In-Reply-To: <20230110064420.3409168-1-shaozhengchao@huawei.com>
References: <20230110064420.3409168-1-shaozhengchao@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2490246059844738308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:6187
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2490246059844738308==--
