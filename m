Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C412078C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 20:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUxDQDs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgFJUE5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFJUE5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 16:04:57 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6EC03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:04:57 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id c15so1303920uar.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 13:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aY89JrPbzTjphUZEDgucRVaNNErNDaFMIvpUKdCdfnI=;
        b=FUxDQDs1GLvMzbwlfaDvet2E7dlwOTiI+x1M0CSLEXKHAOgyNCMq9qwANI5W+5RiyN
         jp2WTW879P5CKNUbb1Zash8n51IK0h0oRAh9x4fM0/FD6fyos3qJR+6FQMVYsTfmH0bw
         gOzvOKZb+wRfpiwDF8bKuKeOnPYDGwy9W2G5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aY89JrPbzTjphUZEDgucRVaNNErNDaFMIvpUKdCdfnI=;
        b=JPsj9mrcDbX+XneCp8ljy8ORY24c8Xyer9o5L3GwWZY/d4p1GHqbHSW0SXIN/Xs8lO
         r0bILLedxkXPFLuE07SOHA6tOTu0ughpQgWUhIFpHkAtO4lsl1agx44cjTL9L3pPWCX2
         889SbxxoYydZx3UkEHOamYqQW3rrJjLo6bTN7Y7tVj1wtC0m8pbZ11D8OARbcncydBsG
         greVAdwdI5ZztWjy6berH7GeOAcecNugCFbBNpcrpSr7c6qf+OVh2tPYZVbiThQh8zNh
         ISIiRH3f3pjN9HrgZmQJTok1zqWT5bbHLCBBGrLbPtdu1FqJLclDuTqtqYjAK6IgFOEg
         2CIA==
X-Gm-Message-State: AOAM530nEz+U6UccaRyJTFL0oyymXdC5k/ncKFsMwDu82aoX9w0uQ0+c
        DqaMhCA1H7121g9rZMJvoQ8xJGpTIyw=
X-Google-Smtp-Source: ABdhPJwVOR/kme2v6/CyVjgaQiaZ56zGbtbGytkQOzZOwxZCV1EbecyTDh6Zntyogb6XSyMNSvnI2w==
X-Received: by 2002:ab0:42e:: with SMTP id 43mr3926100uav.72.1591819495844;
        Wed, 10 Jun 2020 13:04:55 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id q185sm107253vkq.10.2020.06.10.13.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:04:55 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v2 0/3] Support reading and setting default system parameters
Date:   Wed, 10 Jun 2020 20:04:49 +0000
Message-Id: <20200610200452.107406-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
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


Changes in v2:
- Renamed the mgmt.h per Marcel's comments.
- Addressed Marcel's comments in the implementation.

Alain Michaud (3):
  mgmt: read/set system parameter definitions
  bluetooth:centralize default value initialization.
  bluetooth: implement read/set default system parameters mgmt

 include/net/bluetooth/hci_core.h |  18 +++
 include/net/bluetooth/mgmt.h     |  30 ++++
 net/bluetooth/Makefile           |   2 +-
 net/bluetooth/hci_conn.c         |  14 +-
 net/bluetooth/hci_core.c         |  14 +-
 net/bluetooth/hci_request.c      |  15 +-
 net/bluetooth/mgmt.c             |   6 +
 net/bluetooth/mgmt_config.c      | 253 +++++++++++++++++++++++++++++++
 net/bluetooth/mgmt_config.h      |  11 ++
 9 files changed, 341 insertions(+), 22 deletions(-)
 create mode 100644 net/bluetooth/mgmt_config.c
 create mode 100644 net/bluetooth/mgmt_config.h

-- 
2.27.0.290.gba653c62da-goog

