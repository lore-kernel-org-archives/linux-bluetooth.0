Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1136C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 21:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C6961440
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 21:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhENVnp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 17:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhENVnp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 17:43:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71534C06174A
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 14:42:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id i5so300839pgm.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4CVAXjgGAp4LIg7rNZjXXBek4kWxruMx13+pwItoSDM=;
        b=Fze6Fe+uJknlKA4b/k5xbys0h9j2oiws9Zh1rD0ekH/d1YMkdt1LOh0rtiDNhpB/Tc
         b49gHR/5++pfszLRDfdqd8/BEYoxUNCZtRO4x8Ycm9dPzvpWfboFfxPIKNGV/ZIAhWyE
         fxyOVO0IyhM9xyoMZwrAXEdybtyrdKGIS37SYEl/Vbk/yisoU408W+dAH4BozBSfnNKd
         bCUn14t3eWy4MdWO1vggMCwScBb6RIv7/LfhGY30D7znaFMrl7Gajwc1VbEIp+NmDPmB
         108jZOtrNkE/iyEniG7TMqu3OHIfZw2oAdVuM6t3LWBr3NYMIcixQhFpUAbQRuHGe9EF
         k4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4CVAXjgGAp4LIg7rNZjXXBek4kWxruMx13+pwItoSDM=;
        b=uHQWMeXA9zSOnqh25F2ialbSpUeDQUD/VFEHs3zZA637dp0/i4xYMLjuzuAGAM/oFB
         Y6YsSMjPn3C/rAwdhWatTRJ0PoPNtysRV10owvK5m+/nC5R4EdTBa5ibldsngxqvMlK+
         29uuokk/eYjz+1LGCI0sqgfUEn3svc7JtFdTJyHBqeJ+u3cSO3ASZiKI+Im9o7+iX/Ax
         6hldRBQqSlhrjx2pYAoiSJfT2noIG1aP9Sm2QTurEf0ov5S8uq+EE3rNmbzKV/obHiDR
         No9iLMtOoHYdsXc22TUryLUh+Ih19ntwxX4pajhcajEO/tcQinOH9ZGov1GY9sL/mtI/
         D6ow==
X-Gm-Message-State: AOAM532LvxLAL/RYhsRvKiE5wgUu138lTTUBSbeF5OShXJfcRdrGNKoW
        meAGNQ2gzCFvy0b9WvnDbqU/v67X7Mo=
X-Google-Smtp-Source: ABdhPJyM1tsHs0YYhQCjQ3P4FA6jPehH6WxHU0ppY7A3agopDHeF4l+dXE0MnxdYI4uMFE1PfAuHAw==
X-Received: by 2002:a63:515d:: with SMTP id r29mr49108296pgl.422.1621028552698;
        Fri, 14 May 2021 14:42:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.250.122.209])
        by smtp.gmail.com with ESMTPSA id r10sm1341868pjm.20.2021.05.14.14.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 14:42:31 -0700 (PDT)
Message-ID: <609eeec7.1c69fb81.51f46.4576@mx.google.com>
Date:   Fri, 14 May 2021 14:42:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1015906085014395841=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] main.conf: Add option to enable experimental features
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210514211304.17237-1-luiz.dentz@gmail.com>
References: <20210514211304.17237-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1015906085014395841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=482739

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       PASS      0.15 seconds
Prep - Setup ELL              PASS      47.82 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.16 seconds
Build - Make                  PASS      209.60 seconds
Make Check                    PASS      9.27 seconds
Make Distcheck                PASS      242.89 seconds
Build w/ext ELL - Configure   PASS      8.18 seconds
Build w/ext ELL - Make        PASS      196.61 seconds

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


--===============1015906085014395841==--
