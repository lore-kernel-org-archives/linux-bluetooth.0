Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E05CC07E95
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 01:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7578B61370
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jul 2021 01:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhGNBXQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbhGNBXQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 21:23:16 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568EC0613DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 18:20:25 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d1so732172qto.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 18:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ge1p3HVCH3PSO/w2i3tA0W+RUpiv0mAo1K68jzbXb9o=;
        b=d0DymIj1WKJWqFgt0deMRLsszQUjqeyLWFMzbWTbRtFjUqYfOCJtQ/qmRn6wcsr+mQ
         qeY+mb7IPrfXmVEgM+dvtGIbFGqJMBFeYvpHeTEQu1Pp4szMOwhlkUkiAkKSjiBKfq3z
         KLhq3UckrfyHtMzITZeWh9CvN3Ya3NdJ6zsLb2vs5RYK+XR/EM+nGMRYH+79uvr5/RIP
         HIg/F6uPUKn6W8zy/YamW6TXAHKGSaJp3uT8Vld1Ya1OeyA13ruFQ7xCu7D87I17GHvo
         VEy0oa5jtqqThkSpdQBjuBZIaZTUQfjKJw+32NTDE2lBMTPOUvqJSGx0eyd4nir9JQ0R
         EsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ge1p3HVCH3PSO/w2i3tA0W+RUpiv0mAo1K68jzbXb9o=;
        b=sPMfpizYcGvcAmksNNY+JdPKjwdMFgXUSVvIjU/fAmRPcucuAaLTcEqJs3SvEv9dCe
         v7JmOiJLqFjP8AVzbrpx8KeCN32WN0E9vKMi2KRLnWQKzr76EzYQthioUFMbYf4f5oTg
         F/N/oZ4B8qHc8toQHeRmku8vLFuggKkUyBpwPJ3N+bPaBJChqp5sHdJqU29GiYYdSxhx
         3za57ihOSWEvQ0WtioAZQ0/1cL8pE9Eaf67d4pqs93ZayD6C9xJYtgUNv//Gtu8f/z5X
         vtKDVeYUORje2iqrGvCN3ljIIgm+MORJrPAyf3ConF0u9JOn6R1l44hkh2ug5pwL8fRf
         QKLQ==
X-Gm-Message-State: AOAM531i/k/J19BQKpSzCEM5qmQHM6lOquFpTwz6nlSvMQDhEKoKrt+I
        Iz95LZSIDO0b8GVtFtXFOoSEqh+Vms5gcw==
X-Google-Smtp-Source: ABdhPJySf6UWaZv4qNb6bek0GHgwMsL0njkDD/BhRGOVnePXoMpoYezgJf0gBK0m8XrqxDlrfRaSAA==
X-Received: by 2002:ac8:108a:: with SMTP id a10mr6985702qtj.14.1626225624241;
        Tue, 13 Jul 2021 18:20:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.200.192])
        by smtp.gmail.com with ESMTPSA id l5sm318352qkb.62.2021.07.13.18.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 18:20:23 -0700 (PDT)
Message-ID: <60ee3bd7.1c69fb81.73f05.1fd1@mx.google.com>
Date:   Tue, 13 Jul 2021 18:20:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1336005744872030770=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] btdev: Add proper checks for own_addr_type for extended advertising
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210714002224.2632842-1-luiz.dentz@gmail.com>
References: <20210714002224.2632842-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1336005744872030770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=515075

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      39.84 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      6.93 seconds
Build - Make                  PASS      171.76 seconds
Make Check                    PASS      8.57 seconds
Make Distcheck                PASS      203.18 seconds
Build w/ext ELL - Configure   PASS      6.96 seconds
Build w/ext ELL - Make        PASS      161.92 seconds

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


--===============1336005744872030770==--
