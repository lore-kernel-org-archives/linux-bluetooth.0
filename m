Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A332C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 22:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiEIWHp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 18:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiEIWHm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 18:07:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FA2A83C7
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 15:03:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y3so12308497qtn.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 May 2022 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pvZj3C4hOHN1GXC0YyIONiLdlXcVMKAOcTnhFoyRlp0=;
        b=MokDQ6fZxOZVif+Q4lqA4h+IGLFijv1oNFx1Y/yCPcJlgfQsXp5zhvctnfKT6lG0IC
         AEBqf9FEAI9NVC0ucHVhub8XRAoJXdZ8ykmKft7nku2aqmAr9HrPBH3GT+VEHTFOErCV
         +Uwgrstw43zBo/hx4mR26U9WF5CVoctrEXup5uRtxUqJUj3Of4VvAr5h/0uYZ4zbinnp
         i5N0uH4bgTAc7tesj5RZIEnI/oTlV1ESE1D43ZbnY9D2caamDi+D3TCh9LZf2W7jWncU
         XQEy0NFawNAfpuy91aYwdqmjN8khvGWjHeRw2oiTGY7Qvpax7EUa/hoxLiymm+PThz0V
         A2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pvZj3C4hOHN1GXC0YyIONiLdlXcVMKAOcTnhFoyRlp0=;
        b=SD3dKA5x3HfJGaU0mLUrc4D7oVlO4p2aBUE1bCcC7ldw2dNkAUcuFYPZgmXr6S22J8
         xu0LBJmT/GrQNHemubVnJvCsZnISkm1WW2XCKUUKr4gTZ6sM+2WhdWpW7SMhb764S01o
         o8uKs+uhJPOPNowJujQSxkpz7ounNWfzPU7Tz6dwja6z0QIiUUCnJpf98vNlaPLhs1G0
         Bi6JApaAEd6+woSNGFq3PeDuRkbW5I2YeCdqo3tyEkyKx4wGG3l76S4wq2UU+iBy0PRA
         Pvdz6dzjTFBXToN/ObeKVvY+FqEZUw3yELyfOqBTrIplA4/5PjaOgYc+/3LLJRfg6xH/
         vayg==
X-Gm-Message-State: AOAM530byqOeiGrrxUWiTQbVQMf86L+IVh8HPu6bdkbJPH7WK1BpudpU
        ALfeXBnQCz9qLM60Mpxm9cvm/8Uowwc=
X-Google-Smtp-Source: ABdhPJzYzOOlTLHeR4JGAmRn1kPepCI2hKP6TbACzmnwhNCjy5TLBS9YHFKoo/+BzLL5rGqrJ4LrPA==
X-Received: by 2002:a05:622a:20f:b0:2f3:d271:2b12 with SMTP id b15-20020a05622a020f00b002f3d2712b12mr10991330qtx.436.1652133824303;
        Mon, 09 May 2022 15:03:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.33.168])
        by smtp.gmail.com with ESMTPSA id f3-20020ac84643000000b002f39b99f671sm8232804qto.11.2022.05.09.15.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:03:44 -0700 (PDT)
Message-ID: <62798fc0.1c69fb81.41916.9e35@mx.google.com>
Date:   Mon, 09 May 2022 15:03:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8995808258390802388=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: Bluetooth: Fix Adv Monitor msft_add/remove_monitor_sync()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220509140403.1.I28d2ec514ad3b612015b28b8de861b8955033a19@changeid>
References: <20220509140403.1.I28d2ec514ad3b612015b28b8de861b8955033a19@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8995808258390802388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639914

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      0.96 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      31.03 seconds
BuildKernel32                 PASS      27.59 seconds
Incremental Build with patchesPASS      37.79 seconds
TestRunner: Setup             PASS      469.43 seconds
TestRunner: l2cap-tester      PASS      17.48 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      100.65 seconds
TestRunner: rfcomm-tester     PASS      9.66 seconds
TestRunner: sco-tester        PASS      9.45 seconds
TestRunner: smp-tester        PASS      9.36 seconds
TestRunner: userchan-tester   PASS      6.37 seconds



---
Regards,
Linux Bluetooth


--===============8995808258390802388==--
