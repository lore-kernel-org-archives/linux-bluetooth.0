Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF922C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2CA64F51
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCDUZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCDUZk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 15:25:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212DC061756
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 12:24:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q77so32023819ybq.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 12:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=lZ0FJtfUdDFFC6RU9ZSIJt0rKXSosmHo9iw/4Mvpzwk=;
        b=vrbGm5fszjLQ+R57kUHGsIZgHBuXhLPTwcvQJHDdQCCHW/WNPw0nxgkZk0RUNO1HO0
         NG82AvC/wmQMQM7qCAWDI18fHdWiOUpqP1gFHfEj2KG6kvYQJHU2HK8WL0Y8OB9KWEa8
         sAzPesTA52yk08DVknxb6u885G6xDu1m4Dq7uUF6/bOkwN/1mSxTmZl66mi9YOElUJd8
         6gFzdipwB/DsRiW4PKgHAw7t5eVHydaM6hHFssDULM5ysxzLyITm99Q2ECc1ydgJYc1b
         zWQYF9GAo+T8GNq/VON2MVH3nm3JYbgoy52yRznwJf/4wAXFNz7VwworzD9HSLX5B11X
         BpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=lZ0FJtfUdDFFC6RU9ZSIJt0rKXSosmHo9iw/4Mvpzwk=;
        b=g7xc5vpUtH0HgTnnZda4NCiocjx98MJspCJgxR20GlpBtxdQINTbtrmUQkN+5yvxor
         g9aqppy9MltaNf2V5b4POPH7Hfkp53LWBUO/rf0szVM13fXEUun1XR3uyh/8aDduZxX9
         Hr4L0qa033mpgJ+fQVl7p+8zqXgPJXywENMZKOEUbJX6Vw7Cx3CfIxGni2zBhrCRWcka
         77k73V9X+wPQhIozsyvD0fDu4V4G++afZoWlEr+R/njNccW4k1sWn7+7gWax/fsI+2BM
         qBeyEXDTTuiWHByE4cXCJLh92/TVoAyJDWEiKRYVVPdWH7Hv5b0W/HEmkkeBKxFx3Dza
         9IQw==
X-Gm-Message-State: AOAM533UXALq1NvprqItj0Jm69ULoF5CposePMaF8vAOekQw6fvBbAqY
        sZ8x9b3RhewPg+aoapBUYQCS5b0TWRSzAfRbuLH27eKBokFLCyfI1yCtvPirCD9wjPxWbhuxB7l
        P6qHhnIpAaslGO74tssQ1kHQW4SKK9XYokoRJxrFvdpyhJhlGBFd9oNtpdE4xETxK3GEnOtXXlU
        r6rJ9MLfYPxTdgvVUt
X-Google-Smtp-Source: ABdhPJxHCay/KmlzQvIRj9Zz47H6czZjQsCbFogjVeV5hhKTDSDBjqLZa8hU+sz+95HOvUuLDolRFH6QiKDJ+WjUN2If
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:a873:4408:c731:b8f2])
 (user=danielwinkler job=sendgmr) by 2002:a25:ddc3:: with SMTP id
 u186mr8667885ybg.238.1614889499045; Thu, 04 Mar 2021 12:24:59 -0800 (PST)
Date:   Thu,  4 Mar 2021 12:24:49 -0800
Message-Id: <20210304202452.1998022-1-danielwinkler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH v2 0/3] Bluetooth: Fix scannable broadcast advertising
 on extended APIs
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

Changes in v2:
- Check kernel supports flag before setting it

Daniel Winkler (3):
  advertising: Generate advertising data earlier in pipeline
  advertising: Create and use scannable adv param flag
  doc/mgmt-api: Update documentation for scan_rsp param flag

 doc/mgmt-api.txt  |  5 +++
 lib/mgmt.h        |  1 +
 src/advertising.c | 87 ++++++++++++++++++++++++++---------------------
 3 files changed, 55 insertions(+), 38 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog

