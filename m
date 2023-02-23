Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF3FC64ED8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBWUkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBWUkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 15:40:19 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595B14E84
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 12:40:18 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z6so611856qtv.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 12:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677184817;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RDm6ZpK/3LZ9nGPKqWWkmSvRJDY6aTZ68vXPZ7pju9M=;
        b=mfbOnI76QZRWn8dKeayNL7M80NWgGuXw/d5Q+DJF8jyI1vVhVluXYWxnho4zcOuYs+
         mbAoNKZUjsWQk3D8bpwNdTCPcE8RrzGNT1ruU6a+agnr9GApxsXwraLCfLRK0zrPJc1X
         a95+sRDmZNI30aYjfslGH0QO8fnA2WQWNFRBWFIqGg92erdrS6CfU0jfPtMMs76ADYWP
         N4hl0o5Keb2DxdcVZYhcpeVt3coxamyLOXNSCCu4iSpCPDZFNyIfCeuG+06NpYfz5sO5
         tpQ63y1fkg8WZaopL6W9OyjH06ppbD4ZMld/QQoUuFTmWp8ZqfV/ZYfsXmiM0fXGQdEK
         EDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677184817;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDm6ZpK/3LZ9nGPKqWWkmSvRJDY6aTZ68vXPZ7pju9M=;
        b=fSDXUXsMFerjkxH+B47hp1U/rSJiucRr3ncmo0HpxaZpSVLvH2/EbPEyqFfVhX7Juy
         Qz4mAzCsl46WMGmmH3/A0qPtWDZY9TZsOjgN+h+EmQ+8MXd+eb0eiSsxlxa/Bwp5UHl9
         K+gm1lHd26udFILChItGbfRsM/a0yYqENFq6uXOPk2g+Thl4XQdDzprRDS5qF8ftfzSE
         ys5Fk3ebSSK5VHa2guW0YuEoEzvIsXA0YH8z+/SWf2fbUKyIJ4kMJpdaXVByOvekAUem
         tQyTvRqxg/Yrf60M4GlST9MnOypcmMk7YgRoWrzTy0rXtwC+kljDqfmYH8CqhLPv0Fl0
         a0oQ==
X-Gm-Message-State: AO0yUKUxliSgzaDVNMEt+u/NtNFNOuVfBEiSrpjoqPj52jHF/YuF3lKN
        FmhG1vQ3AoQD5u0cYHm+K1VktkOfluA=
X-Google-Smtp-Source: AK7set/8sPc3REfWvMfI7Zgm+qACTMENArSzorf/e/e/O1vbl1nic2m041aOPApwnvTTj8jND4fgyA==
X-Received: by 2002:ac8:5951:0:b0:3b4:a6af:a2f2 with SMTP id 17-20020ac85951000000b003b4a6afa2f2mr23029101qtz.34.1677184817239;
        Thu, 23 Feb 2023 12:40:17 -0800 (PST)
Received: from [172.17.0.2] ([172.176.137.177])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b003b860983973sm6563998qts.60.2023.02.23.12.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 12:40:16 -0800 (PST)
Message-ID: <63f7cf30.c80a0220.567ae.e46e@mx.google.com>
Date:   Thu, 23 Feb 2023 12:40:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4421460040901884385=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] device: wait GATT client ready before service accept() if no cache
In-Reply-To: <6387d20af8252ea1198c81afe728a9f67cd6bf77.1677179059.git.pav@iki.fi>
References: <6387d20af8252ea1198c81afe728a9f67cd6bf77.1677179059.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4421460040901884385==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=724435

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       FAIL      0.59 seconds
BuildEll                      PASS      26.78 seconds
BluezMake                     PASS      970.99 seconds
MakeCheck                     PASS      11.77 seconds
MakeDistcheck                 PASS      151.46 seconds
CheckValgrind                 PASS      245.01 seconds
CheckSmatch                   PASS      328.16 seconds
bluezmakeextell               PASS      98.01 seconds
IncrementalBuild              PASS      875.90 seconds
ScanBuild                     PASS      1023.96 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] device: wait GATT client ready before service accept() if no cache

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
21: B2 Line has trailing whitespace: "    "


---
Regards,
Linux Bluetooth


--===============4421460040901884385==--
