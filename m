Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D383C48BCF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Jun 2021 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22E36108E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Jun 2021 11:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhFMLGc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Jun 2021 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhFMLGc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Jun 2021 07:06:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50624C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jun 2021 04:04:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so3233735pjn.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Jun 2021 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ITYs10OmQh7cy+LbOXGO/M7yaXhD87kT10oKdLHRj+k=;
        b=XYBOdiYTIKFidl67jDTrJc1234Pte3i9CE+61Pom1upxMn1eByBDs4NYXLbK+bCqf9
         An8ig65S/AGaOwfda9aA7efR7C4i5Nn8ZdW452zW0TJTeTFCXydOS7gdOv7O0J+Lu7jb
         Tk45XSk7wMElDPP+ZfXB4hch4Yjt+VZ0e9y0xeX3v2NNyqo5+x8tMs4TCIek1/UnPmqq
         zRh7WzemEZej5LlRHmOkVGMcYDR+6kMoz4mBjaaCIrkrN6RUa16Ia06hrDU3fZCVtudm
         WfMIO7MGN6ZcvAodhQF0CFKV8nqV9EBeKyU1taMDZNc8bdWi0ZQIgUlUupAspBxwz9WJ
         vb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ITYs10OmQh7cy+LbOXGO/M7yaXhD87kT10oKdLHRj+k=;
        b=k9+DvWQYz/TliiztwyeU1s8EGLNNK5lSsDG4atL0aLpWKX9sKH+GDwlI8znDR176Tv
         UjpxzodF74hFvxy2FbD7NQiGVjkKA+eHvvOlY09bCl4gHuGlQPKvCZ6jZhcEknsolZVi
         ciMD9haD6HJKQJuGteoTAzjcPIIsaGtdUdMD/42eA6UtLtEvZBaQ1XhqQfpKC81X+fL/
         my3OzbdXByquUbeo7SCvFUx4aJl62imE/xCeICMtZIYOyjAUpbmCHPiZEFVN9myNwgJv
         z5Hme4Cxfbm7M89tL04ltVHrWmEvDNYMn0KBVyk5tPwEnyBPjJEUvZDkYehJvR6NKB6n
         R8MQ==
X-Gm-Message-State: AOAM533PKsZwnw1U5EqRDxJUnbkfKuiyijuQ/NoDsVrY9AP4oiyfe0rJ
        7ZAyN1rj9Lg731UBjkhKVCNtxWORH8A=
X-Google-Smtp-Source: ABdhPJyNFeZU3O9LetKrD5SBIbeJG+ZShcSZHoEyCl97zRuAb/k0B9j/LdSVLGguKIYBfLAvRupeLA==
X-Received: by 2002:a17:902:ecc6:b029:112:8ab6:9652 with SMTP id a6-20020a170902ecc6b02901128ab69652mr12082454plh.8.1623582269528;
        Sun, 13 Jun 2021 04:04:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.92.177])
        by smtp.gmail.com with ESMTPSA id i1sm9732912pfc.206.2021.06.13.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 04:04:29 -0700 (PDT)
Message-ID: <60c5e63d.1c69fb81.aee49.d4a8@mx.google.com>
Date:   Sun, 13 Jun 2021 04:04:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6167117172219095735=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, surban@surban.net
Subject: RE: [BlueZ] gatt-server: Flush notify multiple buffer when full and fix overflow
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210613103918.5814-1-surban@surban.net>
References: <20210613103918.5814-1-surban@surban.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6167117172219095735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=499527

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.15 seconds
Prep - Setup ELL              PASS      51.54 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      9.04 seconds
Build - Make                  PASS      228.99 seconds
Make Check                    PASS      9.32 seconds
Make Distcheck                PASS      267.21 seconds
Build w/ext ELL - Configure   PASS      9.24 seconds
Build w/ext ELL - Make        PASS      213.85 seconds

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


--===============6167117172219095735==--
