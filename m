Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8865FC433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642DE64EEF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhCDAd5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244384AbhCCTV1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 14:21:27 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413EEC061756
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Mar 2021 11:20:23 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id o70so20898871qke.16
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Mar 2021 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=H1ANAzzpCuxI0QDUf89zqCD4J3Mhy28KptnEtTnb2C0=;
        b=JnEgVskb4oq9yqzfvjizI+GBL6HRnF5tiR9oH36kI5xoUPczVx8KRdpu/yY1TbuHFx
         QgeLPDYa3DlS2+u00+gpDIw1DE0tDydAqjb7a9oFa/fIZGzH7TJllnAGI9yLNH2d6vJg
         mDgwV8UecHzMxa4O012gOkdkWtb0UUugNIxb7D1FcglCJlv21yo/DpU2rJW6OC9h48+E
         xaqDoUB/9q11UPw1Q6Hkbh9qm8r4Cehz7at4HULJkQ8TZVVQy5FyRKag1YzN163M3zLs
         OPcQZ+xuYkqycTN9FA+jFD1aTRd94nDxmJWjbsbl+a0iPw6aOBjxLpoKpYoa4I0SKL1x
         +wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=H1ANAzzpCuxI0QDUf89zqCD4J3Mhy28KptnEtTnb2C0=;
        b=d6F6kDZ7YcGwpvFp4clL37+4oMbbVGUHzopJNzq7EnETTI4qbQMaL6oblxPTTKT2l1
         XbhJC+iZUlAPunoBleSXhbzctfcIb7hPOLaiU3PTt3bNBt7ebQ1JEIzk7e7NcBZfJbub
         5eYqMY0E/398m5H5tZM9zWl/1cXCsUH2XPCm8Zv3TT4vfMYfGV9/W8CmUdQoP5U1Mf9Y
         rWminxMET7vPnTVwFHRpJVGia2l7Dl48Bk8faPB8Kb9Dh/PwzfWZFRdZhdLRrv74zM87
         9jaq+6oZwuXs4eMl3LeX6oAuDywC+riCvcAtQTHsfRkU2nKhscFB48EYjNPiczmVoqZy
         WQHw==
X-Gm-Message-State: AOAM530SUep0zbVlK4e/o/z5T7Z3gvpdJuZicQPHoDxWHGIaHb7rKRcm
        GRd4gL5R8KzLLE5VO/FxnChpA6DymDmAwkupkcAFiVd06tTbiPP81cA9t0ioHWoPAJLEGxIXufn
        hYKTxixCY+sJprEwsjLnTmnvhKmvyBKh7Ulm2JCfvWQyuqkgilpHhFZOvaLMqDDy1mGJdpX+VtP
        FbqWNJNYbN7/0+V1zU
X-Google-Smtp-Source: ABdhPJwEYnH6HC/wuzIxadwHONGCQbcYhOe1yEm1N0FBvHrhPTYnqNNiHHdPmEqxW5UoSQJGSJhzJ+fnVzLFt8SO4ZQb
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:45cc:69de:aba1:a948])
 (user=danielwinkler job=sendgmr) by 2002:ad4:53ac:: with SMTP id
 j12mr379109qvv.3.1614799222296; Wed, 03 Mar 2021 11:20:22 -0800 (PST)
Date:   Wed,  3 Mar 2021 11:20:08 -0800
Message-Id: <20210303192012.1695032-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH 0/3] Bluetooth: Fix scannable broadcast advertising on
 extended APIs
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello Maintainers,

We have discovered that when userspace registers a broadcast
(non-connectable) advertisement with scan response data, it exposes a
limitation in the new extended MGMT APIs. At the time that the
parameters are registered with the controller, kernel does not yet have
the advertising data and scan response (coming in a separate MGMT call),
and will default to a non-scannable PDU. When the MGMT call for
data/scan response is received, the controller will either fail when we
request to set the scan response, or return success and not use it.

This series along with another in kernel will allow userspace to pass a
flag with the params request indicating if the advertisement contains a
scan response. This allows kernel to register the parameters correctly
with the controller.

The patch is tested with a scannable broadcast advertisement on Hatch
and Kukui chromebooks (ext and non-ext capabilities) and ensuring a
peripheral device can detect the scan response.

Best,
Daniel


Daniel Winkler (3):
  advertising: Generate advertising data earlier in pipeline
  advertising: Create and use scannable adv param flag
  doc/mgmt-api: Update documentation for scan_rsp param flag

 doc/mgmt-api.txt  |  5 +++
 lib/mgmt.h        |  1 +
 src/advertising.c | 83 ++++++++++++++++++++++++++---------------------
 3 files changed, 52 insertions(+), 37 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

