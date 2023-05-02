Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2243C77B78
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 21:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjEBVZd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEBVZb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 17:25:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A8910F3
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 14:25:30 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b70f0b320so4957550b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683062729; x=1685654729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgeP9iViJu3wZuagkzymDfMYkLiOzZ5zvhKcpAeRDdU=;
        b=SHaCAIxyVDvgSYSaKVCHoJ28uAOm+c2MkygUM3kxRqB7qLirMnWoO1bSOCE4K2s3gt
         gLsD44kzl0haEjqSS7x1tDFD1C2DkQIdThizNCu7Dm0efbmslRwWc26m8Gv9JPioNjlp
         S63r7tZfEMt/5kO3ASWtbq3+k/+BdVFq+YVgpcGvVnVJtWixgF+hjWczOxC127DybeRH
         doiRW0IRh9dca9WRiX4V6nFBQ1dOn0t4hBlnJ5HlX9/nPF1fABPSiIelKy8jWHBFLJgI
         2aSioUuwlYf6Yy8DpbzG5hq3YtTI3Y3kIYfEk0T6mcQvJzw0JMbcj5pp+YKejr8GNJh+
         IiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062729; x=1685654729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgeP9iViJu3wZuagkzymDfMYkLiOzZ5zvhKcpAeRDdU=;
        b=gJ0BEJ1KbDVIeanscqb9FyhZHtG18YCRxf1aD74V3PZxRaUYuBBAX3zYPMGpHkzXCb
         pXHK1PkjaTqpDJdQC9clkEK5fAjzmG/tRQXAOtKDbtxMaoLj4dXG14agj3sc3epg4Nv1
         zzc6Yd3VHRNsK6NrBjgwcabqRvKESAXxP7I0pzIjqoxVRwVdVn0cyxNtKCyZ5EB0tMU5
         XDIBNarwZsh/qX4+c6f5tRS51vbaTB2LBQ/cxtqwGTd3qEgvQnpPNs3wflrwPwMUWSef
         C+2N+dinwd7HQxq8bSrSkMmo4wwTR0pgxgXUvtLKs6ZbOsICt2JoCllmlgomILgBx7ez
         drDQ==
X-Gm-Message-State: AC+VfDw/StMvUX9GlmqnIulqF5ivNALM79Q3gpHadmcMLFRRqgAZaeJ+
        VdwmCV3EVCa2HAeSbWYA30DiJtvUqU4=
X-Google-Smtp-Source: ACHHUZ56EjstFT1a7iAO9nAuLiw02hcUPJzURNDTjiFLwljBO1xoyvvnFYNAL7b1v+08+9O30m7MGg==
X-Received: by 2002:a05:6a20:6a26:b0:ef:2389:66ca with SMTP id p38-20020a056a206a2600b000ef238966camr24352446pzk.7.1683062729399;
        Tue, 02 May 2023 14:25:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b0063d3d776910sm22232459pfj.138.2023.05.02.14.25.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:25:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
Date:   Tue,  2 May 2023 14:25:24 -0700
Message-Id: <20230502212527.1662896-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

The hci_conn_unlink function is being called by hci_conn_del, which
means it should not call hci_conn_del with the input parameter conn
again. If it does, conn may have already been released when
hci_conn_unlink returns, leading to potential UAF and double-free
issues.

This patch resolves the problem by modifying hci_conn_unlink to release
only conn's child links when necessary, but never release conn itself.

Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-bluetooth/000000000000484a8205faafe216@google.com/
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Reported-by: syzbot+690b90b14f14f43f4688@syzkaller.appspotmail.com
Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Reported-by: syzbot+8bb72f86fc823817bc5d@syzkaller.appspotmail.com
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 640b951bf40a..70e1655a9df6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1083,8 +1083,18 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
-		list_for_each_entry_safe(link, t, &conn->link_list, list)
-			hci_conn_unlink(link->conn);
+		list_for_each_entry_safe(link, t, &conn->link_list, list) {
+			struct hci_conn *child = link->conn;
+
+			hci_conn_unlink(child);
+
+			/* Due to race, SCO connection might be not established
+			 * yet at this point. Delete it now, otherwise it is
+			 * possible for it to be stuck and can't be deleted.
+			 */
+			if (child->handle == HCI_CONN_HANDLE_UNSET)
+				hci_conn_del(child);
+		}
 
 		return;
 	}
@@ -1100,13 +1110,6 @@ static void hci_conn_unlink(struct hci_conn *conn)
 
 	kfree(conn->link);
 	conn->link = NULL;
-
-	/* Due to race, SCO connection might be not established
-	 * yet at this point. Delete it now, otherwise it is
-	 * possible for it to be stuck and can't be deleted.
-	 */
-	if (conn->handle == HCI_CONN_HANDLE_UNSET)
-		hci_conn_del(conn);
 }
 
 int hci_conn_del(struct hci_conn *conn)
-- 
2.40.0

