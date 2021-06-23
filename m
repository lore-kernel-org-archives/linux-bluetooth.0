Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376FCC4743C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 03:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1053461026
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 03:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhFWEBY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 00:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhFWEBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 00:01:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F58AC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 20:59:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g4so761867pjk.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 20:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zj9vfLWaDZlRd9yi4nCVL4TNEWOKqvSoc6ztoqOFBsA=;
        b=bwMF5lvruOLS13kfLZV+Jogf29mnfjKr8R4DjcFUEsoszNPLSK+ZIIwe39pSBT1KmH
         SAQvkWmcO40WwijdLlFW0p8TSktXCbczpzcsoSbd2sZ9mRAFEQGxeMUd5h8GpuxSBLBM
         dylEU9zAE3QsM6G/yVzMtwsutuchK//+GcadEwT4Xc2PcLXEvHliaHRLUpYBio7Ft46O
         dvEBQJsXaGP0WcRN1EFY2ZeiyKYHbM+upX7SPPug/+mh7koLmpsUrx6UvjhR9Dhts8Qf
         HvzZoc6O8dAhq2ZdtlJ3FXxXGUblaWcbwJmK+mrli/NVlnqgFe2xufkWEZcNecZccOzw
         peIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zj9vfLWaDZlRd9yi4nCVL4TNEWOKqvSoc6ztoqOFBsA=;
        b=P1vr2YdrIuEEmumL/i3BCPofWtMNmom26R3OvRCaRBxSYrrQ+N7AekSm2bd2HopQo0
         JFW5m29+Z+szqsw+i6eZQDBysCjM1Ff1UskWLyudEFmkCHue5P5on5o+w0/Fe2D0XdBq
         YmAZL5vU2r1fGyCDujQUIKDMFZ5c9p5fmBVzG7bUvecAXWK7Ln4ck/VkSBX1ekbbmdWC
         nMxleI82olmFq8NE0a89fQMcoU6P6WmRXRoS/4YhgE8UoP2zkJSAHz1lHUpDtle7gx14
         pDhbHrN7oHh1wWfR5XGIE4CkaWyjrR/7/o0cYFhEz6uLkJO4juJnF5TYScZQnIytPumw
         JzdQ==
X-Gm-Message-State: AOAM532bUC2yxCjX5fb4FS/AkfYYQhpUcA9Oxm2PsQSXtBBxzhYbsAr2
        pA9esicp4PzyoBqlG9UaIC5zYK2LxVELTQ==
X-Google-Smtp-Source: ABdhPJy9T11hND8SBWMLu3nTx4MvWEtvlbjS1fOvP2D6p46PChZE9IzK4q1yCMoQGGlbuT4KnzNXVw==
X-Received: by 2002:a17:902:fe10:b029:127:6549:fe98 with SMTP id g16-20020a170902fe10b02901276549fe98mr3462198plj.25.1624420745433;
        Tue, 22 Jun 2021 20:59:05 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k21sm20975737pgb.56.2021.06.22.20.59.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 20:59:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix handling of HCI_LE_Advertising_Set_Terminated event
Date:   Tue, 22 Jun 2021 20:59:02 -0700
Message-Id: <20210623035902.3572144-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Error status of this event means that it has ended due reasons other
than a connection:

 'If advertising has terminated as a result of the advertising duration
 elapsing, the Status parameter shall be set to the error code
 Advertising Timeout (0x3C).'

 'If advertising has terminated because the
 Max_Extended_Advertising_Events was reached, the Status parameter
 shall be set to the error code Limit Reached (0x43).'

Fixes: acf0aeae431a0 ("Bluetooth: Handle ADv set terminated event")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1a4279dfb93e..9c18129e4dbc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5319,8 +5319,19 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
-	if (ev->status)
+	if (ev->status) {
+		struct adv_info *adv;
+
+		adv = hci_find_adv_instance(hdev, ev->handle);
+		if (!adv)
+			return;
+
+		/* Remove advertising as it has been terminated */
+		hci_remove_adv_instance(hdev, ev->handle);
+		mgmt_advertising_removed(NULL, hdev, ev->handle);
+
 		return;
+	}
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->conn_handle));
 	if (conn) {
-- 
2.31.1

