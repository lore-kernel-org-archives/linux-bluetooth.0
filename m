Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E9EC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 22:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE2964FF9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 22:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhCDWiZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCDWiZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 17:38:25 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D379C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 14:38:25 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id 130so63667qkh.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RCzbOVjOU+Eltfn1T0c3rCiHgbZQRH/DnaIJq60ewH8=;
        b=IBkSl9QnGJKyLhVOMQbBZFSzKHWcKBlE+HKYRg6x0Uv1U6YCHWIWVewv07zzGk2nxu
         YwHaKcUKOycjWfcscrcHQHTdaHaMK27My3DL0uN37kIe8g7afZylMlAjeZxMBz6nx67a
         8NHHjcOG9ranIpZPrqUFqcSo1uAWurYhVC509SjR6ASaZGWgkl6IF9/E7R/HR2Fc/joB
         ork8ztfQQ5PyeBNfVklVoVbZzaRYmA4GtKH30nxDrROK4dqEWG3N3lb0/l8g/McxTs6J
         kSdm8UN6Za04yo/X/XRz+zZn55m+oJZxKaXyWgnD+I8WJ3rwJ5oVcLsW1NCrQPc1wzIr
         Bclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RCzbOVjOU+Eltfn1T0c3rCiHgbZQRH/DnaIJq60ewH8=;
        b=qzX87EsDgokzP/jnRwjHzEiwF0E6ODiQB5tE/woocntc8mdD9GByw2VWqxRx8EA2zH
         pXLJcQBkZoQpLqzU9SU/ytQcclnHOgR/jxLfWq1kC4gxUk9NzGgCF23sB/mN57fYBSKq
         XOhfPULrZv11XanMK0aU1uOOMuGGwInz+z1I+ziLcOj/UtnJdAGgnz7NCRpiCk4k+hKP
         ZVw3LopS2VzaOh//yNYrGZ4MnsuoFT3QHfh2pnpdfXFIx9kaECs/Osgami90C0eUuhdF
         REFSr7XLh7uzNdgZnmUPoswC2MGjrASPQJl95b1eDfmPbPpoqlNM8LQkwRgWBMpAygrL
         w03w==
X-Gm-Message-State: AOAM531pdqy39Wr7iaaYpRzdhgowQ6W1pSAzu7EzpHtbpKzqMZmCm69C
        E5jbz8ZGp6OCSaP46h8WdqkF4lS3oxY=
X-Google-Smtp-Source: ABdhPJyTjTRlFwdgbS0UVSa53IJ1BHX06bVSQFfssqD5mmMZuctqKTmUhL2S/jwpwg1E4ai9+Spw9Q==
X-Received: by 2002:a05:620a:e09:: with SMTP id y9mr6396110qkm.126.1614897504345;
        Thu, 04 Mar 2021 14:38:24 -0800 (PST)
Received: from [172.17.0.2] ([40.75.28.55])
        by smtp.gmail.com with ESMTPSA id e15sm677638qti.79.2021.03.04.14.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 14:38:23 -0800 (PST)
Message-ID: <6041615f.1c69fb81.ffcdc.51a4@mx.google.com>
Date:   Thu, 04 Mar 2021 14:38:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1618434067583811806=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] adapter: Fix not using the correct setting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210304222448.3769100-1-luiz.dentz@gmail.com>
References: <20210304222448.3769100-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1618434067583811806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=442263

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1618434067583811806==--
