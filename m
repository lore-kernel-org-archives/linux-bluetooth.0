Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE08C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 20:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41EC61168
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 20:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhEKUmt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUms (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 16:42:48 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9AC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 13:41:40 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q10so16015098qkc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=z/rC3GsCjPdwe1nJgmGm595ofdZc+n26f7oFgSJHH3E=;
        b=EY6iOSF0WUTefkHv6OaEuC6lca6RPw8p8vTsDZFdL02gAT2h7Hv/5QWZ+w1njpK80q
         4bV3XTBDH5J2cZZMG6lye05FaOXHk7hL2i3UR2Wu1JK3ltg5W3O0RXtrRvmZkacFtYrQ
         HZtXwdnZCME/fbJ3C5vMsJ52cFgt+SsueZCRGYN+XUvqGqCJCIXhEEcHbJfR00WZlQIB
         xVjg3P4srFuqtRmq7ONWOgoQC4vnz4Wfj9t97WBcR4HTbtQ4WlX1lMtrtrnL/Mxz92GT
         l/4aAY09n3VH8mX88IK9mBpO7nnpvVf5nXPL7o+81F203Y3vKvWvXmH9UleztKIagtJQ
         lfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=z/rC3GsCjPdwe1nJgmGm595ofdZc+n26f7oFgSJHH3E=;
        b=ul9w9VIqjhz6v9WQRH5XNWDB4LF8OyhgmoO26/BvOD6UWBWOMOQcL2ucKLSFx/QOOU
         CSR6uWX5gfzYptZJGqJDopIW9S67UhJbPH9tkcXHjeNGJECqNzXnORzj5+CLmS+IdbwQ
         HAWGe18GD3h08QHeTeP1URyXmr43lw25K0MiKtDR717UhrUcJ2GkaWuQqvwS+RmeaEPu
         OE8IDVGOoK7kg8JcwdVdTv40KMUXMO3HUL3bJ/vZluhWexa8ZudSSSRxoTfuDeFemolS
         KahblrKMVjzbsSq8R48Ku3Xi4Ztjrp9GN6/QEVVJ+cfUQX3PdO6V0ofI5Wf3kllhdtc8
         GoNA==
X-Gm-Message-State: AOAM5300Vm3gbkKjtxdYNXrAgBjpTggdYzvAIh4kiC5JnFzyUv3iLCXb
        pVkSNR5bNRZ1V0iChMFh7UvjLm+6/ChfFg==
X-Google-Smtp-Source: ABdhPJw0QSv1lLfEpgwfRykQW0KoCNuNGcwfBvBrYX9jG4TqLy034JYTdYlbV3X+fQUvPd1cdwca6Q==
X-Received: by 2002:a37:270d:: with SMTP id n13mr29357756qkn.146.1620765699631;
        Tue, 11 May 2021 13:41:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.107.143])
        by smtp.gmail.com with ESMTPSA id u186sm7556086qkd.30.2021.05.11.13.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:41:38 -0700 (PDT)
Message-ID: <609aec02.1c69fb81.cfa06.e3b9@mx.google.com>
Date:   Tue, 11 May 2021 13:41:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6850347609220654479=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2,1/2] config: Show error if rst2man not found when manpages are enabled
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210511200843.1741595-1-hj.tedd.an@gmail.com>
References: <20210511200843.1741595-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6850347609220654479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=480695

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       PASS      0.26 seconds
Prep - Setup ELL              PASS      48.35 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.59 seconds
Build - Make                  PASS      206.79 seconds
Make Check                    PASS      9.27 seconds
Make Dist                     PASS      13.27 seconds
Make Dist - Configure         PASS      5.30 seconds
Make Dist - Make              PASS      83.52 seconds
Build w/ext ELL - Configure   PASS      8.53 seconds
Build w/ext ELL - Make        PASS      194.49 seconds

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


--===============6850347609220654479==--
