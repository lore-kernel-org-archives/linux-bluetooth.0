Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17645C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Apr 2022 21:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiDVV6X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 17:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiDVV5g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 17:57:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DFC403EB1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 13:40:43 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id jt15so935420qvb.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1i0K30LFa4m8qBgr+gwjt8LEMTii5+35tajj/mmobw8=;
        b=pu5g33jaQ0hskZ7GCpdIJiiN6PeQbdgdAsDeZZC6HhlYCXHDqMkveeiqlThUmakzpw
         hqGh+gmfSKevLgNFnxjiJbBIaRmkgOAKQv/QtAHvoiiuVnzOEVd2cvrbawcT2TtamKGq
         jr+pckKfMdxhY0qdKkm4QE0tQMY3+Xc9LQUjD5W7Y72cA2ilR8Ddw2kNWjrHsnZS6/k+
         A7DjWmoyfd5Z48hqgeIta4vnoDguP2JAKi5yPObunIwaa+8+xGA+0Ulwh13ylWXPh6X+
         pVg1CeYCZ0ukcJ65QW40iNPxbTDU4/QEl+4ioM0A2CL3YoF6no64gOaHupttfcwEPSff
         UpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1i0K30LFa4m8qBgr+gwjt8LEMTii5+35tajj/mmobw8=;
        b=R+zPTZKb4p7B6ktsgAIjiZr+Jhkt0alI6EBHaeD8i5UE6b2KZdErYD7crugyM6vHV7
         4WZKpfSpNDJ5h9quZLgV9zr0mMb4Lw4usqm+q7kDTysZ+japLXW2dxATq/bwxs/Gqhdo
         Co+XWs+2dQ3jsptMLG44k+DtC5Lj0giU6LPghSf/JHnFABdRmGRW54oaX520qiWeCmvi
         ZfX9zQS7n6XyCsP8SI7GDOxJMD9YzBTPVpcxkPZlWTQGab3Af5Gj/0j1RiykUi+Zi9PA
         NV2j+WIbEjvK36c9Mw1NFzCXnlqASMbuYD47Wv+H/4QJQ8eApdsU6KgAnnzuXpb9zyH3
         qvuQ==
X-Gm-Message-State: AOAM531ijU+m62N3m9xpJxGOFZ9i+X6lHTcWBSd/04AFEyan/PthFJJG
        k7xbi0iiDW89OegIn97NWL8LU8nf4SI=
X-Google-Smtp-Source: ABdhPJxw8Nobfm5t0MB7jtvMmG/lABw8T1Z6101/hqV9+TiYnZgCreab9vYKB+FMhnZGgxIqNPfjJQ==
X-Received: by 2002:a17:902:854c:b0:158:35ce:9739 with SMTP id d12-20020a170902854c00b0015835ce9739mr6126643plo.150.1650657501078;
        Fri, 22 Apr 2022 12:58:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090a2c4600b001cb78f1e301sm7152116pjm.1.2022.04.22.12.58.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:58:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/3] Bluetooth: hci_event: Fix creating hci_conn object on error status
Date:   Fri, 22 Apr 2022 12:58:17 -0700
Message-Id: <20220422195818.3640058-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422195818.3640058-1-luiz.dentz@gmail.com>
References: <20220422195818.3640058-1-luiz.dentz@gmail.com>
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
index 3a9071b987f4..5a6c8afc51a0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3075,6 +3075,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
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
@@ -5542,6 +5548,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
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

