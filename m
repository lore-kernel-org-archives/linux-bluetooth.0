Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C192EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 01:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiENBln (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 21:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiENBlm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 21:41:42 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B936DCDD
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:46:27 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o190so10336879iof.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VlFyv9ldND/lJmA77XlE+D6MAlUKWPX9DalQosILKag=;
        b=jvPJb5/FrbHeypd7sMc4l6Cli6Izcz+IphxhKGAkhetMXNO16wnUcANno3TIYVR62l
         xKu0MUwQCdbdFxyalxjNtUbdFShSAEhzDcluZTfWL659bGUkH7rBIJ7FaCRF7gXp9WtJ
         AnG0mNV0XgquAmjmCor5EBxKdeDLc1+A+P2OqDSkanyfPhsowbtw7o7xJcrKJWKTSd+d
         TP1gosSV32D8YhtSVVBQY0EHtdrHURsbfWahM3Z0HfqTMhpc1838Nkcrsc4CslUo136W
         QxK+pu10vZFr1ILY7zo5LG/GqIwUvv1ejBmjKfMrD8jkioSPW3vcUr7WqKNADw0Ox0be
         Lovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VlFyv9ldND/lJmA77XlE+D6MAlUKWPX9DalQosILKag=;
        b=cM+kWAjaHcdtEyGTRvMHlz0YjjfcNo6HausfSWRT+SeCZWDdJ0OTVct3mNYgf+eu0C
         sADuvTW5tv173aaAF1yi+3Owbucdch7mBUcLvctqv3WCpa6Cjbg89n7eAch9xgapZqJd
         83Xr80i5bNxln7LPDQRxdXHEan5aIrDpo+BqGY7YWwyGcZUeztiDNeo0lCU32vfyh7eT
         Ga2CC7EdWPAkcmtIkQZx3jBPFYZStNSNSAPzKGFLyGcGaaZQ8YN4jlSWhsWO7oiT5FFK
         hzx2JKMkGlYHFP0rnA/tNT5/mqq/yQhppi6VeC+9G1xq7n+ojUZZ3lsFilem51T8IZ2G
         mJwA==
X-Gm-Message-State: AOAM530x/0wwZ4DimwGzvX3T9jx8VoAiElVVUQ37OuV71Rj2H3ypbchu
        BpaVZ1/ciVD+HeLXJWbprWY+8sK/VVg=
X-Google-Smtp-Source: ABdhPJxFfRQUOgcsn3QvrmF2E20B0h7Plg6quvaSDj24VT5uANVvdLWj0OatdQP5vYR6QMTH/7yvIg==
X-Received: by 2002:a05:6602:15c6:b0:611:591d:1d9a with SMTP id f6-20020a05660215c600b00611591d1d9amr3258465iow.177.1652485577028;
        Fri, 13 May 2022 16:46:17 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k9-20020a02cb49000000b0032b3a78178fsm1045203jap.83.2022.05.13.16.46.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:46:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_conn: Fix hci_connect_le_sync
Date:   Fri, 13 May 2022 16:46:11 -0700
Message-Id: <20220513234611.1360704-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513234611.1360704-1-luiz.dentz@gmail.com>
References: <20220513234611.1360704-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The handling of connection failures shall be handled by the request
completion callback as already done by hci_cs_le_create_conn, also make
sure to use hci_conn_failed instead of hci_le_conn_failed as the later
don't actually call hci_conn_del to cleanup.

Fixes: 8e8b92ee60de5 ("Bluetooth: hci_sync: Add hci_le_create_conn_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 2 +-
 net/bluetooth/hci_event.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4a5193499b77..c981f3616bb1 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -946,7 +946,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (!conn)
 		goto done;
 
-	hci_le_conn_failed(conn, bt_status(err));
+	hci_conn_failed(conn, bt_status(err));
 
 done:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0270e597c285..af17dfb20e01 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5632,10 +5632,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		status = HCI_ERROR_INVALID_PARAMETERS;
 	}
 
-	if (status) {
-		hci_conn_failed(conn, status);
+	/* All connection failure handling is taken care of by the
+	 * hci_conn_failed function which is triggered by the HCI
+	 * request completion callbacks used for connecting.
+	 */
+	if (status)
 		goto unlock;
-	}
 
 	if (conn->dst_type == ADDR_LE_DEV_PUBLIC)
 		addr_type = BDADDR_LE_PUBLIC;
-- 
2.35.1

