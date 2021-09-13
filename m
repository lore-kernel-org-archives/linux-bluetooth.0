Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F05C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501FE610F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbhIMUiT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbhIMUiQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 16:38:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB84C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 13:37:00 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 22so12146845qkg.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ZqihFlosF/frB6K8uNNZlKD903j632jLlTDDrwP3lhA=;
        b=fMnrppwv3Qt+KoOolTHFHo2YLMF1qMJ4DAzaMPp118KwR1FHMgim3wWqkiOcOsnels
         vvPj+EDneRJXf+cCPxZNaH9Ddg331J20/qPI48cVK5ai5OfTg66DusPtp6/nNJetEp+V
         2Nb/xUcaScrfejLHnUwXHCLrBYu2gLs+xbF9t1dKjqi+wG+LWpH5QVw3jx6YVA8kZY3h
         Pi0z4ch7huSd3pN/1w+yKYU4/KKK6Cl/mGGOb48PhZ/3UFEs1uqA3+FQntYmgWOTXPDf
         bbrqhZVNNakeApnCicu8clHawOSsEToadZhLasvzGWMGfbP/TfWwP1+FLf32o9gFajgr
         Xe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ZqihFlosF/frB6K8uNNZlKD903j632jLlTDDrwP3lhA=;
        b=FIhA7v6McOJc1bKk2vjID9jaqxbKCITYUMgLYLlaTLuvlNYYVb3O5Ny4FMo8ApffNM
         ywJh+4fEZ/6rXSSAH0yzLe2T1ZXIdIbxz4g6N7PDBYnI6yIZOm4VywmIDKs+L7hIKnpT
         imIf2pIyEzVT6QUi4EzJE3aGVA0mmpqjywzkXBgY7DvvJ2TQOZEYldM0lJuzzkDZwPoI
         n8qN9uW5fK+10b8ppYGcZNqWHV3avaw5n2YF+N3OMWOO9563e19x/6n4YIxtp2Kotz8W
         QP/s1dZ+xRZAz+K3piTv4laW5ai7DS4evQ2kLKbecVCsvEAgjB69GOf+JBbjfwNOSPhD
         UNBA==
X-Gm-Message-State: AOAM531KFoWr4OSAXxr7xD/WocQv0KmXurchTHZeu3/NeNX4ZViSXDDX
        mUZG55Q7kgSRz59qjTrzbrwkaYEZQcOHMQ==
X-Google-Smtp-Source: ABdhPJwOJ23NpWDYRU1XS0hY9fHfe/Je9Kz4tzKbY06dL0mx8GN4VcWY3wPeS63T7hPDjrGSZWlc4g==
X-Received: by 2002:a05:620a:1aa6:: with SMTP id bl38mr1551622qkb.36.1631565419380;
        Mon, 13 Sep 2021 13:36:59 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.39.109])
        by smtp.gmail.com with ESMTPSA id d68sm6214013qke.19.2021.09.13.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:36:59 -0700 (PDT)
Message-ID: <613fb66b.1c69fb81.4e083.5b80@mx.google.com>
Date:   Mon, 13 Sep 2021 13:36:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4725378358950165807=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] shared/util: Add conversion function for 24 bits
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210913201341.3515285-1-luiz.dentz@gmail.com>
References: <20210913201341.3515285-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4725378358950165807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=546113

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.20 seconds
Prep - Setup ELL              PASS      39.88 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.99 seconds
Build - Make                  PASS      173.70 seconds
Make Check                    PASS      8.77 seconds
Make Distcheck                PASS      205.84 seconds
Build w/ext ELL - Configure   PASS      7.14 seconds
Build w/ext ELL - Make        PASS      164.39 seconds

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


--===============4725378358950165807==--
