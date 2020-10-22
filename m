Return-Path: <SRS0=kcDe=D5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBEBC4363A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC0F21481
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Oct 2020 08:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JChkS/Sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444039AbgJVITE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Oct 2020 04:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443979AbgJVITD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Oct 2020 04:19:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D76C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:19:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v22so542796ply.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2020 01:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5m6ZGsKaH/N8XvxQ4ALyXU+hvfHLp1e0FEIh1Vzuhc0=;
        b=JChkS/Sb8Q0ZPvBAyrdYSEtF5Zf0LUtMy4jPo6zTHN8NOIAbmgy04qkAllAGi09pHD
         FrDjxReoV26u1b2iRj/1tKN5KCKkTxWyvIXt9PNH/zbSufKouXpXFuDSOHIS/VPuvLke
         1oDySNgnADHR07Lun9/DWPN7ncz33Sc+GQ0vP021FxjPnUIKoFxWNxKvfY93nK4tcN6j
         k9a0aEC+/ZeGJiQDyTZyvb6ApLfouIXe5G/vd37DG2zbHBjQnT0F62LDnp8eHRT55gw4
         DL8RCUy2CL5wNrOLBs/6NEtzSmPONDZOQgBvF3WX7uhOlH9IWqgqMWRaqBBJaziAfrFW
         kG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5m6ZGsKaH/N8XvxQ4ALyXU+hvfHLp1e0FEIh1Vzuhc0=;
        b=tRWsO2jC6/h3k5UW6Ho2N15CfTxEAk34+wPXotPegFlfLFw0NiIKhD96UShYF6Q/YB
         hJ2q8Oy3Za/lNQroR0OjxY/w0ew3NJzjwnU7EhaI+dKb0//Ng6Xgg8L+uNnEmdfmTCt2
         m5kcVxbBAhYqbeatot6MyzLTh8wR7njPdvj06xzzzOJ9AONYmp5SZdaLa7nXthlZzY/t
         1VUaxC5/JtPdn6kKZA1Bky9hEV/5vdxdNx9CYrDgpkbWlJZHe777Wt1M3Y1sEmY4AcQG
         bu+d91PwehrMg+qb3XyBs5uOWvy6W3q4DkbAbDDJIQRqsWyAHc1g5v7JNj3SH7CIeGy+
         k4gg==
X-Gm-Message-State: AOAM530tnTDJloq8oWfAWDFkHAMBpB64Cea98Fw48D5QlpFHy2GVJtfN
        /cq/J2WVeDXw2t0ItZSN1alwXYczpyADq00C
X-Google-Smtp-Source: ABdhPJxOUNTNHRSSSH+HGckucpjz4gQL/z8wUU7sOUGLuGxiSRyrUDs7LBKdUBQpl2kDQMJIEp32lQ==
X-Received: by 2002:a17:902:b488:b029:d4:dbdf:c6a5 with SMTP id y8-20020a170902b488b02900d4dbdfc6a5mr1470188plr.42.1603354742908;
        Thu, 22 Oct 2020 01:19:02 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([134.134.137.79])
        by smtp.gmail.com with ESMTPSA id j5sm1179514pjb.56.2020.10.22.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 01:19:02 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiran.k@intel.com,
        Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH 0/3] Bluetooth:btintel parse TLV structure
Date:   Thu, 22 Oct 2020 13:54:32 +0530
Message-Id: <20201022082435.31831-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Latest intel firmware supports TLV structure in operational mode for intel
read version. so made changes accordingly to support both bootloader
and operational mode . These changes are only to specific intel bluetooth
controller for example ThP, CcP.

Sathish Narasimman (3):
  Bluetooth: btintel: seperated TLV parsing as new function
  Bluetooth: btintel: Introducing new btintel read version
  Bluetooth: btusb: Use the new btintel read version

 drivers/bluetooth/btintel.c | 105 +++++++++++++++++++++++++++---------
 drivers/bluetooth/btintel.h |  16 ++++++
 drivers/bluetooth/btusb.c   |  41 ++++++++++----
 3 files changed, 129 insertions(+), 33 deletions(-)

-- 
2.17.1

