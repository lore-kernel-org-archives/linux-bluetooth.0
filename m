Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8403C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jun 2022 11:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbiFGLJK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbiFGLIr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jun 2022 07:08:47 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ADA10F36A
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jun 2022 04:04:48 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso4713423fac.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jun 2022 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WsU1d6AxtsI1kNnbErTqKMalyUuoPghz7ZZoqU8ZE6Y=;
        b=INVJ6YJYX3XRYgAXtmjDjhcWumflqsAXHUWd5KffSTUlbxAfzpd7Dqk795Yq0Fmeh/
         c6HPT3KI1ut9LmwjPIVfwkNeXeLB4ssCmrj4mDHNVc73cKvGA8O2DG7eXUi5ma3CA49x
         FEweMn+6N1CznhDeE/uy/4k1rLdu9Oxhz6BQC49ROvxJfSn0i17RSGstwVqUMNLdH7W5
         dCP9qSNWOIcEgFrU2xgaFKrtP1dSOViwbFVoo2kXZWFNJYC4Uj1pMbbFcFtrq/eiSiqI
         RKyrEYpA0BU5TI/qOjPOCjMPc4cZXP3tTYHyojBmhfsSmtVfk+h4P/W5+G1MEfInYQ+q
         RFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WsU1d6AxtsI1kNnbErTqKMalyUuoPghz7ZZoqU8ZE6Y=;
        b=fn/SU96j1soJvynrWYto6jvvK4CgRMQjIN8N9F5m75mRjD08EagYrzllcR376GGSVP
         3kS84a3z6VahyHHgWIGLUtPua2Y/2lj3cmQ2+sGxbZjePhZeuOkSgt1XJy6mpvyvhyak
         KRZRPlgVItLl+WWajoKN2/cAys5chl4hmV02uYJiBw8CdToa1MX16T8H3WbzXuUKUvLl
         wg9V7uuPz2aRZTTW4lKVS1VtOOrXy0Yh4f+BF5xwSvZvqHQwlug1shCkmzza4KhT9Sws
         eYY9VeA6P7Qf6B1CiJSnAALffrAguyoHZWnWXweMX0AvYhlKDYcJIbHjcL2PJ7T7VmAw
         Qf6Q==
X-Gm-Message-State: AOAM531Xlwbx65ONMgQj7w2OfucXou26r7uNUQJHzpu39yq0KYUrhtfS
        lFyJ1DBhtpPlYzGNFBqnWWyq/b4K4GazHA==
X-Google-Smtp-Source: ABdhPJx5DhEmFB3TdTGjj97y/ZJomfEv/I7KnQeY9S3YsB/yd1ApYtXW658ElRYUfbldBVJKUwYinw==
X-Received: by 2002:a05:6870:9608:b0:f1:5a7b:92ea with SMTP id d8-20020a056870960800b000f15a7b92eamr15880680oaq.175.1654599887367;
        Tue, 07 Jun 2022 04:04:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.14.47])
        by smtp.gmail.com with ESMTPSA id l14-20020a0568302b0e00b0060b66e2eaaesm9186418otv.38.2022.06.07.04.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 04:04:47 -0700 (PDT)
Message-ID: <629f30cf.1c69fb81.f8003.1167@mx.google.com>
Date:   Tue, 07 Jun 2022 04:04:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8070351250089003196=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, poprdi@google.com
Subject: RE: [v2] Bluetooth: Collect kcov coverage from hci_rx_work
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220607104015.2126118-1-poprdi@google.com>
References: <20220607104015.2126118-1-poprdi@google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8070351250089003196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647954

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
GitLint                       PASS      0.84 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      30.66 seconds
BuildKernel32                 PASS      27.33 seconds
Incremental Build with patchesPASS      37.37 seconds
TestRunner: Setup             PASS      467.41 seconds
TestRunner: l2cap-tester      PASS      17.70 seconds
TestRunner: bnep-tester       PASS      5.98 seconds
TestRunner: mgmt-tester       PASS      100.14 seconds
TestRunner: rfcomm-tester     PASS      9.56 seconds
TestRunner: sco-tester        PASS      9.27 seconds
TestRunner: smp-tester        PASS      9.32 seconds
TestRunner: userchan-tester   PASS      6.25 seconds



---
Regards,
Linux Bluetooth


--===============8070351250089003196==--
