Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F6320674
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 17:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUD7fmzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgFCROG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFCROG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 13:14:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F6C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 10:14:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t7so2200922pgt.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DzcMa4JWeV7TOH883Ypn6ztQyKbVAZd+yj/t8J9/U/Q=;
        b=TUD7fmzSs2ytPtSlmm6Zf1pvV7eWUe10g5eGwBsExyHIAOUr27LA1jbj4DNYf9k5Lr
         NGz1QXTSzken6ZXb61/UVobxUSoMNIsPgYp5sBUHJnFj8Knb4phT5+qn1keW/3op1e+C
         URAvu97aYmzUs077MQtTgOjymFg9+VC70Q3CCeOQuKlF/b46HDpAfKIdLRo5XKp0VS8/
         ePiLwVqFvXpSFKA/vPV76+NV/DXdd8auZBjIo7L3VEtN34EylHJ6aqJ2sE5/m19UTy8o
         HtktIAeLLAhevhZxFIYRJH6WPDn4e1S/BQT8LpLBItSGpCKf92+jJVgRO44IAwH2ECKR
         TzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DzcMa4JWeV7TOH883Ypn6ztQyKbVAZd+yj/t8J9/U/Q=;
        b=ZdII6L6zwT4trkqMUqIWufyeuVnqOFpSUfY+zT2swivoiNRrpjbQQXAZ0UJU0HEQRn
         p+Af9heqyPkoWeKGaVE+8mEtFphNeJJbB+9VMcNViuFa2Mu9IE57xpFR0BlnBsm1QGBR
         c/SyrNNCpxQqbywzptwBRZpCS6naGvehDchi/uinigk/84j5eCTWBVALVIU24W05p6/0
         8NlNNePjvULghbi3Rx31+4ehrpcc34axnDUUg3Z+WbP8FsZCj27ofCzbpk+RT0ifRnHc
         g91ntsZUcOOdD5xK2y85K7atySF/oZ4jgbYI9PJBu+6hxPCULw40+g1129LaQZW1Ot+4
         NGLw==
X-Gm-Message-State: AOAM532dDTdhHLrVqvqEJmMKKmPVKUSU+RiftyuLjhEPcpjagnNePNv2
        l8DptdKVHQ8qhd1jNbsSFU0E6Ogy
X-Google-Smtp-Source: ABdhPJzOl7LaOdsI9G8K6EIMwhsM/NjHj20b2SXjFlARij7xHeYKt+RKUb5uCwHj122JvV3SRSJfKg==
X-Received: by 2002:a63:fb04:: with SMTP id o4mr408277pgh.386.1591204445220;
        Wed, 03 Jun 2020 10:14:05 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id x190sm2016770pgb.79.2020.06.03.10.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:14:04 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v2 0/7] LL Privacy support
Date:   Wed,  3 Jun 2020 22:47:06 +0530
Message-Id: <20200603171713.9882-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Based on the input the patches modified and verifed accordingly.

Marcel Holtmann (3):
  Bluetooth: Translate additional address type correctly
  Bluetooth: Configure controller address resolution if available
  Bluetooth: Update resolving list when updating whitelist

Sathish Narasimman (4):
  Bluetooth: Translate additional address type during le_conn
  Bluetooth: Let controller creates RPA during le create conn
  Bluetooth: Enable/Disable address resolution during le create conn
  Bluetooth: Enable RPA Timeout

 include/net/bluetooth/hci.h      |   8 ++-
 include/net/bluetooth/hci_core.h |   3 +
 net/bluetooth/hci_conn.c         |   6 +-
 net/bluetooth/hci_core.c         |  17 +++++
 net/bluetooth/hci_event.c        |  20 ++++++
 net/bluetooth/hci_request.c      | 119 ++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   3 +-
 net/bluetooth/mgmt.c             |   2 +-
 8 files changed, 157 insertions(+), 21 deletions(-)

-- 
2.17.1

