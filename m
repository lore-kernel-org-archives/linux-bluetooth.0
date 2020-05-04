Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D90C3A5A9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FBC2075A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 15:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XVhHAQlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgEDPgd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgEDPgd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 11:36:33 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD1C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 08:36:31 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y185so11388406vsy.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wj9inrs9woMthizwL4NhhqaMGj+nRW3DDgayM3A6Xgg=;
        b=XVhHAQlR1cbevO0dE9s4AZqUiztoPZ095/YPQZCJfgbAe2ofDgrIaOUPjTBR0hwOvK
         5VD5nQZNFWrhtcI4uxAswt959ElYbpf18EsV2JMAnr80ZEIK2jvJ/Xi19yrLEZNTRp4J
         lZgn9TAkNJjR8bYlTcCvrSGogWPHr+5DulBN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wj9inrs9woMthizwL4NhhqaMGj+nRW3DDgayM3A6Xgg=;
        b=ft/5o0olNaMHrDB7Dp8jYL8BQr9sfqeaMDJL0X6YIHjvptzvWSs9Ts4XkAoTTTO45o
         kgaj9dUmXpbIxfrxImAAkyQr8Cah69WyNAlrrCmENSTSzmfii55lr9Cqsh4xwnFuoZgA
         zDIzdLaFaAaovSh3FSS0FJG+4kf0WEc8iFwAIWA7+Le/3NOomeXiN3KYvszSuAywGwco
         X+hggdydsk0aTrovqmPHoYRcnMNKYRvbkSpDMFESCSbv/TzNdpGCjt80l6379raBksgW
         CYTmyBx1zYAC9b6GJd0XW6CdN41qpPMvbkziEJXBRTogh+2nD8jObHjV6HyJT3VlLzU/
         TqmA==
X-Gm-Message-State: AGi0PuZni/u89EHVtZM921IYyOdVLfIxyZotxbjo0aZ6RnpieuF+cL/4
        KHJXBDKBsAd/Fgoaf4S2vAeYE4L/t9A=
X-Google-Smtp-Source: APiQypIkUgHZfNwQ9VGQ0AZWfquPbgwz8Wi39rk2CbzQtLoqUPFm7Q7Sq7iJs9eoFxcDOZZU4Vg0hg==
X-Received: by 2002:a67:eb17:: with SMTP id a23mr13114934vso.111.1588606590128;
        Mon, 04 May 2020 08:36:30 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id b6sm1927726vkn.31.2020.05.04.08.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:36:29 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2] Fixing opcode definition order
Date:   Mon,  4 May 2020 15:36:26 +0000
Message-Id: <20200504153626.231603-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixing what looks like a bad merge in the opcode order.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 lib/mgmt.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index e46e08ba8..0722c5206 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -586,15 +586,11 @@ struct mgmt_cp_set_phy_confguration {
 
 #define MGMT_OP_SET_BLOCKED_KEYS	0x0046
 
-#define MGMT_OP_READ_SECURITY_INFO	0x0048
-struct mgmt_rp_read_security_info {
-	uint16_t sec_len;
-	uint8_t  sec[0];
-} __packed;
+#define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
 
 #define HCI_BLOCKED_KEY_TYPE_LINKKEY	0x00
-#define HCI_BLOCKED_KEY_TYPE_LTK		0x01
-#define HCI_BLOCKED_KEY_TYPE_IRK		0x02
+#define HCI_BLOCKED_KEY_TYPE_LTK	0x01
+#define HCI_BLOCKED_KEY_TYPE_IRK	0x02
 
 struct mgmt_blocked_key_info {
 	uint8_t type;
@@ -606,7 +602,11 @@ struct mgmt_cp_set_blocked_keys {
 	struct mgmt_blocked_key_info keys[0];
 } __packed;
 
-#define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
+#define MGMT_OP_READ_SECURITY_INFO	0x0048
+struct mgmt_rp_read_security_info {
+	uint16_t sec_len;
+	uint8_t  sec[0];
+} __packed;
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
-- 
2.26.2.526.g744177e7f7-goog

