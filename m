Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B62ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Sep 2022 20:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiICUsg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Sep 2022 16:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiICUsf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Sep 2022 16:48:35 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05C4DB64
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Sep 2022 13:48:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id a10so4122987qkl.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Sep 2022 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=v+lBC8nP7tSPHGEx4ErxzFW1JfxhdFAJbOZha9FPgFo=;
        b=Pg9mtreIyR4e7qF9ZFcuQChdlgnaSPuQATDZUjEKYbQJpYNIMhRIczSorcK0woi08d
         QkZYIZu6+xoYpt70dwv+B12NaScCuI7pBSLcK1LBsx4E7eGGa7cUzP/MaymZus9yeFT0
         wizXoGjDzELpqRzbrzBPVSQ+AtfVYHuEXQ3bkM+ZjlrySShMjhS2AUPH8yyAEOzBiYBl
         JKikAtzI8cUk/7dLN0Nn4pDQXiMHXrOPpOWNSGK9gSviuEfFMzkvTZNu766XyA20h7WG
         NT/aJxfoP7WqoPGnwMtO+6/g6gfUTjljbPdeIkpX3pEThsWCxPbcT/fkFWzkNpvXkzg7
         37kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=v+lBC8nP7tSPHGEx4ErxzFW1JfxhdFAJbOZha9FPgFo=;
        b=i0imKXwUx4rLZVT+t6JHTh3dantTJ2QeHn+iHtASoEM4A5QzG5/SH0U0k92YgMPXPR
         ZI3EqA/0cyJCSeK1gibYqTFA49BTDKjP8oy+todBHj9LxsopP+8EpwIAw6LGR6pXAIIV
         SRDxnaAdM1UAigAIG4/elQwMQneIqc6zCzvBKM4c89HEqudPIXbAXylsK9JpiHrdozQm
         yrGZI8by7PhzbIUuJNx4OKd0OtvKC398LghbWEkDaU/Fj4Exw0L/6a/9YvAEEih2dvBn
         w8S1MJ2H7/Db/mCSF1F/E6Dli8ZBKawloW6BX1mbCjxEoqrbMEjOQlx0UVQIHlc0QsIj
         fv1Q==
X-Gm-Message-State: ACgBeo22TaJ7uOnDpPwg7UuxVBEUMVr+AQv5czs12reu8D8q/IWLenQu
        FgtiIoxf0AnssdtvqG0N20W5D493zcc=
X-Google-Smtp-Source: AA6agR407YV/kZ0Dhd7TCp6H1dyAglx4yA0CcxgzmUzCJ6OrAiAYBhE/p2YrAsQhewUnAebxQT0Uhw==
X-Received: by 2002:a05:620a:4626:b0:6bb:78d0:95d0 with SMTP id br38-20020a05620a462600b006bb78d095d0mr28333805qkb.631.1662238113052;
        Sat, 03 Sep 2022 13:48:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.159.192])
        by smtp.gmail.com with ESMTPSA id fu27-20020a05622a5d9b00b003434d3b5938sm3792610qtb.2.2022.09.03.13.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 13:48:32 -0700 (PDT)
Message-ID: <6313bda0.050a0220.c0b88.a767@mx.google.com>
Date:   Sat, 03 Sep 2022 13:48:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0031743907362759384=="
MIME-Version: 1.0
Subject: RE: KASAN: use-after-free in __mutex_lock
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
In-Reply-To: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
References: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0031743907362759384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 6
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0031743907362759384==--
