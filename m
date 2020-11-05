Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95318C00A89
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 07:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DAA21556
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 07:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1XlC9Y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgKEHpu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgKEHpu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Nov 2020 02:45:50 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28682C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 23:45:50 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id p10so558763ile.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 23:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=18Y3ycgavilN7j6CbEu7/76pjavpv91fLbqRbqPVj+Y=;
        b=K1XlC9Y+TQScea+3fw3ZwuZW/xQfco+hrauIUGTGdDwLDwX5YuQ1yp01Qp4bxTmQNF
         e9KFOse/H1LfP4FUgpEVD4AALSqO9twjIqOoX2ijuN51sEAUEdQWK1mh8ROZy1k0Tg5Y
         xV6oZ8eUPgL4wiA5STTwC2QH1Ayejd3KBWfcUhO9hr3q6UEmZJB3Ip3PdEHNKbP0Fw75
         qj69abSx1NLJ1F13dlSgkp0lfbl2G5DXfpQ27KS7YW3jKY5Y/byoHUFWiILC9nwHISJg
         k/9KUD0TDqugRQuIJeJrPINRqkxSgH4Irjxdhgxq4YAkRA3PlGgxQzOPGXBtFwW6x8dh
         ihVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=18Y3ycgavilN7j6CbEu7/76pjavpv91fLbqRbqPVj+Y=;
        b=S78pCj9mObWma+fp9G6jeiAjdbCD9s2yO6cq6UkFdISIe6FQo5yq0cuoVWtjYVc+4B
         GqAPjdJgA+njVC5rUY81HWzlskobuR+yhTTisa9Yf5DzYTcZRJX9q4L85quD2xU0ZAiF
         290vA0gvzmN+ES/IyTvrZL2t2JGY4Il5Afqt1mTSIECxyGMp2eGb6awNzxGNuEKjDzsX
         Ybv5228xKTAMNW+S/+wDyQLQ+KcmsRRp6B/sQvTOYXIwgGxguePkiijPVMnKpqfbeUjF
         PPnpYE+7xc7+WNkuJRFeIYiTNyiExz8xJIY69PmWIsHDx0E++czkLsRrxjPF44818ABA
         vzQA==
X-Gm-Message-State: AOAM532JPu5tvBlvpGOV6T+WipBCvjVQk7R3XjDEn3j63ErBhB/AoI/y
        vvoYkQyJUFF6XlgMk1KSfSACx886YTKVOg==
X-Google-Smtp-Source: ABdhPJwO0fIhDjB98dDttL+FqJSbxMUgcOm+0WJ2J+VrTeRDQU7u+3ATYlNmLjl/nxeNdMmjRbgbwQ==
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr1010410ilt.40.1604562349473;
        Wed, 04 Nov 2020 23:45:49 -0800 (PST)
Received: from [172.17.0.2] ([40.79.28.251])
        by smtp.gmail.com with ESMTPSA id u8sm581152ilm.36.2020.11.04.23.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 23:45:49 -0800 (PST)
Message-ID: <5fa3adad.1c69fb81.2ac37.1e15@mx.google.com>
Date:   Wed, 04 Nov 2020 23:45:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8190719558827019175=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nsathish41@gmail.com
Subject: RE: [v2] Bluetooth: btintel parse TLV structure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201029062329.29246-1-sathish.narasimman@intel.com>
References: <20201029062329.29246-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8190719558827019175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=372797

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
Bluetooth: btintel parse TLV structure
WARNING: From:/Signed-off-by: email address mismatch: 'From: Sathish Narasimman <nsathish41@gmail.com>' != 'Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>'

total: 0 errors, 1 warnings, 234 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Bluetooth: btintel parse TLV structure" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8190719558827019175==--
