Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25BAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Dec 2021 00:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhLJAfk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Dec 2021 19:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbhLJAfj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Dec 2021 19:35:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB15C061746
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Dec 2021 16:32:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id u80so6952982pfc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Dec 2021 16:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wGY/lJtFh9HNOqkl3XT0ZdZ5QkF8anM9t/g9jTfTzis=;
        b=pC6CnGoBESUJtfO/eY/ukqwNiFmj+mF7V8AsmuaJ4Q/kwMTFBOrPnhAYwrTNt2AJIx
         iLmIH6mf6ILRXSMP4Ipg8ymMiLzDKnCV1Ov5YXDqcerGQp3twH7mdDTgPUMlwNksK7S+
         mdlVkHc7EaVlBTYwdT0UAsZk1oMx0sKB5PTD6TGKrENoTAY2Yihj1tjCTueLodI84hEp
         J9WkSk9yaQrGa/kPNBzkIau+TfpdxoBknfWgAd7iRu4hlrieydnZWdTuwh9NWk9iFO+8
         HaxeRskjGyHyNg2P3pJpPFBmnnQevnvWDcZ8PDMEOiwP77vq5zy98ENRuElK7j00a6L7
         BIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGY/lJtFh9HNOqkl3XT0ZdZ5QkF8anM9t/g9jTfTzis=;
        b=pYfkAa2xlUD3A9+1PWqWXBMg8a2KTbBRlF/QM9Z5wxor8csxQuQkx/f6rHQKO1HgSk
         ogNA9lnODQcGQCmj01gWD2LKx6yHGXSqpcSbOFM09efugEJGKk/hA+vBQ/LiTPYdzBKa
         Md8yTTp+FvOKAsNBuFNPIv6suAXf2SMxQRgCDWx82XpECQhGx0USpEC1tFoTjHwy6psQ
         zF9Rff3PmUsUetGpKLtF+yksZKV9etCpC6U9RB6YtmZSETDMbJb+M1V1qFOlkidAiIiT
         qDokMVZ9OfUuCPn/LhF8VFkBCS9Yf0yqJMEb0hIw/wpQtn/DEDK4dIp2pxLLDIiHYIMh
         32Tw==
X-Gm-Message-State: AOAM531srP9fc1xmPuW8Wq4z9BrNu9A3cqlGaCzQtVAiWwmgjdtX46+t
        yrJ6kyB2LHzfHbmrLpWGnUI0UhOTWqU=
X-Google-Smtp-Source: ABdhPJxyTBAxG/rTLwgR47cwjfdqr6cE9NnX4QGxE3rMMwf9d52FbOTZyQqt+/LXGmohWM63wFQoMA==
X-Received: by 2002:a63:48f:: with SMTP id 137mr37170601pge.469.1639096324522;
        Thu, 09 Dec 2021 16:32:04 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t130sm745502pgc.9.2021.12.09.16.32.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 16:32:04 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_sync: Wait for proper events when connecting LE
Date:   Thu,  9 Dec 2021 16:32:01 -0800
Message-Id: <20211210003201.836706-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211210003201.836706-1-luiz.dentz@gmail.com>
References: <20211210003201.836706-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When using HCI_OP_LE_CREATE_CONN wait for HCI_EV_LE_CONN_COMPLETE before
completing it and for HCI_OP_LE_EXT_CREATE_CONN wait for
HCI_EV_LE_ENHANCED_CONN_COMPLETE before resuming advertising.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8d732725b380..1d19ed944367 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5157,8 +5157,10 @@ int hci_le_ext_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		plen += sizeof(*p);
 	}
 
-	return __hci_cmd_sync_status(hdev, HCI_OP_LE_EXT_CREATE_CONN,
-				     plen, data, HCI_CMD_TIMEOUT);
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_EXT_CREATE_CONN,
+					plen, data,
+					HCI_EV_LE_ENHANCED_CONN_COMPLETE,
+					HCI_CMD_TIMEOUT, NULL);
 }
 
 int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -5262,8 +5264,9 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	cp.min_ce_len = cpu_to_le16(0x0000);
 	cp.max_ce_len = cpu_to_le16(0x0000);
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN,
-				    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
+				       sizeof(cp), &cp, HCI_EV_LE_CONN_COMPLETE,
+				       HCI_CMD_TIMEOUT, NULL);
 
 done:
 	hci_resume_advertising_sync(hdev);
-- 
2.33.1

