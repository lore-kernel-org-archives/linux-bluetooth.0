Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2ACC4742C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Nov 2020 00:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABBE2224F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Nov 2020 00:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7SeLoMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKNAoi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Nov 2020 19:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKNAoi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Nov 2020 19:44:38 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB162C0613D1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 16:44:36 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so9032388pfb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2020 16:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCU8vowkQbrJHhgefxTlNRBptulltP25dbViZcDTAwE=;
        b=E7SeLoMNeludXy43o/wkek8glHkO2tY8aLE3xWxA+QBmf9VT6hfg/b+ICau67xQ8F/
         LdtKV6MJM54qJrjrJA4YXUumpKM3Samjfc3oS+UYmmPJjJoxm2FQToKgNI3rgeQ4k37M
         BgUWfwHozcWrO3ktpjWCKyiyvTTy0a7niFcTRVBDxdziIVMWkYu1O4BJ037HN3jIGgTj
         VspRjczHSr1Ni0qKesgJhJjEedmArbKIco5XoY6bCpo+1ljorf77F4gxo0NI4BNK4REg
         2+GZOy/PngPVvfcXt9F80WxGjEUxU5QkYC0U7KhOmdCVk1e35ByW8B3tmBbP98yGAUsf
         ycPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCU8vowkQbrJHhgefxTlNRBptulltP25dbViZcDTAwE=;
        b=oE93SixW+APUyeS7Oudjocv+mBbQk/d3xl0yIQoCXw1TKmMH28EFWSFxftr8dSXp0F
         KqYd2+TzwaIrmickZjNlHNnzwyXBBjoabe6U4U+id4ChbeCSHxrrWNgfuvsxtwnrwiQ5
         If/eYZMuasRGsMntQaRSqtc/fOwj9wcBfIrEopPj/EFqeXrBN5kgby1lNeqh60TZqwPO
         oFEL78Xkuj1dMb334WP4m6xG5fgjk7KdnGk2gXDEfVkFAyQO+M5uQur2yvsBjHOh9k3u
         YGozBeqVWXelCI7UGFmZTZ6nU+qWgapSeuiu3+AMaQ5YQg/BTObKgQDgm2YJqESRA1q/
         qBew==
X-Gm-Message-State: AOAM533XRLYeO4ZaXDHqR3b64Sbo/7uletYToOwU/jMHtJsmuXBa2rq6
        Dos/2yr/sWUdvm8xvps/GYUpdR8Ev5Q=
X-Google-Smtp-Source: ABdhPJxFUNHlEb4kMtyJwVERJGQoIRztnfliK6OgBf6sFby/BisU6ztIsgLXSChmoEi9RkJ1ysz5bg==
X-Received: by 2002:aa7:8704:0:b029:18a:e2c9:c38 with SMTP id b4-20020aa787040000b029018ae2c90c38mr4027973pfo.79.1605314676095;
        Fri, 13 Nov 2020 16:44:36 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r12sm10710637pfh.213.2020.11.13.16.44.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 16:44:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix not sending Set Extended Scan Response
Date:   Fri, 13 Nov 2020 16:44:33 -0800
Message-Id: <20201114004434.3852104-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Current code is actually failing on the following tests of mgmt-tester
because get_adv_instance_scan_rsp_len did not account for flags that
cause scan response data to be included resulting in non-scannable
instance when in fact it should be scannable.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_request.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 6f12bab4d2fa..bd67c80347cf 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1052,9 +1052,10 @@ static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
 	if (!adv_instance)
 		return 0;
 
-	/* TODO: Take into account the "appearance" and "local-name" flags here.
-	 * These are currently being ignored as they are not supported.
-	 */
+	if (adv_instance->flags & MGMT_ADV_FLAG_APPEARANCE ||
+	    adv_instance->flags & MGMT_ADV_FLAG_LOCAL_NAME)
+		return 1;
+
 	return adv_instance->scan_rsp_len;
 }
 
@@ -1591,14 +1592,11 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
 
 		memset(&cp, 0, sizeof(cp));
 
-		/* Extended scan response data doesn't allow a response to be
-		 * set if the instance isn't scannable.
-		 */
-		if (get_adv_instance_scan_rsp_len(hdev, instance))
+		if (instance)
 			len = create_instance_scan_rsp_data(hdev, instance,
 							    cp.data);
 		else
-			len = 0;
+			len = create_default_scan_rsp_data(hdev, cp.data);
 
 		if (hdev->scan_rsp_data_len == len &&
 		    !memcmp(cp.data, hdev->scan_rsp_data, len))
-- 
2.26.2

