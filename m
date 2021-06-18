Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A06BC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 00:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE21613B9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 00:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhFRASi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhFRASh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jun 2021 20:18:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D268C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 17:16:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x10so3792310plg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Aa4KUJmDkE8M9Wn8OQjAAa5iU1uLtL0Mu1wLeH3puU=;
        b=DHiDm6xlh4cxQDv8TRkyB5P8OQI34CKGdv92JzVjy0CMFZslh5P70syjDppQGJj3Kf
         4rOp+lip/kfFTllQVyHZDBAPwLJEZAa4XhVyDKBDtsOq7xVzPgSGTKcIau4K5YdG3q/x
         zfKy7kw8bW2XTNXThO1SeWfEUNeXs5BNoVoEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Aa4KUJmDkE8M9Wn8OQjAAa5iU1uLtL0Mu1wLeH3puU=;
        b=Lr7TQ/v+kUe8u/o6zmEkbufqSPvPvR++aMzZ7uZeBEkWldU05M2KmHCOxfetc1QTT5
         3d7nvncbqzqme1FKRRQ9665oRlspp5zL+2MmcjdQZmwNa/59wu6Jbj9z2CV4CEYNofbQ
         PKukKTf8eDgfl2htO8tUk5rVrrdHBdrFoyqJz2wb2pmEn7TnaRwHbpxjqzNG9Ygv+/T4
         3JLAK7vehHZgalOkQOzwbCXaK+NASQAAr1dQKoXcat6REnYPEaqoCf5mIGfSofk4RHKH
         vfUM/8g3ykzowHa3LW69plKovQeFonSDrYm3MdTx0TRroFQURtmZ0BdHjnSQFeiu22kA
         XI+w==
X-Gm-Message-State: AOAM532IPAguMyOasLnOQmdhAcVMnm8ZMCtUsKcI+zWMyPQLsy2yroQz
        vy4ZJiARhs1HFkgOy+SYSQSpMMASztfUDw==
X-Google-Smtp-Source: ABdhPJzWl06kYivl4eD1/k2TB0s85I5R0IGaM5S6lwLdCGaBQuNCeQLYcHuaqcVXKX+BNXnGAmWKRw==
X-Received: by 2002:a17:90a:558c:: with SMTP id c12mr3745225pji.166.1623975387292;
        Thu, 17 Jun 2021 17:16:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d75:da94:7930:935d])
        by smtp.gmail.com with UTF8SMTPSA id w21sm6170016pfq.143.2021.06.17.17.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 17:16:26 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v1 0/3] Detailed error code
Date:   Thu, 17 Jun 2021 17:15:56 -0700
Message-Id: <20210618001559.1284204-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi BlueZ maintainers,

Chromium OS has been working closely with Linux Bluetooth community to
improve BlueZ stack, and there are increasing needs from applications
building their features around Bluetooth. One of the major feedback
from these application is the lack of the detailed failure reasons as
return for D-Bus method call, and these failure reasons can be used in
metrics, optimizing retry mechanism, hinting the reproduce scenario to
improve BlueZ stack. The current org.bluez.Error.* are serving the
generic errors well. However,g given org.bluez.Error.* errors are used
across different interface context which does not serve the detailed
failure reasons well. (See https://github.com/bluez/bluez/issues/131)


Miao-chen Chou (3):
  BR/EDR and LE connection failure reasons
  Include BtdError code in Connect() return
  Print error code for connect methods

 client/main.c |   3 +-
 src/device.c  |  52 +++++++++------
 src/error.c   | 124 ++++++++++++++++++++++++++++++++++++
 src/error.h   | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 331 insertions(+), 19 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

