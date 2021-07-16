Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4670AC12002
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 20:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24406613E8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 20:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhGPUkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Jul 2021 16:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhGPUkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Jul 2021 16:40:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DD6C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jul 2021 13:37:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 17so9886676pfz.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jul 2021 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TAj2x3hN85Tm25g7IGV1ZYc4icpUDZO4pihw/fOjlqI=;
        b=U3j0Iq6RMO+1Li1sc0Jpk2MdYF+oqPEFkrqg/R3OIHm4Y4r0n2Syr2sU70B6hDX43d
         ls6j6OmVLJHd5znRlftwoSNjDKhCxEtbw7zzL2+KSvSgoKCiA0AbF2BKAIT9zi0+Chjd
         G7U2Zvd+BaqYU0cUa1Ro5wMY/WZLm7349H3xDCusZ/BTg0ur97Tm3Da8O1CK7gLKW5D5
         UpSLZDSA5KVKOPNGnRgLgL5cHorDi7GsnGO11NPdEaFFdUEESjhR0Oc2GNI9Iaz9+jV7
         4zYSYmwDs25AC0+tHAPhQvmYmuz8Yior5vKcfrDsuS6d/Ndiyv1rViXF1lZ1ToSjqQwO
         22fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TAj2x3hN85Tm25g7IGV1ZYc4icpUDZO4pihw/fOjlqI=;
        b=iN4ba/T5JUliqFGVnxzK7gE5aDFyF0vli0QdXj7P1b4rkd8goRWKuaebX61SWcGMZ4
         t6dyA7b3RiYZ2DfZy1OJtQqZF2Aogxt1u5RqUv0yVcSvyninfCljzWBzjulA30nlOEXV
         O345Ig6bPr/p1j7AdfJ/7UKQrpi3Rf4TLasx7s1l7owrYU1rJJ72/eJ8sNjPYpkJGnln
         j5pMyn7VH69MW3QjCBjxNOqFuKHh+ueE+NWheDkvEU2Ee219LTqcslxoZBEnOBZtNh8C
         zzrM510pJRQoXLeQ2IXvxTbpuJFs4FCO2tba6nkVCSxu42+aA4X+lTiQtdAr5C4CuPQq
         UEfw==
X-Gm-Message-State: AOAM53238cfuHqY2WBjpO8YuJiFgtqAcJHbIS/qjUyDpHZCkd7AVp/Ga
        4ZLhfPzHMgtNtWxaa+Qe4icOQuS8w28=
X-Google-Smtp-Source: ABdhPJwZTCewFO+N7neizJv2k6XeSVawGcx+kV7euprzveGWnmzPrDhjNcomTLQd+fxOqSndu/8v6Q==
X-Received: by 2002:a62:584:0:b029:32e:3b57:a1c6 with SMTP id 126-20020a6205840000b029032e3b57a1c6mr11995112pff.13.1626467845992;
        Fri, 16 Jul 2021 13:37:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.148.174.209])
        by smtp.gmail.com with ESMTPSA id t2sm10489995pfg.73.2021.07.16.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:37:24 -0700 (PDT)
Message-ID: <60f1ee04.1c69fb81.d81ae.1461@mx.google.com>
Date:   Fri, 16 Jul 2021 13:37:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2888890343231438246=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2,1/3] emulator/btdev: Add support HCI_READ_CLOCK command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210716193932.2939264-1-brian.gix@intel.com>
References: <20210716193932.2939264-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2888890343231438246==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=516839

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.37 seconds
Prep - Setup ELL              PASS      49.60 seconds
Build - Prep                  PASS      0.12 seconds
Build - Configure             PASS      8.50 seconds
Build - Make                  PASS      217.53 seconds
Make Check                    PASS      9.48 seconds
Make Distcheck                PASS      259.54 seconds
Build w/ext ELL - Configure   PASS      8.56 seconds
Build w/ext ELL - Make        PASS      197.84 seconds

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
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============2888890343231438246==--
