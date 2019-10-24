Return-Path: <SRS0=pV4/=YR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9564FCA9EAF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Oct 2019 13:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7AF2166E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Oct 2019 13:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdk2Gc9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502475AbfJXNPv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:15:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33269 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502409AbfJXNPu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Oct 2019 09:15:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so17279223wro.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2019 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VfO9qD2A3/aBq+u0oWjyv1HV/mx6qQqFV7SC+93mn1I=;
        b=Qdk2Gc9LSK6/rVpA4CeLW7ROUDtlbNXb+pPP7k6WQPSTNFRoqYV8WQcRWNyIrj5QhN
         DJdgw2x1FYvDscIilJENS+YqdR/LnRBm08JAIFm5Ohlbx2eH6zRrgqjqLyiKXgQLwsi/
         lXRjkBjx2hvAh+5sAx8iODFqrZqgGMc93n0P3VwjIPbIMk12f5kbXIDVczLCuZ3PAGZ6
         V4hHggx6wDPmWb2/4nWqtzCvHxZyqJWnqoxLQj5QIQg26mob5HGAUJWp/J6/75JH+yWx
         8WHEetzeoocfBkrezn2F+DmlugRxCcU45XQI0qdVA8R0pecaWc+xoRXPvIF/kftl7RDR
         Riog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfO9qD2A3/aBq+u0oWjyv1HV/mx6qQqFV7SC+93mn1I=;
        b=c64xv6lv8BwCAxR9MeljSZsFs0BK/gNNG7xcljeoYgSGVg2a8kx+iB9AjWrJuZLDdO
         +dZnskHV/9rPhpXkBQUWPrzWWv3DfAP11IsuAygtW7S3+CFQuowQ2W2L2MqS+k0po8dz
         j49oMm3ww7jQwNl9qwtGzDfUkfROr4pgb42p97EIBOQsv/Eh0n3n3bsTJfh0xRimGdzc
         bJOorgV3MeTzbrohhvOd4pEvfZd6JB4uF4MQulzc9tgbNIIIZldr4JgJ/XKy4Ri8uMGX
         8Zgadv2WHFHmUP5RmTUEGrCi4MDIzme5hW8wODA84PdZNBnG9eYJNVavXx1wol1CFYRj
         W95w==
X-Gm-Message-State: APjAAAWiQ0XPeFrMJ1McrznNBhtqOezKFl+7aW7ksX87RecONsulbxoa
        eXzMaH4RPla7TvuIn/KZdAzw+adk18I=
X-Google-Smtp-Source: APXvYqxgxdh9MyevugGh6v7PKtQvfII55bHjJkmAbW4w1fumhx7vCNL/96JmDw6o9wHm+UGIY3HxpA==
X-Received: by 2002:adf:8465:: with SMTP id 92mr3658430wrf.376.1571922947943;
        Thu, 24 Oct 2019 06:15:47 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.61])
        by smtp.gmail.com with ESMTPSA id d8sm11891334wrr.71.2019.10.24.06.15.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:15:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix not using LE_ADV_NONCONN_IND for instance 0
Date:   Thu, 24 Oct 2019 16:15:43 +0300
Message-Id: <20191024131543.10794-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024131543.10794-1-luiz.dentz@gmail.com>
References: <20191024131543.10794-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instance 0 is controlled by stack itself and always set the local name
in the scan response.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_request.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3a2ec34c2999..ba99c292cf04 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -904,9 +904,9 @@ static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
 {
 	struct adv_info *adv_instance;
 
-	/* Ignore instance 0 */
+	/* Instance 0x00 always set local name */
 	if (instance == 0x00)
-		return 0;
+		return 1;
 
 	adv_instance = hci_find_adv_instance(hdev, instance);
 	if (!adv_instance)
@@ -923,9 +923,9 @@ static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
 	u8 instance = hdev->cur_adv_instance;
 	struct adv_info *adv_instance;
 
-	/* Ignore instance 0 */
+	/* Instance 0x00 always set local name */
 	if (instance == 0x00)
-		return 0;
+		return 1;
 
 	adv_instance = hci_find_adv_instance(hdev, instance);
 	if (!adv_instance)
-- 
2.21.0

