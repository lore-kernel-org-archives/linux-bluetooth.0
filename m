Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06472C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 22:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbhLGW7l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 17:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhLGW7k (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 17:59:40 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E194C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 14:56:09 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x6so1916513edr.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jqa37XG1cxeyiaOqWNKINouiRMRssce80swRqJPtYUI=;
        b=ilhWFm545bHNrBQkWr1Ob4yESTFkEpsyZt9NpD5yhfrAZr7Fme+i18tM7SB6FAMqEn
         5twbsM/R8dCIPn6G8sPABJ/eMxmBGD9TFRa21hDhJNGXfszXEJEJkAyQb/pZA7LDpuYa
         bE1ZIebU6wojqNhR2TUWjtwaGYgNdissrV3/u1/X2KF8k/doCYCqErFVpPC9UGGxvtT3
         9ZRZXTP6GMXlvcS7B2J8xehGGyPADZVdHu5MwO+bQepyKVvpFHUNpusquEqFoXqINZpc
         cNTONLVn2MlvAj1hXttsVs+CBp6B6WwjOVwSgSMzqe6bmYg4gHP9ewWorkRkiQ5KKxkw
         z48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jqa37XG1cxeyiaOqWNKINouiRMRssce80swRqJPtYUI=;
        b=2tW/gdctztg8qee91CAg/3pLki0B+SmSiKhvjR7lslGjdBfV85Lf5i5cUxsV1s8wHv
         T1erRPTsGhkRl4K4v1M9Yz+D+wbpinEk2Rn5kFktK38R5smiaHvFR67GlT5OBJ24gppD
         +FmKlyFvVsyJMrPp5vM30RKkINR0boU9dBFZ3feoGCLLqR7lquDixQA5rUZbzwlzO1A0
         B7K/dNPkJ35SuGdIe3+ptNm93k+TT09sxe7h6XeOeL5HR+nW1EuvZYFNK7fRrfKAWZ3A
         UYfQYHaBnsFXFmRru6k8USqioHwUnyEln/fsYRMjk31cZHfxZ7N7xdKHeR1goCFoc9PF
         cCVA==
X-Gm-Message-State: AOAM5312BqckFfTpv25lKimOGqIcaxUlNJWiNBkENdisocvr84pgcZ9T
        t5gzrUt5KLT5poBLu4CL0hdhn6bckRI=
X-Google-Smtp-Source: ABdhPJyxXZ0MSlabGtyJ7bxdsh9Pi8g8Efb7IMpJWTG6BfbOh2ucRN7UxIKDU07Av2vpe0N3gFpVNg==
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr2686177ejc.356.1638917768112;
        Tue, 07 Dec 2021 14:56:08 -0800 (PST)
Received: from aspire.cbl.vpn (net-188-217-49-100.cust.vodafonedsl.it. [188.217.49.100])
        by smtp.gmail.com with ESMTPSA id ho30sm489468ejc.30.2021.12.07.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 14:56:07 -0800 (PST)
From:   Daniele Biagetti <dbiagio79@gmail.com>
X-Google-Original-From: Daniele Biagetti <daniele.biagetti@cblelectronics.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Daniele Biagetti <daniele.biagetti@cblelectronics.com>
Subject: [PATCH BlueZ 0/6] tools/mesh-gatt meshctl tool improvements
Date:   Tue,  7 Dec 2021 23:55:58 +0100
Message-Id: <20211207225604.35156-1-daniele.biagetti@cblelectronics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

The present patch series adds some functionalities and improvements to the meshctl tool.
More precisely:
- Add onoff set unacknowledge message to onoff client model

- Fix status messages processing
   The status messages was processed and displayed even if they do
   not belong to the present model. This fix ensure that the status
   messages are processed only if they have the correct opcode.

- Fix unwanted return in onoff client model
   Replaced the return statement with a warning message in case of
   transmission or reception of messages coming from unknown addresses
   (such as group addresses)

- Add subscription delete message to config client model

- Generic level model
   Limited to the following messages:
   * Generic Level Get
   * Generic Level Set
   * Generic LevelSet Unacknowledge
   * Generic Level Status

- Generic OnPowerUp model

Best regards

Daniele Biagetti (6):
  tools/mesh-gatt: Add onoff set unack message to onoff client model
  tools/mesh-gatt: Fix status messages processing
  tools/mesh-gatt: Fix unwanted return in onoff client model
  tools/mesh-gatt: Add subscription delete message to config client
    model
  tools/mesh-gatt: Add generic level model support
  tools/mesh-gatt: Add generic power onoff client model

 Makefile.tools                    |   6 +-
 tools/mesh-gatt/config-client.c   |  40 +++++
 tools/mesh-gatt/level-model.c     | 288 ++++++++++++++++++++++++++++++
 tools/mesh-gatt/level-model.h     |  21 +++
 tools/mesh-gatt/local_node.json   |  10 +-
 tools/mesh-gatt/node.c            |  11 ++
 tools/mesh-gatt/onoff-model.c     |  56 +++---
 tools/mesh-gatt/onpowerup-model.c | 250 ++++++++++++++++++++++++++
 tools/mesh-gatt/onpowerup-model.h |  21 +++
 tools/meshctl.c                   |   8 +
 10 files changed, 688 insertions(+), 23 deletions(-)
 create mode 100644 tools/mesh-gatt/level-model.c
 create mode 100644 tools/mesh-gatt/level-model.h
 create mode 100644 tools/mesh-gatt/onpowerup-model.c
 create mode 100644 tools/mesh-gatt/onpowerup-model.h

-- 
2.25.1

