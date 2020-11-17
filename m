Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4E5C388F9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 02:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E902469D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 02:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvY1NXE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgKQCx1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 21:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgKQCx1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 21:53:27 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89CCC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 18:53:25 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v11so14673353qtq.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 18:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rygbSnIo5VRV6wDo6nSedb3ciZB4kriGOfl+MJ4Bt5A=;
        b=FvY1NXE8s1MILDw7/xJDFwesObg7TCnSqHfuh25jYLLekiC42Foucyov6cz/8rLUol
         b1brTPMn8wioSYEmukDkd8xe7QWjKfhCVGFboa7Q+nmJdscxfPHpUxZUSvNOhJrlx7Tp
         /tiEGUb9B3nsDlxh8bPsmJcP/wu2CqRFglu3zsn7Z39IZuzadU/4/Fi4WJzWaEH236ns
         jRfed25JFpUqF9SGLpCj75abP9ysWQpij17fpk7myAReWH6vyFUl5MWDhSfWCil+nZTF
         +bCdpw3lKgSaELt17RkkHgwunRz0379LQphp542tJUwxXPtucu/Uyn0QHLOHw7OAPJPa
         Oj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rygbSnIo5VRV6wDo6nSedb3ciZB4kriGOfl+MJ4Bt5A=;
        b=mgX8WXXFQrvgvFCHYRet8j4aiWkQWUN84gni15MhDQJVvdmhZAe9/DEjgLd5gsisbN
         JpO8hstoHRh/tJ7sBa/lnzBYGHz2r95zzmFBRbmwl8Fm2AeQdbgRBEeSN9t7IuvUAH9a
         WgWVtJyn81E5CHPPR4nSzceGdj+Bq2qTs5iC23uMcFfG7rklLhuBPLjGc/apw5r9IXgq
         uM4cZ9mtzhTvTQ30sVh9gKQH+hjyEWG8jGa0vFTJibKmNrbfw534U0YRol7tO0gENDUo
         zJ4og1N/SZQ5mIF3nQ30mZpyjZnZnFPay/RmbntXJSRB6BfUowN7E1O1MDilj20GoPXk
         OiUQ==
X-Gm-Message-State: AOAM532penaZOWuCdMdYvRiHwbShPWgiq8XVAhNKSJYjE/s1p9UfUqeS
        N4CbpBuooQJDe0eqIgdTFfaWFFoqRFZpuQ==
X-Google-Smtp-Source: ABdhPJyxqYoqu4QnY1DvF/yo0R9H2HRQ6fP/bA7lhcDRtvq8cy9ZUqGEh8GN3joWLplHRZfDl8nYrQ==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr17598208qth.123.1605581604684;
        Mon, 16 Nov 2020 18:53:24 -0800 (PST)
Received: from [172.17.0.2] ([20.57.112.102])
        by smtp.gmail.com with ESMTPSA id j202sm13343149qke.108.2020.11.16.18.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 18:53:24 -0800 (PST)
Message-ID: <5fb33b24.1c69fb81.28ffb.f27b@mx.google.com>
Date:   Mon, 16 Nov 2020 18:53:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2770927284849605195=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jimmywa@spotify.com
Subject: RE: [v3] Fix for Bluetooth SIG test L2CAP/COS/CFD/BV-14-C
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201116155626.GA27472@jimmy-ryzen-home>
References: <20201116155626.GA27472@jimmy-ryzen-home>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2770927284849605195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=385191

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


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============2770927284849605195==--
