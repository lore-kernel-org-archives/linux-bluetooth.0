Return-Path: <SRS0=JOhI=EL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF2C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 00:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF0B21734
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Nov 2020 00:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smgNGfRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387890AbgKEAyD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 19:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbgKEAyD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 19:54:03 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21C1C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 16:54:02 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id g19so130964qvy.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 16:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yoW8xKdDVqLGzRr2VgI05aq37WYL0GVmqlkeL3mY800=;
        b=smgNGfRDaPCS2XNbQhwWTZb1olDcSx5ASpqX025YMjWz+hQxtj0IS7VBoknegWx2sq
         3bBe3ULzkPz+CfHAsKWHE36MkhqGJrWXgkhBeE3KYYZKxjG9OPKEKNfh6sAMEO1giQb2
         IN/pMsCDUUy7KnH7KDCJVlGaKwWKYX8eJjZjC5XPGLniqzlUeqUGUAUKf+kbrPsBX5BJ
         TwOofQIciLnMHMe2f5lQzVp6BE+V+/Af5ZSBymZqAO1Jpfff9ZND0bKxje+QymtBSw18
         Fq6cJc5Hb7r5i4YRLPqD33VcA94t+p1UeJwJxdOIlv8XwnEF/xk9DG7+9HYJ/eTS90eE
         KzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yoW8xKdDVqLGzRr2VgI05aq37WYL0GVmqlkeL3mY800=;
        b=mgj53F/eTu26x5suDDAtN6uN0vcTpg+BM4yN6hvay7AyC+NV9Zj9gGr86TxFGA8MTe
         AzTZDUIHZET/NloEBkFcmvU185Q94TRBGnn7hhZYhKQ+iUkOCyrWYJ12tc9Iq18qyw8e
         dJrC0NEaKunGH+WtJHJ3jA9L752PirQpEtbijX7SJ+6R5L2l59zOWhu/BLQuJhlngsAZ
         RP4SKUs6AU9AfcvZ9oYPkcsgwepvfsswVIxUXv+QAiAm5owdlCFS/omUA2eID7CbD3fl
         pW+cXLc4GeK7UnnnMxBBAYIMF/3eAK3a6JpGJ8OFofEhETQDIIZ24K8cwCLcbjqIfgj9
         nEKA==
X-Gm-Message-State: AOAM530UZXsvP6WguKU2L+jbi4IwPLVJc/G8bqB9n450czVY39JceQn5
        Gvj4cLa2XoIEkanptEeM7qXA3b7KS5V3YA==
X-Google-Smtp-Source: ABdhPJwXeWvWOG2qRkPm2S4jEtrhzvs1gflsU5lteG4GwfWWgZ+sOpCePqh7ZvksBxvp9pTvAA8LKQ==
X-Received: by 2002:ad4:4512:: with SMTP id k18mr162008qvu.5.1604537641985;
        Wed, 04 Nov 2020 16:54:01 -0800 (PST)
Received: from [172.17.0.2] ([20.190.217.136])
        by smtp.gmail.com with ESMTPSA id a25sm3881589qko.17.2020.11.04.16.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 16:54:01 -0800 (PST)
Message-ID: <5fa34d29.1c69fb81.6ce35.55d9@mx.google.com>
Date:   Wed, 04 Nov 2020 16:54:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3826506039143389451=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/8] doc: Add tester.config
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201104234228.2257427-1-luiz.dentz@gmail.com>
References: <20201104234228.2257427-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3826506039143389451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=377723

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
mgmt-tester: Update set_connectable_off_adv_param
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#16: 
        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)

- total: 0 errors, 1 warnings, 78 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] mgmt-tester: Update set_connectable_off_adv_param" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
mgmt-tester: Update set_connectable_off_adv_param
13: B1 Line exceeds max length (89>80): "        Filter policy: Allow Scan Request from Any, Allow Connect Request from Any (0x00)"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3826506039143389451==--
