Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72856C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 10:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DDE611EE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 10:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhEDKni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 06:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhEDKn3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 06:43:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6468AC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 03:42:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h127so2252325pfe.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zqQEcQC3ZYc2GotlisaekCHyCLy/g5U/K0bFe5KGBe4=;
        b=cm70+v6Y5dBRmtY9SsooVdf+4+3LaJ8KGWnTkDYZQRoWw1qo6DKTD2mPjzF61L+5VR
         L/wvLxfogHixK3ERa25GC5WTsxm+kEeW7lu+sO/K7iFdKGL0QSbWvQKY4NSNmKW8LcVD
         TlUMR9Q0ZeuYwTYUy0OVdDSOBIOMZi6oEED4ErB/f9LLbck73lFSZUdyJBzBH8bSs3Ob
         RFzbuBlfLCDMqwvktec9SEcjnQ303netipW6fXrBrnfoq/CUmdbI9s4sT5SVrWsC/Hu7
         1WXpel2NX/KPmcm0TZC946NqeqkHpIvEampdMg8AUSgGbK07IMILvlblEXGLIaPVjRnZ
         /eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zqQEcQC3ZYc2GotlisaekCHyCLy/g5U/K0bFe5KGBe4=;
        b=HZk48QtqDRxrHM97o+iU2F1xb3W1upe98u+LNWUzJUxjxPL0afobQj9P75fbZFlkIt
         z7KNgQO59UnFzmVusUVWMlZiIy3dk5uRjs8Ema7hrtqdcMYpuuWj5Ee1Ddvw+aYDXNtc
         /MbScdKB1XF7i8UWbE+CK6YHaBKU2lvS90l9IYWqLTj/+9HdSH4SD2TcFT6sbyXE/hSn
         c74BYEMUbBirrdU8VqenJhO8kDzPVJi/kfrThxVFdf84Ij9f6XXl8u5Mri8Dh6BIyvsv
         JcdnGXzcE/mGf9sp6mGOauV7fe6MZ4q+D/obvCMlQ6/gXY6XOnbOnPp6ayvw+qOFyZw9
         YcwA==
X-Gm-Message-State: AOAM532HTc10SgonhT6sIlWKO+dFIUSQn2wSni20bnSWytezQakVmfg7
        2QRbqxwzxyiYjPDZnryRuZzQVtSQ6kI=
X-Google-Smtp-Source: ABdhPJzl1ZmL2EarmvLO8Oj/t4Gy7gvEHj0l+yMIbH0HF8ie0PcovHPq8rLK1fp5EIKPvKg2Su3mvA==
X-Received: by 2002:a17:90a:17a2:: with SMTP id q31mr4389507pja.32.1620124952584;
        Tue, 04 May 2021 03:42:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.143.228])
        by smtp.gmail.com with ESMTPSA id c15sm6334816pfo.176.2021.05.04.03.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 03:42:32 -0700 (PDT)
Message-ID: <60912518.1c69fb81.d1102.f77c@mx.google.com>
Date:   Tue, 04 May 2021 03:42:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8104168770994090031=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Subject: RE: [Bluez,v1] btmgmt: Fix enable adding irk when turining privacy on.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210504100835.29468-1-sathish.narasimman@intel.com>
References: <20210504100835.29468-1-sathish.narasimman@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8104168770994090031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476775

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       FAIL      0.14 seconds
Prep - Setup ELL              PASS      52.39 seconds
Build - Prep                  PASS      0.14 seconds
Build - Configure             PASS      9.07 seconds
Build - Make                  PASS      228.63 seconds
Make Check                    PASS      9.52 seconds
Make Dist                     PASS      13.37 seconds
Make Dist - Configure         PASS      5.66 seconds
Make Dist - Make              PASS      92.73 seconds
Build w/ext ELL - Configure   PASS      9.30 seconds
Build w/ext ELL - Make        PASS      215.52 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
btmgmt: Fix enable adding irk when turining privacy on.
1: T3 Title has trailing punctuation (.): "btmgmt: Fix enable adding irk when turining privacy on."


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


--===============8104168770994090031==--
