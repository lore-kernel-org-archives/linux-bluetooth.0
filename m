Return-Path: <SRS0=apyX=5I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76FC4332E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 19:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C1D20714
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Mar 2020 19:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LmlNw6qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCWTpQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:45:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41346 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgCWTpQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 15:45:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id z65so8011939pfz.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80B/TTFy4vFKz8L9+3RjvU1r3boBA5t0X4WLtGJoAss=;
        b=LmlNw6qhloEXhNPwTTRoJnnY1RRSyI1vukop6LWemBIZ7WiAYP8MMBU/tDoetPZ7Ic
         DnB+YTC9QVV0DcZQDAHwAIeiGxDBVqSHVfMD45MqIJtHOtVLZ1vD1QURpLlWad+NBdQF
         l49NVuqzu4uUXjB25TU+fNg80eeNR+Qh0jwHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=80B/TTFy4vFKz8L9+3RjvU1r3boBA5t0X4WLtGJoAss=;
        b=mwys2EpFOJWUh1dl4xbnzcpK9Gf6xtRDCXfkN0wEehk6W4A7L9dRzfKdQxRg73umvQ
         7fVmjf0EcuhR6NCVsG3kB4dggeLdsTClymJ8gWMJpV6643cGRnGiAKOyU2pBEMS/0Sla
         e3BzYO81KSpVlwdrx8o3TK9v+Ywn25PTLpzgDug7yInuuXtb/tR6e3BhlsFgZrSH/WdN
         82y5qSp1omG3Vairf9DvkFecAI6fuI7mjq/Eq5vpobQsL+W5/6f96tVcPEIKhFQTSMXX
         wA75S8AetgWhPFKeuZztvttmsLarY4wgIR7ue7SbSHA55yVBIdVn9YIeTU/sfSQVofHM
         Z7WQ==
X-Gm-Message-State: ANhLgQ2e7FFUPRR2L7jxMmxJ40q3ytZl1RELpvlOHFo2A2+numo4Aplq
        Sgf5kFQrIlkP4SJb7QqukV9fWg==
X-Google-Smtp-Source: ADFU+vuCb3AKe+oRCHKCUOWWRUML5CHZGIql4EX16aeiRa+xpJXnbDTvnZaB6ZCXbvbldXkAHeB48A==
X-Received: by 2002:aa7:84cc:: with SMTP id x12mr7601806pfn.82.1584992714004;
        Mon, 23 Mar 2020 12:45:14 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id s98sm344857pjb.46.2020.03.23.12.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:45:13 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v3 0/1] Bluetooth: Prioritize sco traffic on slow interfaces
Date:   Mon, 23 Mar 2020 12:45:06 -0700
Message-Id: <20200323194507.90944-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Marcel,

While investigating supporting Voice over HCI/UART, we discovered that
it is possible for SCO packet deadlines to be missed in some conditions
where large ACL packets are being transferred. For UART, at a baudrate
of 3000000, a single 1024 byte packet will take ~3.4ms to transfer.
Sending two ACL packets of max size would cause us to miss the timing
for SCO (which is 3.75ms) in the worst case.

To mitigate this, we change hci_tx_work to prefer scheduling SCO/eSCO
over ACL/LE and modify the hci_sched_{acl,le} routines so that they will
only send one packet before checking whether a SCO packet is queued. ACL
packets should still get sent at a similar rate (depending on number of
ACL packets supported by controller) since the loop will continue until
there is no more quota left for ACL and LE packets.

To test this patch, I played some music over SCO (open youtube and
a video conference page at the same time) while using an LE keyboard and
mouse.  There were no discernible slowdowns caused by this change.

Thanks
Abhishek

Changes in v3:
* Removed hci_sched_sync

Changes in v2:
* Refactor to check for SCO/eSCO after each ACL/LE packet sent
* Enabled SCO priority all the time and removed the sched_limit variable

Abhishek Pandit-Subedi (1):
  Bluetooth: Prioritize SCO traffic

 net/bluetooth/hci_core.c | 106 +++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

