Return-Path: <SRS0=Rzh7=7E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27386C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA3F20738
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 May 2020 23:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgqWUkK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgEVXg5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 May 2020 19:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgEVXg4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 May 2020 19:36:56 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D3C061A0E
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:36:56 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id s1so12415064qkf.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2020 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7Bw9DwmIxapPgWc2W7z51s+yYQar+aTevTQDuByHdCs=;
        b=pgqWUkK+T5qa5LuDtRSN+NohCDK3QyLUPNN0a7abV9+RkXTSb22S8/TPvRQTAgDWlk
         LfGQ2zZ61oEsULkGvKjy+/Apctu6gfOaR7jUl3j87vfUIV7UKASS0kX1ee6vSosOzeTj
         EchNn1fv51YBt9yk316xINfSeC/ZYm2PXtL4un+lrvVfbozcyR1RYfTeTqpdogQGHKck
         TdFBpi1Tpje8/tUXns0J/if1yGw+miju8w+JcB7QG/THg972IS9G0U8VjeIDb1v3wZsB
         IZjIXB8Owf/5eV4iWKnD84r9g6gG630ApZ1mbvv8R/PO0dkCKHp3yrhSm57DRtP45+mO
         xAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7Bw9DwmIxapPgWc2W7z51s+yYQar+aTevTQDuByHdCs=;
        b=bLeBvqUbnM4djbsA5ODl2esycFYRc20zpVgzkfLyoJK8J/9nr4bTO5tYSwemvb4R0P
         YLb+vyKTEkDnK4FgH19cS9EzcJrypc7sOeFtAHPmbdFh9kX+AVihFl//q4mqD2Lya1X9
         wt0NSDDGzH7plROimdrbpndCPjGBfqjVigXdfiw8LRIa3Zfv6oLkuL6CRajRqXULPJWC
         krDcDQzwRSZGdNRQvwgzGEw+yPBpZiNLKNo5yJW9Ajqfy5DvgBiuJS/G8hQmnyyqO/RR
         fbA80IL8IRNLPLfzBWsMfb+c3HbHd/FIKnaHVlivfdE+Of+gUH6VmTs4tSwgSyN2L9gk
         INkw==
X-Gm-Message-State: AOAM530d75vEYm9dLkFTxIs5xDBSD8LLi53xPS4WqZXytxBc8SmsqmmI
        2lzQ7QA1+wz1k/KCSH7KLaoBa68SWCs=
X-Google-Smtp-Source: ABdhPJyLRrMsEPD7dbt4d9qiH7l9iN/NPWCJSaqxBnBhEFoA15xi5NtJMWOM11aX5WhlNP0FGbAnkA==
X-Received: by 2002:a37:845:: with SMTP id 66mr5260333qki.67.1590190615962;
        Fri, 22 May 2020 16:36:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.100.111])
        by smtp.gmail.com with ESMTPSA id i41sm9891565qte.15.2020.05.22.16.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:36:55 -0700 (PDT)
Message-ID: <5ec86217.1c69fb81.e06e6.9d84@mx.google.com>
Date:   Fri, 22 May 2020 16:36:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0341237799051241020=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,3/3] mesh: Fix leaked message reference
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200522205756.230907-4-brian.gix@intel.com>
References: <20200522205756.230907-4-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0341237799051241020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============0341237799051241020==--
