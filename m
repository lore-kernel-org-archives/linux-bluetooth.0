Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBA2C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjCWKbf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCWKae (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:30:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6C4212AB
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:27:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b20so51319396edd.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0vh56DrwmiOLKSzQrJTF6Mh2GigCOXzXUVM8dmQKc0=;
        b=cjewgcdT5HvjlsquzxUgBC8i/rFbXuYsuPP6VUqsZqeMzPtVTNGBt5TSHurQiKMwNJ
         lJAXSWWZjgeivpAd3PSaEC2vwa3mDuyMujuwNSeQ+5/jYn3XNtO3zcl8qbMDehMm1FO5
         NQOcllFufy9rm6kbHLy7h/3CybdqPrHjHwZAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0vh56DrwmiOLKSzQrJTF6Mh2GigCOXzXUVM8dmQKc0=;
        b=uNKFf+gB7bjcvJFxG2m9wRz8VdGPH2uTWgf+gijPo2nC58ztSuSXPH+O+lCK1im9cA
         fLNkocsTV9w9zBEMKmAbRnoom4bso93I3Jfo4z9RFo0Xewz/viRHE3cNa+snN/wdQJiK
         0hdts/gZdLkoSTW3LesHhi4RCCzd0DKb2CcDCpXy6/bCrZnnFnR5AA0oZSefd7xTR+Iq
         og2bGAh2Zt2acjsQVyo1XooZuD0wm29D/hUhSyVNMkruR+YJnY6oteiTZCBGQrxHDGnG
         kPqItPPd00WoiBJGnoYft5lxy51M8v3qppvoFu1Co6YJIPz07pHUs3fGNvHaQCfH7NZK
         RvNg==
X-Gm-Message-State: AO0yUKULC6V96LzywvYDI3gWTJLQPmILyRBBMT7M96LVvaP9mLqzJnU8
        APIsnY/rfV1Cw92ZEjE08MNJoAn03YyO9rHJ09c=
X-Google-Smtp-Source: AK7set90G17z9ISbuA2kXUKUdyT69V1PXsekw+ISJnvLajuJNMwYbAdcee0L+hKAGV2lUmNfXaYt2w==
X-Received: by 2002:a17:906:e296:b0:92f:48f0:736d with SMTP id gg22-20020a170906e29600b0092f48f0736dmr10193684ejb.62.1679567254492;
        Thu, 23 Mar 2023 03:27:34 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id u25-20020a50c2d9000000b004faf34064c8sm8880564edf.62.2023.03.23.03.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:27:34 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/2] l2test fix+feature
Date:   Thu, 23 Mar 2023 11:27:30 +0100
Message-Id: <20230323102732.566440-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

Added fix setting socket BT_MODE
Also added minor feature enabling hex input to PSM (e.g. 0x1001)

Best regards.

Simon Mikuda (2):
  l2test: Enable hex input for PSM
  l2test: Fix setting mode for BR/EDR l2cap socket

 lib/l2cap.h    |  2 ++
 tools/l2test.c | 27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.34.1

