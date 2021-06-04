Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5828C4743D
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 22:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B04610E7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 22:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDWdD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 18:33:03 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]:38758 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFDWdC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 18:33:02 -0400
Received: by mail-qv1-f43.google.com with SMTP id d7so3494744qvo.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Hb3WunFysWmvTO7JCfsM7UO3FzfGbUOClsLHFTS9sio=;
        b=FKxFzqfe8fTYDx9SwRPl6Xp2YVZSZUvvC8oxwJHrdRTHp3tkvnYljbXENhxam9lc+w
         d1w2rmlkQBOz6YsDS6tFnfZD7C8bLk693arq1ofmgI4qzlLDiJgNlMMtu3LLuq8znbeA
         corF6LizrMffLg28ajeeoaj1lV2ezx7kT8EvTc302O6U9OtKKjeg4dzan9X4KKa5PqFZ
         EnbXyGz65zaICcZEozjwc8wy8SfGPkd7uu82W82VeJmHEdyCLzw6ug7FhlsLy/O4deY1
         O46LxUfUy//OdkYlhh9Gv7TOgThbz3to8l7rdel0dSBDXH4Rq6F9N0l4CNzqKjNNVj1z
         IGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Hb3WunFysWmvTO7JCfsM7UO3FzfGbUOClsLHFTS9sio=;
        b=eyL7RAtiRrbi5CHiXA8flPWN+2iDYvZs9FsBLIcuadxvzTK6nXG9y1iKnTdnDYVrRy
         2KCwr+HbAhsG4KNsFuPF1KQ2w6sGiao7ivbCRIJgC5DDXEMtN00PFrlfkq/OrLfIPDN6
         Io+96CslCs+KAWuG2srEmo4okBh0G77xk0QOpFoNKTphI6D0BS5CoaLNkqUKTJlaPLdu
         l+Reb3X0dJxBzcrinCEzj4wH8JLOPxczaTvsfwWoX4dVeaxFeTEldKkfFBIIPlB5/C/a
         GZoEiUyq7LbrA14tId/q+gXXJq6WRPFXWuZkY0MYqmViNGWpM+QL1vvLX+i1dvEfx5Nh
         MW0g==
X-Gm-Message-State: AOAM533VeWcYDQOA4t25QBdHtuQff/ae0hPSNyU25J+o9P9VP1/cHAP3
        QrZpmW63CmjK39qFXNSowOWyoUJk3+YmHA==
X-Google-Smtp-Source: ABdhPJz68KmXHlCXG0i7U2RQMrqi2Xfs7D20ujawxbI7AOb9rsiVKETnxAidMbxHCjK5oz2RtEmTKw==
X-Received: by 2002:ad4:4ea8:: with SMTP id ed8mr7148320qvb.58.1622845815160;
        Fri, 04 Jun 2021 15:30:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.214.113])
        by smtp.gmail.com with ESMTPSA id b132sm1654690qkg.116.2021.06.04.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 15:30:14 -0700 (PDT)
Message-ID: <60baa976.1c69fb81.61be7.c064@mx.google.com>
Date:   Fri, 04 Jun 2021 15:30:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2521439640749567990=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/mgmt: Fix not processing request queue
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210604213326.1724684-1-luiz.dentz@gmail.com>
References: <20210604213326.1724684-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2521439640749567990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=494413

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      41.28 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.16 seconds
Build - Make                  PASS      177.22 seconds
Make Check                    PASS      9.35 seconds
Make Distcheck                PASS      210.08 seconds
Build w/ext ELL - Configure   PASS      7.25 seconds
Build w/ext ELL - Make        PASS      166.83 seconds

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


--===============2521439640749567990==--
