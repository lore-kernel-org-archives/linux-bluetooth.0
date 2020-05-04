Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FAEC47254
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F32924953
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlBl29SK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgEDPbk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 11:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgEDPbk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 11:31:40 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F3C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 08:31:39 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id t8so6734286uap.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H50kSyd7dZl4yb0/DChkeyyLWlti58NbdSjRMyD0640=;
        b=WlBl29SKRVh+R2jvWybP8chonjjhtTyoXQbPJF1HNLlSm+zwL3JysAfYwwsLTB+mXp
         6cNIDT/QM+E1jt2hc9d2BZGaIdbQNYBCnilOE0EuaWsdTTXufjh84kSEh8kITC7nyfNs
         /Wa0JT8H4daYsysTxhIfuWgpnfpQgkWKarWsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H50kSyd7dZl4yb0/DChkeyyLWlti58NbdSjRMyD0640=;
        b=IRUADJreM3cBfKtXiaEMRdIt/6MlyO3c5RGJw3en1TTWHZixG/t4E8gLA1YZYo3DyB
         4IpOU7SnkwJdLqMzphFlJk4/JjPCcq8tW85ml503UImAwSYrIskxMQh7RFHb+Gn97Bru
         UJ+xFNT4lUYmLbEyparNlR1ByEvgdYsDxI6bgWbOd7VsH1OKnIJMTEtDODlbSJWHxWU3
         H3W8li6MbHF+DQ3J0JZJsxTBEpTWGEcXOyFS02DA+Q5AnTNQEo237fQ9rDbur7iBgyf0
         CtlQTPl/gu2F2MRJ7/yvo8GAerCViX5BZZtUF+FGW5WclQXQJ/eEAHGNya+aschTfa/X
         3ZhA==
X-Gm-Message-State: AGi0PuYSBcUVZowL2ezQ3zgcfJ+/Ga0eiV+BwgC1GEOHzGkPPJEtIhOk
        Tm5cU4Hs/fN64oSgK/7o9avnLYBnMFc=
X-Google-Smtp-Source: APiQypLBx4UUTxY3XRFPeF7DXzylqalqXxM1ddNeh8lCmXOV12vJdnK1GQ5Cj3gb1QAfJ1Puf6d9Vg==
X-Received: by 2002:ab0:1d97:: with SMTP id l23mr12101909uak.107.1588606298769;
        Mon, 04 May 2020 08:31:38 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id u85sm4769152vsu.22.2020.05.04.08.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:31:37 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v1] Fixing opcode definition order
Date:   Mon,  4 May 2020 15:31:34 +0000
Message-Id: <20200504153134.226879-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixing what looks like a bad merge in the opcode order.

---

 lib/mgmt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index e46e08ba8..c81286460 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -586,6 +586,8 @@ struct mgmt_cp_set_phy_confguration {
 
 #define MGMT_OP_SET_BLOCKED_KEYS	0x0046
 
+#define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
+
 #define MGMT_OP_READ_SECURITY_INFO	0x0048
 struct mgmt_rp_read_security_info {
 	uint16_t sec_len;
@@ -606,8 +608,6 @@ struct mgmt_cp_set_blocked_keys {
 	struct mgmt_blocked_key_info keys[0];
 } __packed;
 
-#define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
-
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
-- 
2.26.2.526.g744177e7f7-goog

