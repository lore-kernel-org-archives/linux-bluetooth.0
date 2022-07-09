Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518CFC43334
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Jul 2022 18:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGISfa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Jul 2022 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGISf3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Jul 2022 14:35:29 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5C2E6AD
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Jul 2022 11:35:28 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f14so1278956qkm.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Jul 2022 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DcgUCn9Ywit0aAF2rzURmXhjDwDOILjrvQLQXn6Yk0=;
        b=GgMae8Rr2MBGQp2Wd9CRdRyBo3L/JrKVM13iEEdwjgYnumpi4ta8DETGOIJRD9Y4zj
         91aXo0ZZ63v9nAngyY1N7YDSZuWMQhzorkBOjFQqnvHAwwdgYXP3Wu3OFMRMBRnJbuq2
         pR3VimVybDI8aVCtxr7o38pwy4tEjD5Va3VEsTBXA1sbvPzVan0m1o51f4w4dD86frKP
         UqNzCD+q9a3XUH9hTllL0J5BqkFYoYSXvWGloeDMPml0SqBnv9w187+INeF1T1U4q0HG
         gyZkBug0o9Hz02m4bh67HRZvmQqycWCsbShDJSBQlgro61vrtNU+piWq+T1pJzMvtWyT
         Kjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DcgUCn9Ywit0aAF2rzURmXhjDwDOILjrvQLQXn6Yk0=;
        b=gmuctKgvxH/QbLZrxw2k6vtUqSWPuoTt9cLNh6nrzTm2AbchgilXJ0jl40n2y36bEM
         +jpJN7Bvk0HI4kKDXahgD1p+op0qknrSVyBtveUTfpq4ctMU3JFlGEsg4I42L7ZhuoiC
         /hOVlahVU3lrHEFZxkjeRkjhnDmcRmq/8GOhOELXmRaC3yQRZiYoVfUqtNGbleg4AuXo
         obYHt57Zmunwc/5mVpUpGpJJ7gMFteDvy4s3GrY6wppgNUTeB4lIu/qwFozLzRL1onMZ
         Wkefw5tdPjA3K4UDnj+JqUKRzBqZnJZtp7BYcH7heb0QDKemKQR/pVUEJ/qoVvLg1EYE
         nbkQ==
X-Gm-Message-State: AJIora9xDtJMfifezO4vCOWQwpfTIZ50PsRkKYC1L7IKLWXSG2UDks7Q
        JSmbHjnyaDr67ZooTEOxifcpafGxSZsLhh5r
X-Google-Smtp-Source: AGRyM1tNxW0KKzVE7JlBMA+Fg/c2IoGgsUCeXwF4FhnISr4qEJG9yNreu30vza3ypf1zJiAtWetKCw==
X-Received: by 2002:a05:620a:2941:b0:6af:4f95:3ef1 with SMTP id n1-20020a05620a294100b006af4f953ef1mr6270779qkp.329.1657391727311;
        Sat, 09 Jul 2022 11:35:27 -0700 (PDT)
Received: from robotnik.. ([209.23.56.93])
        by smtp.gmail.com with ESMTPSA id g10-20020ac8580a000000b00304e2e4bf1esm1865961qtg.88.2022.07.09.11.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 11:35:26 -0700 (PDT)
From:   shwoseph <shwoseph@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     shwoseph@gmail.com
Subject: [PATCH BlueZ 0/1] [v2] ExcludeAdapter configuration setting for input plugin
Date:   Sat,  9 Jul 2022 14:35:23 -0400
Message-Id: <20220709183524.13900-1-shwoseph@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As a bluez user I have run into cases where the input plugin can be problematic because it binds both HID PSMs on all bluetooth adapters. Simply disabling the plugin is not an ideal solution if you want to, for example, run an application that binds PSMs 17 and 19 on adapterA while using a bluetooth input device on adapterB. This proposed feature would allow users to determine which of their adapters can be engaged by the input plugin. Using the ExcludeAdapters key in input.conf a comma separated list of bdaddrs can be specified that the input plugin will not start a server on.

shwoseph (1):
  ExcludeAdapter configuration setting for input profile

 profiles/input/device.c   | 22 ++++++++++++++++++++++
 profiles/input/device.h   |  4 ++++
 profiles/input/input.conf |  4 ++++
 profiles/input/manager.c  | 34 +++++++++++++++++++++++++++++++++-
 4 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.32.0

