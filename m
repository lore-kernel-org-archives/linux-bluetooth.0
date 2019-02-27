Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E07C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732712147C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 11:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMewDIv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfB0Lqe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:46:34 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36029 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbfB0Lqd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 06:46:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so13635731eds.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Feb 2019 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=6EQoltPuuCPbxSs9z5x2eFXgX7Go4GZJBLkD4HSlW9E=;
        b=aMewDIv892dzWI/K6ERtCwGJ0ticGn16BX6HwlkAhsWmEcRwkbKKEbTti17WKKLb6t
         rMLapbEy/RDHnPHWEPCDdZjulanInvL0LnYdQ7+wiwyPZ606rHcCuZ3VQFssxbTxEob+
         FJaidZyIoRxnxxwznk0Nw0sIfJaFZO2BOIIHV+SKS5Sc0cqa7jctzKn8IFN1TmfeLgwX
         s7F+ggqvJgO9uG58z4kNXaQsH4dhRnHionpOKo50vAeH2rngXacAWP3IXUTw7pBemo21
         Lr8hIAdSnZQgeH9V97lNcspX34hlQHX7qiLh0UjzmMs5vZlgVSHNP/bafXRrSSAOJAXe
         hG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=6EQoltPuuCPbxSs9z5x2eFXgX7Go4GZJBLkD4HSlW9E=;
        b=HLPQxKprTdHxFgQ6gjdM9qQ6JjWmY9w6VslLElUG6oJiiPHI2BmOtr91G85G1Y5pVD
         J6Ab/YYFLQXvxLQ2bwDWI453mqDl0yjjw+h9B9Y68YmkENXGr6t88+1MDJ9ta+/4m8ay
         8yDVUp+9C3lBRZRB4iCRrEzYUR/rUq7EQftDsU3q/VquhNWLS74bioFjLxnN4ogUxMc8
         jqE3q0XDlyAi7RikwzkwLJTTnRA/1euuLMzxS3Q9kDU3DWST7YIJ7kSl7XNXRnPq9Q5f
         HBuyA3jE4YenYkruc3cjb0kRbWWW00LZVqkGn4zsob9lDeDWfeWoMlth09MkMJ0loclG
         i7Zw==
X-Gm-Message-State: AHQUAubijeq6kd9Fgzzq/QK0GRcxJWa3/SSNghPLOI8GC/+bX4057p4E
        Gal6JD0SXM/On+JRYyqPN4YYVWk19eM=
X-Google-Smtp-Source: AHgI3IY5uSsSectgft8QEYRdGqZBy4oEOUWi9muTumUezlBPtNLp3Nr7IyqsUFOoWbEo1kpmECqUoQ==
X-Received: by 2002:a17:906:e56:: with SMTP id q22mr1270337eji.132.1551267991166;
        Wed, 27 Feb 2019 03:46:31 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l24sm2652333eja.57.2019.02.27.03.46.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 03:46:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] monitor: Decode LL_CLOCK_ACCURACY_*
Date:   Wed, 27 Feb 2019 13:46:20 +0200
Message-Id: <20190227114620.21630-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190227114620.21630-1-luiz.dentz@gmail.com>
References: <20190227114620.21630-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces the command passing for LL_CLOCK_ACCURACY_* PDUs added
in 5.1.
---
 monitor/bt.h | 7 +++++++
 monitor/ll.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 3b2af7439..af17c1f82 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -168,6 +168,13 @@ struct bt_ll_periodic_sync_ind {
 	uint16_t sync_counter;
 } __attribute__ ((packed));
 
+#define BT_LL_CLOCK_ACCURACY_REQ 0x1d
+struct bt_ll_clock_acc {
+	uint8_t  sca;
+} __attribute__ ((packed));
+
+#define BT_LL_CLOCK_ACCURACY_RSP 0x1e
+
 #define LMP_ESC4(x) ((127 << 8) | (x))
 
 #define BT_LMP_NAME_REQ			1
diff --git a/monitor/ll.c b/monitor/ll.c
index 712c383a6..5141f2be6 100644
--- a/monitor/ll.c
+++ b/monitor/ll.c
@@ -594,6 +594,13 @@ static void periodic_sync_ind(const void *data, uint8_t size)
 	print_field("syncConnEventCount: 0x%4.4x", pdu->sync_counter);
 }
 
+static void clock_acc_req_rsp(const void *data, uint8_t size)
+{
+	const struct bt_ll_clock_acc *pdu = data;
+
+	print_field("SCA: 0x%2.2x", pdu->sca);
+}
+
 struct llcp_data {
 	uint8_t opcode;
 	const char *str;
@@ -632,6 +639,8 @@ static const struct llcp_data llcp_table[] = {
 	{ 0x1a, "LL_CTE_REQ",               cte_req,            1, true },
 	{ 0x1b, "LL_CTE_RSP",               null_pdu,           0, true },
 	{ 0x1c, "LL_PERIODIC_SYNC_IND",     periodic_sync_ind, 34, true },
+	{ 0x1d, "LL_CLOCK_ACCURACY_REQ",    clock_acc_req_rsp,  1, true },
+	{ 0x1e, "LL_CLOCK_ACCURACY_RSP",    clock_acc_req_rsp,  1, true },
 	{ }
 };
 
-- 
2.17.2

