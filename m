Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBADC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390252AbiDUVtF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442172AbiDUVtB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 17:49:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7EA4A904
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:46:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so6630588plg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VP8YKOzYi1zRrFBd4Bgm9vysYewj1f7W2UFWZJcysQs=;
        b=SDVjJXpiHLHj/wp1pNaw0WPv9bhYvLzb0dwXmgVMf/2kWOC5MEywnOiovMDvCmN7t/
         6tjj8B8ue5OslObbTmhsI/tlNGAmmyF4hP2PThcoJ10CjTcH10Zk4288CoL67UiXi4Xq
         NQpedsnAxn4p+dPBEoweETn7OsOEAuDjqYzJmFRaeyURkDfe6coOc2HdrPv0SodpPnMD
         D/tZietLpKrfVQWaO2ApJTj3gHq27rwPcbtcNVBDFuq2KXb8TGc3XxWHheWNTFqNMxdY
         8/k042lwxYF3p2I9Bs0uYSuZdJ6sfP9XAvsj/3g2aL3iGzWce2vB7KItUnkcWEQzvQiD
         O6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VP8YKOzYi1zRrFBd4Bgm9vysYewj1f7W2UFWZJcysQs=;
        b=CC597kwxeqmhXjRaOztHh+L+5Py2VCtRg6sdum9+aDKe8G+aVzJL13DIvHWZU4gFsr
         Kw19HplxTxIqpwugkF/hHyH43hSmxHqg0GbKFNgsBYX1W7a0icarW9cNfetIvX2Z+rU3
         +t6clF/2CCEy/iqrlVYaZh7zv0HnLCMi1zAASZEr9zUWF3RdQr+ub2TEEGQqXOCFCPws
         z1yD6I8nMf0DVaUheX4rg35E89YA2O8YhoNElvThFw/yBIX2nPAhkwvvoH+kYl6QVdNs
         8k9d/OfR6Sa0XDilFpGmV+6wBXxMW96Pnsc2FQ+9UhuHPo2fODcdIZEPWHpuAM1oLX15
         ubYg==
X-Gm-Message-State: AOAM532VaYCeknazDTbPWu/e8JQrIcQ1jummgtEC9mh9YDzo6qnzA4uv
        bVR1YTCJmM/EJthli2u3hzv8I7Inwb0=
X-Google-Smtp-Source: ABdhPJxd2Kvj1MeALgZzUAFbbDCdhIya9wGCptCDcEXrmIUkm4f1HCu2UhVM345GoTEdYhm0+PCdMg==
X-Received: by 2002:a17:903:124a:b0:154:c860:6d52 with SMTP id u10-20020a170903124a00b00154c8606d52mr1202635plh.159.1650577570361;
        Thu, 21 Apr 2022 14:46:10 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id mp9-20020a17090b190900b001cd4989feb6sm3812484pjb.2.2022.04.21.14.46.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:46:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: hci_event: Fix creating hci_conn object on error status
Date:   Thu, 21 Apr 2022 14:46:06 -0700
Message-Id: <20220421214607.3326277-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421214607.3326277-1-luiz.dentz@gmail.com>
References: <20220421214607.3326277-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It is useless to create a hci_conn object if on error status as the
result would be it being freed in the process and anyway it is likely
the result of controller and host stack being out of sync.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9feef7dbde3d..3002df41f16b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3074,6 +3074,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 	if (!conn) {
+		/* In case of error status and there is no connection pending
+		 * just unlock as there is nothing to cleanup.
+		 */
+		if (ev->status)
+			goto unlock;
+
 		/* Connection may not exist if auto-connected. Check the bredr
 		 * allowlist to see if this device is allowed to auto connect.
 		 * If link is an ACL type, create a connection class
@@ -5540,6 +5546,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 	conn = hci_lookup_le_connect(hdev);
 	if (!conn) {
+		/* In case of error status and there is no connection pending
+		 * just unlock as there is nothing to cleanup.
+		 */
+		if (status)
+			goto unlock;
+
 		conn = hci_conn_add(hdev, LE_LINK, bdaddr, role);
 		if (!conn) {
 			bt_dev_err(hdev, "no memory for new connection");
-- 
2.35.1

