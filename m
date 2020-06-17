Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718EFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4884621508
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRBm/f7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgFQHzk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQHzk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 03:55:40 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21448C061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:55:40 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 140so1171159qko.23
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2020 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=MYXgB1SKK1/+rMc2dsKKYJgkHIkbzjHh5XBszLpy1Vo=;
        b=MRBm/f7K7hRLqFZ6PHPIkLdhYvyE85zwG7aXO162t2BwkeoKF8n/7MRa6W8GE2uRdu
         7At/yXMd33QjbGdKRwIKGQ1C6Jjt7lT7hw5oDzucmjAxBaUtCj/jWKBd/TRlB2i1emZl
         02R1SHcYN+TDdkjFmQ49rHoq1tfnEQom3iWezY6IKbvjjZsTTJ6b/+b9Ea8ikmF81H66
         TP77e3E8GunyywabsnKfELHZ+ZLu0HUYkIfNSsGycg5o54VGaxm8gURvLEmj3VV3ydfB
         DR9GVopR/2XcrQ1Pb48xtpV639VWfmNEi4Bek4j+uk3FXZEoBfaMS7cRdgXwnTlRKLgB
         q5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=MYXgB1SKK1/+rMc2dsKKYJgkHIkbzjHh5XBszLpy1Vo=;
        b=pMaDbVp2N07GghBtOkvGMB5IUvJA4bP7PTCfiUpzQG/7/bkVSSnabEd9DksqYp2Ikx
         X0ADDAlDcwrYH1jrnrP7WyZ92mV3/PGFMO6kq5SpxzqM/rmeUMV7iAXqk1piI53GqTO3
         gYEzkKGnf5TWNWF8lTr0Jhiyk8JF2E/lhtj5eCchw5GX4B/FCVLLmbSXmiiTlATjtkEy
         izn5tKSstTWUOvMRBVCMynYSL+GI0Dzm7J/1ielGTrVM1mjhtAW0hpx5Py8lHZPMq2q4
         jRTQ+oG8XscynTKkdlmGw3NsYHHbJIKCeAljUlo/PHvSy230KFvmWIN77TU9FyRTqd9p
         zTIQ==
X-Gm-Message-State: AOAM532yv30zft1nuoKPHyBNpwX4V15IGjZ7FC0jMzuk+X06MgK34MRU
        /OQtjwlSiUEJLHb1B4T7u8vkwknlaXW+Op/deFP09yrLSMbIUHPWl8FYPJGxAy9y1rJbmqVU46r
        nvAUZ5d4xce0HRBi6o4UvvEuSgW4ukZUvLMc8NtYSs61kptLV/DPYhCeXE9wHWK/peZSGayaDfj
        lbJpaqSHG5Alc=
X-Google-Smtp-Source: ABdhPJzio49WBxobSJ8RAD+sf0Ue3RHvhJiTglkwqtKsZwPI7tL+Q81KOCwNYoV0EDDWpwG2w2ERBUNnNkuzxdclGg==
X-Received: by 2002:a0c:b507:: with SMTP id d7mr5879099qve.133.1592380539181;
 Wed, 17 Jun 2020 00:55:39 -0700 (PDT)
Date:   Wed, 17 Jun 2020 00:55:33 -0700
Message-Id: <20200617075536.98672-1-michaelfsun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v3 0/3] Add new commands in btmgmt to support adv monitor
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        luiz.von.dentz@intel.com, alainm@chromium.org,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-bluetooth,

This series of patches add support for new advertisement monitor mgmt
opcodes by introducing new btmgmt commands into a new submenu
'monitor'. The new commands are =E2=80=98features=E2=80=99, =E2=80=98add=E2=
=80=99, and =E2=80=98remove=E2=80=99. They
provide the ability for users to query supported advertisement
monitoring features and add/remove monitor filters through btmgmt
console.

Changes in v3:
- Fix build errors

Changes in v2:
- Move features command into submenu and fix build warnings
- Move remove command into submenu and fix build warnings
- Move add command into submenu and fix build warnings

Michael Sun (3):
  btmgmt: Add "monitor" btmgmt submenu and command "features"
  btmgmt: Add command "remove" into "monitor" btmgmt submenu
  btmgmt: Add command "add" into "monitor" btmgmt submenu

 tools/btmgmt.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

--=20
2.27.0.290.gba653c62da-goog

