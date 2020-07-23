Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8A0C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 06:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E4F206F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 06:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZxU6ZGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgGWGt0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWGt0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 02:49:26 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF50C0619DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 23:49:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id el4so2127294qvb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 23:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CDMWFz/zPWYOXKwOA7M2SkB3diPkvKSPOO6Fv8ZhAz0=;
        b=bZxU6ZGzPkLyRlzy4JOxyNc9wX5qRPS6mHVQ2cqa9RPQFMwP+rDsvzKb3Zd6phl1Qo
         qWgtsr/UYrtoojhrx40XIUkfRSxQXkg9v/PvbSiChpYJTG4rKWgjySB7GqhkTmqH3nV/
         XUHTFMlPnlrRxLCd2UM/02PJqeuRiuUCf4WKsociAZ0BLKLx10oMDqjD6HpKA6gV1nz7
         s+SkVgAIrbss8b45+23QDvzQzvQ0gBUimA32qc+C+xblLL5Gs3Zqvyms4TBTUXt+YCdm
         VEoFpBhmhv0JjcxF3A0ZdxhD8dLjeyAjxSIcqaTvUPea8OIeR11NQwZZ8RBtB6Ct0tyl
         MjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CDMWFz/zPWYOXKwOA7M2SkB3diPkvKSPOO6Fv8ZhAz0=;
        b=mWHRPzRDeJRsVYGqL03Y9Qc8rZ9HWwHUDSJTVQ3olNFD1BJxZ3geq7moP53+TJRWmC
         wf8CccR67AbX3cSiLY2JUDgg9NKVG6LNW6drDT0NilSaD9XXYOjIDjsCQCI6v160Dl4o
         KZpsfoEtqUB7taJ/Bh25GVnTwEyaPtZ2YsFDPXYBUUjUZMLkUnI68cPpMzf+JmqMF0ig
         nzmfmEltwS5RIenOxRi5ZzNaX8ZmTP1BzBhtq0ycL3tQhZ8cNDqRwu8xa3vv61cN009g
         +NhUUBNYwgxOTapMEzHBBtGte6ILRkzJ6J5Oi6jDjrd7rfSpQN2isw0LXHAIQRFkiXSo
         Rzlw==
X-Gm-Message-State: AOAM531uU52vDGYjoH0xsiR15/6tOUU9Z4MzTuFeUmjOqU9p63TZZB8h
        xFDetu62NGKXw1znP2qv4rpfxjrG7d0=
X-Google-Smtp-Source: ABdhPJx9eRJXtlW0FgcJ9A34TNgOLYJivLuYrTP2JOKuY4Y6sWCiYzNOKJ6DzNuu6eBWP/KyTAqTfQ==
X-Received: by 2002:a0c:b5d8:: with SMTP id o24mr3529503qvf.214.1595486965112;
        Wed, 22 Jul 2020 23:49:25 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.66.140])
        by smtp.gmail.com with ESMTPSA id k48sm1972511qtc.14.2020.07.22.23.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 23:49:24 -0700 (PDT)
Message-ID: <5f1932f4.1c69fb81.79bf5.abb4@mx.google.com>
Date:   Wed, 22 Jul 2020 23:49:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7789159536542965512=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v4,1/2] audio/transport: change volume to 8bit
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200723142128.Bluez.v4.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
References: <20200723142128.Bluez.v4.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7789159536542965512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPACING: Unnecessary space before function pointer arguments
#80: FILE: profiles/audio/avrcp.h:97:
+	void (*set_volume) (int8_t volume, struct btd_device *dev,

- total: 0 errors, 1 warnings, 215 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7789159536542965512==--
