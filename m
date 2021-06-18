Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A8C49361
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 05:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D9161220
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 05:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhFRFm7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 01:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhFRFm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 01:42:57 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908DFC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 22:40:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q16so8117578qkm.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 22:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dOXybcFN79TMe2B8ZtNwE7YVplmC1vBnQj+wKn57jwg=;
        b=QZ5SURxUSyu0aR/BeKxn+ugt5WGWfG7gU2LhEvDuIioFTdRzdvgZL69ps2tKmHjwpM
         SOdfGSvfq+huqmycFv7U32RMcMOu9MeXlj5h/bzODSkqumZdpvk7UJFXDToLskNdmA5N
         753Dr1QRbqCHAD9oUlqU6gYn4t18ibvZ6LBRlyTBxQ98gsCMqerDwteqOF56m8YlkZiZ
         xaPxlSu+PimO4alj5OVa0sFCb200n3/J1A3lixrqfZEq4iDXEhzAV4jTkwDeQdJaiwBN
         aPnrLoA7BicGXqx4EKVY+WU/J+i4H4zzCFgQMCGeraXNy+setdmgV1nfvHlqk5u3dVoT
         3pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dOXybcFN79TMe2B8ZtNwE7YVplmC1vBnQj+wKn57jwg=;
        b=XUzMfb1YhEuuXk7GUJKXMb13Vq57M4T9qfAe2hw5LhPNQdf7eNFQX/kvuw8Qr1Q7aJ
         HuhGIMJdDx4enZdyNvWZt2uCMytaW0QhUaQ1ggyfdnCLtCDe3a5YS2F5de4CJ+cMvx3X
         TTN0nXUa8ZrZ3gHeqfJg6peqCri2LpcFAoOabmyjKaAizfydB693udQJ6I8nh7oBoPNR
         txGU79qqf5kGj8MCFs7mvqm8uTM2dcjuZjkq765hMI3GTN8tP7jxZ2ZDupwv4zC3I4qn
         N/xknPxLw0WADgDsJL7ztPJ977iTxHl2aoAeZeMyOYI19YCN/k1TKBMkH/qb06hESS/U
         vQZQ==
X-Gm-Message-State: AOAM533yxqvC4y1BFtJwIjr7iz96LSlKwTJxFWYjBVMx+lJ3XDAQ9oWq
        YfRXUnuZ9DYjyztau+cfGrGvYFmTiRaaIw==
X-Google-Smtp-Source: ABdhPJwkCq59pfXLoH1MUTokCncWZOUORgKLr39VGEUhidvHeNrHm9bJhZx+S+o0MZXB6IGMSmXxRQ==
X-Received: by 2002:a05:620a:15d0:: with SMTP id o16mr7648823qkm.236.1623994847508;
        Thu, 17 Jun 2021 22:40:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.1.29])
        by smtp.gmail.com with ESMTPSA id h12sm4733372qtn.44.2021.06.17.22.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 22:40:47 -0700 (PDT)
Message-ID: <60cc31df.1c69fb81.61f2f.1ba1@mx.google.com>
Date:   Thu, 17 Jun 2021 22:40:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6815047227684567483=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v1] adv_monitor: Avoid skipping non-discoverable dev on Monitor match
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210617215758.BlueZ.v1.1.Iaf42bf6ccbc1a06a9fb7f8da55bf7f2ef37349f2@changeid>
References: <20210617215758.BlueZ.v1.1.Iaf42bf6ccbc1a06a9fb7f8da55bf7f2ef37349f2@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6815047227684567483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=502943

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.15 seconds
Prep - Setup ELL              PASS      47.36 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.29 seconds
Build - Make                  PASS      203.05 seconds
Make Check                    PASS      8.86 seconds
Make Distcheck                PASS      243.32 seconds
Build w/ext ELL - Configure   PASS      8.30 seconds
Build w/ext ELL - Make        PASS      191.56 seconds

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


--===============6815047227684567483==--
