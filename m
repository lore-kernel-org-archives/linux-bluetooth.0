Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D5AC433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 19:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD39610E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 19:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhERTFp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 15:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhERTFp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 15:05:45 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E6C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 12:04:26 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t20so8313600qtx.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Rt/4pjGKwXXTeedWAj8lqNJeVIH5C8t/kgGvCkVu4dU=;
        b=TTaVl7M8Kcz9ifcPMXj1K/9FNb8sco8wk5vBQ3ZDKta+KsX7p2/X2M11eLCj2T31g2
         j7h5zu+ibxxpYtvmgk0Rn8yIhFlRdszSGBphRS46XaNxfpMxD3GDkzVOrvdhy123CbtN
         d5MRvL3FHc0uyY9PU3qj6xXJyL1802S6saRTLZ/t6xztFGuDzBbKLab4TSPj7LRiQLR/
         O/A4ohrlchvwHhXuRgObx6hQUOBaGcEwQS2MjxorYGhf4PuRiKUNNb3Bf8Bw9xmhrJfG
         /aufqo9EofORCggf35bP/neBxbmFGW6wP02p1tvNvr9xVTuYG2iezoi+XfwRJUE8kpIZ
         RjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Rt/4pjGKwXXTeedWAj8lqNJeVIH5C8t/kgGvCkVu4dU=;
        b=ao2Rynuho6RjjwGT0Msa+hkdZwRpU/Gmf/N6loIuaQ3DVC5wiVRRc6VuE0I1hryCIV
         35O9ZuF+pbhCyX4wK8G3bm3Fti8OCxcbJU513nWSFVTwiBMRoUix+Ib8/EzKt7uFzfVh
         QyWovFcGQRVuhTH08BAcNsgm8UmTNMWsxOzJkGUQaOKz4G0QyDDwDvg/pQCWKfXE4Z3C
         lqMGvEGcdwQo71ZCi5Ny4q5d06N35pZybVxSNtZyPXvYf49LyfpLU2NbWw9xJ+1WV+LD
         y5tAfuk/dom2/jXMgBPTw5nDkXknDPwqmTPVpoZlDXakNWlhOkjkWEwKf9Oj9xBmCKvx
         3R7Q==
X-Gm-Message-State: AOAM530BqOVo8jZSCB/y21lYdr9hmHz9tAsn/QkIxL897OH5OMwuj2U0
        P1QleL+N0BvlAA72ynuL3GJDaNeKlKpHTg==
X-Google-Smtp-Source: ABdhPJyLB8lvkzoyKXzWADh3HX/671NbIsMVX7yH5zB3c2nMF1xqLCMAMh3S0Kc/KeYhpgeh9mnrHA==
X-Received: by 2002:a05:622a:2d1:: with SMTP id a17mr5119181qtx.88.1621364665292;
        Tue, 18 May 2021 12:04:25 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.139.105])
        by smtp.gmail.com with ESMTPSA id c20sm13876899qtm.52.2021.05.18.12.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 12:04:24 -0700 (PDT)
Message-ID: <60a40fb8.1c69fb81.62a81.a826@mx.google.com>
Date:   Tue, 18 May 2021 12:04:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2535496061836890369=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/3] shared/util: Add bt_uuid128_to_str
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210518183937.786605-1-luiz.dentz@gmail.com>
References: <20210518183937.786605-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2535496061836890369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=484525

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
GitLint                       PASS      0.40 seconds
Prep - Setup ELL              PASS      51.17 seconds
Build - Prep                  PASS      0.11 seconds
Build - Configure             PASS      9.04 seconds
Build - Make                  PASS      217.20 seconds
Make Check                    PASS      9.63 seconds
Make Distcheck                PASS      256.57 seconds
Build w/ext ELL - Configure   PASS      9.17 seconds
Build w/ext ELL - Make        PASS      204.36 seconds

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


--===============2535496061836890369==--
