Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9736BC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 19:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7446B610A8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 19:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhESTDP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 15:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhESTDO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 15:03:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303AEC061760
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 12:01:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so3991598pjo.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 May 2021 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hWGeEImgPmQzJEGWrgcF/duPgudBkyrmJ4sJHqmp+Mo=;
        b=UE4VqJVfSyPLk33K760SyJ73UCI2HCpnk6bseC/4Nwta1/Oslm54Rkvx4XN25gn2qO
         YXK1m2d1vG2hEO9UOZdtxDax2ezeLfQoOxaPqzDja1KqQlju4YkD+jHXJhNfewaitnRb
         4+ylW0mRb4ayrXbcIkTl3WQRFg0zAqs4EL9r4VL4j9IdJ/0tRHw69+hj2O3tAZCjq5Ad
         B3vru5jAjUiy3bhyPNGhcdGIhfEsqm26g8aV057RxdGKEItMN5Iw19URMlSTsfqKfoyZ
         r3BJ+iM+hnvyjeYZ2rPvWvQTSL8vG4yvXqUJTSSqfqwVyWjRx0jBOYxz9BJO8uUp8N9a
         8Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hWGeEImgPmQzJEGWrgcF/duPgudBkyrmJ4sJHqmp+Mo=;
        b=PASGZLup0EIhHhEbmrTSloi9nq4aEia+2d33eRnRUvdY2+FkDJCm+VocWH4e9UI5Xm
         ZMujh+LQfJ0sgaVtF+dvuspEBaHmBTJwWAvzO36d8v0ViycdAa/7rjzEXXxvpqtrDPY2
         P2sQ+RiQRkBWhToguMCqMQ3GsW06xQQCC4ROeT+EyZNjSxbZuyWn3FoSQXDWvZtoC/ft
         4zMQV+ImQLlWWL9VkMAjQYEU+6lkWlr94XgNW2no8lWp6is7MctlKX0MC077KMIgM4fL
         3WShJU52npxWt1g5ViFqTbuVPKXh+G5f0OlqQtVRUbr2HBxoZbUDSWTtHHnNsivLSfCK
         ZixA==
X-Gm-Message-State: AOAM533mZrOtXHw77WqErWNUrHd0XbnYsSXMkPrJrbcB0ZKLhdKlNSVZ
        3xIgi+VPvqGo7soWQlisk2/7h7jMJyk7vA==
X-Google-Smtp-Source: ABdhPJyYdcKVTvZN7jBAA3ir7MltKjOQXQMAkSAgmpdOVLTHkf15Vz7o5WxhF04JtbYf6/GtTWNPrw==
X-Received: by 2002:a17:902:6ac6:b029:ee:e9ac:5a19 with SMTP id i6-20020a1709026ac6b02900eee9ac5a19mr1000509plt.43.1621450911653;
        Wed, 19 May 2021 12:01:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.229.21.193])
        by smtp.gmail.com with ESMTPSA id r5sm4816315pjd.2.2021.05.19.12.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:01:51 -0700 (PDT)
Message-ID: <60a5609f.1c69fb81.4ae7c.1067@mx.google.com>
Date:   Wed, 19 May 2021 12:01:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2356694334984827550=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: OOB Authentication improvements
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210519182150.1680987-2-brian.gix@intel.com>
References: <20210519182150.1680987-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2356694334984827550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=485239

---Test result---

Test Summary:
CheckPatch                    PASS      1.78 seconds
GitLint                       PASS      0.63 seconds
Prep - Setup ELL              PASS      49.25 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.62 seconds
Build - Make                  PASS      214.90 seconds
Make Check                    PASS      8.97 seconds
Make Distcheck                PASS      252.99 seconds
Build w/ext ELL - Configure   PASS      8.65 seconds
Build w/ext ELL - Make        PASS      202.95 seconds

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


--===============2356694334984827550==--
