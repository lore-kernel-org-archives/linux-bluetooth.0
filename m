Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D6C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6086664FD4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCKSjB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 13:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCKSgi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 13:36:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E04C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 10:36:36 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w8so3890180pjf.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Mar 2021 10:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=7k5hKNsLSyIeiNQyQ0FlyZtaWQh0LLo5Whfbf8KAcYk=;
        b=cH6qtVNLkACcPu9Mk/1/KKN8SdEJrBX3b48f+ebr4aIHN+2LP7zu/mBTPiv2vyjNzT
         /YHbL4/Ip82Z6jlJe1WT87bwkkBuIQEDhkA5OBYiiblY3AF6D0e9fT4XgcYHwGd5ixWK
         1oOaujiTD10qwaWEhonK/RX9agHfCrA1QD3g7WRpHQCnNdeVHbxzfYzNIwEQdWfTsnvL
         FKxsd8tyiEDuTN+GwvEzfCxyFRgswQXTdz/Z22v/euvwS0wJ1zVydNFNopfvGe6EwLIk
         zUoN0s0Sqv1386iE/XO890pwlKPibKV3q8BISYtG11FzR10n/TIXhmMzAv0+q3dtTmRx
         XAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=7k5hKNsLSyIeiNQyQ0FlyZtaWQh0LLo5Whfbf8KAcYk=;
        b=BIxJxdLCZcArWA/UDzkLk9Oj18k/IRySacVu4HLy8pXhmN+mp4QV22iJTUFc07aC3N
         Chgx2Lsozrl1Xad9n/igkn/hFY/JHu/7kjUY9B6wbNQ4TT0qwdjVEvzJKMn4LagoOnmC
         vCJWfIEEN56W0bvvghyuLCpLaO6lwgP3jlDwpcUlbCLXmDEk+UpU6KM5g8QYJQeuEYk9
         1EvETVpeYuMJIaHCAQyO1q9h008YbUAh+0OKciCSrpSmmbBPh9NfU1CFJgYSsj5fOyjY
         yUrDW93KVGy99Co8Ljj6P63uI5Zrx5l6S31YQqxPTWDdWpDOOGeaO5toPjVKdZD8EmMi
         YOmA==
X-Gm-Message-State: AOAM533v5s54z1TgwNLzEySFtGjhgmQpITy2cqAsZS98h6t3sM0iwsLN
        lJmiTsy5dEiVDgafoVmT5pcrhK16jkQ=
X-Google-Smtp-Source: ABdhPJzpNwHMExfAIREIrFtU2r/L1YTXZFgMP9oUeIZ++6TgHFIJDP50yLUw9vzbZyfTu4lLlBj5xw==
X-Received: by 2002:a17:90a:ea91:: with SMTP id h17mr10212559pjz.66.1615487795600;
        Thu, 11 Mar 2021 10:36:35 -0800 (PST)
Received: from localhost.localdomain (76-14-108-251.rk.wavecable.com. [76.14.108.251])
        by smtp.gmail.com with ESMTPSA id r23sm3192094pje.38.2021.03.11.10.36.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 10:36:35 -0800 (PST)
From:   cdwhite13@gmail.com
To:     linux-bluetooth@vger.kernel.org
Cc:     chris.white@dolby.com
Subject: [PATCH BlueZ 1/1] emulator: Periodic Advertising Command
Date:   Thu, 11 Mar 2021 10:35:49 -0800
Message-Id: <20210311183550.11150-1-cdwhite13@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
Reply-To: chris.white@dolby.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chris White <chris.white@dolby.com>

This adds emulator support for Periodic Advertising HCI commands for
https://github.com/bluez/bluez-sig/issues/2. These changes are intended
as the first step in making the emulator useful for testing the LE
Audio Broadcast feature.

kpare (1):
  emulator: Periodic Advertising Command

 emulator/btdev.c | 50 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

-- 
2.21.0 (Apple Git-122.2)

