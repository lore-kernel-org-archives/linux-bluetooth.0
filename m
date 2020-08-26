Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E32C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBAC207DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh2W6g/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHZU2x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZU2w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:28:52 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AD8C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:28:51 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n129so3551161qkd.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CQhIl4nHHwVJWKs3yK9yKLoxI0mRlCyp2xDolKEbfKw=;
        b=rh2W6g/rLvSLnlVOlj+1HfRFaE8CdrvTTQ4PbBM/punKjH+fTrGlkPeg+fhmC5Xyj1
         v5AFwWmw//5v5acHXamTy1w1Oyu/Jf21Ess57OMcyQfixWFqBsvgEKdeaqK3D7UKN4Du
         xYHXjDYK2zazCblwRH/hsMt4YXkSNd/2hEzsErnCW5X9WYiIaW7Qcvl2eXT3hyTbXbCz
         FkUnkpOQi7z56pYb+lCh66hCwkaujjxNWhVr5mJVyjuPLgroKIL8DqZP/9w2SJEH4egG
         tmG+drXhWGvj34ugYsFmz3Ydo4ktW0oKaYPVP9Jv/ThGl71HemtIUaPx7npR3zu26jKN
         mjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CQhIl4nHHwVJWKs3yK9yKLoxI0mRlCyp2xDolKEbfKw=;
        b=QFvwBEeNpacBNuJF5fA3+1iRft2bR2+kNTGfRWg7nHCympjl2zFrmsZT3nkVckZ2NK
         fukyYVdBAsblZRszr5NqV1ZPbFoX1tmbyjFfW2NoeOxZYL3MoG1Ez2tsB79Ip6RkjuSJ
         hxG00R3uDSQryWdGCidOEUQzAqAMV6uu2kEsXTgEp8aUiwrKzukrif1pLjW9X1JLEXKt
         ehwNjLPehtWrj5vcAU+TfBFwHnGHbMI+BfznIniDL1Rz5wSaLvi9I2XFMgIjqqL//63B
         n8y7fN0FfMtZDWqG3Hc6vJNzDAEHcGlXmHqLLuptTq+7z+ZWbmk3Mzj9lqx4UYX54qqP
         SAlA==
X-Gm-Message-State: AOAM533q8JUlutT+hz1DCyNL99ym91TMmBEGvbILW0zxtrzAqHkqpqbi
        t+Y1IyDVza/kjpEKy6eF7uUO4p8QcdQ=
X-Google-Smtp-Source: ABdhPJwa33zamg473GBXrHBYYGMJ1YY/Aaxljr+qTzvN4ukUuPVHWas80qZOkSsMNA13+tsqB4LLgg==
X-Received: by 2002:a05:620a:1525:: with SMTP id n5mr15552829qkk.126.1598473730804;
        Wed, 26 Aug 2020 13:28:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.1.170])
        by smtp.gmail.com with ESMTPSA id i18sm49404qtv.39.2020.08.26.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 13:28:50 -0700 (PDT)
Message-ID: <5f46c602.1c69fb81.7ac52.04e2@mx.google.com>
Date:   Wed, 26 Aug 2020 13:28:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5321790126634835349=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: [Bluez,v1,1/3] PRE_UPSTREAM: advertising: Add SupportedFeatures to LEAdvertisingManager1
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200826131103.Bluez.v1.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
References: <20200826131103.Bluez.v1.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5321790126634835349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T1 Title exceeds max length (73>72): "PRE_UPSTREAM: advertising: Add SupportedFeatures to LEAdvertisingManager1"



---
Regards,
Linux Bluetooth

--===============5321790126634835349==--
