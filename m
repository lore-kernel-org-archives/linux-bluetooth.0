Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 00:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbhKYAT1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Nov 2021 19:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346127AbhKYAT0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Nov 2021 19:19:26 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FF2C06173E
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 16:16:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so4181970pjb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 16:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QRLf7evpC+z3sWVkPSyEejHGVJ4DfUjo0lTCHwGZp78=;
        b=qS8zsFs7cgoLhGj5DRd1Hkog0hH0S5OVQy7d8z8CBJ/nzc2OxEI/sCjzjM5AaJVGNx
         Z6qAui8chFfoi2TjIfBy8YAZMQYh3LF6clx7o5feZWm+hnxZd+U6HuE1N4QoKqn6w3EO
         ahrznWArFvUNyrFMG7MZ306F+ZQryBAoNlpyKjUOJ1y7P1PTe+M4d4FlpngAdUcX3kYP
         /17UThZqiqQPIaAaooAy2aPnpQyXSrOX6IQ06RlMCqH5ZwodaZ3ur6T8eYXnjvX7+EkF
         +gq3IkmZGOmwZO9WSX3ORyZW6yi0IljCAhdUhVpQAbJzdVxHQNMOK4jKjbMKqLhBqYYC
         n1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRLf7evpC+z3sWVkPSyEejHGVJ4DfUjo0lTCHwGZp78=;
        b=bra9p/s4qhaCkbTaLIAv7CD36707uOIyQOhScQcrRyIFU0F2WFGWm0+/tcToqIJ9s2
         Oum+EsyGU3gQT0kK+lxaZh7X/lBqx5IDoS2ZjTEFULOdYi6b/Yx8RldOfE1Y0phsc79L
         lIQhr6K81zvVPEjOd9ox4yl5oGEhd2T8OFOK/ULarldCOxmQJZrEVY3fXKwuvFL2o2eS
         8oCU2Dxvxs/0LaUeZEwuu5lwb1leJ7So4enk8CNz+aEAytQqe3mKaqM5h+IkEnW7wU8E
         RPuZdChMSsmfFN5geYdMMGNxssBFgreBIOvIDW2Vv+3rYZEUeI8nSbyYg63FU/4BYO7y
         qpIw==
X-Gm-Message-State: AOAM532JOVbRmOMweaDaVYevnCt+PPh1pzET+jK+0FHnetBHHIaEuYgc
        7qBiih6PNgBxk2WNKght+QUKzP4BRZ4=
X-Google-Smtp-Source: ABdhPJyqbbPty79389kVlnkVMCqypQe5RVQo8N1ve0TxfCnbsvSgvwihGH3lAGTfMqwrFE04MEijNQ==
X-Received: by 2002:a17:90a:ab17:: with SMTP id m23mr1574681pjq.194.1637799374982;
        Wed, 24 Nov 2021 16:16:14 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z4sm861751pfg.101.2021.11.24.16.16.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 16:16:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: HCI: Fix definition of hci_rp_delete_stored_link_key
Date:   Wed, 24 Nov 2021 16:16:13 -0800
Message-Id: <20211125001613.3274241-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211125001613.3274241-1-luiz.dentz@gmail.com>
References: <20211125001613.3274241-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

num_keys is actually 2 octects not 1:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 1989:

  Num_Keys_Deleted:
  Size: 2 octets
  0xXXXX	Number of Link Keys Deleted

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3c5211c3a790..b557d86396d5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1058,7 +1058,7 @@ struct hci_cp_delete_stored_link_key {
 } __packed;
 struct hci_rp_delete_stored_link_key {
 	__u8     status;
-	__u8     num_keys;
+	__le16   num_keys;
 } __packed;
 
 #define HCI_MAX_NAME_LENGTH		248
-- 
2.33.1

