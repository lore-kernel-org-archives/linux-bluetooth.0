Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABCBC388F9
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 17:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7583F22202
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 17:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6rh9l7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgKUR5H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 21 Nov 2020 12:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgKUR5G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 21 Nov 2020 12:57:06 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB681C0613CF
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 09:57:04 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id q5so12212187qkc.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2020 09:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rAzWbHHaxfpDO01QLIyXC710L3S8e1ZchivEP9IudNQ=;
        b=a6rh9l7OU85YZc+VJ7JgCRSz3rmwFncc03zeNQfQgLpjX8ivUqDJ60hOQGmUhWw/Oz
         T0XlWfaMH8Vu9efx8COLB/kzJQAWFpI9ifgrcJpB5d+RNMY+AU8u86wXS9ZG1B43tjLf
         BtXkjZU6VqFjD9zEb3MT9gjzHji6f5T6UNd15keXVxFVjTLfiX7jHKRlQUTRBaldky8L
         TtZxwTamaDbfthdXFsoSXvEx8Vs/7mEkhBgy035PeILpW6frAJuJUN0ZRsTQAKHtSCnI
         Pwx9JWsEuYxHOgU744q045mf5zh4zw76k0AFbXJGISnGAKIiw5uQPWehvZ/xc12sXqok
         7Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rAzWbHHaxfpDO01QLIyXC710L3S8e1ZchivEP9IudNQ=;
        b=TiMztFHH1QBB9c1NkYPOKNkLpYqc0gSuPk1uzW4F//65uYCo10z0u1+K/WjV8F+m7G
         z6vr+/lk9lQtpweZMtRHVcMbOpUSjG2GcaYME4zx1VZ6uUAmmQ7akE67jbZsOtnY736J
         I6c+qWnQ9E0gExnTFEJ24FJMZW6rm4et14RkLWPyhARcFfBC8lgT3aZhbwfgVOSKz3tR
         hUdl16rPtP6ADtuZfWSYnMtTuWWI3hiJ7fNXGB9M5iIFC59WYJFqLRhi1SJ+rlX8l3m/
         xmPjf8JUhAwHeVJjozV6TBqypCufkpTe2p9fbOygDdEWE/nTGCIY4KTuasVLD6agbgIl
         2wJA==
X-Gm-Message-State: AOAM530PEv3wgjgdeStUFFvFvFCpQLJwtmx+4RvnvuGDuJeIkTMdteed
        QnZpRmOslmdp9qoiOKIV5DNDCzH/VUNWNg==
X-Google-Smtp-Source: ABdhPJzZIx62ZytfSM0NLkBgPnzhyNEPvoLEm/In5/GKDKf4xk6FFIvnaG6arPCCVWuEKGNVeKsZ/g==
X-Received: by 2002:a37:58c1:: with SMTP id m184mr8626206qkb.9.1605981423283;
        Sat, 21 Nov 2020 09:57:03 -0800 (PST)
Received: from [172.17.0.2] ([13.68.101.182])
        by smtp.gmail.com with ESMTPSA id j13sm4863759qtc.81.2020.11.21.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 09:57:02 -0800 (PST)
Message-ID: <5fb954ee.1c69fb81.2f993.e6ab@mx.google.com>
Date:   Sat, 21 Nov 2020 09:57:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1047661858904060644=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, trix@redhat.com
Subject: RE: [RFC] MAINTAINERS tag for cleanup robot
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201121165058.1644182-1-trix@redhat.com>
References: <20201121165058.1644182-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1047661858904060644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=388955

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
MAINTAINERS tag for cleanup robot
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#8: 
one or two fixes a release the use of 'treewide:' does not seem appropriate.

WARNING: From:/Signed-off-by: email name mismatch: 'From: "trix@redhat.com" <trix@redhat.com>' != 'Signed-off-by: Tom Rix <trix@redhat.com>'

total: 0 errors, 2 warnings, 61 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] MAINTAINERS tag for cleanup robot" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
MAINTAINERS tag for cleanup robot
12: B3 Line contains hard tab characters (\t): "	D: Commit subsystem prefix"
16: B3 Line contains hard tab characters (\t): "	D: fpga: dfl:"
24: B3 Line contains hard tab characters (\t): "	int v = 0;"
25: B3 Line contains hard tab characters (\t): "	FOO(a);"
33: B3 Line contains hard tab characters (\t): "	int v = 0;"
34: B3 Line contains hard tab characters (\t): "	FOO(a);"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============1047661858904060644==--
