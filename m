Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E2DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 May 2022 00:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiENADk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 20:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiENADj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 20:03:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D643D733A
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:53:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h85so10342322iof.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3DZNAkRxrKZ2IrtkklqnnZvSJg+0ZftVA00mm61Dk4k=;
        b=PzjHPNSPVIO8wkopCTLY7QP8PwH3l8Ki6I3UgxKyT1U3Uhl11OpOEzZTvXy2wX7zen
         yn5WQE2+rv7GgTSq7u3rBultfgRc9iotIw5kJF5/8UbyP/u0xhy7o/3CHEs4AJUbmpjm
         KJFpTKCViX5U6N3p9DysEPAaLOLWMFc/CQVMF1aPtNC1yGE7FtIDT1gcTkecawmqWSd5
         wEqZaJmXsaHZjaY6MClSx3tAhK14fVQUXVHUgkoDbN6VR6LMXnpz9V98xuKdwuu1ZpTK
         7BJisQtRZo6fSjhJxBxgE/m4lJq8ypWfqdji2uu/q3AZmf/7YYAVAq6DxaWNCiTbFDcL
         AT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DZNAkRxrKZ2IrtkklqnnZvSJg+0ZftVA00mm61Dk4k=;
        b=2+c09lm0jAMf5zSgU0pZWW4UtihcvaXM8M2oVsx7+x+fMUSaaneOYtbMTT4A7YCROT
         tPycA34Efu3Ja4nmIsKKfsZ6vlkyiQXy5Lx2xTbebpqmQ/U12V1rFF8VKipukw91mg0M
         wrwBBOIaTssh2vFORqBOoqZ/ddtDzoWbEetUpxbbEyCiKJPXvdxUjzjjqn1MznT5z76B
         YG+fN5whuuC9XY/FSPCcGTpQyuR1wU6g34SSk2QSwGoZWvFSqxX0vDv2Kx7WnQYd8nvq
         rKUqmLo+ce6Kb+Zov6IO8iZW+CmfSKgNpLyLbIY+c4rY8DGBZS9R/nib5lyOC4//Sffe
         7czg==
X-Gm-Message-State: AOAM5339VGw6DwPZsIViTm7pLM95xHOnEjnTlNidy0dH/DTVr3DufvB/
        aiuWa08S7LMdbjatda1Ft4qRay9JnUw=
X-Google-Smtp-Source: ABdhPJwZd25y1WfFCD5GtUQpypV2CI4Ms3UzCb6JwhrvRp1++HBNQlUb2fMWH2QOtMcNFUpLgR5cAg==
X-Received: by 2002:a05:6602:1584:b0:65a:cf4f:c93a with SMTP id e4-20020a056602158400b0065acf4fc93amr3355101iow.52.1652485887853;
        Fri, 13 May 2022 16:51:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i16-20020a056e020d9000b002d0e8a52ab6sm937628ilj.27.2022.05.13.16.51.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:51:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Use bt_status to convert from errno
Date:   Fri, 13 May 2022 16:51:24 -0700
Message-Id: <20220513235125.1364692-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513235125.1364692-1-luiz.dentz@gmail.com>
References: <20220513235125.1364692-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a command cannot be sent or there is a internal error an errno maybe
set instead of a command status.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 882a7df13005..4a5193499b77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -946,7 +946,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	if (!conn)
 		goto done;
 
-	hci_le_conn_failed(conn, err);
+	hci_le_conn_failed(conn, bt_status(err));
 
 done:
 	hci_dev_unlock(hdev);
-- 
2.35.1

