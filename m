Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13788C63798
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 02:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAF062469D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 02:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkVY5Hil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKQCyU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 21:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKQCyT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 21:54:19 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1E7C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 18:54:19 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a13so139080qkl.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 18:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pFMN2u2b9kZ0TtXaBT65Ehi18kiR1SHgYQHXZexMBA4=;
        b=rkVY5HilFWbLiLvYfp6xgqM20/Um5QJQOXYUuEENjfM9GdbxyhgPIASvPAZacR+jKs
         UinqBw1uqOuLw+hdXpv4dHv8QRA1pPMw7ch3Vorg/TqdD2fHG/IOS6IbvZbjg/HLrc30
         URSIbdwVzRTwIVfR+J5UkDRDpKH87uVzmcrkdZZ/ORiLRXDSm6hADSS7lE33miHYHdZn
         NerhAdNv5BTiV20OSsvQacPklIPqnTwrBoDY9Lj2YTaMpFjmZ65kpnXJliy+RP5IXjiV
         AaBok9vZk3Q76idRbGlZrF2Ih3W7xAWf0OzjgUmfvkADjTmks3sjQA+J1fpcP956pS08
         x1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pFMN2u2b9kZ0TtXaBT65Ehi18kiR1SHgYQHXZexMBA4=;
        b=V8tjxqSPLXCyS6sMDZv26sFqkRG0V8KQy0OaCnFqrNhixkWgJWfjQso2JXaq2PNzPr
         i2pot4yEuEdihoIc5Qv5mj8AuuXjK9M2H5uIloKM8WeSYUxJ+QCDRiUx+YMq8kUReg6j
         ur+xpP3b92JxILg43y3dd1JJnQ9A+xGGy/HEQAc4jvq05ox8PW5TXTcZbZC6VV9AAkBF
         R5ciqAVv6/Qkn9S6h8NfA388TRCYsR7Ca9+hd/UmI/x41e56ZG6XYoEZxswAAF5R7UFf
         o9beft8aq7xA6Cc+Jldo4EKkjIb2or3GfNTSVLzRxnMaxgzUUcbJJ6/AMjiXQP+QBUbN
         eIeA==
X-Gm-Message-State: AOAM532wCaAN6ZpIs5zhmL0JILDygtYEeDNEsSjai2lR0WbP1zozS11d
        7Te7HPklOiQndAPgvXtj7FkDuiMen5cfKQ==
X-Google-Smtp-Source: ABdhPJxrNhD8kh8Jfgeo6BwEb6IwEuI7AUHY3aP2vVId3+q5cnTReWcSbU9YnkmhqNAhIqIi5hNhxw==
X-Received: by 2002:a05:620a:1415:: with SMTP id d21mr4657729qkj.275.1605581658444;
        Mon, 16 Nov 2020 18:54:18 -0800 (PST)
Received: from [172.17.0.2] ([52.167.202.247])
        by smtp.gmail.com with ESMTPSA id g9sm13540886qtq.21.2020.11.16.18.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 18:54:18 -0800 (PST)
Message-ID: <5fb33b5a.1c69fb81.4d007.e950@mx.google.com>
Date:   Mon, 16 Nov 2020 18:54:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6465241193525390252=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, weiyongjun1@huawei.com
Subject: RE: Bluetooth: sco: Fix crash when using BT_SNDMTU/BT_RCVMTU option
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201116132421.94624-1-weiyongjun1@huawei.com>
References: <20201116132421.94624-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6465241193525390252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=385021

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
workflow: Add workflow files for ci
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#20: 
new file mode 100644

total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] workflow: Add workflow files for ci" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Bluetooth: sco: Fix crash when using BT_SNDMTU/BT_RCVMTU option
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014

total: 0 errors, 1 warnings, 0 checks, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Bluetooth: sco: Fix crash when using BT_SNDMTU/BT_RCVMTU" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: sco: Fix crash when using BT_SNDMTU/BT_RCVMTU option
8: B1 Line exceeds max length (86>80): "Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1 04/01/2014"
37: B1 Line exceeds max length (82>80): "Fixes: 0fc1a726f897 ("Bluetooth: sco: new getsockopt options BT_SNDMTU/BT_RCVMTU")"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============6465241193525390252==--
