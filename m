Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60148C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 18:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B98C61263
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 18:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhEQSJv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 14:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEQSJu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 14:09:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49800C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 11:08:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s19so3262008pfe.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ZPESsCqLvFLM4hGUUoT8c2jdpkRUSkkTI3LNQDkh3ik=;
        b=RdtQt5U4KjLRFiFVd5BjV185EUozZVU6bqg0/KBJNhrUnWZ3TG80y4ltKvPBEWwkOT
         UVEsdHhSKV7fSU0onduhHOyysRTy5TNBQci6uZeaS2XhxqrcgZVlgc9dBmD3+AaqYD/z
         JAFdidX0gp38awnNrmJoUD9IFYPeebasyPyYEJCAJ1cX//xrmY88ClUvX0wfwDkCwXEv
         FJNKL7LOj3/JwUlCLB2wtiZ+HXtixg2otdjuGMyAifE7e3gT28JSMvdqdwV7XiHmppIP
         u+WrPvVbWRisgiquZH/DGlGK6TfX1364Dd6OxXL24rYYabUamEy/t97B1f7O6/UBbbge
         wX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ZPESsCqLvFLM4hGUUoT8c2jdpkRUSkkTI3LNQDkh3ik=;
        b=SWuovslrxJohdWdkceN4GanLsZz5kvqmvM0YYZ1vxBTaBwoKqwvJgtzRf6Is4QW4o0
         LgPA/zWeev2/hReXtCxzMjgkSzz21bQFpbqT4LthNFeNYOX/plcSLek5FfDAqonqDpN3
         d3vz0mM6xW1p2zy2/CR3pALJz6WRi7Q1wVaV58Vxs7LzvuU19J7k1JnCm1uN47sfY2Sa
         u9+nYPrQVroDz+nDCJAP6LcSfCHGx2A/KJvwIfPYVCG58wRBELE7FgSmSX9jfAaKjEuW
         qPWN9FFIBYFwjBKigJMWDr5HSuHSOPi+ave6yoPH/1hOqAtwJz/jDTje/z2nmmLkarbR
         qWkQ==
X-Gm-Message-State: AOAM533cOmT6VWA8D8CwXH5u0xpr9pGt1gAsQae4WJ5XK4uLa14BrSZe
        e2AsnsHMR5sLqyc+UFdnjLQ+LpEGdw8=
X-Google-Smtp-Source: ABdhPJxPCOfeQCQryYEnIhGg6FG0dZYdUEGcUcAk0WKJ1h6ju1yO3Iq3z7mKQEhhYC7xuK/1es0fhQ==
X-Received: by 2002:a63:5910:: with SMTP id n16mr742996pgb.351.1621274912461;
        Mon, 17 May 2021 11:08:32 -0700 (PDT)
Received: from [172.17.0.2] ([52.151.32.239])
        by smtp.gmail.com with ESMTPSA id k15sm10697327pfi.0.2021.05.17.11.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:08:31 -0700 (PDT)
Message-ID: <60a2b11f.1c69fb81.417b9.3edb@mx.google.com>
Date:   Mon, 17 May 2021 11:08:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5097365220212944014=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btdev: Add support for Add/Remove White List
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210517173906.575688-1-luiz.dentz@gmail.com>
References: <20210517173906.575688-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5097365220212944014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=483813

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.15 seconds
Prep - Setup ELL              PASS      52.50 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      9.32 seconds
Build - Make                  PASS      222.28 seconds
Make Check                    PASS      9.22 seconds
Make Distcheck                PASS      262.69 seconds
Build w/ext ELL - Configure   PASS      9.43 seconds
Build w/ext ELL - Make        PASS      209.08 seconds

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


--===============5097365220212944014==--
