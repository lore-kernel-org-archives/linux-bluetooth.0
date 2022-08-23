Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367CDC28D13
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 00:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiHWA0b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbiHWA03 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 20:26:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322C3DF13
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 17:26:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 67so3739506pfv.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 17:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=A0QyZbAxBfpI2vXEDUBdLSWY2TvEcFNh45BxuZ1zw9E=;
        b=JrGLYayuToV8hhECw2b8YLyNHVf+lIvTDaHcHSST/lD5o5ht98JM4+X92uzECwNwMC
         qI6mgyFOAaEF8QLlhFs/ekpX/2RPe8Sr7XUy49kKHms8advh3VUtMw3D2AeMhHtkbjsr
         k+ojd+1RBzQaw9Re3vjQwz5M9yWieLxfPlwPu+zmNGkf+tb9NdqS6jDUZxLhzLvaFgTh
         neA7iwmbVpmslXpNnperVlHWl9q9YOoN0uC1KXdEnut6+sewywz0uzlrsIEBQ/a3JPjA
         yBWlaH/78kDbCFnLkmV4I0iOZfPnYRRLsvjmKN6Mg4YXT1Ovw8zPcp/DEtfgbDfik+LR
         cuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=A0QyZbAxBfpI2vXEDUBdLSWY2TvEcFNh45BxuZ1zw9E=;
        b=WYWLnFqlLddvQZEgIszm1jdhHAIaUpbAeqIxkGbcgMUb/P+r16hCp/G8nlugdH3XZs
         cWVCYfzKeMLCStD+9OMCnlU7QcTIhG8Ul7Z2ZLI6NEjKxXM47BPhE2lBxEek/HDEuGvq
         l2EfV5JHtTj3twR69dUsDWvaec6qUzaItToBcp6ztryvXqnJ37hoUa7sIDQNRTkSLhfX
         4bspNbAdSHEg9mhNDle4Cs6A0upHPLfA3Etzp/E0GvgcojiS5AsBI/yNmaUFUTG1uBZr
         F01CIixEUyNTg7ExZHgbucCT+A6q9bpBMpsq9hFC4VNtaYXi8QLqHKOpXAcZowVSfEnq
         s+Jg==
X-Gm-Message-State: ACgBeo3wZLiI4rxKaHvSPdW1DP9Kmtdavy8gB5SBH2AC2LB4SYko+mKG
        FCx5Qi3R+2+ZupYeK1nH5+8HFTuJy9ctog==
X-Google-Smtp-Source: AA6agR6MZqTZ3jBzdzCU8w8hkUdFVROxh6JKmoyXg41CcIkWuRMloPN90XIWMbGDKM/4x6Wt3NQ1aA==
X-Received: by 2002:a63:4621:0:b0:429:f162:555e with SMTP id t33-20020a634621000000b00429f162555emr18343996pga.63.1661214388509;
        Mon, 22 Aug 2022 17:26:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.237.211.179])
        by smtp.gmail.com with ESMTPSA id v1-20020a622f01000000b0052e5bb18a41sm9189794pfv.58.2022.08.22.17.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 17:26:28 -0700 (PDT)
Message-ID: <63041eb4.620a0220.695b6.05c6@mx.google.com>
Date:   Mon, 22 Aug 2022 17:26:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1481218627209619478=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ronan@rjp.ie
Subject: RE: [BlueZ,v2] zsh: drop no more arguments message
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220822231909.45606-1-ronan@rjp.ie>
References: <20220822231909.45606-1-ronan@rjp.ie>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1481218627209619478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=669941

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.46 seconds
Prep - Setup ELL              PASS      33.11 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      10.55 seconds
Build - Make                  PASS      953.56 seconds
Make Check                    PASS      12.72 seconds
Make Check w/Valgrind         PASS      343.01 seconds
Make Distcheck                PASS      293.02 seconds
Build w/ext ELL - Configure   PASS      10.52 seconds
Build w/ext ELL - Make        PASS      98.24 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      594.20 seconds



---
Regards,
Linux Bluetooth


--===============1481218627209619478==--
