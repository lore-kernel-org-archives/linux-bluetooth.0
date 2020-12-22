Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F79DC4332B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 13:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D81923130
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Dec 2020 13:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgLVNqk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Dec 2020 08:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgLVNqj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Dec 2020 08:46:39 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D888C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 05:45:59 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 22so11806441qkf.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Dec 2020 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/5TyytyswBQGu7GUx8DkF7u3fghInrxbTyT7G6bgA/0=;
        b=VuYVT7cVopqb769AQGFyHqznidYjmwUy0E4zeWgxDm4UWuBPoMr7FGORYjYLDfNd0G
         LqJVeV3QODvOpdHk6deEE1z4pz3C1FUXSqlVcJFS5dZusYtwxxHNIByoxleBQdXj2ORE
         7QtVKOcLs/MibSW7b4SD30Y/apgIGPtDzYRqyFd32NP6N4RSOuPa0PmX/2g4fw/lhztX
         8ip9/j66jTB+HyG5bQ8CtsLTLwMB3mI0oGUpIDg2ZCavVKPxFS67ATYpn5A2bYUtCGPU
         Jv3IdkEQPwApPMT5kfxvdB6mXLIPLaU2A3Gmizzm3teMhE6EBDt0Nmh3Y7MmE6zuA36f
         foqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/5TyytyswBQGu7GUx8DkF7u3fghInrxbTyT7G6bgA/0=;
        b=sZ8+IjlbZn4J/2V+T4+nRky4TQyYLX90Cp7qPxMXL2tjCD8w4nzcY7jHZYYLDuY+W2
         G5nyBAWEKUIBH/Js/yAzmZykvku2SFD2USYmhkwGOaGRGsKECZAbNakqEXhFSlvNwJ/8
         O/xPdC6wiiyWJHf62vSD0Lhkaa1Zobs7d4r4hANrfP1977HBqEMoa331NlCkoNn2FXbw
         zXdaXJTRHm/5rX1vgcAaLYa7OhuBrFuZY20VNWPVHGSLwkxNt6sYF8Gkae6UKYlWU4uC
         bMFWDPQ79OKn29xF6bBQk2umADEqL+ySEJT4kkI1g+5EmM9Bg4OIWLUaezg7/y3Gyb+e
         G73A==
X-Gm-Message-State: AOAM532C5QzNKDnQk05dbEg4oc5ilkK6Ot0Ti6HsbfGlr7f3GDG/HWZU
        A5fAa8vNSkGgKDRpXilygCPCpCSS1OXEgA==
X-Google-Smtp-Source: ABdhPJwrjyc7c6A50KHoT1i69+G/zHt5OA9byRHEQ+qpUM3CD+q4r75dvEYoyVh0cFponwLpFz2TXg==
X-Received: by 2002:ae9:e909:: with SMTP id x9mr21621533qkf.166.1608644757909;
        Tue, 22 Dec 2020 05:45:57 -0800 (PST)
Received: from [172.17.0.2] ([20.49.29.60])
        by smtp.gmail.com with ESMTPSA id h125sm12709732qkc.36.2020.12.22.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 05:45:57 -0800 (PST)
Message-ID: <5fe1f895.1c69fb81.10313.13dc@mx.google.com>
Date:   Tue, 22 Dec 2020 05:45:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1229872126571861639=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: RE: doc/mgmt-api.txt: Introduce Set Runtime Firmware command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201222124651.101063-1-marcel@holtmann.org>
References: <20201222124651.101063-1-marcel@holtmann.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1229872126571861639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=405289

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
doc/mgmt-api.txt: Introduce Set Runtime Firmware command
WARNING:TYPO_SPELLING: 'firwmare' may be misspelled - perhaps 'firmware'?
#37: FILE: doc/mgmt-api.txt:3166:
+		some sort of runtime firmware. Only in the firwmare name

WARNING:TYPO_SPELLING: 'charaters' may be misspelled - perhaps 'characters'?
#38: FILE: doc/mgmt-api.txt:3167:
+		happens to exceed the 255 charaters, the shortened type

WARNING:TYPO_SPELLING: 'firwmare' may be misspelled - perhaps 'firmware'?
#91: FILE: doc/mgmt-api.txt:3910:
+	When the support for runtime firwmare configuration is indicated

- total: 0 errors, 3 warnings, 110 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] doc/mgmt-api.txt: Introduce Set Runtime Firmware command" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
doc/mgmt-api.txt: Introduce Set Runtime Firmware command
3: B6 Body message is missing


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1229872126571861639==--
