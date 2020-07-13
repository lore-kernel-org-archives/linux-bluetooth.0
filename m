Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0E9C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D987E2068F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7RUEu0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGMGIb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGIb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:08:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A59C061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w2so5569314pgg.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lSPwcC2DR49/2//P8zU4LAtRpkobwSTOzg0X78esOCI=;
        b=f7RUEu0cdj/1L6Lg5CRbLSE6/0A7vqmf22meXZ7FOfuzdYsGlmgSAMZFCWOjA23L5V
         jzWSdrbnUf4t5axOnu674NhY2SY4aVtFFVDrJfUa8OgdpppZaens5g9SxJftDp/8uLBn
         Pxij9pFcbQEzDtM0fsP3GqjVUFvZOy2pur6EQ6P+6s7tn+BpBdEBQqr3j1jNrDZDpMvw
         +FkRW8UbsFnrClLfD2efuRVLouScgh6ZcLaAnXBa/QMuFc3F2WcF87H9e5xCwvNX0GkZ
         o0nEvtwgWMApZzYCcKA0pYfY3oD3HhKmMSjme7rDtZB82yLIiNA9DmzAqEFHyc10l9g7
         izVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lSPwcC2DR49/2//P8zU4LAtRpkobwSTOzg0X78esOCI=;
        b=tiDdYwlsot0x7IO/bLFyZTnZIjroebL86PdLwZ9xzNseFXJWqdvHiW5SCG99bjDb6Y
         ZvbCYRt7IAVxgDZVsNgfevnqBSByfMM9MxyPTJe6U/vzEbTgOQ+YOBLRe++sfGAdhRxJ
         /CAassUn8rnAk3g4XEcP0ucruva7yV7fsWIppcODz7L1Gz0VLca8ztHsA7NFK7dRSiHV
         N/ZqCRPYpKLhsfxwfMaAntuZkULDv8JREPbv5T/B+X+oEATYhLCYxambLjJln3ATOUf6
         DmHDHJR9zzNOGgemhS1nKptlwP72D2PxujGrRrB9WRGFX0S6Q5/CgNqbI2CVhNfRDtk+
         2vag==
X-Gm-Message-State: AOAM530BsGiCzDbcSIiZPLiaEzCeukYCD5zmjMzx32wOadttkQL1kjuK
        gx8C8jNnu9ftC8umGfs0xWuWkMGAlAZ3/A==
X-Google-Smtp-Source: ABdhPJw4gVsV8fUA2KeZou9+47d4OZBI3ITpz1HJygYvamBtNLegypBSBAvOqnDHDlN+duX6+Q0+ig==
X-Received: by 2002:a63:6945:: with SMTP id e66mr65331902pgc.177.1594620510558;
        Sun, 12 Jul 2020 23:08:30 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id e5sm12787172pjy.26.2020.07.12.23.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:08:30 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 0/8] LL Privacy Support
Date:   Mon, 13 Jul 2020 11:42:12 +0530
Message-Id: <20200713061220.3252-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

V4: patches are rebased
Added support to use set Experimental feature to enable controller
address resolution

Marcel Holtmann (3):
  Bluetooth: Translate additional address type correctly
  Bluetooth: Configure controller address resolution if available
  Bluetooth: Update resolving list when updating whitelist

Sathish Narasimman (5):
  Bluetooth: Translate additional address type during le_conn
  Bluetooth: Let controller creates RPA during le create conn
  Bluetooth: Enable/Disable address resolution during le create conn
  Bluetooth: Enable RPA Timeout
  Bluetooth: Enable controller RPA resolution using Experimental feature

 include/net/bluetooth/hci.h      |   9 ++-
 include/net/bluetooth/hci_core.h |   3 +
 net/bluetooth/hci_conn.c         |   7 +-
 net/bluetooth/hci_core.c         |  17 +++++
 net/bluetooth/hci_event.c        |  21 ++++++
 net/bluetooth/hci_request.c      | 120 ++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   3 +-
 net/bluetooth/mgmt.c             |  54 +++++++++++++-
 8 files changed, 213 insertions(+), 21 deletions(-)

-- 
2.17.1

