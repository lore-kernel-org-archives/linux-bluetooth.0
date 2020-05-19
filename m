Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D190C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2DD20657
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPjmSbDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgESUZW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESUZW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:25:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58767C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:25:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f15so359992plr.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlpimUzdploR0syL9l8/YlsWxzaH6bbKnKDninRyKo8=;
        b=lPjmSbDS2xboM3Po4TkB2itCUlVdWT2DePlXwbqdllU5XAuiiUzjL4P5oe3JX6ttLf
         xxYBLiP72GTG6MwRaj9sqerhgk28rVMvUfyuK3Dkiinzt0s/hnDBNlXHghNp2SFprTNv
         2CXtVrv6ItxAYYl0c0RrCxzVSYTef0Hz9Nqex2LVgscyF52M9S7jenKBHcg119ayEFzW
         3tdlCsERhHOHcvHqNnB7/FhiGl4FTtkrVKlEfxqxuw3JEspfI/XALkqRMrXw77FhO0pL
         89alWlxJ69DOx0L111iGldKzKuSBQxm+ob0uYmKRg5bnw2nPAO6Jm+rUwXOLFlur0tSW
         BMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PlpimUzdploR0syL9l8/YlsWxzaH6bbKnKDninRyKo8=;
        b=SRYxjZHow5AlIPgHwXE5e+SvLYdpVt3iDebmrQhn+bHBnfqALMT84eoSyMJ3BvviAc
         l71aa0xZeshprE+y2F7MtZLXtPv5CqtcJf332QN4tuyiAxF0LodCjnvIBmTb6Se2WNzD
         I60HUMCGiMYcsY8qzb0Nuyqm8rkwlWC6CLfVyb1YRp72iWt4qVJ8ijg7YgJfFXzeW62R
         sTNyxQ8gSQwswUI78o03mBNyIbbCnstVsgY6Xx17auZzlMlYM2DQUw35G96G+7pHK+Jh
         JIJrflGB7Wsu4ZQbpVqV7vWjH//PzXSyNLEi4yxgMefwdedIAM167f53iP5ubM3zZ48P
         Rjxg==
X-Gm-Message-State: AOAM532io5tjDDw6JKl/xI/9GWrjuwi6jUW4Ol8OVv/SgVJ32rvIonx5
        w6dSPb+3ZBsLJ5ryhgL/dUAEme+6
X-Google-Smtp-Source: ABdhPJwpxeFYSso5iXkEPAuN4UdFdHfEulLYdjGRvTqGASiSFF6Yy5QD5G1/OeyN2NWtZZKIlpW9MA==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22mr1232413pls.222.1589919921259;
        Tue, 19 May 2020 13:25:21 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c184sm298808pfc.57.2020.05.19.13.25.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:25:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Disconnect if E0 is used for Level 4
Date:   Tue, 19 May 2020 13:25:16 -0700
Message-Id: <20200519202519.219335-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

E0 is not allowed with Level 4:

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1319:

  '128-bit equivalent strength for link and encryption keys
   required using FIPS approved algorithms (E0 not allowed,
   SAFER+ not allowed, and P-192 not allowed; encryption key
   not shortened'

SC enabled:

> HCI Event: Read Remote Extended Features (0x23) plen 13
        Status: Success (0x00)
        Handle: 256
        Page: 1/2
        Features: 0x0b 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
          LE Supported (Host)
          Secure Connections (Host Support)
> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 256
        Encryption: Enabled with AES-CCM (0x02)

SC disabled:

> HCI Event: Read Remote Extended Features (0x23) plen 13
        Status: Success (0x00)
        Handle: 256
        Page: 1/2
        Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
          LE Supported (Host)
> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 256
        Encryption: Enabled with E0 (0x01)
[May 8 20:23] Bluetooth: hci0: Invalid security: expect AES but E0 was used
< HCI Command: Disconnect (0x01|0x0006) plen 3
        Handle: 256
        Reason: Authentication Failure (0x05)

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 17 +++++++++++++++++
 net/bluetooth/hci_event.c |  6 ++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 07c34c55fc50..0c1cae83c8dc 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1325,6 +1325,23 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 			return 0;
 	}
 
+	 /* AES encryption is required for Level 4:
+	  *
+	  * BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C
+	  * page 1319:
+	  *
+	  * 128-bit equivalent strength for link and encryption keys
+	  * required using FIPS approved algorithms (E0 not allowed,
+	  * SAFER+ not allowed, and P-192 not allowed; encryption key
+	  * not shortened)
+	  */
+	if (conn->sec_level == BT_SECURITY_FIPS &&
+	    !test_bit(HCI_CONN_AES_CCM, &conn->flags)) {
+		bt_dev_err(conn->hdev, "Invalid security: expect AES but E0 "
+			   "was used");
+		return 0;
+	}
+
 	if (hci_conn_ssp_enabled(conn) &&
 	    !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 		return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 006c24e04b44..dc1cc3c4348c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3078,10 +3078,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 * that are not encrypted with AES-CCM using a P-256 authenticated
 	 * combination key.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
-	    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
-	     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
-		hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
+	if (!hci_conn_check_link_mode(conn)) {
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_drop(conn);
 		goto unlock;
 	}
-- 
2.25.3

