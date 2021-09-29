Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B4EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38DB6135E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 16:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbhI2QSt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbhI2QSs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 12:18:48 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3CC06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 09:17:07 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 138so2825259qko.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7YziGfzKm59x/gLYmkXAYDndaZThTUE+yg+hbqFc0E=;
        b=MivqT3OI8P8nKLpE7luD58bLPa+00Z9L2wnLcUyPm1x40dCVfuZknHAzGJRkyTgsBX
         yxnc3UtPRl54gOoBWRIu7yqTCDTipbbpauwtgb20THPy/KTE8JmJpJX0KN/aXjC5s3fw
         4I51/GYyvC4/IPh9Cf3ApcLVqD5Kawqy3cCmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7YziGfzKm59x/gLYmkXAYDndaZThTUE+yg+hbqFc0E=;
        b=BScciqL+BMGeO7tODZagnS77qxRI339qGcbq9KztFO8PAt1i48yRAHohfNSNz05jub
         qJ5N0E7bV137SVGgst/saq75zVrtFxKtL3cX7HxQdr7+CfQ8n1DjgFkPxW84yzo5gqwV
         kQHGwQTlf93C2udVRsr6jP6XSMzt11S0NEU8KRmCp3lGL/ec/yompWuq9lKrOWuUtKd3
         Mf2p/jXR3xMH5sMLTAzudHquHRVe+WVzEAPFOcmig4E1uZwBOiBc0KfozYg8p7QqdwV3
         LyxtJaXvyaJxdfww0gJV9awFoz6eIsjfnOjWjF5rMOamxXPFHKjyZrQia2uK6yelEeP2
         /m9A==
X-Gm-Message-State: AOAM5335ANvxdB+bgW1W4IzJ0Id6QLMzAQggP2ugSMBeRUTLAMslz22O
        xxMn2jIWIFTFc+eRv8jtxjPEtCqls3RXUg==
X-Google-Smtp-Source: ABdhPJwcL6VJ2PIhy+0yRQI1m7Li99wDhW/qNZj0NtcbiFz5+tvMXgMswJTHugfB45ZvhNLoMxAJmw==
X-Received: by 2002:ae9:ef8c:: with SMTP id d134mr614092qkg.290.1632932226315;
        Wed, 29 Sep 2021 09:17:06 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id 205sm165863qkf.19.2021.09.29.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 09:17:06 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ 0/2] Optionally require security for notify/indicate
Date:   Wed, 29 Sep 2021 12:16:54 -0400
Message-Id: <20210929161656.413300-1-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In some cases, it is desirable to require encryption and/or
authentication for server-initiated updates, as they may contain
sensitive data.

Currently, there is no way to do this with BlueZ.

Here is a query about this feature from 2019:
https://stackoverflow.com/questions/55884233

This patch implements this feature by introducing new `x-asynchronous`
flags that allow a user to restrict access to a characteristic's CCCD
(as well as documentation for those flags).

Dagan Martinez (2):
  gatt: allow GATT server to dicate CCC permissions
  doc/gatt-api: Add 'X-asynchronous` permissions

 doc/gatt-api.txt       | 11 ++++++++++-
 src/gatt-database.c    | 29 +++++++++++++++++++++++++----
 src/shared/att-types.h |  4 ++++
 3 files changed, 39 insertions(+), 5 deletions(-)

-- 
2.31.1

