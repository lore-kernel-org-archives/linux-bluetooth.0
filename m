Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAE1C19F2C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 05:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiHPFNr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 01:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiHPFNZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 01:13:25 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BFB32A86
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 14:27:28 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w197so9932508oie.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=b+ccsExr1Sz2kB+WMdV/H1H4kJFG+EUvyw8nerekgFs=;
        b=abRSv0Gf5AZmPOgjELv2/z17XGRBhK7kvjzzZN4fsYnA7reLz1+2G/ef9Pnykuerp+
         rWrNIxTMpehTYPD+DXgm41vA7lNNJr61M/7G9SuUXPxVDWK+AGrhkhLUNZbpQ+75uIlz
         cC3iPxab9b4kLGwVcTr5viTSBBlVJ/xROnVdzxvlXOI4ceLD7JqN9JbWNJI7Qqpo7uFe
         r5jKo9Q7Zc5iE2UzMHMJq+OQlgZhranFNVMcb6ZrVzWoveEBMOc9q+7zoyx6Q1KeHVPL
         v5DUnq7JqZUwrondwsXjs5/21/uy8Co4yWBm4RtbpOTQ2BXhE1ljTpXucjiogrqYG6a4
         ccKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=b+ccsExr1Sz2kB+WMdV/H1H4kJFG+EUvyw8nerekgFs=;
        b=FkbPkDmo+4CVyEhdBWDiqUdzjNjFNnC7Usj4+jz5+EV9S7Onzbd+P+4iKpSOeZgDQ+
         1180hN+Js3a/yAyv/8s2t4ikrZUdG8hJ12H5Cbp59X53iWs7oNvU69umMxRZKF4/JroQ
         n16Y1EvqfMP9RdT26rqomN34Jcxa6sNtp1xNCX8/Rtg6Xc4ykr6Dxss7oqVjxVU/XUV2
         OuLDmSu0ZZN2OHLw+qgaOcrTESHjEst2v9VVvYPHXGs2IXayZM4enk7RP+cF3OJgqCjO
         wJ184U2E5NuBEMrtq6FiO3tn5nVPP6lPD/CzDn06YLe2RN+BCsKIoFoh2nzE8m0+t3I/
         ODJQ==
X-Gm-Message-State: ACgBeo0P7LYaRQx+hk80Q3NVx+KdQ/e2D1+i3sQoYJSByd1KxlxR9pzL
        bHGnOB8zDYQJkuueHc8VfggUaSv+KSPZ9A==
X-Google-Smtp-Source: AA6agR5rDUpWuBufo9zSdONWvEMo8zPtR7a4K156pv1fPb8lpEemK8mxoVGM3VHMl3efBgkP8mmY8A==
X-Received: by 2002:a05:6808:1718:b0:333:5794:5572 with SMTP id bc24-20020a056808171800b0033357945572mr7293426oib.115.1660598847589;
        Mon, 15 Aug 2022 14:27:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.194.200])
        by smtp.gmail.com with ESMTPSA id o6-20020a056870524600b0010e3cb4c98fsm1660088oai.9.2022.08.15.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:27:27 -0700 (PDT)
Message-ID: <62faba3f.050a0220.81d20.5879@mx.google.com>
Date:   Mon, 15 Aug 2022 14:27:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0299842066673625039=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] iso-tester: Introduce tests for Disconnect/Reconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220815190401.1176081-1-luiz.dentz@gmail.com>
References: <20220815190401.1176081-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0299842066673625039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667762

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.71 seconds
Prep - Setup ELL              PASS      32.82 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      10.46 seconds
Build - Make                  PASS      962.41 seconds
Make Check                    PASS      13.13 seconds
Make Check w/Valgrind         PASS      342.14 seconds
Make Distcheck                PASS      289.07 seconds
Build w/ext ELL - Configure   PASS      10.59 seconds
Build w/ext ELL - Make        PASS      98.66 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      582.45 seconds



---
Regards,
Linux Bluetooth


--===============0299842066673625039==--
