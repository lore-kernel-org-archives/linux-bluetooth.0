Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE31BC77B78
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 May 2023 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEBUP7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 May 2023 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEBUP6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 May 2023 16:15:58 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D90210E
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 May 2023 13:15:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ab05018381so18848805ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 May 2023 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683058540; x=1685650540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5PgbJGedD8HlcmGT/8oN+fJ8K2DKtJGmVsb+pq6khc=;
        b=Aj4ohmxSDdXcFj6mCf2IViXweAs6fnspJYUn9WwHF9PkoJXkHNUzYoG1h1HEBslVtb
         lYjT2IOlG7/dkjsgOUhRWQ74DG4r/yQdFjFVBM7Z07J+TVKsuB0ikVjSNhZw2S5RfU1l
         B+sjLDAbDDs+WNi2M+Dy4By6JdIROJwMYpxTKB0fxchEt1LoSQ1uuluABEVrG9/mhaNo
         SxgMKOURaCWzknj/ooFbV53j18Xf54C/4pFpzRdkJTnphVu9NTULjthoi8rrlwe9omRA
         wVisxtArOrZV5di5ZB9tWIH25maRHIpRtaRTecOufor9lF9whvJG6/zu7nmwxvGvzNnU
         7WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058540; x=1685650540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5PgbJGedD8HlcmGT/8oN+fJ8K2DKtJGmVsb+pq6khc=;
        b=l5PhzaS6puCZWc3jFc7+Rm8HBiX6H86j4mkeHUi8/x8hvKR/WMagKVy97ojAIuqykK
         fRSh9vtbD8xdQR68I8hl0I2XUuMgDYBsK+FLGPcyMhepGCSavN3OldY8zIw+PgOUA94S
         HLwG2VpmWhh6Qatg7pMdK9/FElEYKSodm5EkVPTMztuvbI0h67xuiPvOBhrD2wRQEDwM
         uUmJeEUd4K/oBzJy4oKG5crevQdwpEa4y6Mbx24O6x9CXRYgBbNa7KxdhXO0LMAeAUH6
         Y9lQkhDxHpJrox9S4OVmzBGphXIdm7b7kM3GLzK8IlnH1iLyYAq2EZW3gVlK3P1suRfR
         fuZQ==
X-Gm-Message-State: AC+VfDxF1u5nrTUiyiUTzbOb2i8Fm4HMYrO3tq1NHvRm32hf5/mbHfxU
        n2jSX2XYV/GkpSmb6TArPuw4RPGuWqI=
X-Google-Smtp-Source: ACHHUZ4pRxBbgujyNXnhWl3EUe28JjLHKwQZnJXpBo6ZK4B/bCBs1qmKc+5ezidJMuSVqXCHRtqmNg==
X-Received: by 2002:a17:903:2310:b0:19c:fc41:2dfd with SMTP id d16-20020a170903231000b0019cfc412dfdmr24459218plh.29.1683058539665;
        Tue, 02 May 2023 13:15:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0019cb6222691sm20133364plo.133.2023.05.02.13.15.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 13:15:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
Date:   Tue,  2 May 2023 13:15:32 -0700
Message-Id: <20230502201534.1500462-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502201534.1500462-1-luiz.dentz@gmail.com>
References: <20230502201534.1500462-1-luiz.dentz@gmail.com>
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

