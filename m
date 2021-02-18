Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62795C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 01:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2820C64DD7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Feb 2021 01:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBRBKL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Feb 2021 20:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBRBKK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Feb 2021 20:10:10 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA7C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 17:09:30 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z32so293820qtd.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Feb 2021 17:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cT/dk0VTjlMtwKtH9n2irJQDJDdFl0HEfFnk3TwvnBw=;
        b=ocrqd9eLqYe1BL1HFNJoCXKrWWIyHzUme2y2Pl3Rc2UNfYPV2+c0FinuFSmd0jckE7
         yQnZ+gn7bQN0f/2EbpohdiJI82ZJOFTWd8jJrSIBlUTjEHXcP8JFw+/37DX5XdTuUr91
         K8lc1jl3vW9xL1zd8pv6zIv0ujM3tlUyVStpiXllZhRAZKb6SurPpT1TV7seV+u1/aCr
         Bsezy+S8XfRKNN2tQSQt0+Br6Rk9DEmFjghVr4zUtyIWlkldZDQtf5Lh3QDrndvtgH6B
         W83o+KXVV1Q9YGAXUUnHcVM5ylKm1ICEuikOTm9CeUTVWCLraWY0F2lho19/Y+iukCv9
         1mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cT/dk0VTjlMtwKtH9n2irJQDJDdFl0HEfFnk3TwvnBw=;
        b=YSC0OX3we7yhjUA0r/qyyhbnyp0H9KwqDlZxzuSCnMs7BT4WiDTb3YpiaaPppYhyxv
         hwBl3LHMgZzuxaxnStZqjeplkGsCQCfF0dG7dSwuXNYlr7vM2+k23OOpeB4gTU3k4RFo
         Y/7W9xtY1RP801LbbW1RcMqGzNGr2cgmbzELHS3MJdwPG+vbdBh4SLXQ15Kdj7Kj4EtW
         +lc/xpbgI3w666HPaLAOkt6wF5zQNZZHKCjLZpnbC9wgMLOvYvKFqTwSuHYcbFIDgfL1
         jruRJAPYcT9GNw0ixhtUqiV/m723oCiUj/5+bUQKmDMEKi2yfcDTqZ7ViHM4Vg/XvCB1
         OtUQ==
X-Gm-Message-State: AOAM530H3GTtzQg09CGm2O+52gFUOwrLrpcqK8hTMNLP5JBd5+8oniKP
        anzpTHOR4EPk3PpDkZoxIw/ygiAFj9k=
X-Google-Smtp-Source: ABdhPJwKCuAbtfV92nHffUjcDy7U+AzD14rMuFcAqXHFgBC/u2C/jk/cIWydihMABJDF+bR4M9klBw==
X-Received: by 2002:ac8:5447:: with SMTP id d7mr2109376qtq.56.1613610569076;
        Wed, 17 Feb 2021 17:09:29 -0800 (PST)
Received: from [172.17.0.2] ([52.251.112.121])
        by smtp.gmail.com with ESMTPSA id y190sm2892223qkb.133.2021.02.17.17.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 17:09:28 -0800 (PST)
Message-ID: <602dbe48.1c69fb81.a1db9.1fb2@mx.google.com>
Date:   Wed, 17 Feb 2021 17:09:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1546760996918234776=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v2] mesh: Combine common functions for NetKeys and AppKeys
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210218003956.23887-1-inga.stotland@intel.com>
References: <20210218003956.23887-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1546760996918234776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=434773

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
mesh: Combine common functions for NetKeys and AppKeys
WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUSR | S_IWUSR' are not preferred. Consider using octal permissions '0600'.
#49: FILE: mesh/keyring.c:58:
+		return open(fname, flags, S_IRUSR | S_IWUSR);

- total: 0 errors, 1 warnings, 174 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mesh: Combine common functions for NetKeys and AppKeys" has style problems, please review.

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


--===============1546760996918234776==--
