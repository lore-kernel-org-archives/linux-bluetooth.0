Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF6C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jun 2022 19:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344651AbiFITVh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jun 2022 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiFITVd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jun 2022 15:21:33 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9D1F1BE7
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 12:21:32 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d23so3582541qke.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jun 2022 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=rGRpK+qQOJ6EAbdwXCzKlTHLi5ZdAryuqEEnA+iaUW4=;
        b=DeuYgy04SInZ34BQH/gZtfG9y5MSmQQGVGIrFocbp4E5j74ZtpgN4dxWbdupb6jlAT
         EiwwyNXgnMRhKUXPFP2zuAEDkwekkfOYzWdjDbIkXZgYhCzNKK7EopL0LTuBT+3MZfuE
         pXY5adwUAFpxF1opRBdqgJll6JB5ezKlxBqz8aHGo2tp72fJgUyNcyqDU4YnXf3hCRAf
         XJhoXon4hhmyGaVRl9fQn3cAgjn279r9+jz2G1ggyhPO3tE0yVZAEOuhDjIZ1Cyx/rXW
         ByYGBoUpAdp/tTQ9Ql50/L+ujuoEv5dXPZkA39w8WH00EGhAoG1R92wmjkeRamAB5i/Z
         3/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=rGRpK+qQOJ6EAbdwXCzKlTHLi5ZdAryuqEEnA+iaUW4=;
        b=BbwNKzdG++4NmlS5jlRV85RAm+r96Yobczw8950JyuV9ybavFx1hgmDMv6WjVVpRXd
         yL0z+uxUQ7Fzl1TMvIzDvoOYvhiD4PB/haSHHh7VmpPwbQqce2nwl7dDu0BFIoxGsYbV
         m9Tr7/WKkL3S6Dp1avBs1AHDfhogYtkwKI6VaxHoQQ38kChUHD6BVpZPfN15tARqmjHd
         wMIGxrQBtTQAafLOIiCAjgJP7dh8b52M/bL4Vd5REKO9jAZHKnUY8zMLkTLtAukH1cuq
         N4o3YxVHqI+fYqbT7gDL764FdaMiILEPVo8Q2eKOKqMH6LyZE5RUjGha7rRTggYQzIOf
         zpqg==
X-Gm-Message-State: AOAM5319N4DZGMaxPjMLuPRm8bH0Uiuczfbfa09k3QNuMk8olfELuWZ2
        wn+BtMtqbx8NyQnqqNbyDYqoqJX9OSyi6A==
X-Google-Smtp-Source: ABdhPJzmxz7FPvVRQIJr7ByYuhjYfu1YjcSLIVowxWvstiMjkLYsAf7AN1Ee3Oomt9oedBUaDONy+g==
X-Received: by 2002:a05:620a:284b:b0:67d:1ce7:328b with SMTP id h11-20020a05620a284b00b0067d1ce7328bmr27743473qkp.312.1654802491361;
        Thu, 09 Jun 2022 12:21:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.156.164])
        by smtp.gmail.com with ESMTPSA id m2-20020a05620a290200b006a6ae636ce0sm14499528qkp.131.2022.06.09.12.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 12:21:31 -0700 (PDT)
Message-ID: <62a2483b.1c69fb81.4646b.9b6f@mx.google.com>
Date:   Thu, 09 Jun 2022 12:21:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4910540191895476983=="
MIME-Version: 1.0
Subject: RE: test-runner: Add support for audio daemons
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
In-Reply-To: <20220609190442.74325-2-frederic.danis@collabora.com>
References: <20220609190442.74325-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4910540191895476983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: tools/test-runner.c:445
error: tools/test-runner.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4910540191895476983==--
