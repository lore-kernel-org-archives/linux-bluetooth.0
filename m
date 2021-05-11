Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E879C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5588661185
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 18:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhEKSzY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhEKSzX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 14:55:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E31C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 11:54:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v11-20020a17090a6b0bb029015cba7c6bdeso1656132pjj.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RoOYzBNAGyijfgDHuvnJU+B+Sf01KsEx4EtP+LslW5g=;
        b=CqQq1UL3hBpYoDSrqs84rMPfgN3winVNkSz/u3U6QR+dkErYnU4dYGQhL+JAxi09fj
         5OsmCAmPQH1Q8MZjPp4ExI0qAFJ6iAoUwYcQRSxc1KBI0G0fpN5THXN3I/R9yyI3vd4U
         hN6vN/gIz/IS5STJamf1+dREDGzQPZtTw6bj53U4vKMX039VjJ8Ujb9qz2Yllpxrsl3o
         nmX4u6aFooBZNJL87k38EntLhTZGeoE36KhrL40YPMyvD4NkQXrU+wIJWCXTW6G7JHTP
         7Bh3B9Uhyc4lHsVXdnOxMF2Wf2YqDLFq/v3Bst2QfUffStIHRi2CnWwxHdtPwG4KEMw2
         7ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RoOYzBNAGyijfgDHuvnJU+B+Sf01KsEx4EtP+LslW5g=;
        b=AVlOadKrMR+jY4CLrd/mdk5yWOXZcbxqI1eNjJDI/5Z8r0lTPNcCxfxl5FCYsnAPsk
         OOnI1tOyf7Et33ipDfUz692gi2/K5TXmaZWAue3c5pSQOSx0qYNeZbu4H4JaxZTJhMgU
         QOUhSp3FYSQp4cCAbqJkhbPfCozCTyhme+ceqT8eWp7y4BXd3LBzWaznTQhXFAHiJQZ1
         ScVTb+zu2A8JLKpdmtMxmowURSAWD9oYGRGn4r3jQT9XjYU/fnX/gSynSaSUBfFik/9f
         mGK//xDQL3c4Ejfs74EZJuaPbCaNOsWxd/C+4ZDje+XTQSLxlODUtqSWhxuQQ3udu97K
         ML5A==
X-Gm-Message-State: AOAM5322dDKsbff9X/5w2Ka3JPiLwOCI2QiZ8+4zrp7sY/fjnaU/d7bp
        ArRZIBITtGgrfY9nY8WyF7JUIsT89hc=
X-Google-Smtp-Source: ABdhPJzUZa8wTQGZ2sqCv1aQcnt/Vsal/oeoxcCeiAspRLeXN1rRVtwRZ/5ddJuWuIVB3piopauQ+g==
X-Received: by 2002:a17:90a:fa0e:: with SMTP id cm14mr6628171pjb.59.1620759255087;
        Tue, 11 May 2021 11:54:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.156.87.35])
        by smtp.gmail.com with ESMTPSA id k69sm14495623pgc.45.2021.05.11.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:54:14 -0700 (PDT)
Message-ID: <609ad2d6.1c69fb81.c1eb5.d0a8@mx.google.com>
Date:   Tue, 11 May 2021 11:54:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5634436870075211475=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] config: Show error if rst2man not found when manpages are enabled
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210511175803.1609438-1-hj.tedd.an@gmail.com>
References: <20210511175803.1609438-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5634436870075211475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480621

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.14 seconds
Prep - Setup ELL              PASS      52.43 seconds
Build - Prep                  PASS      0.16 seconds
Build - Configure             PASS      9.31 seconds
Build - Make                  PASS      220.57 seconds
Make Check                    PASS      9.17 seconds
Make Dist                     PASS      13.43 seconds
Make Dist - Configure         PASS      5.48 seconds
Make Dist - Make              PASS      89.69 seconds
Build w/ext ELL - Configure   PASS      9.07 seconds
Build w/ext ELL - Make        PASS      212.28 seconds

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


--===============5634436870075211475==--
