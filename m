Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6354CC07E9B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 09:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F22F6108B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 09:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbhGUJSz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbhGUJRq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 05:17:46 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB4C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 02:58:22 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o31so651870qvo.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rf9T2wOzMQhSt1GenDDzU3ca+gt4PKmO0ehlE83thmI=;
        b=WL+swGDnH9r9IuNfoThv/5f22pdaUOSt4jZh0wXGm4KiatCpBH9k+qwdIPTBRYQhjf
         qnZFo4a8ASCPMed2tpJi1ux4BuvRSJro68c6ba8h4fGYBE0raisTVvn1x9o5x1jOwahQ
         sCyyX3fnq/Hr7jYj41qpVPzeJGi8RPgDaKuU83xLsDT84gRJUAJX6LcCTqVHxYuDAgWl
         sNKKdcxtFyqC42Z+d8uiJiwJC+9p4DRBPpsbGAmBbJ43SS9N6CzXKneDtYmyXlpm0c4j
         Qcce2Kg4J/snEbB7IMJlcMXL6i0nUg6jCjmN18G8LDU7RquXQfUK1heZHwO5WiT6st5R
         02Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rf9T2wOzMQhSt1GenDDzU3ca+gt4PKmO0ehlE83thmI=;
        b=YZr1LG2v5xSgVp0Sc9XK9/N7rFqoPpighFD7isI1QlUbSjHnIugdljm7E5uGvlv4i7
         /l/VcwW9uIAlzh2vvc5CjFLERaZTLA5/5RvWjZtYzy8KvXY5sKn3nFJJNLaoaTMWyGR1
         Qlc2zQfLKcZcrHu0oPWjIybWXvHZdatATc+U+qyhW+I4PQlpp7rh/G9Kqdsoz75fwcn6
         Kba5A855P/BnhhLK2BweJAVdTJH+qtXL8zVQY7JAXincuR96MxCiFyZ9ndwkOEQeggqU
         jtm/0EKOKU8zdVDs7O26LwnufIERbpxmVJJdiB+/Pmb4M0h/6GruKZY/p1tzdQGt4zy4
         OY8w==
X-Gm-Message-State: AOAM533jL/mxq1Ls4PNOkP6s6ra6+SGj/bsBEpKn9/DjRRvWT/8i40hK
        W01Y3POeQLJH3DNts7y0nZ6ZmSa0zXgllg==
X-Google-Smtp-Source: ABdhPJw+r6axp2bFiPuNNJwMqvLkZFFf1GWtnyjAS6wDFeDd30l5SPLGHrsZY7AjbSZeomVP0ZfVGg==
X-Received: by 2002:ad4:5cef:: with SMTP id iv15mr34974826qvb.14.1626861501124;
        Wed, 21 Jul 2021 02:58:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.147.174.17])
        by smtp.gmail.com with ESMTPSA id w5sm1646729qtv.3.2021.07.21.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 02:58:20 -0700 (PDT)
Message-ID: <60f7efbc.1c69fb81.7f03e.94fd@mx.google.com>
Date:   Wed, 21 Jul 2021 02:58:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4418879542612561996=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sviande@gmail.com
Subject: RE: [BlueZ,BlueZ] audio/a2dp: refcount
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210721091727.177872-1-sviande@gmail.com>
References: <20210721091727.177872-1-sviande@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4418879542612561996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=518787

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      40.69 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      7.11 seconds
Build - Make                  PASS      176.72 seconds
Make Check                    PASS      9.05 seconds
Make Distcheck                PASS      209.85 seconds
Build w/ext ELL - Configure   PASS      7.21 seconds
Build w/ext ELL - Make        PASS      166.28 seconds

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


--===============4418879542612561996==--
