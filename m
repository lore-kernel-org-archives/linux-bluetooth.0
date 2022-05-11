Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5165FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 May 2022 23:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbiEKXFF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 19:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiEKXFD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 19:05:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC41166440
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 16:05:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id hh4so3137322qtb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 16:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EGAzen4BPkjlFtYkxjVzqT6wBKL6dzkkFs8H1TyceOc=;
        b=WvMJK9nx381V2jaVeiN68AwBV+FBndhqqoxQSOFNIbI0AzGvzcu8ZOirwBOYFxTiVo
         yfRURX6RKD1Vpws1XhtMBojb1vKOypg7+bpdI07OoBgLmDFhwfD/yRqXIOoX32L+oUgd
         Iro1BTHVJXzzEspNMY6mh40XtRn/F8gI47QDE/DFfPh77A//w5Nj/1yBcPSwdT/Uf4D9
         4jSqBR8/BCkAKHN/iDecIp1rpFqnNxQ2zVdRmgBMG0rh8uVX+ht+D+NV+YGuEzUXRYDP
         PMoYwmrpnxcm36xI2rybR0K6uaCgWc9qnjIgyiCTcHIMiq+zJat/aw9JWSeFD/3qVLf0
         2rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EGAzen4BPkjlFtYkxjVzqT6wBKL6dzkkFs8H1TyceOc=;
        b=nrm2GQCSf0kOLUm2rKjnzqlhnVkQyPEZ7aM5lr5CwEyXLfMMjdZ0uFLPsgffwNaTx5
         9QCHlC+u+4ib4KA05jniZszEuLIjIocFjhObgVUAiK3t+J7YMj+dk4sGdorNfDFHEUs2
         Tqr6Zx1tvxu0fD8KUagTdU4G8/boVOBq7QKIstzA4DCHWqVgWCQDVFN0Vyi3B8VEmChU
         sqtJ6TCRIV21zOk2E1obQmhSxfvLg5r7aim6bFKcppakBwpvDF7SoVam00QPNU0qEH71
         h3kbwVJt/jGbPJxkYxElZS3GRD0LFZxr4bRB94pyg9GuObbK5E3o0x1/6SoDBomC+iAh
         0DKQ==
X-Gm-Message-State: AOAM53280hGcvJN8ajwZR72lhB4hfRWNN6pW1mW2IZhJkTWIPTurQ0nQ
        qFbjIi6JP5DIpP1aEHpRU9bxr2wO6FeL0g==
X-Google-Smtp-Source: ABdhPJzwv2/64hzuaCG07t8GjrywzIVv6IDrz2ZwidUqLWIri0PjQVbTvDJpQGYv2QvCa77OkG3skA==
X-Received: by 2002:a05:622a:5d4:b0:2f3:cdb0:816a with SMTP id d20-20020a05622a05d400b002f3cdb0816amr22626099qtb.310.1652310301018;
        Wed, 11 May 2022 16:05:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.77.51])
        by smtp.gmail.com with ESMTPSA id h67-20020a376c46000000b0069fc13ce250sm2047960qkc.129.2022.05.11.16.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:05:00 -0700 (PDT)
Message-ID: <627c411c.1c69fb81.52f86.a72b@mx.google.com>
Date:   Wed, 11 May 2022 16:05:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1901613733822208218=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: Bluetooth: btmtksdio: fix use-after-free at btmtksdio_recv_event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <25f3428482241cd449bffa39ad964240ee28483a.1652306557.git.objelf@gmail.com>
References: <25f3428482241cd449bffa39ad964240ee28483a.1652306557.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1901613733822208218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=640725

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      32.10 seconds
BuildKernel32                 PASS      28.52 seconds
Incremental Build with patchesPASS      40.80 seconds
TestRunner: Setup             PASS      527.35 seconds
TestRunner: l2cap-tester      PASS      19.60 seconds
TestRunner: bnep-tester       PASS      7.26 seconds
TestRunner: mgmt-tester       PASS      120.18 seconds
TestRunner: rfcomm-tester     PASS      11.25 seconds
TestRunner: sco-tester        PASS      10.74 seconds
TestRunner: smp-tester        PASS      10.85 seconds
TestRunner: userchan-tester   PASS      7.52 seconds



---
Regards,
Linux Bluetooth


--===============1901613733822208218==--
