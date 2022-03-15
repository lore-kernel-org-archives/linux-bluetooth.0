Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 19:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350363AbiCOTHV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351289AbiCOTHL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 15:07:11 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713EBDA9
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 12:05:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 1so209168qke.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IhOmQLmFUpi0I7gLW/zU8pWjBQOOt/xx/bIbUodog7A=;
        b=L1bkkkdchPaQZZ3uXJd98nemxrz8jIqUOICK/uf639tyZsG2tuTLMTBZ6UEH8xojUB
         LsEo7muCcDxZPRxZT/3NbeOZ5zxpKU9na850B5TeyM1coxJIaztEIfzJVRW9iHb9p8qF
         qqjuHA8kWW6FqIZBYzPgZm2o7ca74yZzODdqpCzVvhup5aB3DPvZPh3nRnLiLgXPRfKI
         tj0WUd4/m9Ug3uXFFSbPxfuU5H0A8btbPz/7E0B5I59WvEM984Tl6AVjnYZGigoJxpxV
         jbVmEx7uwilAvo1chbI8uu1XnJ0uAIp8pWbzMGGsKUhoY8EOqIdfqw/6bXlYjykqjFrh
         3SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IhOmQLmFUpi0I7gLW/zU8pWjBQOOt/xx/bIbUodog7A=;
        b=X0LMqVk86FFofd9n+QmjeLarlllysNs8CY6p75CrMl2AWKSjVDgc/YxR4N/FZx65bQ
         y0057D5fw+YovAg8BM1sjGNqIbq1j6+AzLMjBW2mO2NDL4qkYTfFdCF5bTGv3tL74f8x
         XE55e+sBYbPHIecQvtX79oqntrDfPJ2yDUg5Ejc5OzTkROnp28zG51TYZVAHQZiRlf3X
         8GZdLoMvuCXhj7TwjFo6ROXXL0ABAdvGIsLh08wMaMV74rG7N3xCLkgNsT4SxTafDgdQ
         KSV/cqpzWoxGk1LWYQzzKqfYfWop4ldMA01ibBr7f2Y/gUFdZAuO7n6K/g3doKopAmxE
         ZhzQ==
X-Gm-Message-State: AOAM530TRtzEFPFRwiA+7MLYdM1fljBtOJrLwrMf9Ps400pZOnBLMn6L
        X9UbnNQQ3X952wx3DY41ApbXo6QfgB04aw==
X-Google-Smtp-Source: ABdhPJzlk2Hscc/pGxzXpw7Muh7wJ65+c/bDjet0kzUJs+R/Oy+g/v/WSoguWdihGZl4ulmZoSxzeA==
X-Received: by 2002:a05:620a:290d:b0:67d:b5f5:302a with SMTP id m13-20020a05620a290d00b0067db5f5302amr9437150qkp.399.1647371157458;
        Tue, 15 Mar 2022 12:05:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.220.8])
        by smtp.gmail.com with ESMTPSA id z19-20020a05622a029300b002e1a763dac1sm12572512qtw.9.2022.03.15.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:05:57 -0700 (PDT)
Message-ID: <6230e395.1c69fb81.d2454.8585@mx.google.com>
Date:   Tue, 15 Mar 2022 12:05:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1927528466965515657=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v4,1/5] Bluetooth: btmtksdio: Fix kernel oops in btmtksdio_interrupt
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <7b4627d5017be2c26ded9daf7fd297bed6614852.1647366404.git.objelf@gmail.com>
References: <7b4627d5017be2c26ded9daf7fd297bed6614852.1647366404.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1927528466965515657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=623608

---Test result---

Test Summary:
CheckPatch                    PASS      8.07 seconds
GitLint                       PASS      4.89 seconds
SubjectPrefix                 PASS      4.40 seconds
BuildKernel                   PASS      30.43 seconds
BuildKernel32                 PASS      27.61 seconds
Incremental Build with patchesPASS      61.38 seconds
TestRunner: Setup             PASS      476.36 seconds
TestRunner: l2cap-tester      PASS      15.66 seconds
TestRunner: bnep-tester       PASS      6.08 seconds
TestRunner: mgmt-tester       PASS      122.73 seconds
TestRunner: rfcomm-tester     PASS      7.75 seconds
TestRunner: sco-tester        PASS      7.91 seconds
TestRunner: smp-tester        PASS      7.61 seconds
TestRunner: userchan-tester   PASS      6.46 seconds



---
Regards,
Linux Bluetooth


--===============1927528466965515657==--
