Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672B3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 15:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC1261882
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Sep 2021 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244724AbhI3PKg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhI3PKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Sep 2021 11:10:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0052C06176A
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 08:08:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id m26so5983139qtn.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Sep 2021 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIhQ6uh2LQ0nck1gqy4vQfAyci3k4/52EoefsnVDAjM=;
        b=pMBmQ5rYmq0hwbbOowCVAmjuqjutt9bYxqLJwaW/XeUMEM5XEke8JiT5NOeHhTCXqi
         LrPOmdB289oRpj2aYgbGAJUQZfulLWA8ca2kTfP/bKNt8CIeIBJfgaFGmUfkIuZ7J+Gk
         ZEYfCs5D1EczLTMh4816XHJ4wxF8EZ+0kWPm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIhQ6uh2LQ0nck1gqy4vQfAyci3k4/52EoefsnVDAjM=;
        b=fIWF1KQpMOzw0OSKuDfTe5gsDo/eT/uVel9vlmbheJLBPnoSsylDdo+S/Dyia11V2H
         bkl3Qa8V2YtLCoG4Hi8Iye6hxxBq4ySIIGlfZlvezYGmWADE1vuH6pyBfuANdiFS8WnS
         cc9CsoUad5EH0u4j3twPlUvzdV/RUyENkEJBRQEcMM7eE7j5wZY+MQP5ipy0rTt2600U
         TngPxLa1aRaK4ozUy3p+MXpQRsdHeMt384oVI6m0E1eGaeZap/oJrDOcvbQdLCBBmyV1
         YRtjdp/v5ldDpgacHkJP46WsZ/FWSmd20Q5PY92hzK7MhFmQop72VIlOgS2VtW0B2nk7
         iu3A==
X-Gm-Message-State: AOAM531tRryj+Inu4MzamVkXva+4Y0YQJpKzUghLyN817CndbjcqhwyR
        OGZuChc25ZVzckry9+7yQq4LexUP9gJl3bUN
X-Google-Smtp-Source: ABdhPJxDe8Su7TR/GAP5Nw33V+MrhxK4q2rpg8h+v4imYi6G3pVOCSySMTG8/X17BLIneO9GRScN4w==
X-Received: by 2002:ac8:560b:: with SMTP id 11mr7239429qtr.319.1633014513983;
        Thu, 30 Sep 2021 08:08:33 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id w17sm1573741qkf.97.2021.09.30.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 08:08:33 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v3 0/2] Optionally require security for notify/indicate
Date:   Thu, 30 Sep 2021 11:08:17 -0400
Message-Id: <20210930150819.34270-1-dmartinez@starry.com>
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

This patch implements this feature by introducing new `x-notify` and
`x-indicate` flags that allow a user to restrict access to a
characteristic's CCCD (as well as documentation for those flags).

Note that `x-notify` and `x-indicate` each enforce security for ALL
server-initiated updates. That is, you cannot require one level of
security for notifications and another security level for indications on
the same CCCD. I could not think of a reason why somebody would want
that feature, and did not think the accuracy of terms would be worth the
introduced complexity, so I didn't implement it.

---
Changes in v3:
- Split the `x-asynchronous` flags into `x-notify` and `x-indicate`
- Fix a mixed code and declaration error

Changes in v2:
- Fix line-width issues brought up by CI


Dagan Martinez (2):
  gatt: Allow GATT server to dicate CCC permissions
  doc/gatt-api: Add 'X-notify`/`X-indicate`

 doc/gatt-api.txt       | 15 ++++++++++++++-
 src/gatt-database.c    | 42 ++++++++++++++++++++++++++++++++++++++----
 src/shared/att-types.h |  4 ++++
 3 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.31.1

