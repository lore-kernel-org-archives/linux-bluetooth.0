Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA7CC4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA423B27
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgLRThs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgLRThs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 14:37:48 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF91BC0617A7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 11:37:07 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id h4so3109047qkk.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 11:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SZ0HEMSCZUQDFLb0hwx9RPSk8Q1IrDcJEcxdVBXefBg=;
        b=P3Mf3w/v/X4Kg1RwNEV7AU1ZEiplFHC4TPcN02QazYiEjPHJMiMgG291d1pYDUA3SW
         W4mN8A9L6C0taRP7FeV4yfhDOkID+gr6mntMLx8V64bvSYuefJV8/oSHi/Z4T+MHLGkM
         ii7yZkYsW+7c1ZnACCH57UK5wT02UjMsiDATC7v/rqa6w19Nq/Q0am1BNXH6wNGN5wJY
         ZVxK97q4+Wf64wY/3iVXg7jNGIfn8ANhI+cYvX2wMOfp3HfwHhHFqLkgP28sqCFC1R7e
         gnmlhrmkWcEGbwV1Rr+WE4kTA2yyFR4ZAbwOJMqSeQ/E1pLhwmlTRvCXJFRGUmQLt2Y6
         OhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SZ0HEMSCZUQDFLb0hwx9RPSk8Q1IrDcJEcxdVBXefBg=;
        b=ldfHNmbePds+/UZo+b+WtYk3l63NPOO+bTBteDjjnLY1zfJEfFwZL5qn++4yt2XZBZ
         Tjkm9iGts2FBUawywstHF2EYbyrYaFteaXVFprawYY7u8h1n8CHKZg0DofhmxVMCRP80
         Q74y5BzT18epenlouW2b7uoGS9tcNuD+J3cymV/U8TfNJSmQz6wgQG2K2yq4M0tDE4mt
         uDkp4JAv7MX1Jd1jiDHt4q9LKTxgDgPtfyBkxHKfuERICMGNkh9VjDCYA7DE20nMQe2v
         t/bCx7skEafbhxj8hg7y3zzTMTTVoML9nnrWv1XZJL2GH/ud+QXkJIw9blHlaGVH+LZz
         F+uA==
X-Gm-Message-State: AOAM5333xzMarAQSeT8f1QuGgOJ0TLEwN4xbwUF08iszei+8/wL7QgEH
        +HoUur+7/wQmeFPS19Xlh9F/LaOL8SpsJA==
X-Google-Smtp-Source: ABdhPJwsBNnpFlb1b9N1srProMR11q5BrtMPkKrNii/czA9XY0DIkdlXe1SnCpv9jdi1tRuSV27E5g==
X-Received: by 2002:a37:50c:: with SMTP id 12mr6131487qkf.296.1608320226771;
        Fri, 18 Dec 2020 11:37:06 -0800 (PST)
Received: from [172.17.0.2] ([20.186.75.132])
        by smtp.gmail.com with ESMTPSA id v5sm6258161qkv.64.2020.12.18.11.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:37:06 -0800 (PST)
Message-ID: <5fdd04e2.1c69fb81.e4607.86b4@mx.google.com>
Date:   Fri, 18 Dec 2020 11:37:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0639952559104871859=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dave.jones@canonical.com
Subject: RE: Support patches for Raspberry Pi boards
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201218190609.107898-2-dave.jones@canonical.com>
References: <20201218190609.107898-2-dave.jones@canonical.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0639952559104871859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=404253

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


--===============0639952559104871859==--
