Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9811DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiCEBX3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiCEBXZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF462F4
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so11938659pjb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9Y5pgaVkXyazSAz0gklrbyoOTE7TwpdgHa0U0KeOhL0=;
        b=WC4uB+xcx94pbVKG3sJr0QpXg3azbv/9Phqws4rjY37LiJMYI23OxqwNkYAm9/l1lF
         hlQ0++qcWwRCDRrY+mimjgezy8Qq3jrv0g3n783So4UwC2jvb5kEw9Jhtd0P2aNW2Wo4
         FtaOYl/PJfwUFhq0qLkUndS+rXR2Io/e/dhhay5ZAKZ8tCzSfiZ/49HmeIcJgFz4n/zJ
         zcZdjF96abumBht/+LGen2DjiDWAALwcABwYGLST/hMtsGmdaJPmCbdMTzPC2kN/li3H
         JZfwtk4EsxWIg8yUIT8jz0nLVvUwX68XNJ8lBwmlCFGoIIo3IieKxzSnQ9nIqbVOtNoK
         q0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Y5pgaVkXyazSAz0gklrbyoOTE7TwpdgHa0U0KeOhL0=;
        b=3tUQW0ZB3xTIkGrJu23YKGVNfpYLvPK7VN+uPyQMgMuYuaiKcL4ZK8n0C/1N0x9v3S
         hZQ2wcWNOumbYBALDFJgFOylx2OBu1f8fkCtO+iYf9837+Dfh7qpdnat7+CSE7W3gPOB
         mGKhC74D4SEtao9xqCPUt3tPfzHHI3ZJrw1rZ5VXdRN/ji2AASzgDJDbyoVZSdGr31Ny
         DW9GPX4OgMOLbard6pXw+xAcqyQ+RpsWJrJw96U2uT1XrUxnxL/2OvLtqe4WvIoNmHWg
         xg+wEx5ujeNDUnsFWuz6KwEYJSzETs9h4iabxlrDXUJ4sp+MVHfqDZFbgzWJ2JbAalh2
         PMwA==
X-Gm-Message-State: AOAM530LPRV5kevckQdVLzef4FcvYUy0X1bbaM5mpFzmcLAWpt0dqr/Z
        FV0qPyJ3WHNUvHEIZaSJ2myoqDcTU9A=
X-Google-Smtp-Source: ABdhPJzqMwgfwrJzv2gWA3xOGhEjJJwA/+WsJj1lLmuztF2GjiZ5kF9d0+D3E7yEfkD9ZhzkyuY4Zw==
X-Received: by 2002:a17:90b:17d1:b0:1bf:1e3:ded3 with SMTP id me17-20020a17090b17d100b001bf01e3ded3mr13531137pjb.144.1646443354194;
        Fri, 04 Mar 2022 17:22:34 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 04/12] btdev: Implement BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC
Date:   Fri,  4 Mar 2022 17:22:21 -0800
Message-Id: <20220305012229.853784-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds implementation of BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC.
---
 emulator/btdev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 09101a5df..15689137c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5425,8 +5425,21 @@ static int cmd_per_adv_create_sync_cancel(struct btdev *dev, const void *data,
 static int cmd_per_adv_term_sync(struct btdev *dev, const void *data,
 							uint8_t len)
 {
-	/* TODO */
-	return -ENOTSUP;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	/* If the periodic advertising train corresponding to the Sync_Handle
+	 * parameter does not exist, then the Controller shall return the error
+	 * code Unknown Advertising Identifier (0x42).
+	 */
+	if (dev->le_periodic_sync_handle != SYC_HANDLE)
+		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+	else
+		dev->le_periodic_sync_handle = 0x0000;
+
+	cmd_complete(dev, BT_HCI_CMD_LE_PERIODIC_ADV_TERM_SYNC,
+					&status, sizeof(status));
+
+	return 0;
 }
 
 static int cmd_per_adv_add(struct btdev *dev, const void *data, uint8_t len)
-- 
2.35.1

