Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 01:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EA760FDA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 01:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhJMBeg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 21:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhJMBef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 21:34:35 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18AC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 18:32:33 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id d23so736871pgh.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CDrWJhNR3EsJWaVN0czFAsAE3GZUP+/ZVvXxyVdXV+g=;
        b=q2KfcMa9zyuL8ZxvKSYGgj31ynlFp66w7rUmMFQSU07/R6e9iAb0Yo/kF4LKcFn1md
         VZQM6lbuhAu8e7jFsTl4LfPAXI0xHESI1i0UYaTtjy6wTeWXcn/eaXWORPTj9ea9GmsC
         O71bnLEjA+3kr2ygWxRJecVqOTh1edyQRxUi69YHakM4WR1O8TN3/QwW4lDbMX3X/T95
         iGpfG12BPn8YVfHLBHgKMHWAGiutC1cv0boHsV2aGCR8KXkM8TngyKx3RA/K0rbOcq7T
         LbKMVCi9kdNEwP+ssh4C9XWpkEWxZ0z18nUGkoyeSKS3Fj9SkV9vKBUnDlDgebDpg+2l
         QeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CDrWJhNR3EsJWaVN0czFAsAE3GZUP+/ZVvXxyVdXV+g=;
        b=2jDqUCl4drc+OJxruItOjU2Bv48431WiEUXERVzAqY7Wl7VqfKSBGBDk7qFJC2ZXyK
         ynoDwQY1O2Xc1JG2zIS9xHvJy8fckHm9a0EjhqCIb95/eNvOAl3VcGZW9I4DW/pfpvbm
         DhrJ5nyg8TfQSxmSjXk5ohWyGoIzLvmDfCj6bxLsMUb2JbuT1xRIjiJg7Jih5DW3Dw3Z
         JhkcKctJZJOedAyopT7ejnQGeULXSEK6xRLxdzBFIyBPTZyCd5oBgU9D7z1QOtwJ3GhW
         tIHpZ9er/Nt1Byzu2E+ANfaaE3o4KFDIfr4Du0DXQTG2Z97BNuEe3DcqImNHNK1eRaDo
         aTCA==
X-Gm-Message-State: AOAM531+/2vhUWK65eMn0S2MpU+OeI370Pmi65F3J2fuUO/ASEUDLiy6
        7g2s0/fKGLon+LGAvjiQIaOitysewvo7Jg==
X-Google-Smtp-Source: ABdhPJyCfELBV9Gp44up+3I7u3dgbKkjVGDCtVFbH46HY/+wHChIwr/3jORMWcOk6kaBw4PkKYRqfw==
X-Received: by 2002:a63:7d0e:: with SMTP id y14mr12759439pgc.229.1634088751994;
        Tue, 12 Oct 2021 18:32:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.210.195])
        by smtp.gmail.com with ESMTPSA id oo9sm91951pjb.53.2021.10.12.18.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 18:32:31 -0700 (PDT)
Message-ID: <6166372f.1c69fb81.d63b6.0685@mx.google.com>
Date:   Tue, 12 Oct 2021 18:32:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3899976507211363130=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] monitor: Add packet definitions for MSFT extension
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211013002627.2661081-1-luiz.dentz@gmail.com>
References: <20211013002627.2661081-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3899976507211363130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=562229

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.32 seconds
Prep - Setup ELL              PASS      53.20 seconds
Build - Prep                  PASS      0.25 seconds
Build - Configure             PASS      9.52 seconds
Build - Make                  PASS      230.45 seconds
Make Check                    PASS      9.82 seconds
Make Distcheck                PASS      271.95 seconds
Build w/ext ELL - Configure   PASS      9.75 seconds
Build w/ext ELL - Make        PASS      218.57 seconds



---
Regards,
Linux Bluetooth


--===============3899976507211363130==--
