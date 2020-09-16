Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2071C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 22:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF012087D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 22:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fARVxxdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgIPWve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgIPWvd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 18:51:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7887DC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:51:31 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id cr8so32364qvb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=guefPuweQWMbhZw1fyLePLDNYNLTNtUl2ljOokMfoCY=;
        b=fARVxxdKtxIyThikSxun0sQisEP//gjWBhQ1EeyZmoVzzvF7Ec0rhwIVQHmnAjpt6P
         ip1VKj3K+dHefOh+rZoXnM25n6vsE6Q+3ssAXveNau9h6Ug8YGGMIcFOVW+apIuDnN/x
         +iJWkDq/bVer79IEhzxRqZC59J0g6Ap7WN3CWKl9EAcbsHM9qV/pTbUs2Q0cy6vF5Ed/
         77pwnR+Cl2pBMfMYTUfgtFYrqkG2ZU9gux5o9w/jedx8IBGgsq0IcI9G4CKoV1yu6Oxd
         3YTb0kKQtGFg4URMKKt3SaEThL8NTutQEmtxUmE7Wxvtv6q8ZgE2GgT7g3lTZQ9A9sYc
         s87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=guefPuweQWMbhZw1fyLePLDNYNLTNtUl2ljOokMfoCY=;
        b=QTnscURLL23SflnSsxho0QIqrOWRLlH8feJ//vZc0CzYKePzbo1mNUWZFaGz8Le1IO
         dCAAwZG12/1vJa1aQjtXpd5OMpYuLDuwWEoW/S3+ToqGRS4eciSqiWhoKWZf71iAUoiN
         fQ90shFV8gNMgCqFxUxOQK7gwBFGymbJC7PH43yJuSVTZ9B3h8lrD/xkVh53iW9RtsLo
         PFEHFeH8tfEQN2WLqhkmguMUkukojljRcu57Qn1fN5Sbjti1bPYik6mtK+Kc7LYqW4Nk
         naYIyR3xefcOuWhRpTTBWauDVS8NMVKhzdjo8zLhfzYrZVy6ZNVeDYSFd/LajehzD0ay
         hSnQ==
X-Gm-Message-State: AOAM530s15SyuvsfTvCXY7dnpuabRHCeMhmkVuTaEcW7rP6c5LOBJop3
        AYnLzUoFwHVA1MeOozcssblGK/bqxTcBIA==
X-Google-Smtp-Source: ABdhPJyeFS4XDk7abjBzVN9XWQB4lLBiRwqFnhQ6aTzm6E0rmM2Zhe98gl9kM42SoF6T0/B2C6+Hpw==
X-Received: by 2002:ad4:4891:: with SMTP id bv17mr25446319qvb.20.1600296688805;
        Wed, 16 Sep 2020 15:51:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.218.1])
        by smtp.gmail.com with ESMTPSA id r5sm19837523qtd.87.2020.09.16.15.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 15:51:28 -0700 (PDT)
Message-ID: <5f6296f0.1c69fb81.b0d4e.9db0@mx.google.com>
Date:   Wed, 16 Sep 2020 15:51:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4868024934633137905=="
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

--===============4868024934633137905==
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
28: B1 Line exceeds max length (81>80): "    frame #5: 0xf679523c libglib-2.0.so.0`g_main_context_dispatch at gmain.c:3182"
32: B1 Line exceeds max length (85>80): "    frame #9: 0x0c65a7ea bluetoothd`mainloop_run_with_signal at mainloop-notify.c:201"



---
Regards,
Linux Bluetooth

--===============4868024934633137905==--
