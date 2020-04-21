Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056DCC54FCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55F82068F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bf/h90z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDUQAP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDUQAP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 12:00:15 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3DC061A10
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 09:00:15 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o3so8752364vsd.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MRgEfFWldJ+nbPjKrWVW/UCyBRIS5F0risTypuqjZbc=;
        b=bf/h90z2UtECKe04PdPSLo3xFI9UibHSNhf8MnnbBStOGjK4qsZvkfvYkNEazSPnIB
         7F9fPigAVR0PZi+8VA8WBSYXEy2UJaFv+UYSNHs+NmvIavRpE1nEAICR100/5ROJeXqL
         +0NLMUCXKiqul20JXA/X6ijivap1AreLMt+xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MRgEfFWldJ+nbPjKrWVW/UCyBRIS5F0risTypuqjZbc=;
        b=D+vu4PRHo6hAc1T7hnkag0rS9SkZSRfQFAa2fkE937UoCQD4BRelii6SHcLbLiEt16
         sNdpcdn0SThZGeHmyBQ87WdvwFaIV8KCxv13FZ0bgzpplpbOl14/LG1PbFottskr5f5T
         MYfyfbxtbRdY2ZSCRhjvXRIbKrvYgJoxIxKUvEatT20Tjt0qk+ll6Ag+/qLWaaSgZtDz
         M0WJtoXrp5lEJ/SnYQf/gK5xu1U1rJDbZ0hfLMAc5SVqnEVmEq+CVnzn1TwcvJAyJCxq
         nruha1gPNJZsgPOvndJYkTEra4/ArjttyKvwae3TXiPePOCpZ2peL/pHAsf5waN9YTuQ
         +sHA==
X-Gm-Message-State: AGi0PuaTs+YlDWx2EPHaKWbet9Ynq2juiEtRyscvRZUcodptyB+5EapY
        zbtfNsGIwR7qaKgKZKhR1tOyM0epCnA=
X-Google-Smtp-Source: APiQypLQHYM7QKmSo4xDrsdiRahH6j/OazroOWHwuJfkD/gtPGqC0ZeACS36AoElzLQgwkDM7DpqsQ==
X-Received: by 2002:a67:f1c3:: with SMTP id v3mr15140907vsm.119.1587484813164;
        Tue, 21 Apr 2020 09:00:13 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id h16sm840074vkc.44.2020.04.21.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:00:12 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 1/3] bluetooth:Adding driver and quirk defs for multi-role LE
Date:   Tue, 21 Apr 2020 15:59:53 +0000
Message-Id: <20200421155954.137391-2-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421155954.137391-1-alainm@chromium.org>
References: <20200421155954.137391-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds the relevant driver and quirk to allow drivers to
report the le_states as being trustworthy.

This has historically been disabled as controllers did not reliably
support this. In particular, this will be used to relax this condition
for controllers that have been well tested and reliable.

	/* Most controller will fail if we try to create new connections
	 * while we have an existing one in slave role.
	 */
	if (hdev->conn_hash.le_num_slave > 0)
		return NULL;

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 drivers/bluetooth/btusb.c   | 2 +-
 include/net/bluetooth/hci.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3bdec42c9612..dd27e28d4601 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -58,7 +58,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_CW6622		0x100000
 #define BTUSB_MEDIATEK		0x200000
 #define BTUSB_WIDEBAND_SPEECH	0x400000
-
+#define BTUSB_VALID_LE_STATES   0x800000
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f60e135aeb6..25c2e5ee81dc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -214,6 +214,15 @@ enum {
 	 * This quirk must be set before hci_register_dev is called.
 	 */
 	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED,
+
+	/* When this quirk is set, the controller has validated that
+	 * LE states reported through the HCI_LE_READ_SUPPORTED_STATES are
+	 * valid.  This mechanism is necessary as many controllers have
+	 * been seen has having trouble initiating a connectable
+	 * advertisement despite the state combination being reported as
+	 * supported.
+	 */
+	HCI_QUIRK_VALID_LE_STATES,
 };
 
 /* HCI device flags */
-- 
2.26.1.301.g55bc3eb7cb9-goog

