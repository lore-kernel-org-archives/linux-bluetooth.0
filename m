Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F08C04A95
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 05:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiI1Fd1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 01:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiI1FdX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 01:33:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385F11E2771
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 22:33:21 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id s9so7307779qkg.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 22:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=07X3oAyYrn3Ee4O15gBLslMSxLCm/2R7P7RVYkPsSlQ=;
        b=RkYURC7JmeJ1zjiZ7du+jDszxb1X/77FpRB8jHQMevAqo9qqwqdrf7nZ5u5WXfcEwC
         8TjO7GwDI2jRiW6O+JPh46YNvNaSV6EnKk+E+XQ1n1PtxUKrj2KBW5WndqcRtLS8THve
         8hGuTNQ40k/C8EktttXkAlteU1iyoQNzMPjBPgALXef8AKvhLiMpjOIS0UyEQzIgU4b0
         v1UUrt+fcyovWD8poklfgk+44rXd3/aDEgCS5GwLW0DubYuYjNcpEREHYMd+ec+OmO04
         GuO5gVzG2S+pGJyDXtswmT0ZC5JMB5x8UySGI5x34pfwI/bnWuSnNv8z+8Hm70TLViJ9
         J11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=07X3oAyYrn3Ee4O15gBLslMSxLCm/2R7P7RVYkPsSlQ=;
        b=DjwFs4UBBmdmPYzyCQFaEUl5YDa6oYlMYDOv7vMa+XSMItixCki6aU4mru1RjQ8Kzu
         na/Ajx3hYs8TdvKEcgJZ+e9yQf+5mHXsf9rD3tlmK2PkZCVePaxmBRv7mz2XogpY+Hlp
         Pg3B/6x82bJPGnKLj5GifWUMkX6fndvqcVP+0qsLkLS0gnu/Ur34EYgKJj18/kRsLINH
         bD3w+cTB3ScYmIUwdrwTz/g7Ktlw4M+HQJWK2T0JlwDdhve0bWmLWnAkp3LKSTE4ybz1
         8ykvRGZnHEmdG4UjqOS091ZCMXPdiVynYBgYR/nQgMj842AGwHdH+2J1X1i4nfa9IoQW
         n6wA==
X-Gm-Message-State: ACrzQf1E62LtzK9B/KsFW919bycye8lMeR0DrrpJaZx7CtbNoJP8IF0F
        Ni6eNvsTVcv0fJ8zWe7tj0JbLeGp/ZaPMw==
X-Google-Smtp-Source: AMsMyM5r35WexqtdMV8ajf1JIji7jgmJ+Y17uFN2vmC36y0nfvqd8J/GSpktJbwFV3baBauUDKpUPw==
X-Received: by 2002:a05:620a:460c:b0:6ce:43e4:4e57 with SMTP id br12-20020a05620a460c00b006ce43e44e57mr20849985qkb.778.1664343200125;
        Tue, 27 Sep 2022 22:33:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.175.81])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a448400b006a5d2eb58b2sm2284572qkp.33.2022.09.27.22.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:33:19 -0700 (PDT)
Message-ID: <6333dc9f.050a0220.cdacd.781a@mx.google.com>
Date:   Tue, 27 Sep 2022 22:33:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6395025161738290093=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [v2] Bluetooth: doc: test patch - DO NOT MERGE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220928045348.210835-1-hj.tedd.an@gmail.com>
References: <20220928045348.210835-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6395025161738290093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681300

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.96 seconds
BuildKernel                   PASS      33.30 seconds
BuildKernel32                 PASS      29.87 seconds
Incremental Build with patchesPASS      42.48 seconds
TestRunner: Setup             PASS      504.17 seconds
TestRunner: l2cap-tester      PASS      17.02 seconds
TestRunner: iso-tester        PASS      15.90 seconds
TestRunner: bnep-tester       PASS      6.29 seconds
TestRunner: mgmt-tester       PASS      100.65 seconds
TestRunner: rfcomm-tester     PASS      9.90 seconds
TestRunner: sco-tester        PASS      9.35 seconds
TestRunner: ioctl-tester      PASS      10.51 seconds
TestRunner: smp-tester        PASS      9.40 seconds
TestRunner: userchan-tester   PASS      6.43 seconds



---
Regards,
Linux Bluetooth


--===============6395025161738290093==--
