Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657BE64EDB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhCCNME (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 08:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhCBXwF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Mar 2021 18:52:05 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E69C0611C1
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Mar 2021 15:37:25 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l132so21041517qke.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Mar 2021 15:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XBRpgES3EiaXfjH5yojAI5ozBk9GLVFhYfUc6vKywoI=;
        b=vYFkFdpRef1w8FAPIxmJu718iz21SbaFiqwIxAFUTSfDh9IPgPCBnPtgmarIgtOXaa
         juh08zK0FB8UrhWXS0IZC30WSBLkSdPFiwdKXbZ33NRFBZrcJW9N4NmU4gPvFqJck7IV
         t0m6G7f2j9mAvnwCe+EI34F/JddvfJEBGxOvnzB2FogrDpqTpmhktjjNqImnAL0kqDIe
         MpT2LLMVMvlUYHcw7PSC/HCn86pBnLcHrldU3O6Bsxjy99gScdS/l5FkE/0h1DEZ/v+4
         2zfv0QQEWn3yf3VG3xdSdXJJ8Kc8DRtK9hmiXTlDWDi/EnzKyTNzUayVga3adsraAeTu
         BEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XBRpgES3EiaXfjH5yojAI5ozBk9GLVFhYfUc6vKywoI=;
        b=ZqMrGYHKGT0cROrDkU1yZlMbNA7JWe7yXq7YepITqwEbpv5M7TQaq9I3T4sEd0VGOI
         9X7IK3KLciKtYTPBWSYCuavxSoJHKBAi0kFJMviAZK+ozjH/JAjm4BXfvyRPkRrImX+G
         SKFNDSa+ZG9yshOpt760lbpVztQ0ZHtT1EPoBjHFPKo2zogn+JjRKMAr9L4d+yMyhPSD
         CcQblwEh6Rpqzek3B0u2jdCDcW4sEJKsXjAn0oO1JW9HcTb13aYCMi5Fll7zlhNrUEuI
         ZG9L/GlcygFGbyoJ3RzydsU3Gy3fyfNG5YE9FAD5f1IA6EEbM3MMvyAYC/mPcN4HA62h
         xMuw==
X-Gm-Message-State: AOAM532NJpn5cgODIK/mkKbj30N80ox/fnfQMmW3VnvaxVcFlzfRnW2X
        Qe+bUxvs3TUsf78IhqeRHDyW6l+SDz1v0Q==
X-Google-Smtp-Source: ABdhPJzE5mYTmFmh2bK3WD8UoIKQtLti87zshspjkkYmqbG5MoHJqW5WfW9eoaNU6UAdma97aRJE5w==
X-Received: by 2002:a37:500b:: with SMTP id e11mr8056928qkb.56.1614728244099;
        Tue, 02 Mar 2021 15:37:24 -0800 (PST)
Received: from [172.17.0.2] ([52.252.5.67])
        by smtp.gmail.com with ESMTPSA id f27sm9985716qkh.118.2021.03.02.15.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 15:37:23 -0800 (PST)
Message-ID: <603ecc33.1c69fb81.2476e.f93a@mx.google.com>
Date:   Tue, 02 Mar 2021 15:37:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8621375222264430279=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v4] monitor: Add option to set fallback width
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210302004019.7150-1-sonnysasaka@chromium.org>
References: <20210302004019.7150-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8621375222264430279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=440755

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8621375222264430279==--
