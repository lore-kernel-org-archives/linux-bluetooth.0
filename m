Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D191C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Apr 2021 00:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE54361042
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Apr 2021 00:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhDTAEO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 20:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhDTAEO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 20:04:14 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B58C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 17:03:42 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i9so17622732qvo.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 17:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3lwAxq6XQePx0q9t6G07yAFzea9OjjNcxWPHQaqsYv0=;
        b=AlIyLKucAZW6pon3Hu5+qYToa3PraC+UwUv71nP9/l8HMIGxzvcX52AEoSceaiU5ly
         0dBwe1loIwUtz7U/EwvrtmbcZLclRvGmpp80S1uMeaLl6mMNS2VB1BzGJ3f7a/vjq/Lr
         +2ggsLqaZPnUuJEJJSge+8/YXb02rc/FOvWbnN5eitM1Jp3OXHrJ+yQh/PSi+MSmTavj
         HYwBxBH0wR7JErIFAQwD4vDmw9IkqMz/J+gmlNL9ydhXqcJ5o+qSZa5oX71yo+whj+KJ
         0dEfnmW/j+CsLkVcBpJ4WPXNJJoeCcxBnAvwxhAahrL4aynxv1SjQJfvI7KcRXidy68g
         VQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3lwAxq6XQePx0q9t6G07yAFzea9OjjNcxWPHQaqsYv0=;
        b=aEwtGE8BhJ9aFbe3mn6mbaF73XZfIlBGYDXekx8wrsfrYFZTdE3UyOc0zlvdpR0DaJ
         DSItzZhEsYLFlAAIoH9nnKRbVsqUvqDt+c1fRN/mVOLl38RLyg7ZypQDp/b//KnZHavZ
         NzDkyYV6cbY7y6ozMyccXq/yW+Qev+rjMhowMYpvLPt0x0wfpdAsa5zUnntyr91u3Bl5
         GOXeMD8k9Vw4Yn75XAhXilAmS1uYjZvZtnOgOK/6ULf9dlkouoVPcwDLe+XJ79j0RhpE
         IOVMFfK7LSIWPxoKgIU+gXBLVflWdOWOBZH1DM7MaDsOD8Z4bn62MytCrgeqhSnJOIHz
         eH3Q==
X-Gm-Message-State: AOAM531PmIlv+GR2wewXDSiM02erumtGb8pOxkLoalY7ov9Y4VABv456
        re+NJrDx8+KI6M+ixu0COMutmVKvsWU=
X-Google-Smtp-Source: ABdhPJyZAxNryRCO5jBtxHwUISxZx9Sr15nRv4hI0EFy2BjwJGxyWRSqdyfQNQQdHul9jIqkz+yMuw==
X-Received: by 2002:a0c:a9c5:: with SMTP id c5mr23988285qvb.6.1618877021513;
        Mon, 19 Apr 2021 17:03:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.85.242])
        by smtp.gmail.com with ESMTPSA id 132sm10877793qkn.52.2021.04.19.17.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:03:40 -0700 (PDT)
Message-ID: <607e1a5c.1c69fb81.2a37f.8f69@mx.google.com>
Date:   Mon, 19 Apr 2021 17:03:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5651690251194818838=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1] device: Reply to connect request if SDP search failed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210419163518.BlueZ.v1.1.Id327043128b54d359c7ad4bf44ec21179c7d3213@changeid>
References: <20210419163518.BlueZ.v1.1.Id327043128b54d359c7ad4bf44ec21179c7d3213@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5651690251194818838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=469903

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      44.34 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.74 seconds
Build - Make                  PASS      184.91 seconds
Make Check                    PASS      8.96 seconds
Make Dist                     PASS      11.44 seconds
Make Dist - Configure         PASS      4.77 seconds
Make Dist - Make              PASS      76.05 seconds
Build w/ext ELL - Configure   PASS      7.68 seconds
Build w/ext ELL - Make        PASS      176.90 seconds

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


--===============5651690251194818838==--
