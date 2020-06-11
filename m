Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7EAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 02:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B8C206FA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 02:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oe13Mt3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFKCCC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgFKCCC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 22:02:02 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C5C08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 19:02:01 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id c15so1578641uar.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jdGd7oJ9RVYQxRo7fYstmcN3nIcBgTRAT3s0K47VsMw=;
        b=Oe13Mt3Ep6s4ftXeT3oIdif8Sny7slkjK7nXXSGRk40SOMgQL531HPfrSR/f+EFZaV
         dSP/yt8I49RDYF6zMBzHc4oYxjyOhSrNkkJWmNb31ou9RtBYedmeo0O4mOBu4tMe2HKj
         DTrbMyGNobD0YiKVD0s+gkCMRIymGdxdARxUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jdGd7oJ9RVYQxRo7fYstmcN3nIcBgTRAT3s0K47VsMw=;
        b=TmrRzIt2/OB/8wGunpmrJC1daVBTB4tLI4bP+eVEFhn0iTaahWu+nuGWHf32qcLsNf
         e5+ZHhjXGc601Ml9soOMOI307RgubuoOasVVcwxos/yzgzTEwsqWCZMNWQHw7BHZatLR
         TLNtFSaFkKiBmJnR8FaOB1G64h+y0MR+2H0wspEeLYaY5WJnUO9syHWs7M8uMOm4RIPV
         GjBs1GHPGlKKEU+OYYTdY69IlROW1HZBu5Vg8VmzGSs00waoqy5H2SLlQYwOBnvjkvOp
         LfxIow7Z3nWebapLQ2+d/OaZdOvE627l/ZMZZ+M8aYNC44Lmh+KNWxa5tP16+yeOiIsE
         7yJQ==
X-Gm-Message-State: AOAM533w2DVVIa6lH7cRKlE0232hx52ghe/SR6YMe1diKm9cnbtS8lbV
        XSYQLIkMKEYhP2vIujEWsFXogGRDqCs=
X-Google-Smtp-Source: ABdhPJxw0LoTdjxtqg+UevhIaXbdOzrsrz35ycvH5X+k+sk2T+kKU9JuUIeZRVqp439LycMQvc4vFg==
X-Received: by 2002:ab0:5f95:: with SMTP id b21mr4850462uaj.122.1591840920746;
        Wed, 10 Jun 2020 19:02:00 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id r17sm243197vsi.34.2020.06.10.19.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 19:02:00 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 0/3] Support reading and setting default system parameters
Date:   Thu, 11 Jun 2020 02:01:54 +0000
Message-Id: <20200611020157.70230-1-alainm@chromium.org>
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


Changes in v3:
- Fixed sparse errors
-Fixing sparse errors

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

