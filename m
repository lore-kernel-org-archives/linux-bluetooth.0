Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535D5C54FC9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E914206F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cKNYBY1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgDUQAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 12:00:21 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE2C061A10
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 09:00:21 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 184so8746140vsu.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkIypgcddOiZPZ1yBFqxpKxj/S2eqFKe3dF1EGDP/Vg=;
        b=cKNYBY1BMfW0xbFD9KeP2/b3dHpnui593WcxPX1W1qApdAKgsjZ8vWiTq5wcxU9DQk
         1oZ9puRmypIPo+bmATTBHtb0qvTetnvub4aCfNDroGujbVQT5f1atBu1OdfLTTF0Ysap
         tU5dXhTvJvKRXUAcIp3GZ6JGITsJDmB7UTG7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkIypgcddOiZPZ1yBFqxpKxj/S2eqFKe3dF1EGDP/Vg=;
        b=VSJq5ZyYcUniIf+Fx3y05StWVKR+b3wulFT4rHuJujN4vedLMUu/jqEjDmAvmtPgs8
         XSjmtbfB1M2SR0tPZcyZynIkXMhKK9AeEYP3CE4buPim9nkBXyX8c4k+O15p9WjhK+s+
         MGspUOTGqM93bqrzVzVkZFUXTyF5gTV7M+PNC5n5o4gnXEwmpxjnNpKHwRUqyM+q6mE0
         6Vnzc8U0OAUnEjJIkRSCJejvfN7u1NfiacV/ontKJQfY41Hn9i0SOoQQyDZKtWJVSH4J
         JKIkrtfkQ4yfkuuiA4iP8WqtuL6qJhGdoZR4w05tynXg0V9mFCwPqrwv+E5PX6BFiRU5
         ofeA==
X-Gm-Message-State: AGi0PubyuaFXdxfN6Wo6E8VY7bshDlOUZqyEfnuPfLhd4+oyT9g4Xf5i
        2iuhoAZWlmw98+LXY7wmrdMulrV6LcE=
X-Google-Smtp-Source: APiQypIdlGDJTm5pT7TO/20aitHf2n7mngQHFKyYcqPqiF6TRIQNXW2xbZWdX5yrupGFz5Dv/P2ilA==
X-Received: by 2002:a67:e83:: with SMTP id 125mr16244272vso.100.1587484820308;
        Tue, 21 Apr 2020 09:00:20 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id h16sm840074vkc.44.2020.04.21.09.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:00:19 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 2/3] bluetooth:allow scatternet connections if supported.
Date:   Tue, 21 Apr 2020 15:59:55 +0000
Message-Id: <20200421155954.137391-3-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421155954.137391-1-alainm@chromium.org>
References: <20200421155954.137391-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change allows scatternet connections to be created if the
controller reports support and the HCI_QUIRK_VALID_LE_STATES indicates
that the reported LE states can be trusted.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/hci_event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0a591be8b0ae..34cd98a1d370 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5245,7 +5245,9 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	/* Most controller will fail if we try to create new connections
 	 * while we have an existing one in slave role.
 	 */
-	if (hdev->conn_hash.le_num_slave > 0)
+	if (hdev->conn_hash.le_num_slave > 0 &&
+	    (hdev->quirks & HCI_QUIRK_VALID_LE_STATES) == 0 ||
+	     !(hdev->le_states[3] & 0x10))
 		return NULL;
 
 	/* If we're not connectable only connect devices that we have in
-- 
2.26.1.301.g55bc3eb7cb9-goog

