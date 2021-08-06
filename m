Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37DBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D06960E78
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 23:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhHFXrw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 19:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbhHFXrw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 19:47:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0675EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Aug 2021 16:47:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j3so9186853plx.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Aug 2021 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZIGWuiCoc1camvi535r1KhRo6f/+bi2yF9HecPkL1M=;
        b=UDJxAARgf9/2EtvCfYOa0UcP8WSyyTK+UAqoJiQ2b+P7UYw2+w1jxKT9Ecc9cZagn9
         fm5RkQNzehWLOEEUCwdgN+SAIQTe1fNRN0FqznHKHBng/bbbzgf0Gctk1acPyDk96gBo
         vj7b9aAA5MclRT8ztbKdjphrKOx5CmJz5Zww0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fZIGWuiCoc1camvi535r1KhRo6f/+bi2yF9HecPkL1M=;
        b=hPbcR8O2GqxAfbWRj93146Qn5MHuGMvN3zVrBTWw5pp4+K/wxfUlb0rGmgadHDiEi4
         1ylNse8tYWRga20UCbxYNyzHrYQvngUezK78wFqlIioc5w0wTAL/Mit8XX2iAR6GUibt
         LKun7HPFWzDn9CEWGLsFaCtOixClKklFLbTJVFR9Rxe1Kt7KHd127kO5ijovyzvk7hEH
         Emsh9Wo9BrYs2zyhfUk+0T2KoYRckoT1EmMTwDZW3upS5rOABhsKILkOdDS2WEOVfqjd
         S98Qc2b7a2CHAhtb9mvz/WnNMqYtvM7XNchdIQs8KsiYUrnQ2EclukXXeEasUMA3UfHh
         8BtQ==
X-Gm-Message-State: AOAM530aDrzA0hc3b9poEHnceqmxpodeKzVtfDqiP9UWdEm5/XeJLW/c
        bB1Wz7IaBW3fbsa4w63GxRW6OGTN3kRf6Q==
X-Google-Smtp-Source: ABdhPJxbkYgiTWwY0bV4ArJe0lR3tIjaDX8yzFPf3jgKzRb31x7jDTOEaYgth+uTtqhfLcGcuWL37g==
X-Received: by 2002:a17:902:9f88:b029:12c:c06:2645 with SMTP id g8-20020a1709029f88b029012c0c062645mr10596013plq.21.1628293655300;
        Fri, 06 Aug 2021 16:47:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:48a2:9887:4da1:32a4])
        by smtp.gmail.com with UTF8SMTPSA id m17sm11655150pfh.133.2021.08.06.16.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 16:47:34 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v5 0/4] Detailed error string
Date:   Fri,  6 Aug 2021 16:47:17 -0700
Message-Id: <20210806234720.286157-1-mcchou@chromium.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

Changes in v5:
- Replace error code with error string

Changes in v4:
- Address make errors.

Changes in v3:
- Correct error-codes.txt.

Changes in v2:
- Add documentation for error codes

Miao-chen Chou (4):
  Add errors.txt to describe errors of D-Bus method returns
  BR/EDR and LE connection failure reasons
  Include detailed error string in Connect() return
  Print error code for connect methods

 client/main.c  |   3 +-
 doc/errors.txt | 233 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c   |  46 ++++++----
 src/error.c    | 100 +++++++++++++++++++++
 src/error.h    |  59 +++++++++++++
 5 files changed, 424 insertions(+), 17 deletions(-)
 create mode 100644 doc/errors.txt

-- 
2.32.0.605.g8dce9f2422-goog

