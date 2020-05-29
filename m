Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4131EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105A9206E2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VJWUmm73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgE2P3q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgE2P3q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:29:46 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5CC03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:29:46 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id k3so926366ual.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0IsKODMXSzvMGSAh9Gryo1QBRpF6G8Og9IEBshvpoU=;
        b=VJWUmm73h98XahwgCptjJ+Q6ul+pffi67zEywNEE25FSK2SV3biFGcW9nd0nfN8hrW
         yooo2pvR6+zn584bFACHBN4bI03xvuCZJnRz+3RQ/NrLL6rw/LCsIroAuvzIKgLMPUj8
         UX2jhOh9n2pvrzPTj+sjuDXjO4tYtfXCPfcBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0IsKODMXSzvMGSAh9Gryo1QBRpF6G8Og9IEBshvpoU=;
        b=Wg0ooZ8Pg3Nhqc3X3Ckrc9QszZSNRZ8THv8iNKYrU8TR5eRPxO0izHoj0alnKH4zNc
         gKJ+IxDrxHH8QJmUIioCWz48/pkEG/piVH97N7J6SvgX8xoyhCUoiFDpaEXSa35KHYER
         FxAO0ZZY+5c0Oa9wTMcwqF1D9Wh59zcE9n3LGD3bZV3JQexL8E/Wqisj1wbj841Q3J1q
         GjcslgYeUOb7BMUYXXEnAGI7L19SgCaLDE9kfygDfkx0OO2mNnCArNP0Zi0Rp5T1GhAe
         58gurBJEXkJcTzIOLx8utwwanpFfs/+lW8xUeVjDb5ul3EiLliks8xDcEPDU6WI9GmvC
         AI8A==
X-Gm-Message-State: AOAM530AJV+UK+8U3zjpP18ZR02dN1zX7JDllgJuZI+L99tc68jliFpo
        B03+hssUKqz4nPH3TD4h8sAGxAwUTu0=
X-Google-Smtp-Source: ABdhPJz2Pb6RM3eaf88jYeRtLfTG4luRVTo+uKl8XQqe/CJMDoFFBEz9oISJTAEfmjzwSJwLnh5zIg==
X-Received: by 2002:a9f:318b:: with SMTP id v11mr6876568uad.46.1590766184894;
        Fri, 29 May 2020 08:29:44 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id c65sm1216286vkh.32.2020.05.29.08.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:29:44 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2 0/3] Load default system configuration from file.
Date:   Fri, 29 May 2020 15:29:37 +0000
Message-Id: <20200529152940.208214-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series adds supports for reading default system configurations from
a configuration file.  This allows a system to override what are
currently kernel hardcoded values from a conf file.

The dependent kernel patch will be posted after some additional parsing
validation on the tlv is completed.

Changes in v2:
- Fixing checkpatch warning that are applicable.

Alain Michaud (3):
  mgmt:adding load default system configuration definitions
  adapter:set default system configuration if available
  main:read default system configuration from the conf file.

 lib/mgmt.h    |  20 ++++
 src/adapter.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/hcid.h    |  39 ++++++++
 src/main.c    | 162 ++++++++++++++++++++++++++++++++
 src/main.conf |  65 +++++++++++++
 5 files changed, 537 insertions(+)

-- 
2.27.0.rc0.183.gde8f92d652-goog

