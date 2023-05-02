Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A357EC77B75
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 21:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjEBVZe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEBVZd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 17:25:33 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D13C10EF
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 14:25:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5465fc13so3338239b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683062731; x=1685654731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5PgbJGedD8HlcmGT/8oN+fJ8K2DKtJGmVsb+pq6khc=;
        b=oCc82gv8uGuZTArFI7/6ki9iFPIHQw5KtXNWLcX6BoV8lTiYLeoWESVMm1maOIzHvw
         3HV4WpA2TAA1+qZ/9tIF89FSwv24KAM/5J9u6vE29mqUwfVJvzxUEXK0af5su0ZmSu0o
         tvn4OayKxhz2B0SPSvU3NJzGm0YhQ4PmGXL1vm4IMTlPBjfNAXo2pZKFerN8++R+tSbY
         h/moDcbdHmDHUgLcjtVJhHJDhQqAfKQJkLlrpXzGMlgcB0Dud18ewkSN7qp/RMAtlYm8
         NUr9XFNQ25+gU7TvjBoJLyjkItx+W/o+4fka47+JFkXQeGvvlnA/1ccZ94aLGoa5ijFe
         If9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062731; x=1685654731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5PgbJGedD8HlcmGT/8oN+fJ8K2DKtJGmVsb+pq6khc=;
        b=DcdYclkvx1B11yBQSxEvx2x/WpRYkXWn1l98EhILhZ/R5WZRt+86CSaZpNkYQ+3ZMV
         VQdPheGxbIoYabv703JUvZvh3WIlMHEY/zNiE1WdGTMuape/U2I5gVF8vsS7wc457BYI
         tbt1zHzXiA11rVDOEp795sGxFx8Tw9nuK6bGpEvqc3BkeJ4VmSgOtHBDboh5MF2h9aSK
         bREX9utLu8RLFO2gSDMeO54bG0MX49fPMgGESe3hK+quwXiiXIbZn6duGnAVToDFE+5Z
         2SfVvp5BMNjEzPFatU8QafXtVq9/jR/F7H7+jf+oFLlbEbnb8/9gwE532CYbDzgFIaJv
         fHyg==
X-Gm-Message-State: AC+VfDwTDKcvA2xC9PR1xG+Y5rkKFRSjlDXyfSwqHXL1mjk5tdesHclI
        6JzpcWy+L+S/WqNwupeF/fBnLNKZtgQ=
X-Google-Smtp-Source: ACHHUZ799N+PAnKioUsby+fSL3w43vV1eDjY46vX6C5dPRpcY3exYBYBXFr5Qpz4P0M/xpLc2tlcdA==
X-Received: by 2002:a05:6a20:918d:b0:fa:3347:6e1 with SMTP id v13-20020a056a20918d00b000fa334706e1mr14139509pzd.51.1683062731120;
        Tue, 02 May 2023 14:25:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b0063d3d776910sm22232459pfj.138.2023.05.02.14.25.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 14:25:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
Date:   Tue,  2 May 2023 14:25:25 -0700
Message-Id: <20230502212527.1662896-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502212527.1662896-1-luiz.dentz@gmail.com>
References: <20230502212527.1662896-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Ruihan Li <lrh2000@pku.edu.cn>

If hci_conn_put(conn->parent) reduces conn->parent's reference count to
zero, it can immediately deallocate conn->parent. At the same time,
conn->link->list has its head in conn->parent, causing use-after-free
problems in the latter list_del_rcu(&conn->link->list).

This problem can be easily solved by reordering the two operations,
i.e., first performing the list removal with list_del_rcu and then
decreasing the refcnt with hci_conn_put.

Reported-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Closes: https://lore.kernel.org/linux-bluetooth/CABBYNZ+1kce8_RJrLNOXd_8=Mdpb=2bx4Nto-hFORk=qiOkoCg@mail.gmail.com/
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")
Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 70e1655a9df6..44d0643fc681 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1102,12 +1102,12 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->link)
 		return;
 
-	hci_conn_put(conn->parent);
-	conn->parent = NULL;
-
 	list_del_rcu(&conn->link->list);
 	synchronize_rcu();
 
+	hci_conn_put(conn->parent);
+	conn->parent = NULL;
+
 	kfree(conn->link);
 	conn->link = NULL;
 }
-- 
2.40.0

