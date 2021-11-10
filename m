Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B84C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436C96117A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Nov 2021 18:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKJSmu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhKJSmt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 13:42:49 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9548C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 10:40:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u17so3732234plg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5bRHSxRiKY/kQvhhcRT+3G24zSuq0nxzR3UqEt5amNg=;
        b=jH158B7d+nQkcwvXfqsMp6CSnyE+P2oQx5mD75EsEinjMq6x8V9gMJt/8r5ohyJwYW
         snOYNZR97IZxbc5PEtMdsCVey2CTiLoT2lDJWFXqKF3+6zKrgtl8Yf8u2tB0nMeo5i17
         Zda279cwPUFEhHOjiblEJ6ylmXlM9IGINYfswwg2npZGYpAlzWYHPpjPIaPYeIYqINQs
         6OTfR3gFuvs30xgRYmn2ZgwWBSTePDLLCZgIgeyuHEt71CERiQPDGDXdaJKfyc2LCHEm
         lnHGY1RDXjvOQ39kg5RC7XEEez+zMOMTBZ2HBkP4aS7D4DH/4+HfOfpA/yJl2EdlJt2Z
         yISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5bRHSxRiKY/kQvhhcRT+3G24zSuq0nxzR3UqEt5amNg=;
        b=e1tlEcbcruwdkAhfG/f8YWVDP5tpbH095m69e21+C4trkJM4Gz3deuVPfBRgzEU+HY
         6fP7w9+zQvyNwDtaLVNgH7BxuKmv1L3A5JHWJq+koG6dsiIL1PPfE/w5pb1DwacDDqXK
         c9qY0tCoXqtm2kjtG/se7hqsIKl01Xwkt+0GUoCzaAaG6TqCnc7ZD/po+0UuOaOA+nBL
         6anoRmPfYRyYugE+kYyL2xAz7KSQdfn+xxXwuWGqAbq9UP96DPm7iDIT+fO97Yvs4N99
         7ilYdtANd0dviEx+xI6ep4buLb9jUOwLvT5d6QSgY4eHzPGahlsG3ZvS34g8tYGiY5wO
         cwJw==
X-Gm-Message-State: AOAM530JHHf1twW94rs+McBzk9SVJUu0xAzZHv66nk3RvN+YvmyQKfyx
        vMkD93IFw3qipG7TUr4Njy4JHZF+HKE=
X-Google-Smtp-Source: ABdhPJz9zBQ20uOhUG1CQY4YkxNJF0q3MCCuFHlDPcTUouGY9Ot3VA+KmCvIoW09GPdlaRfffYXlig==
X-Received: by 2002:a17:90b:1e4e:: with SMTP id pi14mr1081692pjb.161.1636569600991;
        Wed, 10 Nov 2021 10:40:00 -0800 (PST)
Received: from [172.17.0.2] ([20.69.165.235])
        by smtp.gmail.com with ESMTPSA id l6sm394954pfc.126.2021.11.10.10.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 10:40:00 -0800 (PST)
Message-ID: <618c1200.1c69fb81.c5125.18bf@mx.google.com>
Date:   Wed, 10 Nov 2021 10:40:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2410812906875797648=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/6] btdev: Add support for LE Set Privacy mode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211105211245.424024-1-luiz.dentz@gmail.com>
References: <20211105211245.424024-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2410812906875797648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=576261

---Test result---

Test Summary:
CheckPatch                    PASS      3.26 seconds
GitLint                       PASS      1.89 seconds
Prep - Setup ELL              PASS      52.41 seconds
Build - Prep                  PASS      0.26 seconds
Build - Configure             PASS      9.43 seconds
Build - Make                  PASS      224.72 seconds
Make Check                    PASS      9.45 seconds
Make Distcheck                PASS      261.29 seconds
Build w/ext ELL - Configure   PASS      9.39 seconds
Build w/ext ELL - Make        PASS      210.38 seconds



---
Regards,
Linux Bluetooth


--===============2410812906875797648==--
