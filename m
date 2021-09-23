Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDDEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 04:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624636103D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 04:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhIWEB7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 00:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhIWEB5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 00:01:57 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF01C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 21:00:26 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id e5so3158839qvq.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qZeUhL4I6E7TcnMmvzmRl8lJjou3W+XLlx7yODtsB70=;
        b=YZ/5NVW+TUACdPV2QwBFcPb2pkxJA5MOYFxEz49eBGcqHAjfLoE5TPqU36axsJE9Gw
         kel6Fwtxsa5zUr0m6Ca138mNrJElEx4PmJy3qQ21jISv5Vi+DycXDkVq5BiWD5nfBVNR
         y3BL821LG2y3La8njURmTNq/XVcHdhxxYFLUQnQo2dXtEAm1ZUDz+R2lkEz4e+Z3Rw6c
         pZ13EWfFd7j6P1T6qGXADnBEJmugJNId98hg4dIT6ZMRCF28+2hFmveVzoYqcuIW+zgJ
         EEqcNf7MdW+qtjiYWtPPLfWcJr0a6UJmhIU+Aq4zXeHrXMJmwA8aaLMbpnC1UN9GWoOc
         2lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qZeUhL4I6E7TcnMmvzmRl8lJjou3W+XLlx7yODtsB70=;
        b=FFr7vNUmGUVIUjG82BBBsNnK+1KaijIzOnFLPqra/emkKulZxLI2+NneDMeGs1X7jN
         /qcTv4iScdd4pqOLHQEg4Kdwfz5+eX7rgz0tqG5G5yB5/q5bnOAZUiLoUxmfKiqO6uQI
         BkGSzW86227qzuZUx0zPGAr+Ump2GjM3v3I3uYZ0NWqt0azQQ2r73Sq1gLgPixCvqSWm
         rjeyKQ/34A9Im2JIHtU7cK/JqbjuZG6lx2o183PCc9m2VZpRFsfUKxoIxs1D1tpViMoh
         U/ul9UGkYqAjJF9zx2sbDsJyrgXABlHq3TaC+J5vcpciAF+5hW9W/bGOG7NPHnTNVrhO
         Kw2Q==
X-Gm-Message-State: AOAM531RS+UT/LmUZhLge/awcjbH07TVjyVOHDOIr3WbkPu28jfR8taa
        laRjKdGi+HdJ1e0DpOjFyITNY3o0CGoQ0A==
X-Google-Smtp-Source: ABdhPJxN455c4jE4uvG5PWfh9a2wenJitPRIosGI1kY5H3UR/KPoLQe/6ZwsBMiWs6xXaAkwDODjQw==
X-Received: by 2002:ad4:4765:: with SMTP id d5mr2274457qvx.51.1632369625209;
        Wed, 22 Sep 2021 21:00:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.116.202])
        by smtp.gmail.com with ESMTPSA id r139sm3380540qke.84.2021.09.22.21.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 21:00:24 -0700 (PDT)
Message-ID: <614bfbd8.1c69fb81.a75af.a5f5@mx.google.com>
Date:   Wed, 22 Sep 2021 21:00:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8050000670953850281=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Mesh Configuration Database
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210923032603.50536-2-inga.stotland@intel.com>
References: <20210923032603.50536-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8050000670953850281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=551419

---Test result---

Test Summary:
CheckPatch                    PASS      30.23 seconds
GitLint                       FAIL      18.49 seconds
Prep - Setup ELL              PASS      49.39 seconds
Build - Prep                  PASS      0.51 seconds
Build - Configure             PASS      9.05 seconds
Build - Make                  PASS      216.88 seconds
Make Check                    PASS      10.03 seconds
Make Distcheck                PASS      252.94 seconds
Build w/ext ELL - Configure   PASS      9.10 seconds
Build w/ext ELL - Make        PASS      205.82 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,01/20] tools/mesh-cfgclient: Save provisioner info
1: T3 Title has trailing punctuation (.): "This adds "provisioners" property to the config database."

[BlueZ,02/20] tools/mesh-cfgclient: Add timestamp to config database
1: T3 Title has trailing punctuation (.): "This adds timestamp property to the configuration database."

[BlueZ,03/20] tools/mesh-cfgclient: Update stored NetKey and AppKey
1: T3 Title has trailing punctuation (:): "NetKeys:"

[BlueZ,04/20] tools/mesh-cfgclient: Keep track of updated keys
1: T8 Title is too short (3<5): "---"

[BlueZ,05/20] tools/mesh: Add new info to stored remote nodes
1: T3 Title has trailing punctuation (,): "When adding a new remote node into configuration database,"

[BlueZ,12/20] tools/mesh-cfgclient: Rename mesh-db APIs for consistency
1: T8 Title is too short (3<5): "---"

[BlueZ,15/20] tools/mesh-cfgclient: Add group parent address for DB compliance
1: T8 Title is too short (3<5): "---"

[BlueZ,16/20] doc/mesh-api: Add ExportKeys call
1: T3 Title has trailing punctuation (:): "Add description for a new method:"

[BlueZ,20/20] tools/mesh-cfgclient: Export configuration database
1: T3 Title has trailing punctuation (.): "This adds main menu command "export-db"."




---
Regards,
Linux Bluetooth


--===============8050000670953850281==--
