Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B818FC83F33
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241055AbjIDWiW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjIDWiW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:38:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF3DB
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:38:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-564af0ac494so973158a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693867094; x=1694471894; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SXGzqUF3BdL0Yy89K0e4lhPfQqjTIlj4/46CXcc+Ht0=;
        b=gudkoNmkA9hYhzn65gtLl4OZyjCq5Efgv+uw4sJ3cF0EX5NVfWy+06AmT/TTnL8MdS
         ODoev8GZxZN5oVOu5Uix93HrgW+z5WFodJDCTq5U3V9uBbSSeVDQQeHBZbQjxvzGggVR
         /4G5fPqe3B60Mds8mwvtlQZH04P/NQju+8VH3oBbxxgSeakOLiKS55cgb0rsx34/Re8k
         au6XUb6ezgKIELrda+rdLEr/Urrp8H3dV/X9BCdGbv3A/QEohhkMgvLhOHJnvsC81gDJ
         7PHvblKmVs3QQB6vDH9Vx7FlrkI+SSUU0wyCPp4Z0cz2glukv8POIPKBFSY92+ecYQZJ
         nYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693867094; x=1694471894;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXGzqUF3BdL0Yy89K0e4lhPfQqjTIlj4/46CXcc+Ht0=;
        b=A5aJ9yy35L04Xg2yyJRQmyF1vugZs2ayKUklan5vDuOYv/j0xjkZzJDBIQJVaCJvA/
         lQFLUW/zSxgK++X+oKoLCzdGpglFPlDgmU6bkF2HSj+nKFfr8G6eHs+yMyIjJoZKZLVf
         No9UlEE8pmw8tehTdUr+WK2twXFNIIuyubFX2j/DsDMvea9/BrjFP3j8XNNR9wr15l+E
         FGX1/P6CkKq6KhvEmgBV1x9m9U8Hl3Cr6BLoj1NPsCW7wAzOrmooJwYRlsaCP+bWqoL8
         LVgyydduEHuPY59emBLPFDzfrH4NH6Web3A9j9hIBjAPjs9VW8J+H0O4ssYANJNR5yyU
         Ip/Q==
X-Gm-Message-State: AOJu0YxEXkYvbgnxqoDrMZHqCaiPdrcP82jK4qxeppv6CxgfoGEH0wxj
        QZPYBIdRrAU1ZZKTSlFeaknXh1cdy+E=
X-Google-Smtp-Source: AGHT+IH7L5UGJ7oZP8qRXVVC0oGiRk2oZysnZO/Z6Karu8XG3tLx3LekvRyK89U9NX0Gh8xg4Hayew==
X-Received: by 2002:a05:6a21:66cb:b0:133:b3a9:90d with SMTP id ze11-20020a056a2166cb00b00133b3a9090dmr8999974pzb.36.1693867093702;
        Mon, 04 Sep 2023 15:38:13 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.173.113])
        by smtp.gmail.com with ESMTPSA id j2-20020aa783c2000000b00672ea40b8a9sm8070987pfn.170.2023.09.04.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:38:13 -0700 (PDT)
Message-ID: <64f65c55.a70a0220.937d4.03d0@mx.google.com>
Date:   Mon, 04 Sep 2023 15:38:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2101039448844271819=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, olivier.lheureux@mind.be
Subject: RE: Fix a memory leak in Bluetooth L2CAP
In-Reply-To: <20230904221158.35425-2-olivier.lheureux@mind.be>
References: <20230904221158.35425-2-olivier.lheureux@mind.be>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2101039448844271819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:994
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2101039448844271819==--
