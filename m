Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F3C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 03:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8560F61370
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 03:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhELDVV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 23:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhELDVV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 23:21:21 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4ACC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 20:20:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id v4so7493706qtp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 20:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3iJcxHytO3ojEUlx8phaPgRKYMHTPtKtw5i20aBOdR8=;
        b=Q6tCvtdU2oBSXNBMfwQrL3jSotzYC+l89wRLwyQGi/+THEbZadOO2b2mRgEwOnghxc
         SMke7ngSnDivJp0T8JmGQUMn954T+sMnRY2VZhVKUkZdYISdmWWgFrK3/YbfCqFViPo+
         wwWRM1szHelhdekLfXuu7KKN3f5k1tZkAf5+AOEyJaT9JrehC+8gm4k6Lr7Rarm2Y5KA
         IbP4vItkRRHWF1ukhsIcHHRt03caGcJeyRijL99YZI+BfS5uDuPhgF62bKIejxvh4MCP
         uB+krUSucwoT86RRclOccQjiw+62lbmrJX0VflT1XVonT38/b67pU9AR6J2LB3BbNbQe
         uDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3iJcxHytO3ojEUlx8phaPgRKYMHTPtKtw5i20aBOdR8=;
        b=pMqx4pZ0f3VPijycdOaGGJ7geSrbRrxILXu/d2fqWGaPm/b2wT4XciiH+aEf0K9Qpg
         N5M+XTiE4+5JJjhHhQ1kjIBe0Hn4l/CgW5Jzudp/nD7HmDHVET35qZO8TLV47rkuzKFO
         ZnveRTDiLxa+rIfw/Oxgh9dApd97/TqUWW8VF8grAE63dijK7/vLw14AOTh3leoW2Nc9
         up0UUSQE3m9Z/XR1jq8ZYTJCKb4ylkO2OC68Pd0eIhs+Jb2Al5CFvxurz7yr0O/klWyr
         6Y5OQOGSMLiAaf4P8VQ062imVmI3u+qz1e4hxolSjr8p8PelJWuOawzbX9+MoJjrAsnd
         IIhA==
X-Gm-Message-State: AOAM533ZdZGmoyhC3T/kJntkAVFrDrC4ylOw9CuSfmXhOUozpuKXZJgq
        Y5Ggo0QbDxdMHJsOJSzQEOeHjU72nT8=
X-Google-Smtp-Source: ABdhPJyqvQZo/80lvE2sCFaGVirDzUEeBEpCYw82PS3eNVE2yNxTw2JElM1XQ4XkFg4Lqh07AcVtAg==
X-Received: by 2002:ac8:e83:: with SMTP id v3mr30703149qti.25.1620789609432;
        Tue, 11 May 2021 20:20:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.230.177])
        by smtp.gmail.com with ESMTPSA id s190sm15357846qkc.40.2021.05.11.20.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:20:08 -0700 (PDT)
Message-ID: <609b4968.1c69fb81.acc3d.d4b6@mx.google.com>
Date:   Tue, 11 May 2021 20:20:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4893084229920351428=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v2] monitor: Fix possible crash of rfcomm packet
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210512103550.Bluez.v2.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
References: <20210512103550.Bluez.v2.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4893084229920351428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480831

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.13 seconds
Prep - Setup ELL              PASS      49.08 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      8.39 seconds
Build - Make                  PASS      215.02 seconds
Make Check                    PASS      9.33 seconds
Make Dist                     PASS      12.62 seconds
Make Dist - Configure         PASS      5.15 seconds
Make Dist - Make              PASS      87.51 seconds
Build w/ext ELL - Configure   PASS      8.44 seconds
Build w/ext ELL - Make        PASS      201.74 seconds

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


--===============4893084229920351428==--
