Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2DFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 17:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiI2RpG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 13:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiI2RpE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 13:45:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD0827DF4
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:45:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w10so1844379pll.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=RRZKTVIOk3w1Tsryvhb2ZYYamNCUSMukWQPkLjt/9rI=;
        b=d8ryOw3b2GvvBs0ru8B/yVm4JY1yOYiul6Eg4ESEMk9iTUPsuShT9Hh/5NruBoqNmE
         Y8zer4mDmb0pFEPEi9b9peHr0ihHk6iqJTIVXkLCYCcKhsgBGAKfG9vNSllGmiFPrLIi
         iRHxLKy1aOHhEAbctdjfEvIzyhHQmEGs/3LOwCLowjCtViPHq9GUMW9YOV+nrN8IMPkj
         +7QJZfSxM/a8NEfSaGf3JHilGVkzcDPtr0VnZXPoHfSm9xK0jwHPbSHQByxCTYLGIq9C
         PItUG1Xf2Dw8l2o7Z3uo5Bqy4A7T63xlu2JR0TesHodlEozjpnsWuUlftVdU3nhcyFoA
         44PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=RRZKTVIOk3w1Tsryvhb2ZYYamNCUSMukWQPkLjt/9rI=;
        b=2GYCdVwXYmUac9tWuIlj9CtfCOhHeALJqMd3TcYexxGLzC9cmejrMzqJHYtHQI5ZEL
         lyffBo0Z3LjR7x7JITmfAKvxFE/O+aVad1VH+H2wv4nlwaAfGhXnObWF1b3rrhg3218p
         zr7hW1K+H6yFzaauyx1GnLE8c8Ssxos8HLau3PjSTl56zpBhhyI8IMaNpkcmdK0NlUlo
         0pIOWVu+7yvQwwu2HDQSD/ak0neNKRS9uLvXMy+HVjfKXrTTfldrOj5DJHa3LJdWF1fM
         J79hQyZ4g/a3OJaBh//g82w+urG3/8iAgVhEtA3gooGZFLicQWCKSKkgn71jBbTLRCZm
         c+Fw==
X-Gm-Message-State: ACrzQf1mXJtL/pbIVAjFldEIOuqfBswL0ypaJQVjjlVgv0acRipNZFQX
        eaGh7wPR5hNpMYCgy9FFGiIRpebkqB0h1A==
X-Google-Smtp-Source: AMsMyM5Rz2ZggPYWTh4oget00Z/ecehHvAL5htdnXk+E+A6xEYT5PKkwQ+YZ3ZjqKW3t3+XNTiyyEQ==
X-Received: by 2002:a17:902:f64d:b0:178:a963:d400 with SMTP id m13-20020a170902f64d00b00178a963d400mr4660162plg.6.1664473501174;
        Thu, 29 Sep 2022 10:45:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.161.36])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090a608f00b002036006d65bsm38502pji.39.2022.09.29.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:45:00 -0700 (PDT)
Message-ID: <6335d99c.170a0220.9bde6.0160@mx.google.com>
Date:   Thu, 29 Sep 2022 10:45:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3220378919851207555=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3220378919851207555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3220378919851207555==--
