Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D753DC56202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 01:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AAB20729
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 01:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpU2anu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgKXBgA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgKXBf7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 20:35:59 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58DC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 17:35:59 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id q7so9855438qvt.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 17:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Nq/mzqfcc7jAhyKbfCoYyTwZUwUu1I8Y1D/EN38iVck=;
        b=YpU2anu2GbPhbm4CGU9w0L8qzfS+dOZmFv6M8w1WsFr4Pc8+WpVFRoZI8G5xJzuFcF
         PVJ1ENKm4HIUQYW3gynxXembkjB7r0xB75DGXwdiWS5DYsAwc1pQp8ELgOZLWimAnvyE
         273DnjKnZKBImP2HMXVba2k31OMQYnfMICYc49aRRKv9mbCqGWapGAXCjzyiXZt6wido
         TSAQ5XDowh2rk7dWCsv/ghIgxv+Q5s45UDRF95743iBLGvOTcbD+ox+qXlW3wXT2mEur
         eH6Mtpp8X2Lgaqx4MyEw3opFa5CpUfOQ1Aihwyhhs3bReuEweuzZ1TfMNFd8HF2MSSp9
         LqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Nq/mzqfcc7jAhyKbfCoYyTwZUwUu1I8Y1D/EN38iVck=;
        b=m70ynOr5Q8JffJ0pnjOOEzKlGAqDw61N3AA4y7NqV9kY/UGgI69K2jAX3OYh7We4Jn
         hg/hk9du90VeSOhNg2EqAvyVzX8g09qyvyE6/+sSynXAo2Ye9Ol48t/MK4CH7ipDWhS/
         j0QhEf+g6/coWwSQlbyh5rIvr5wDV2oGSZIreW16YKVupdCXm/Bf59u+RZnYeIl0BOqi
         GTJyv9AnYfkNJLUqGTQrcwJB7rt3ndF1Cio/dphqUzJ7H6NU6beH/R+XApkWFkZvnR5b
         lbjrQbn6BaJFOheTwIQPj6WHA02ssCn/aGVNKhrHeKZGLr/0O7u6GZOvU1FVFK94W7pA
         asWA==
X-Gm-Message-State: AOAM533cIVTpzGwjb72XSiFdEUW/plMxZoXhCZenF/r6WXX+OtilsbvV
        mTLUcmgIQ7pQwgbsn45tQx0w6mL2BV+zHw==
X-Google-Smtp-Source: ABdhPJzGMwcRRuUHBTyWJD91PuCs+BPlaZAe4pE636Z2Lf8XkHuNqazIwHcOIwDtQHJQkYPFZvQIbA==
X-Received: by 2002:ad4:5beb:: with SMTP id k11mr2459188qvc.20.1606181758711;
        Mon, 23 Nov 2020 17:35:58 -0800 (PST)
Received: from [172.17.0.2] ([40.84.35.204])
        by smtp.gmail.com with ESMTPSA id h4sm11343344qkh.93.2020.11.23.17.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 17:35:58 -0800 (PST)
Message-ID: <5fbc637e.1c69fb81.378b2.81de@mx.google.com>
Date:   Mon, 23 Nov 2020 17:35:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5661570842006864766=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: Bluetooth: Cancel Inquiry before Create Connection
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201124010906.340433-1-sonnysasaka@chromium.org>
References: <20201124010906.340433-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5661570842006864766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=389811

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============5661570842006864766==--
