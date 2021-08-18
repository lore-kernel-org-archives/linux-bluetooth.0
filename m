Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC69C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 06:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFB46102A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 06:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhHRGot (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbhHRGoq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 02:44:46 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D73C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 23:44:12 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d5so794752qtd.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 23:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7BWqLJl1l8EB5C9b9ktzpAgeFREhFX91rzKhDCalINk=;
        b=a/ZiV44vzO3gjqPUDy5GyvQG4O2VTk8UwrF5/UJ6KgSUDhy2l5W7t8JqSzjTWTXq1G
         S0FrDz1Ee3UCk7DzvLV9Ytd3Gj02v4T+UbgzrUHCHZ6x/Tz7nWk0bEWmfXLnfGa9qVdf
         I69puPn2k4ssV+a9KkmJOGBUdaVdfEiqZ9iSxaQrwJpZn9Om8aeHtHDdNe8pBcHQA+wF
         sO4vdSOrKK36rp7Cvv7NW3/zIjqbu5ao67fBzjYASXKZnXS00y1bYTbAApTh9sDFxWlg
         rASvk6zx8aPK48Qyjrp+OMD1tWyvqha7stNWmWNIOZXIjx1PFrVrpwalREloaiGXTD3Q
         qfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7BWqLJl1l8EB5C9b9ktzpAgeFREhFX91rzKhDCalINk=;
        b=SF5IDGfDTMj6eQvzEq3Ssic2Bb7+L27RERUX0nvr5EM+5gZ5spFPXpqfzuWLcic3nN
         cdN7ehcsSOKvr6FJfTavnnuHFds9ZZKM2mbNONW1F10SNi2RFcFQjV52FsSpjKkrC72P
         LYjJx4mll5W96GY+uCz6n38+Df8mLfm2uzsSEVZmrMTgcI5VVxzgZ5qVykRy0e0oOgmc
         hSHmYfQZg87h5JkRRlhw4HbSlRmZmZ+OmUo2EyUD4HKDxYKt/CaNwaMkaD0qZP07RC+O
         oo5JkL0+7xnTTI82Atw+3G1xbkhoOLLeTpUs4wra1b0nAjBy0N2FTmzt0nhv6+W+FtRO
         JZOw==
X-Gm-Message-State: AOAM530y+VaujjEfaffpi5+TMgK2mTAOc5vegsjKFprUITafVQTydyIr
        0fqN7tKphnf8GEptb8xBz90eKnfek6rVPQ==
X-Google-Smtp-Source: ABdhPJyRD3xjhfTsN0uywyNK9oiTfHg2kfXqqfQoqwVfAdwF8PNu/ZWnWazFQqyKnDcwFTvo/W+KUw==
X-Received: by 2002:ac8:7217:: with SMTP id a23mr6560632qtp.33.1629269051379;
        Tue, 17 Aug 2021 23:44:11 -0700 (PDT)
Received: from [172.17.0.2] ([13.92.174.1])
        by smtp.gmail.com with ESMTPSA id p22sm2980359qkj.16.2021.08.17.23.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:44:11 -0700 (PDT)
Message-ID: <611cac3b.1c69fb81.84b7c.51ac@mx.google.com>
Date:   Tue, 17 Aug 2021 23:44:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0575880019361376317=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3,1/2] mgmt: Set offload codec mgmt feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210818055948.22616-1-kiran.k@intel.com>
References: <20210818055948.22616-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0575880019361376317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=533151

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.25 seconds
Prep - Setup ELL              PASS      48.34 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      8.67 seconds
Build - Make                  PASS      205.77 seconds
Make Check                    PASS      9.70 seconds
Make Distcheck                PASS      244.21 seconds
Build w/ext ELL - Configure   PASS      8.30 seconds
Build w/ext ELL - Make        PASS      194.59 seconds

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


--===============0575880019361376317==--
