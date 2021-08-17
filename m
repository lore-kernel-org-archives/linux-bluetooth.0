Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63417C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 19:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432946103A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhHQTaq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhHQTap (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 15:30:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36795C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 12:30:12 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t3so1473qkg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WRucNeNGmslzKpQrViPzIg4NAEAwI5mSjlNbx7P+hi0=;
        b=fFto6uS/lIQCzQ51OLADWYoPUisO4A7qGDHEDlX7vJYg3TnkascRKpF2XayVA6GF4m
         XTzVQ2tdB/l4QMlrlJJLAOzGdCMZvXQKMXRgobHK4BQZVum+nSX0afIeC0cHtQe6CRu1
         bmNiu7hn6munViH/qvvtb/nr0zZVi3LZm1zKro3yvIGE74wwVHY9Od0R8FxcGc3GQ+eT
         hHU1z2l9vZf4MmUEeV0w6YwcHZ0xnOQUnXhH5vlAEVGLxiL+wMsehQCsM+bQekpyn07I
         S9TCufyzH8hl1fhaIA9z4p/NyvnRJrNv1HCTS7Imjv+s/NPa2jSpxgWiEv+zlnNkCV3a
         HR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WRucNeNGmslzKpQrViPzIg4NAEAwI5mSjlNbx7P+hi0=;
        b=m1Oqe5rmqq2irCWwHxDlrXW7OuAA42p37GDmYr5wldf5XEAF5wBN+kBlw/VW3tL4ic
         bx01olVkwfs5RfRRSQzaV0s0SrJ7Hobxh49zNblN27GiRrKSaBNA7Bpnfu7994CcjEmi
         Ga1edvSXzHYeG7hNZsujc2ibmVYovNZgJkvV9Rbx+f2z9H7TBSoPrP3IjC9eQwMeKzSu
         6+UfKr7A/cuZUKygoyDHwk+GWRYSaVW+dIwWcPbkCb4vqgww+D/qxrkphYwawD47QrSq
         MwZKqyKb9wI3YMsptBKVpOrW/24rWFEajJpvckhFxr9ugVHf/ywol5r8gI3yiHwET282
         I35Q==
X-Gm-Message-State: AOAM531DZ8BUmClJeXb7VWcqN/xJRjt/9u0TU2lHfBu6hDIzyt0JIMTI
        4zn29VsAhxrkwBF6njbn6ourdBnlj3C+Gg==
X-Google-Smtp-Source: ABdhPJxFpUuDyytCyQa95F77cgmaJE3HNH6gLeykQxlrgTwG6r9AymNdtaZK3w57ba7WWEkit/SrVQ==
X-Received: by 2002:a37:809:: with SMTP id 9mr5456094qki.318.1629228611255;
        Tue, 17 Aug 2021 12:30:11 -0700 (PDT)
Received: from [172.17.0.2] ([104.46.125.252])
        by smtp.gmail.com with ESMTPSA id t64sm2053918qkd.71.2021.08.17.12.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:30:10 -0700 (PDT)
Message-ID: <611c0e42.1c69fb81.5e8e6.e741@mx.google.com>
Date:   Tue, 17 Aug 2021 12:30:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0310974399126249538=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bernie@allthenticate.net
Subject: RE: [RFC,v3,BlueZ] Added GDBusMethod to notify one device of characteristic change
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210817191245.10846-2-bernie@allthenticate.net>
References: <20210817191245.10846-2-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0310974399126249538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=532911

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      40.14 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.92 seconds
Build - Make                  PASS      172.65 seconds
Make Check                    PASS      9.03 seconds
Make Distcheck                PASS      206.44 seconds
Build w/ext ELL - Configure   PASS      7.10 seconds
Build w/ext ELL - Make        PASS      170.74 seconds

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


--===============0310974399126249538==--
