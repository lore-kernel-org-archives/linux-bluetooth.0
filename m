Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B9DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 00:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiI3ABT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 20:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiI3ABQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 20:01:16 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2DEEBD62
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 17:01:15 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d17so1884459qko.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 17:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=p8WVwTrW4AihRqdI70ATg7qa5qtk2H2j7rvOQNBqqHM=;
        b=EVu8x7qc/LsyLtDgv1tyeOxl1yMTE8hgikGqhHwfazKBzathGE6vltt2XHQCfA49q2
         zCZKLjnWSHrs8BoNf6a/Ry4i1kdPnpSuZyDYVVizfJXDychybfPvT5MeAr+5+pwhL9QT
         MmiLA5MdCK9K7dG0QgdY3mCOG03ribiw11PYd2c8PcPj80M4FOmjgMl5a5lyDZgfjq43
         IGIobM7+efTTpmSpdBUxfuD+Vb86S3tagYCDc/as71wxy1wF44Sj2LghQSfPBbhtEljr
         H2TG7JaqBNiOUhJ/jr4NOgGuZH7ohzIFfyn5ZJUDx9bq/BToNUwh2Dmn5P1++tZiHofr
         rQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=p8WVwTrW4AihRqdI70ATg7qa5qtk2H2j7rvOQNBqqHM=;
        b=yv+QevkPzjngcBWCJFQWiL6Eai9GSxVtLiQsHG+ANDQc019KeeG0oxubAinK79W2fs
         cSJgGo9VgQbXtarDFAsJ6BIVZlWYFIjWE/HVs0S4F8ITodkKNruYU6PxR12fr/U7NxvF
         1Uin8eeRyoL9u09zFXk116yZInhKB/oDjoouAAmPDJ4G/7YmG99YWzmH1Cn3i+8fT6fO
         s72UBDvtxpxP76XfXXO3NBh/cz9KkwupQIgMIQ5oSoo8TnIh7DnR+HQ2Pm7I9RV6+jst
         d34503E5er5Un6mZf84nY4FUE7Bd1MO1aFRLY5912HF065H+O1fMMBwMeXR4O5Y1GdCm
         mdQw==
X-Gm-Message-State: ACrzQf2GhjUC7mdEEeFUXy2n2J6WKHd9aTznNhVS0OZi/TiJSUFg8BqP
        OQ9/ZwFnKMrLiZET8YSEKCKqha4qv92X9A==
X-Google-Smtp-Source: AMsMyM5Ywzi3ns6z0vd3Yzrn1eIS2jmE1w+j5MS1HBsLHoWZUueLoqLQVvoa3ySqrPPK9e+G1R/W5Q==
X-Received: by 2002:ae9:e70a:0:b0:6ce:bfc0:f98b with SMTP id m10-20020ae9e70a000000b006cebfc0f98bmr4161665qka.381.1664496074199;
        Thu, 29 Sep 2022 17:01:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.128.176])
        by smtp.gmail.com with ESMTPSA id u5-20020a05622a17c500b0035d0655b079sm480548qtk.30.2022.09.29.17.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 17:01:13 -0700 (PDT)
Message-ID: <633631c9.050a0220.f6a93.14d3@mx.google.com>
Date:   Thu, 29 Sep 2022 17:01:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3534348745807258433=="
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

--===============3534348745807258433==
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


--===============3534348745807258433==--
