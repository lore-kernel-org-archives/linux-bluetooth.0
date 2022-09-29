Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AFCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 16:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiI2Qtw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiI2Qtv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 12:49:51 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B61B797
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 09:49:49 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c19so1210713qkm.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=BIyeL7HdVGtsFYkMa2Z0ch5kMtWLu6mwcYKo4mvwu+c=;
        b=UJyrBV6N34pfRuTLyN31E2NR6l0QwfXxuK+IFnNzDS9nfyda5lhEEEp298TG5gBxW6
         sjW2xojtfxAd9iX9P2+iIEAL8hZj78wK8D0/rtuP4JW7ItNP6cn6l9D62F6VhTKpJSqt
         7K3CLGu35GRKpRNxuzRLv1nuEXENG1m3kMItfkD4Ek7/HfgYnl/UChMwaMriNwx8KZVJ
         NzQ1iG/HsF7d4+9swxFg8JmQaPsfCwmgscnvm3ifb2l+LiHzezAqobI9ETV5/gQTuBuw
         8vtuVlmdnUPU+icE+02d79bMRCG/8x5pUm/WBNN//PJrAU/2EJMTb06/XEa7CQwjDDLm
         5+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=BIyeL7HdVGtsFYkMa2Z0ch5kMtWLu6mwcYKo4mvwu+c=;
        b=drHXAfwYet2qeherLtdwUfw5b78s887+uNYu4sorzWpXfdLC+LKRSghOMDoQmR0qMy
         DXL4C53bn6yoixzGgAL2drYhmChjbtzgSOsNxH8mEt2EWrOsN4Qau05HOjQ/KNYk5tej
         dlkBA9ivGm+iwQE0DfeDdsSDQkhWXDqmZ6sXgfYBcvUhEuaGQMnIQkBmtxz3zMK35HX5
         RY9Tv6U4LmWAsXSD4PnEOHnm+3bXHWRCXXjK32UNO+31zu6aIHO0sHFyhFEvM7bVpOOp
         WBN5wm3oYhV7tbo2nrrDhs1GOjuSTt12pebTfwfHpY5Xb5bAMQzH/Up9cWyd3SwK/4fa
         Q2BQ==
X-Gm-Message-State: ACrzQf3me3EKSiAX92KHHFHPVlbB2ZyoOUhiWBl9Ja0mpSeCtRCtpNGk
        bR05EErhC5vAbTBhoc/JFaKxnytKCM1WeA==
X-Google-Smtp-Source: AMsMyM57zVLSlAs9N5sD0oWBNEr20P6F8PnmpeTIoclzSK24Ewhvm55cQr0rtbZhmt0tCa5GN1k1pg==
X-Received: by 2002:a05:620a:ceb:b0:6cf:468f:ae66 with SMTP id c11-20020a05620a0ceb00b006cf468fae66mr2819413qkj.591.1664470188547;
        Thu, 29 Sep 2022 09:49:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.233.203])
        by smtp.gmail.com with ESMTPSA id v19-20020a05620a441300b006ceafb1aa92sm6425178qkp.96.2022.09.29.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:49:48 -0700 (PDT)
Message-ID: <6335ccac.050a0220.6d0db.3187@mx.google.com>
Date:   Thu, 29 Sep 2022 09:49:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2478577646320364212=="
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

--===============2478577646320364212==
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


--===============2478577646320364212==--
