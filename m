Return-Path: <SRS0=QcUl=BD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96A5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 13:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81B212065F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 13:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai207q0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXNWG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXNWG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jul 2020 09:22:06 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81AC0619D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2020 06:22:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h21so444088qtp.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2020 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BBfsvEPqNiBOfV6lXndiApKNU8ZzRGIx5wkt8sT23CM=;
        b=ai207q0tq1y/Z4KAUcawy6OZD/jMHM/URn1wgX2cwd0Z0cOo3rIB2hWOmqovX0JP0W
         hqkp00C3iin9jMqALWyj+TrcOKM7Uk8WGIp1579TCNKlTSKwJAcx70x1atA8ylsqEvxW
         vN7i1f2/DuJgTYFVEiEU3PyCDPu6GWtgPC54HuY3vvmxRtlspFYV/yaLQgbJ8TjGZDy9
         gHdgyPrlHtKnt0dX3n2VwAvzqlFvH3L34m/li9GPP9dPx5vOa1b4j2crltzF6s/8nLEz
         8FfcUeQeEWgrIVH936q/8lxxfLOpOtLHdAZjfKTZqUCYSPqtoVVD3hO9V1+gQYCccea9
         BMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BBfsvEPqNiBOfV6lXndiApKNU8ZzRGIx5wkt8sT23CM=;
        b=RuCdCc/t6J5cTErqwpMS9r8EOe4kdT7JgSUNcx7DEp54OZt/j94Ey2LHYID+W3N5IU
         rwpD4cdyHGIZUHIqmV54BfRPI8UbjWKtW2ViOHTpfT4Qbe1KJnInwuWQRTmDaEoK+tau
         17nnWDVv83xxPhT+ukqYhSzVPA1gkBjK8nBnkXLgSCWgID4oImpBuCsY/hCk2+0R1BRR
         m8F/kaxY1gyMDO/MDSP0gnz0ex4lQsy+r3K8wNPevm9U5cgXO0dmQrg0p93YHXX755AU
         ktjmgY6nsptasiRmyZ8hcmAWVUsrctUY55Z5Of63p+XvLGIYeDtWXlK22EZRC3NovzHf
         LO4g==
X-Gm-Message-State: AOAM530PsmsR2wNizW5Xbbd+CUn6EiNalsNeGLQi+0ORad7xKWyHg1WF
        vSO6VM7CHpoceW4wLNcCfJOxJGAsh4s=
X-Google-Smtp-Source: ABdhPJxeD2q8gXXjexiSjW3xVwN+mJy9pPP+s0b4AOCrRDtWrTo6ygM2/kbUJ0P5FsEbccX0bVFxKg==
X-Received: by 2002:ac8:27c9:: with SMTP id x9mr9536760qtx.172.1595596924773;
        Fri, 24 Jul 2020 06:22:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.211.51])
        by smtp.gmail.com with ESMTPSA id d16sm6233463qkk.106.2020.07.24.06.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:22:04 -0700 (PDT)
Message-ID: <5f1ae07c.1c69fb81.7a649.ac60@mx.google.com>
Date:   Fri, 24 Jul 2020 06:22:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6427513465486341450=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, committed@heine.so
Subject: RE: [BlueZ] main: add missing comma after AlwaysPairable
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200724130903.110903-1-committed@heine.so>
References: <20200724130903.110903-1-committed@heine.so>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6427513465486341450==
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
ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'Commit 1880b2990866 ("core: Add AlwaysPairable to main.conf")'
#6: 
Commit 1880b2990866598 added a new key to supported_options but didn't

- total: 1 errors, 0 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============6427513465486341450==--
