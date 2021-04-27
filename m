Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1D1C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Apr 2021 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E256113D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Apr 2021 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhD0S4r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhD0S4r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Apr 2021 14:56:47 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480EEC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 11:56:03 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id l2so11647959qvb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Apr 2021 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lVT4q/LhDC0E+qaZP0oDSyvM67a8RrLXPE3hP8twF/4=;
        b=oP8szzn3Ibh3bzBsRiBNc4owoM1WPVfpEX3/ofhN1DauCgskP9WC35dsF0kQ46/EeN
         MrvZFWuJtkLb6yzhLVQS7u2xmpI3Km9KOddjSpmi+hqDv6dtx24/uL6XMxq5sDvXeCdk
         prSHQM9Jd86gg7qXXWov0z/9GlUas6m8bHY6bEGBsTz1zTa4nfq9vqkjuYeMhebPrXK9
         sNyKEX+ERvARc5GVkqmGUjBYM/AOn35Ggmz1bTb+qfxVVBANzcqcTXx7JrQlWhl3C94R
         JQd9LErqe3zfBtxo1Y23knxPxSx4tqnloSIZiRRI+xGScyq2dpH1BKC84j230CkW1aze
         6Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lVT4q/LhDC0E+qaZP0oDSyvM67a8RrLXPE3hP8twF/4=;
        b=AfeFXEs5ssWeS+Xj1DI+2nPcfCzyseq2+GdClnlPdJSmlPzUgwdoNeaP6LiHVlfiPS
         IX0WqhbvD0MU/zHM6GAW6496JTVKM1pml46CVjzyrMDgOxEapjHGnO6V3ov20ArV5avx
         EnAxZAgN8nfkF4UQVowPYnTHA0hRRY35ImlMUiNFQNxT2xVqc44XpUmGKuPARWDVR0Iq
         JYczA9hiLfxjm5+YdNlGBV+6alcYU21i0tAsnakfUfGnkT2qfxEJjR3HoR+XR9104Ni2
         Vi0MwPDf6LLghe2T6auFE+1PSTt9/16hJnTRikZKzq9jEYt9gtsDxMSb4h07h8y0uLCM
         aq8Q==
X-Gm-Message-State: AOAM531RxmvA7gSd/euSOc0OR/Xi5U4FfC7ujTwGXofk9PRk/Cp3F5FT
        6ZI3q7egQwY4kyHkjeMitE6QEZcMAW6uXA==
X-Google-Smtp-Source: ABdhPJxhoGCRgONItzu+yLx7wZdUzMPD1MswMaTI9KDRVXdZs/iFW520D/llyu4v9m52QUui6Z552w==
X-Received: by 2002:ad4:4e94:: with SMTP id dy20mr13394627qvb.50.1619549762331;
        Tue, 27 Apr 2021 11:56:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.96.35.232])
        by smtp.gmail.com with ESMTPSA id d19sm524987qtd.29.2021.04.27.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 11:56:01 -0700 (PDT)
Message-ID: <60885e41.1c69fb81.84a6c.4995@mx.google.com>
Date:   Tue, 27 Apr 2021 11:56:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3836652562190674246=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] monitor: Update manpage
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210427174310.100632-1-hj.tedd.an@gmail.com>
References: <20210427174310.100632-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3836652562190674246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=474043

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      47.22 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      197.87 seconds
Make Check                    PASS      8.86 seconds
Make Dist                     PASS      12.55 seconds
Make Dist - Configure         PASS      5.18 seconds
Make Dist - Make              PASS      82.20 seconds
Build w/ext ELL - Configure   PASS      8.11 seconds
Build w/ext ELL - Make        PASS      190.03 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Dist - PASS
Desc: Run 'make dist' and build the distribution tarball

##############################
Test: Make Dist - Configure - PASS
Desc: Configure the source from distribution tarball

##############################
Test: Make Dist - Make - PASS
Desc: Build the source from distribution tarball

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============3836652562190674246==--
