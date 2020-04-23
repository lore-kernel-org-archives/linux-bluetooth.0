Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B10AC54FD0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FAC20781
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 14:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E4neivPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgDWOnr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDWOnq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 10:43:46 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC98C08E934
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:43:46 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id i22so5890563uak.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2020 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=23PczzMyR6+ew4AVNhl/pFHjr/juWJO8Y8y4apArs1A=;
        b=E4neivPKiCEMH80abgQ0UVVz6meHkEJVVLyHqsaLLBDzQO/I5HsQ8rhfVwOLtYpWn7
         YtXxfZCp+GWeL5jY6eZWqvPPvOTLeCbvEZjj+WPx88eZ1RMn+3JMeGp/0D3RXWWDwNWh
         K7LYxfCAadBsx9osMUH9Kt9OfPFNaOHbg+JZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23PczzMyR6+ew4AVNhl/pFHjr/juWJO8Y8y4apArs1A=;
        b=AgguwVB/oB9of/UD07W8v3q5h8rXpgf6DsFzgCGnhq26vd5q5PjCYBb4+6kbdx86/a
         avmuVN6dd+PX5G1r6nLt1K3ehOMUgn2NvTuXeJCXBOMFfsFAwXeUszu3uMhXlZAZRb8B
         yfRXf3c9QiO5qGexiS0VyRF4mdu6n62oG/PNPNRJ45oNK3RqTLq86HKElVm6sXpBmktZ
         mjWRFeZnbRleZw4isaZeoX4sWRQaWYgp3fMc1EEwpNQOz1EopaQcqsR624/GpavEl0YA
         0pf649VSeUXaSlRZ8Fp5Dv92cgTDg0NoQh4d4cSKdp3YLF+IQiDyxLYITAHMYeDKIrnA
         JEgw==
X-Gm-Message-State: AGi0PubgYmuFiWbOvz7KJ2hVHU4O8DP1knQNVufXPXkjiaT5B5jEDrJ8
        NwPeH6fmdiu7ipPcBRj2rUcFQQn4YPU=
X-Google-Smtp-Source: APiQypKzyRsi8F4KN/SgIV+ZH2kbz70MaLarpIWDqq3Rg/r1Er7e0kVkZlf1o7FdQ83E10GYE7iRCw==
X-Received: by 2002:ab0:3762:: with SMTP id o2mr3071693uat.119.1587653025652;
        Thu, 23 Apr 2020 07:43:45 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id d83sm762107vka.34.2020.04.23.07.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 07:43:45 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 2/3] bluetooth:allow scatternet connections if supported.
Date:   Thu, 23 Apr 2020 14:43:29 +0000
Message-Id: <20200423144328.82478-3-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200423144328.82478-1-alainm@chromium.org>
References: <20200423144328.82478-1-alainm@chromium.org>
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
index 0a591be8b0ae..830688612e05 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5245,7 +5245,9 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	/* Most controller will fail if we try to create new connections
 	 * while we have an existing one in slave role.
 	 */
-	if (hdev->conn_hash.le_num_slave > 0)
+	if (hdev->conn_hash.le_num_slave > 0 &&
+	    (!test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) ||
+	     !(hdev->le_states[3] & 0x10)))
 		return NULL;
 
 	/* If we're not connectable only connect devices that we have in
-- 
2.26.1.301.g55bc3eb7cb9-goog

