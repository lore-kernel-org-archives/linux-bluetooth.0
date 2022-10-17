Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5839AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 22:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiJQWlw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJQWlv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 18:41:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103F422BCE
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 15:41:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b2so12108157plc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjaGGqCr83SjyQrH4azFCoozPx7gCyPalQPzix+YMTI=;
        b=CL1LZ2F38T9F+hFSzCcK0TBghav9tkjeL8zb9buYf1QRMdxE4LRILX3aNgt80BqMki
         TvDDIIq9lxxzZwA7gc8TNbn8ImtmRQIYgjo70LTQvZiKscUtAVPQg5C2WSrRfDUIusb0
         RPfkmkj+Boy7V4/JzuW3jNYvnDBn/RfganoaSxhQ/UiTI9ru7b6JCTNjqrdqd8u0GRIe
         tJVDj8MVrTuvzhYSCPEdR4U/JtXVed/E7aTn2e4vi1GNqQbpYAELQNIgSDv3yyEPpcWF
         o7l0kztP+CatH5d/r9jhZuAVw9/1dRsxLu9qgvyarj3Bmer4SDlbltwtgAHERaLOuUPZ
         XlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjaGGqCr83SjyQrH4azFCoozPx7gCyPalQPzix+YMTI=;
        b=k2cSibaLZ0Bq7Z0jP1W1+HGkKnXHfwJ+ExzHHMDWlJP55IzlvypEYv8b7mKGzTi4A4
         MXc3Ng02eZRL3FaTJDPL5S7W70vzsRRzNjqYzdJ+wkvEfA/uxkZUWJtWsxztYxM6Ec+m
         kF11b3ROpQkh/QJiMoC2IZi7DAcGU+XqN9T5dYH8YZksPF9lxOIkVKHI/tar3wJqF4kh
         89qZGwBcbn7XHVkXfX+Bs3lRe6sSIMCUwCChmirmqQ1xBJlqryrvHtChwmMATO/gXMOw
         Fdz/zgb2R0DP73+BMLaByXOkKQKEcK2yoCzJ4sLF6uQK5/jF/v7hDJmERxRyBJUz6ds4
         h3AA==
X-Gm-Message-State: ACrzQf2doIjl0fTvVUzQ9Icavvx0LlbHf4Evzd/iNj56ZoS0LhAk7ECk
        T9EwFCS3GdNdE3hq4h7uO25pSnxQVog=
X-Google-Smtp-Source: AMsMyM50MGRyWse9351ipEsZu/PYwGiK4sxFtzyoxu6hyvxCC07UWEQ0+rv2VRMOrR66vKUPqzBpBg==
X-Received: by 2002:a17:90b:3a88:b0:209:f55a:962e with SMTP id om8-20020a17090b3a8800b00209f55a962emr93551pjb.28.1666046509040;
        Mon, 17 Oct 2022 15:41:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709027e4600b0017a0f40fa19sm7063512pln.191.2022.10.17.15.41.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 15:41:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: Fix not restoring ISO buffer count on disconnect
Date:   Mon, 17 Oct 2022 15:41:47 -0700
Message-Id: <20221017224147.3629459-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When disconnecting an ISO link the controller may not generate
HCI_EV_NUM_COMP_PKTS for unacked packets which needs to be restored in
hci_conn_del otherwise the host would assume they are still in use and
would not be able to use all the buffers available.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5d6ee5075642..df914f521c9d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1067,10 +1067,21 @@ int hci_conn_del(struct hci_conn *conn)
 			hdev->acl_cnt += conn->sent;
 	} else {
 		struct hci_conn *acl = conn->link;
+
 		if (acl) {
 			acl->link = NULL;
 			hci_conn_drop(acl);
 		}
+
+		/* Unacked ISO frames */
+		if (conn->type == ISO_LINK) {
+			if (hdev->iso_pkts)
+				hdev->iso_cnt += conn->sent;
+			else if (hdev->le_pkts)
+				hdev->le_cnt += conn->sent;
+			else
+				hdev->acl_cnt += conn->sent;
+		}
 	}
 
 	if (conn->amp_mgr)
-- 
2.37.3

