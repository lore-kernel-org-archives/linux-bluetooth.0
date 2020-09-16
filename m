Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20515C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 22:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10B82087D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 22:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4z+Rlvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIPWvb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIPWvb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 18:51:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EDCC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:51:29 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 16so280597qkf.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QdPdHxhh2X030UI9Pl73zrxQxSQW5ssC98IxPG2SNYk=;
        b=k4z+RlvnnCKiVC2fUWmD5/ReTRGYsDltRmPOgYAi3zFofExp+dYf6f0rkz90sdTww4
         x01U9YEL1gz4NH2p8ZRkoS0OCjnBpQZ6xWwKufF+n0X9li5kcT2prha2jh4OtZgG0AfY
         RzcZrL3P60pHIFc6CgmaXRvmQaXFSZpPGvFkY90o/uBAk2RHYqvVmxAsEZhTOs8r+Pev
         7NUFhmQ/pcnCH3erCNlvFd/h8DwqMPBirbZZsd5DnFB9rXJ5ddrkfdfOiieQZnznhUtL
         hITyYPEFOuK8zihf4mz9PO+XeLQGT5Yqasn+7MI8nWlHVpmMOGvvsGuTpxT3Fo7cKOrc
         KBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QdPdHxhh2X030UI9Pl73zrxQxSQW5ssC98IxPG2SNYk=;
        b=b3ayQB3R4UzivpyThMmLvZocMyBp8xX7AneFmUTNTwYoxLzUh7xbTqs2QNiVPMWPya
         sJfnFFQoSyuKWnfT54Obr9Togf4QnBt2Hirp82CqjABCEdAy7fgwDcWmObWoAeQt8+Cx
         vzplL5xijJwSBYjHggALHTLj9wYiGXjupxGz6O6D/QRhVEAw+R085NfYemb4qt3iIoLL
         6xl5/gKUn7/TSCEpb6FQQDyUd0wmRJHbUz2CQfkpLAO0rtMazizYa4OYaQlzffO3XiSD
         nBDfmnmueLKmV1MCI68fgny1D03VhTfpbQlCOS6MaheEXd5CDalOjh0x9FI/38zg9F3i
         W/qw==
X-Gm-Message-State: AOAM533qfGV8NtFgv5EBCsVqn24MiWzx0NdFf1ex+GUDXMYo+kHnnWR5
        uPLgzKOj6vm2EPNkIft9Pz3pAR2pY5dWhw==
X-Google-Smtp-Source: ABdhPJybFj8OiCkmpUv1Lq+2tEG7nOIzrWGK+FINfroGDeaBxZpg5x7yhrZ7YgEIQZ7zJreXu11C9g==
X-Received: by 2002:a37:a953:: with SMTP id s80mr25068224qke.152.1600296685785;
        Wed, 16 Sep 2020 15:51:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.218.1])
        by smtp.gmail.com with ESMTPSA id d9sm21087337qtg.51.2020.09.16.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 15:51:25 -0700 (PDT)
Message-ID: <5f6296ed.1c69fb81.edc3f.f566@mx.google.com>
Date:   Wed, 16 Sep 2020 15:51:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0362790845663508504=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] a2dp: Keep track of ref ownership of a2dp_setup
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200916211122.127881-1-sonnysasaka@chromium.org>
References: <20200916211122.127881-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0362790845663508504==
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
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#31: 
    frame #5: 0xf679523c libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3182

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#137: FILE: profiles/audio/avdtp.c:370:
+					 * opening is pending */

- total: 0 errors, 2 warnings, 122 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============0362790845663508504==--
