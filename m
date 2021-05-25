Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F1BC2B9F8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 09:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC996140E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 May 2021 09:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhEYJ7v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 May 2021 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhEYJ7v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 May 2021 05:59:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A9AC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 02:58:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3224940wmk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 May 2021 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=NIh3hOETUHkHlxhNkqRvL6N0wBtLhzR4S87M39q/5XQ=;
        b=iLLIKYtrX9sVIahaMt9Dh25yYhrRiM8cB+XfEzTHoxD4vd/XW/YvTykMOPScyZ6cr9
         +o4UgS2IVzKi33d7ySvf90UakzmnN5DnfCXGWI3CaP1EQ/sQjerE2X5x2A8dRFvn9JD2
         PP+M1CwXYFb6CEce0p6y4uD1TV9ai5h5QcklH+cWF0YCyLLGZ63RNQex0KV/NoR8U2UY
         CSwDjsaBmLzkPLvCxwL7zLPSe8JaL/VvZIuliuJogqe5wNQzMaGivmHS240QP9oWvLNZ
         44VrWPpFv1Zv6CPKy2fReVDX8QQHX/RPNwg0tzL0tIjRQxcRAzeb4bd9zDp+VRcPdDVs
         wtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=NIh3hOETUHkHlxhNkqRvL6N0wBtLhzR4S87M39q/5XQ=;
        b=h9oxI+jZoAT9w/w4tKlNaYL4ehRa1wZz73Fz8BWFqSHD2pYnW2oWXIUPrJwDHThtQn
         hmpjwn6icSs3AEq5FVZzOKZSGWuEFGtiJLcmG5bjnO24/kUFa4NCCIhpiuw+qsm3Fj/E
         QFksix5wuxB/k8H9RFHBpzGygBTrWCeOgHGurSn7Y7ls3rPW7O1jamEWm7eNiUOBti6n
         JTSqTQbU4ycFmDEJJQNqY59JjF3ZjTHYdlQOVoHwehcQ3D28H8/bWPRd8ru5Tl3+wOKx
         WspMa/O/AoE7wFqBdXNkW5sghu30QsO5wwGxxqiKpWLDzjrbd/U+4PPthscaPirQUK8Y
         f0dQ==
X-Gm-Message-State: AOAM5306MYQAJ9+ZZdJP5VbCIBF3SNNjkm3ogQuJxs0SEvMnuJiLLsKb
        9ZL/up/5Wer/Q/h9oAyTCJAdYQW+G98=
X-Google-Smtp-Source: ABdhPJyrK69rWFVx6Kzhs3tVsOKqMgGchEF6yX7MxCg00SJ4XnCiQFcobdGhkNw3k1KWzXCpOX7FlA==
X-Received: by 2002:a05:600c:b44:: with SMTP id k4mr3109299wmr.152.1621936699275;
        Tue, 25 May 2021 02:58:19 -0700 (PDT)
Received: from [192.168.1.10] ([94.10.28.216])
        by smtp.googlemail.com with ESMTPSA id a17sm15153223wrt.53.2021.05.25.02.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 02:58:18 -0700 (PDT)
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
From:   Chris Clayton <chris2553@googlemail.com>
Subject: BT Intel: Regression loading firmware in linux-5.13-rc3
Message-ID: <81eddb07-f346-c12a-345b-d929fd2edb10@googlemail.com>
Date:   Tue, 25 May 2021 10:58:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I've built and installed 5.13-rc3+ (freshly pulled from Linus' tree). On booting it I find that none of my bluetooth
devices can connect. In the output from dmesg I find:

[    8.170332] Bluetooth: hci0: Firmware revision 0.0 build 121 week 7 2021
[    8.171339] bluetooth hci0: Direct firmware load for intel/ibt-19-16-0.sfi failed with error -2
[    8.171871] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-19-16-0.sfi (-2)

As you can see it is looking for a non-existent firmware file intel/ibt-19-16-0.sfi. intel/ibt-19-16-4.{ddc,sfi} do
exist and both 5.12.6 and 5.10.39 successfully load those.

If I create symbolic links from the ibt-19-16-4 files to ibt-19-16-0 equivalents, rc3 loads them and my bluetooth
devices work fine. I can't find any ibt-19-16-0 files in the lkinux-firmware tree on kernel.org (or anywhere else for
that matter).

I looked at the changes introduced in 5.13 and found a couple of suspects - d68903da4e220d1e6b7c6ecdb853c36144c6acc9
(Bluetooth: btintel: Consolidate intel_version parsing) and its parent commit 0a460d8fe2db6887169a19b048ea0c90f8bdc3b7
(Bluetooth: btintel: Consolidate intel_version_tlv parsing). Both were authored by Luiz Augusto von Dentz and make
changes to code that processes the firmware version data. I built a kernel with 0a460d8fe2db6887169a19b048ea0c90f8bdc3b7
checked out and that loads the installed firmware fine. d68903da4e220d1e6b7c6ecdb853c36144c6acc9, however, seems to be
the the change that breaks things because it tries (and obviously fails) to load ibt-19-16-0.sfi.

I can provide any additional diagnostics or test a fix, but please copy me in to any email because I'm not subscribed to
the list.

In the meantime, I'll use my symlinks workaround.

Thanks,

Chris

