Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990CCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 06:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713B860F92
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 06:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhIFGlL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbhIFGlL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 02:41:11 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F91C061575
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 23:40:07 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 4so3482064qvp.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Sep 2021 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JVzYmZGQKLhEeUPEA+xNAmt2zNP+Ngp3oPl2Ypb8r78=;
        b=hWmyNV241EDIi6qAq90Mp72betT1f9Z3OnXXzbzQmlWLdQEbLYJghsJOhnVxsK2TWD
         7Zl7OY4hE+xotFma0VcoMJ6lfpNbTZa7G1EG8Inx3rji8Q0XN17rNXHC5rLPQgHWqPvh
         qOkR0HvaZ37P0wD3VZ9jDpm2r6sGzoNoAVfswAiDLQyZlgjUvasU9ODNAAeOXshMFWK8
         WnMSH081PwhY7mljR837zUkpxPfmCs/ybzezzMaxhYjQ6DJWZy+4HnIjEZaD8fmr/wr5
         z3X5UZ8d/q7g3rPwH+VADayj/4i+DAOUotlOMP5B9WlwIguvMFy7rXa4TuSTY92xVuqe
         h+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JVzYmZGQKLhEeUPEA+xNAmt2zNP+Ngp3oPl2Ypb8r78=;
        b=SLqxOo7yJI+21wFClXCJFiObhAVrdmGGPYTVli5S9/7g57w2o54IvVohy7NLf376Q6
         thiVQsR0Z/3XgJ828zSFsk2zV2pObmcO9RJ9xcfuuLI3AQbn4McmdbgpwIuajpMBu10v
         uTr7UO5/dGcrN44O1TXyYLaR/Lz9Pg8eBse2lxbaMl8zuAJhsh1NSRA23OMFnGy44r0k
         j076o+4GKAemVontx8lusKjzrZm+6SbFoErAHRBNdcFjVSSZn1l+6YwtC//9zNBJRIM0
         DeIgbCqtxwgOQsJgQ4xwVzyqrlketL2XXQCb9YAtl6osTpCQGoDurooFryOAnAFFZfSC
         ONiw==
X-Gm-Message-State: AOAM530dgP5zaLOrN5gZSyS8BXcQ5PYh7+0L/l3MppWP4+sFAqmEOr6j
        IU3E+9r+zS4+36+v3wO1QI4J/v6S5O/GSQ==
X-Google-Smtp-Source: ABdhPJy8ONMilxhsg9fjiObA1jH6T6BFwmlnm9gysvc0CH3a2CoSkt9kcK4SMqM42J6EGfynF5I8ew==
X-Received: by 2002:a05:6214:762:: with SMTP id f2mr10578369qvz.48.1630910406359;
        Sun, 05 Sep 2021 23:40:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.224.119])
        by smtp.gmail.com with ESMTPSA id e22sm4764627qte.57.2021.09.05.23.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 23:40:06 -0700 (PDT)
Message-ID: <6135b7c6.1c69fb81.7a59d.90d3@mx.google.com>
Date:   Sun, 05 Sep 2021 23:40:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7445914430567690383=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v2,1/2] plugins/admin: add adapter_remove handler
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
References: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7445914430567690383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=542331

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.20 seconds
Prep - Setup ELL              PASS      40.61 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.15 seconds
Build - Make                  PASS      177.46 seconds
Make Check                    PASS      9.32 seconds
Make Distcheck                PASS      214.73 seconds
Build w/ext ELL - Configure   PASS      7.19 seconds
Build w/ext ELL - Make        PASS      167.46 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============7445914430567690383==--
