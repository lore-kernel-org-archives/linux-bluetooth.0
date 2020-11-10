Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE8C55ABD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 22:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C2B2074B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Nov 2020 22:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/M36lQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgKJW0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbgKJW0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 17:26:09 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1B0C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 14:26:08 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id i12so9856485qtj.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hCAMeKEKKokxHyHUOi8qYlA1ZqZRjCtfv5gyF32v/hs=;
        b=R/M36lQ6g0he0z3FzxcrXTwJRgfj6ul9PQxm0rIlNMIkPuGphY0C8b0psinfL7uJ2Q
         Kt0NgocnsITAiaDogtuuYwTvGssYaEfwZpyBXWvKMWb8MK9Z7bt2I4j0ynGWWh0pZo6F
         ZIXNTIac3XOAzPMY5aicAtC6S8W/s0V7rMMkHUfp/gtI9J+9RUntjvj5DE4jJDBMGI7x
         FwQ25lumigpmHr/2bqB1ao12HMdYBPk9mISkqJ2eKYQWRVV4tRF/vLA0Nex3H48CRIIu
         nvmUMxJ+QVkLnJ64ca7dhAg0SAu/zbfril5p5pUerCtcmE0uneZQrWUgCgqJFNPXoPK3
         YFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hCAMeKEKKokxHyHUOi8qYlA1ZqZRjCtfv5gyF32v/hs=;
        b=YdLfGNaZCznvsyugDlko5r88M93tZnobmRikxxjsZklhm0/09qMr0PvQjLS4mRO2D+
         w1jqkSp1XZTF+rRBG6BtuedK5epOB6LfUwurSyRQlm9WrIdHgUJcBvWldM1nW1vCBQ3x
         QiIoLGpQ7z65gxJtCCv4cPYymbB/qwMS6vVOzT1S84NKboRs41pRSUTM6CiHJlgjm5Nq
         2BS0qp6IpHu78Nv7VPS0ylwG1pD+fNexsbCIV4letYQFyUNmJKzfz2VIv+4JZH+Nshdq
         CSNMkGXteyhcVr6vEZlX85Wl1fEM7jrK+N1jkVQYDoyWVtuEKyxKhXVAuZAgR+yVlm/6
         ejyQ==
X-Gm-Message-State: AOAM530OfW+LMiVdLm0o5cnF9CRFcaHxhW5oY8T+DVDna7ZXfr2OAR0T
        jUQT/ei16geA0Rh6jDd5SgRnm3kk/jumqA==
X-Google-Smtp-Source: ABdhPJx4cmP9eDdP5RsfPCh90iJqfBSC3uL7b9qDKVMvyYtUUCHUG2nH8BwWAv+IUGokOJAbMR8gWw==
X-Received: by 2002:ac8:23fb:: with SMTP id r56mr19672139qtr.371.1605047167403;
        Tue, 10 Nov 2020 14:26:07 -0800 (PST)
Received: from [172.17.0.2] ([52.177.179.0])
        by smtp.gmail.com with ESMTPSA id g70sm213953qke.8.2020.11.10.14.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 14:26:07 -0800 (PST)
Message-ID: <5fab137f.1c69fb81.51a46.129b@mx.google.com>
Date:   Tue, 10 Nov 2020 14:26:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3856725255871919160=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] emulator: Rework command handling
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201110214205.3092997-1-luiz.dentz@gmail.com>
References: <20201110214205.3092997-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3856725255871919160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=381525

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
emulator: Rework command handling
ERROR:SPACING: need consistent spacing around '-' (ctx:WxV)
#100: FILE: emulator/btdev.c:336:
+	if (run_hooks(btdev, BTDEV_HOOK_POST_CMD, opcode, iov[i -1].iov_base,
 	                                                        ^

ERROR:SPACING: need consistent spacing around '-' (ctx:WxV)
#101: FILE: emulator/btdev.c:337:
+							iov[i -1].iov_len))
 							      ^

- total: 2 errors, 0 warnings, 7681 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] emulator: Rework command handling" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3856725255871919160==--
