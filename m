Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 21:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4D60234
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 21:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhCRVe0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhCRVeK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Mar 2021 17:34:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2F3C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 14:34:10 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s2so5263111qtx.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Mar 2021 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/V1bTfUHJZXy56iAX520HItmPfMH7b5VBcy47yjkivg=;
        b=eQjRw27bIBFD61pgPAAPS6XCjAxYtp+ZpUad1lOXBijm/k+gOFFPu7voViWiNI/JF/
         UHRlJ9VpyfjSziFB+a6oFm9oYgnrYZV4dkH/qrDAefD8t63lXQe9lcO8KEC2dl6E66iH
         8xrkyFhWUpXgQiP+OSyDYz40KOQAupaujmAYj28kYlgkQfGDMV7G8LBJTPiAe44KeymV
         /irz9nStFxmUCdeLH03xBo5pG69AAdmGPZOOK+Sm87TrYitsm6ig67Tla0VjX85YgSKy
         mXgvZ2ereXF3PbWVb66Js6StnDJQRNkL2vthrCVR4uzLb9q4qnOQoprn6hnjFTh3BL3L
         XdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/V1bTfUHJZXy56iAX520HItmPfMH7b5VBcy47yjkivg=;
        b=TuXySbJ0suCsDoS+AiNm754xKD86hzf9NvwlWalM16o6fmT9wNS2Xw5OH6jvGB7v0w
         qxkrUOtqKkeHJrp0npHz+SyuDoF3wnGMrg9aZ0IRoFs3GeTSyiW4Sx+F9hofF9qW/8Dl
         Lgb7J42LZoULSL2urKySXJfGUgM9ABUtq+PPDp11+fc0svl6HqNVv5Y3OY3JZxPTi9gI
         Dt7fdqf7fCpwilCOKnQMvwCeqaiwYShVgsPRnKhzLKodaEPPgRwh105fSe7uFul3h9wm
         SmSvW2JJyjvOo9BsNoTL0CHTw0rJvVYiu0VVWQv0y4h0PH3nhwEcrV/Bayz6yP9rxmgT
         MMog==
X-Gm-Message-State: AOAM5330Q8iIieTeo2cyAcQ8w/3OEn1AFLMlp8RVXy2UgjYBCO0nYukJ
        6CykVp2bbENPgT/l/TL3YaU2Gd2O9+OZfA==
X-Google-Smtp-Source: ABdhPJxLmM9OjfSCqhrn8/vY2minQ7N5MnZ+zzAnXSuOGxHL6Kv7Eba1VwXiOlNW6M55Q9wXpA9q2Q==
X-Received: by 2002:aed:30c2:: with SMTP id 60mr5691107qtf.85.1616103249212;
        Thu, 18 Mar 2021 14:34:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.36.255])
        by smtp.gmail.com with ESMTPSA id x10sm2204880qtw.17.2021.03.18.14.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 14:34:08 -0700 (PDT)
Message-ID: <6053c750.1c69fb81.2f7f1.e27e@mx.google.com>
Date:   Thu, 18 Mar 2021 14:34:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2137340027194577419=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v2] tools/mgmt-tester: Fix for scan response in read adv feature command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210318204640.424409-1-hj.tedd.an@gmail.com>
References: <20210318204640.424409-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2137340027194577419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=451087

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
tools/mgmt-tester: Fix for scan response in read adv feature command
6: B3 Line contains hard tab characters (\t): " Read Advertising Features - Success 1 (No instance) 	Failed"
7: B3 Line contains hard tab characters (\t): " Read Advertising Features - Success 2 (One instance)	Failed"
8: B3 Line contains hard tab characters (\t): " Read Ext Advertising Features - Success 3 (PHY flags)	Failed"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============2137340027194577419==--
