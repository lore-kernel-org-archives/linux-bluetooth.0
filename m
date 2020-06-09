Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C39C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BE5207ED
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SZmU3EiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgFIOEA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgFIOD6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 10:03:58 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30705C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 07:03:58 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id i1so4894750vkp.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3L0T/kPWaApJr3y242zYjxv2NxisenLnw2UesIvHR8=;
        b=SZmU3EiLLg/J3SNnvZNmiOFRWPhW8F23mfM40096TK697QBGFSCTxI12fnxuTqXIvK
         xUlXOOGLzL5wWjSuMtoxjFuKPnvxaDV1AwxHc2cJ/ZxLJWNSC19D7lXhFCEKtFPOs0S1
         2QkxnXhbmSuzFFOY7sd91PZRmkb/qOBDPbPEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3L0T/kPWaApJr3y242zYjxv2NxisenLnw2UesIvHR8=;
        b=lSX/VH+E/kQ+aJ7T+1MUOg6Lm3IvO8gexqR/7K3TYj8OzHMcUL3R9oeZn7hpckAAN1
         4Ej8aEKYfsQvZlD/Y0XNboPMUSPz1GoMtEosowpFiPautj53/KNZ5DalqwMhYMDd1Nbq
         Ta0GxwuEfoP9YlmLoxQrn3pDMv+w28550gCp3RuLXx8kLBbmOVw7J3H+GAlwGzH1nUff
         69VE7iibfZqGLJFzpa4nBYsmQG55Jpm2KdolYlMFX4JVg4MURC2JfCmHoqDxUMb8mrVx
         dloSmJvaU1T8ICcG4amptULZIxwgSUpDY+JJz5wPSGh6keT470t7CxazNEKfiAAHUEfp
         qwQg==
X-Gm-Message-State: AOAM5314EhRgJcA3dPIAVsCAdDyJbq9N6p6VZ4YZxDUJYDji+FCnVd8f
        qhORIzeShNbp3Edg1AyN6FDZ6/gIyvU=
X-Google-Smtp-Source: ABdhPJwdfwz592sURmGEg4hyuQ0UzLQeQV76BIlyxHKaLBKKh4MBSGTRSG5UBdaycg7A9sG2EudnQQ==
X-Received: by 2002:ac5:c94b:: with SMTP id s11mr3129731vkm.8.1591711436311;
        Tue, 09 Jun 2020 07:03:56 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id b7sm403849vsc.13.2020.06.09.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 07:03:55 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v1 0/3] Support reading and setting default system parameters
Date:   Tue,  9 Jun 2020 14:03:48 +0000
Message-Id: <20200609140351.153833-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series adds support for reading and setting default system
parameters from userspace.  In particular, combined with the userspace
changes, allows platforms to override default system parameters from a
main.conf file.

The series has been reviewed and tested on chromeos.

Alain Michaud (3):
  mgmt: read/set system parameter definitions
  bluetooth:centralize default value initialization.
  bluetooth: implement read/set default system parameters mgmt

 include/net/bluetooth/hci_core.h |  18 ++
 include/net/bluetooth/mgmt.h     |  18 ++
 net/bluetooth/hci_conn.c         |  14 +-
 net/bluetooth/hci_core.c         |  14 +-
 net/bluetooth/hci_request.c      |  15 +-
 net/bluetooth/mgmt.c             | 429 +++++++++++++++++++++++++++++++
 6 files changed, 487 insertions(+), 21 deletions(-)

-- 
2.27.0.278.ge193c7cf3a9-goog

