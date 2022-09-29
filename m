Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F559C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 21:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiI2Vv5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI2Vv4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 17:51:56 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E58D126B72
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:51:53 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id m18so1733414qvo.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=JDs+6P8BEe7MHbw/+C7UiezoEo81n7WkmoowN4tpO0s=;
        b=H20F3ajVEjBo+KA70ey5zN3v6CTfYkfJigC4RS0sKrDtS3FYz/y1g27345sK75ev80
         kAGid+seg64Z2vXAg2T1dRnSOCdM5qlF88aGdqZFpmP1SsDjlzYZQDGTJSlF4neGDPQf
         NIjMXXd92JVd6qHdap+WSgKqjmHMjklUPpC3eYbkHYQd2NVCQwY0y2sOL85NXRujfwZ0
         krS4HJlJrxNHsxZgGq75B5kwHNYyx00FcJkWe/tFwMMhecgrmy/U55+6hjCq1iOWcPqp
         CtXQVwWjY7Sc9aD6y9faE3X4a0Shhts7El5H77N4FsxKeZyYKyLt7W7UGAG9jV0HDcoO
         FkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=JDs+6P8BEe7MHbw/+C7UiezoEo81n7WkmoowN4tpO0s=;
        b=oU2lOFLxjD31oxLnMmKqsxmMR6200llr8Qusvv7gLB+mfBCl2kZ+5DMheAGGftIdRk
         Qk993I5GHFZnkIjHKJAHI8cBbPxabhsZxQep4TBymXwVzhdCfK7+vDYoAAYGjqRbopc3
         g8HvatvY16Pz3ZJ8LnE/zP9L3BCPbERqgkshPxCKrUhW9BTyj4R9rYE3j7Yk7RBeqfrH
         nAiaGe6wJzKHRmDEfb6waaz0VxZlljBe8axAx+CavPO6/x4M3KK3Oh1x9BIgVPMkft++
         KgrRNi7b8rb+SdQ4XoVvXI3v7Lu0Bs1QTXl4PGAoUKQXND/10Ytfu6gpfPFjwWAo1t0l
         sMFA==
X-Gm-Message-State: ACrzQf2TCQWw0h4InPZOTfShjGzU4/4hjUywJIgo9310P5KxIT/eE8ww
        QS2/tneLfbbGCDp3gNrBe+mGNnNA5pV8EQ==
X-Google-Smtp-Source: AMsMyM6zAWNXTIJhhlbWLcVy1FTb8J0KT6UE+TjNsHZNXCgLNhUAMQp1iAsL3uzacWTVowBB3IAFvw==
X-Received: by 2002:a05:6214:f26:b0:4ac:7bf9:21d4 with SMTP id iw6-20020a0562140f2600b004ac7bf921d4mr4448793qvb.98.1664488312343;
        Thu, 29 Sep 2022 14:51:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.145.230])
        by smtp.gmail.com with ESMTPSA id fz17-20020a05622a5a9100b00359961365f1sm264978qtb.68.2022.09.29.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:51:51 -0700 (PDT)
Message-ID: <63361377.050a0220.184da.0fda@mx.google.com>
Date:   Thu, 29 Sep 2022 14:51:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0272645000307443640=="
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

--===============0272645000307443640==
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


--===============0272645000307443640==--
