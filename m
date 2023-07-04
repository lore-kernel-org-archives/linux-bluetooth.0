Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78760EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 07:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjGDH35 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjGDH3z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 03:29:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE11C1A7
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jul 2023 00:29:54 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-763a2e39b88so545525285a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jul 2023 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688455794; x=1691047794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YKsERztKAx37vOMDVWNgQxBCPiJ6gZgzDuQ/1LBHEgA=;
        b=XTz5cUHzq8ByZtwwczdIzenCw1kNKGswr7EJeZdQf6o9CPrGt1wn/tJyw4zu5SbswR
         2NP6Hen99rDA+Nx37H9Lgrj/QyoM0lXZCD3U8J6A2ieRRHoUUTd0rOgx4+QaUX5aOfmO
         CsDFt+dUYWOxFmvv9sqwAG8W/fxo/LI/jYJ8LeHFa9+hCo45UN0FaeIPdjG92nMMqm0i
         LTvW52DagIU+oh6G17glff0wPbjzTAO3pujw6EsXTq3Rq3Nt4OhJ3bOlBrtUgTzPnayS
         bhU630p5p8JJSTL4JR1GCs4F2Db/39f8MNH2WznJ0k95/LdnRZ0pOHmss0Sk0DPZVDkW
         asNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455794; x=1691047794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKsERztKAx37vOMDVWNgQxBCPiJ6gZgzDuQ/1LBHEgA=;
        b=BLVYj7UrTTMzSicvR0MJWFwy0aFuUuxljyHMNNixcwe6jhaiJRLKHcFP9su4pWPf12
         5vdsyaLyWsZ+Mo/rk5meY86USqqFDp2QW7yBvNeyYRVZkQxYSItWXjWFe5sGcs9Preye
         XqRgV7iKZhpzR0FLOQ8TnYxQsKeWaU87DSGo/28mFT+mWFMOVh3eRM5+dsTcYAgXAJmk
         /tk0FZ7cUSWMgShXWA2vx3DoQ0L2UxFa9QoZrZoVVNfQweicQDYcVtgiBjPlh/sIvma7
         RBIh3Ys5uOrZKpHAjZ/dintLNm7RWLe0ZiFv6mckmAXLbEULqd+YTZUjlxckC1sKxxi2
         auiQ==
X-Gm-Message-State: ABy/qLY3/2hPJank+cmJrELz0Gh1d17Wp5Tw5Adsl44Orh+gT+5I5T2c
        ZaG7lHOicIK07tZ9mYC5FWFYZLR/jXQ=
X-Google-Smtp-Source: APBJJlEOyVt/QWBEPhRSuXe3gjw2iURIEuTfvTY2t0PYwj35i2CUbcCuCN577XNgjmU9JvjEV/Ybzw==
X-Received: by 2002:a05:620a:4106:b0:767:2833:7130 with SMTP id j6-20020a05620a410600b0076728337130mr16827603qko.68.1688455793697;
        Tue, 04 Jul 2023 00:29:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.83])
        by smtp.gmail.com with ESMTPSA id pc27-20020a05620a841b00b0075772c756e0sm6418569qkn.101.2023.07.04.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:29:53 -0700 (PDT)
Message-ID: <64a3ca71.050a0220.64957.0497@mx.google.com>
Date:   Tue, 04 Jul 2023 00:29:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1977201537639443669=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: plugins/admin: Fix heap-use-after-free when using 2 controllers
In-Reply-To: <20230704055643.296260-2-vlad.pruteanu@nxp.com>
References: <20230704055643.296260-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1977201537639443669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=762216

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      32.78 seconds
BluezMake                     PASS      986.57 seconds
MakeCheck                     PASS      13.03 seconds
MakeDistcheck                 PASS      186.73 seconds
CheckValgrind                 PASS      306.82 seconds
CheckSmatch                   PASS      408.42 seconds
bluezmakeextell               PASS      125.13 seconds
IncrementalBuild              PASS      819.17 seconds
ScanBuild                     PASS      1253.01 seconds



---
Regards,
Linux Bluetooth


--===============1977201537639443669==--
