Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AF0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiI2TrK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiI2TrJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:47:09 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302231D1E2C
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:47:06 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d1so1582637qvs.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=WGbqd1AhfBh6VPI+bfrbh855KrSpcdNhY7LKDWE9YEQ=;
        b=nl5gU8cqcoUnQkEYJKQWapOUt2x5ihOZo798ptySNMYryw4oJfKuYOdKedTahngrZ0
         49JMuKBRVCft9nPbXp+KC1iw3vhOcz5ufReHUOoxdn+3nLTdLm+p1FTukHy5yijG3TuS
         SxPq6fESZrsv7pIQsiRJWX6y2K9GxkN+84bUQa1YhjA6YZkPjmNdyg8nygw+1vdIhsWF
         2vQFmCd0IIRFxPlD8EElma+LvkjfBh5wPymuuQa9fhLIG2qw/zJvHlCnQyQM9w869mlH
         OJygA5JWYC5aATlHDsCL+VfcAccNWwV7XDAgdce60n+XIEh+sp+yHJKEHcXN8OT+l5pj
         C0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=WGbqd1AhfBh6VPI+bfrbh855KrSpcdNhY7LKDWE9YEQ=;
        b=NGRssAZ9mbOUqWAeKkn4gLQ4BVGgqs7Jky0AlEXBeqLXgSrElKDtet3vm1+PQt9hX7
         SNYi3vBVqZAFdCcRSh9ZJtXX6k8iGw3kp+dLOjuDRBwTWubV79VJzGfMkQq9hNoYHJkl
         mcK22fv6npvMznZnY46TM0onq6Vzq+plC8GT3PN4sHUcarQv8mdZS5jejyTCWUXMljyq
         6k7FHgU6zKRBwMtMBh4nXEafAMZnelvi/nEqicPVrXQckv3d2J6npXB6DFFohjOoqRJt
         w6DyYvemeSqwC+V3E62MubxCODhaK7IioXcwbOmZUk6bw07Hj1lOCtwYtblBklKbQuux
         +B7g==
X-Gm-Message-State: ACrzQf3PpkotH+6fZ14DCWo2N/S2A4aUzKjMSS99gTYcnH7fzG1Gr8HF
        /xeMTgb4sFUx3y91p1juDg1MkOBF33tifw==
X-Google-Smtp-Source: AMsMyM4Q9Mgs3TIvOFmydvtQoWMtHdzAzuoxy0xkGTaXyLHMTNAdcNAEQ0iVBmo87+TkTo8kAqywZA==
X-Received: by 2002:ad4:5bcd:0:b0:4af:9074:8c96 with SMTP id t13-20020ad45bcd000000b004af90748c96mr4020869qvt.51.1664480825078;
        Thu, 29 Sep 2022 12:47:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.9.174])
        by smtp.gmail.com with ESMTPSA id a30-20020ac8435e000000b003438a8e842fsm95944qtn.44.2022.09.29.12.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:47:04 -0700 (PDT)
Message-ID: <6335f638.c80a0220.553f0.04ac@mx.google.com>
Date:   Thu, 29 Sep 2022 12:47:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8202677951468200366=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8202677951468200366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8202677951468200366==--
