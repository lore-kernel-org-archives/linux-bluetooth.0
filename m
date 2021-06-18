Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33178C49EA2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 17:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C913613ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 17:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhFRRyT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 13:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhFRRyT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 13:54:19 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC7C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 10:52:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r20so8189232qtp.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SAegdqWLp5gwmKZ7VFYtEsPwyb+4mtbHdZXFETu3mqU=;
        b=l5qHd3vqKgwq9O5A4nXqas+6K0HEPxHn8JO3zn3W7yV8gc4CneQUNK9cGLT703RNBY
         lq+73d6YnE4X13vSvGfVSzbFjWmaI4hS5S5yRJu/nqwzwfdm0ZULxHWvXx2CoYMARVAk
         loKGAI7VeXoIQkadp++eTfiqpZi85KlNvf4R28mxghFA/KS2wWWAT20L7P4FJtphEIp7
         HCJHZCuVhzw8i6u4M/lS0VPUI2IeQl9qJ+qZ0DeWsKDtuiNXhJnx3xNqp/TveeoQH1cJ
         GQfwLKwL8UZUu0UhtFvq78ejUsxgLCEQAhdCwbmEGa7wpZo8rO1Mj1LvOcMmecdsHGiP
         x6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SAegdqWLp5gwmKZ7VFYtEsPwyb+4mtbHdZXFETu3mqU=;
        b=Xe3dUzxxWE2mb4+Xt2bMcflLrabofVoj8zIYUuQY5raXKkrf+jNDWTANHbhCU4+ltx
         hxOwnOapmFGlbkpMUpPBVfd1PwIgzyCqp+yCOuuiSiv/oLHfolHNQG7PkbyPaNMaWhnH
         43UYCrbRaP4vNzrCgDzKAybv8w0BM/odgloWi0eiSs/bou0LNNc5mty2FUhrkmgiOsOQ
         4NXXtju8s9gWxA+Rt3Mj/WvS9oGXmXnYVtxjNMXBp+tcxADYsLTkIFP66YwUTbSVl23Y
         8thXp3LCJl8YTM6cH8HFZqN+PgkFMIhfJ9gum02B4t7dP044I6f8pt7kaYHofoItRq8u
         X8YA==
X-Gm-Message-State: AOAM53059a/UDxoLyEXLqr+CxEW65d1sVjX4xWtlZFX9P7FSxd8pHI4l
        mB9bp1XfHlKPn/MekF+eOlInciba4afCJQ==
X-Google-Smtp-Source: ABdhPJwMnn9qBASrxZqBlLIdRJzyMhXbHDDMhrA8X6DH+foI+aQ9fNVvCu1eGqijnk9becbVbBZz9w==
X-Received: by 2002:ac8:5a56:: with SMTP id o22mr11878586qta.10.1624038727740;
        Fri, 18 Jun 2021 10:52:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.21.88])
        by smtp.gmail.com with ESMTPSA id q184sm3700426qkd.35.2021.06.18.10.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:52:07 -0700 (PDT)
Message-ID: <60ccdd47.1c69fb81.5cb52.96dd@mx.google.com>
Date:   Fri, 18 Jun 2021 10:52:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0341045510751336276=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Fix enabling temporary timer when TemporaryTimeout=0
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210618171301.2285511-1-luiz.dentz@gmail.com>
References: <20210618171301.2285511-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0341045510751336276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=503457

---Test result---

Test Summary:
CheckPatch                    PASS      0.37 seconds
GitLint                       PASS      0.15 seconds
Prep - Setup ELL              PASS      50.72 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.80 seconds
Build - Make                  PASS      219.47 seconds
Make Check                    PASS      9.61 seconds
Make Distcheck                PASS      263.52 seconds
Build w/ext ELL - Configure   PASS      8.77 seconds
Build w/ext ELL - Make        PASS      204.11 seconds

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


--===============0341045510751336276==--
