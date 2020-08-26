Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA81C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD5A2076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uRpF2yvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHZURV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZURU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:17:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A878C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:17:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l67so4318907ybb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5f/lN0/70bYXYJZSh5TJQuXrKMG7Gi5D2DcObKSQfRQ=;
        b=uRpF2yvlvVv9aEyURzj8IXIHpHZrVxIKfyuUpz79LL4JhK/iVVoI4cUEuMGvOt50oc
         2Zn49M4jL8/pvHXUPYRnhI/U/mQmS8/TUCz8ukWxM0V8Mt1Zz0X7M+0H8IgesbdWXxqg
         aFPJrWTmQXzpaUCTFvvFlUonAruXjI5TGwO2AFm08jjejXpPB5j6VmkiGDmzGvK18Bih
         rr1qPJNeXYjc4zUA8KdRUN0/Nj192Yd5K3Fa2NgQuqirIPHiIkbb9VvF7dnbcszKg7L3
         AruYtnjBLgdLb6Oh0BA37ccwRZGatBv3L/tyCt5RXjXSfn7ZG8+pkEW7s5RKyHRiv/bG
         ekbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5f/lN0/70bYXYJZSh5TJQuXrKMG7Gi5D2DcObKSQfRQ=;
        b=gOsYWjATFZW51TbRgkp9rcI7lONgBz0g23/Fakzb3cPRBqUHuJcJRO7nTCEq6vBv+m
         tCPCNtolMCQT7S01oG65bJcmkzwSGqZ0VZ4je0vTDSZHlANlTEjU7/DUFoQjdGDZC3U9
         gv7wCjEXYM7TZh85WOsT86DIIL2YaZebb0vTw5/EwOB2xoOZSqU980iJGRRc3aujJI5j
         DmFVR0wV/DWi/UrBIvROce9axWtmdrHeuD8fnZWAsZq2/Y26sSnkAfkFfbZgxyYftUIW
         W+exjeq2Vj5F589Eu0M84RPDkBxon4HcFgCsIUvbwmpeQyy+UwD5S1PoRgoJwmBgMmTj
         Tuow==
X-Gm-Message-State: AOAM533+15noeEu0Zidi0z7qRr384kpR9bgj15ubY+tyeuPpeO4KfXiU
        YXqWNYIBHpKsMtsl27YjRoVVssOBU6khx3dWkCR+chO+MENzIGMSL/WyzZGdFANBrY8wmSC5gZr
        Pm1HvKcqzfpS8v/tyTthgKusdbNJGaCCe7xENq/9XuB7XWz8WHRTI/Soo/B90UKcnIpG2O9efaI
        2wZJJuMj9wYX3AJlbW
X-Google-Smtp-Source: ABdhPJz1IStXfh0rJivPlGVe4gbKEtd1FOsFD0lbVX04afPvS3TILMls5lXlGck/PYTHV3kXRlNgdJ4MY8kV0EMtzxC9
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:3556:: with SMTP id
 c83mr23823765yba.412.1598473039702; Wed, 26 Aug 2020 13:17:19 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:17:11 -0700
Message-Id: <20200826201715.1911816-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v1 0/3] Expose extended adv feature support via bluez API
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Maintainers,

This change adds a SupportedFeatures member to the LEAdvertisingManager
interface, which allows us to expose support for hardware offloading and
setting TX power on advertisements.

Best,
Daniel


Daniel Winkler (3):
  PRE_UPSTREAM: advertising: Add SupportedFeatures to
    LEAdvertisingManager1
  PRE_UPSTREAM: advertising: Add adv SupportedFeatures to bluetoothctl
  PRE_UPSTREAM: advertising: Add adv SupportedFeatures to doc

 client/main.c           |  1 +
 doc/advertising-api.txt | 18 +++++++++++++
 lib/mgmt.h              |  2 ++
 src/advertising.c       | 56 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 75 insertions(+), 2 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

