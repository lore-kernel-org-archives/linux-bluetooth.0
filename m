Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4638BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 19:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiI2TDE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiI2TDB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 15:03:01 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073C13F703
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:02:58 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so742096oom.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=HOw39icMxnu+738+lXPsuWrCuKKsZEgzWP4SAOBMkPs=;
        b=KV5qjtwRKWV2e6Ba19pk0N4smZJ+vB1hg+mLc7RJSCJAg99whwI62tyY7DUt9pKRS+
         H4im9knQ/4EVyIPzGNOA1dGD+UYV+58a1vutTl58dxlEu+Wob9oI2d4rFj3xM0pt6u5T
         pdOk3RBIcKDFJWx2Rf/6HSXYoi2NR9LQnJ9wetzBqbo+zszjMPdDIrREY9juagGXcQa8
         /cWahiBSzJfAt4jTBRy/JQAeX+//WsWgV4wToFmdgteYi9wx94RXgu5dZbl7dIqYT0jb
         bmENV3g4tPY0c3mi3lpUoSi8JcDcmyqeDcMUU+6GKYQi8EiZ/OeQKV2p/qOZEkheMKcD
         4APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=HOw39icMxnu+738+lXPsuWrCuKKsZEgzWP4SAOBMkPs=;
        b=qiJJD37/Ub2pd5SNpbvLTeUlY8Y9Ag84Wfg6GfKHjGL5gB18ICESypBI1/F+q5QIJA
         NprawOxxJKJf5xr/KYFmu3dAH3CRfUvUvO7X7yj1oA3jPs6HgORFGoDw5xOlMs6/abzY
         tWZSeadUUiwNmtkD05f8iYR5hNeNr5WONwKIcISvvMH0+wwrEY7aZgWSzjHytf3iml3I
         Pz/CiXIumUvNrXxEjOYJ5CskvbU/49JDGaHqL0lB19MplmkTnotgjkWNoDZr8aomA8lJ
         BItXeCJda2fJk77jyA7Cm/sSclFn9wojD/vRV4KKXjxU5forjHrZtJKCfHv5WcXlkCKS
         o9Tg==
X-Gm-Message-State: ACrzQf0JXsOn639NWLspOCnWoQV991XfAk5WP5ZW4lCf38hgWcPTD72A
        YF43oKaHCTBs/5Wl+Byf1XPzqinSmno=
X-Google-Smtp-Source: AMsMyM49KqAY0EqrKa2kaQ5UT8VeJrozy8ZwyApPPRjdwJmCZLbAwIpYe5aoGp99CaLHZgcckFnQdQ==
X-Received: by 2002:a05:6830:1691:b0:659:e769:2d8f with SMTP id k17-20020a056830169100b00659e7692d8fmr2103143otr.369.1664478177173;
        Thu, 29 Sep 2022 12:02:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.84.214.97])
        by smtp.gmail.com with ESMTPSA id 91-20020a9d02e4000000b006389650374dsm108193otl.54.2022.09.29.12.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 12:02:56 -0700 (PDT)
Message-ID: <6335ebe0.9d0a0220.89b31.09a0@mx.google.com>
Date:   Thu, 29 Sep 2022 12:02:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3300535025676025139=="
MIME-Version: 1.0
Subject: RE: KASAN: use-after-free in __mutex_lock
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
In-Reply-To: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
References: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3300535025676025139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 6
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3300535025676025139==--
