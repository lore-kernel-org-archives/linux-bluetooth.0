Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD115C433C1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Mar 2021 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9F761968
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Mar 2021 17:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhC2R10 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Mar 2021 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhC2R1G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Mar 2021 13:27:06 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079D0C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 10:27:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v10so9821713pgs.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq8ca9NLJfG3o1JyMrCOMOp3uD86KQjuHEhSu8hpy1U=;
        b=eeIsIc4x9xpAUtdgotMV1XEOCpIe80M6W0TLd7min6B40qUWzFBbp5k0wz27YAU0Qc
         mfb8BhK0J8fpXvd4VXbNF8l74SEXRQNY2ZWZSCsy7KCP4q1Esb56WoXjW9nE249uZA+U
         VxkBmSo5KH33WlUJj0aQgFH6wt+mI6f79eTb4wYXY55CynUcF1VllD2nmPaEtxOXhQIX
         OtI3TyQPIu9L/hVyKIhYmnCGUqzeL3k6bIE0//hHMK1xg9aaRQVTFgB2Hzzjqe0Z0tLS
         cM9noZA5pr5bHc7zUmEymAEHzbu0iWpcEx+zu9OHPAdeP9jxPhTRVPJnUCnuR8HbFdqv
         zJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq8ca9NLJfG3o1JyMrCOMOp3uD86KQjuHEhSu8hpy1U=;
        b=RyMQCISrDIjmwKtgeY/MxFcXqOMbDYKtCg3dOzF1sNsjec9HvzyJ+AigatBOnh/pdv
         /oGbKms1j2sYsEvdEOTeieahMoZabIkPO5F4X+vAMxc0nmDMfq7wIh6/58IZxXfVmAZx
         /hPBPeckY5jVCd882ddzQ/qr74GIPsjyC/sXj9ZYMBsq3ig7ybaInRWsY9TAW7l2K+QP
         kVgmnTtPeiqrV7FJyjSp6iyd05+h9aW+PiQthFygA2SWJayKXnVG2XHaUlhivYw1YNFq
         6cN7WUPAnwYxZeEUnvXIob1mFlogRRzdXEI8fN+U7NvhjKGjf6qNo+0M0GbQ2ur+BiHE
         b1Lw==
X-Gm-Message-State: AOAM532mFlvX4byE7cMIEAuu5HONC6ffH1cjN8dmecz2i/ZqxZWzYdxp
        kFqjByMSsxt6pLUlWRMcqLRXq8Rdvw8sew==
X-Google-Smtp-Source: ABdhPJwfprMHh09q0/viyRDf1Hsi0MCJo9aPUdJNauThkm9ID7aQ7QW2VQlMrQPPFZn7cUaHCF+qEg==
X-Received: by 2002:a63:2c8a:: with SMTP id s132mr2811150pgs.165.1617038825324;
        Mon, 29 Mar 2021 10:27:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y194sm17379642pfb.21.2021.03.29.10.27.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 10:27:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: SMP: Fix variable dereferenced before check 'conn'
Date:   Mon, 29 Mar 2021 10:27:04 -0700
Message-Id: <20210329172704.117731-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes kbuild findings:

smatch warnings:
net/bluetooth/smp.c:1633 smp_user_confirm_reply() warn: variable
dereferenced before check 'conn' (see line 1631)

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/bluetooth/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2def90668173..5c17acfb1645 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1628,11 +1628,11 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	u32 value;
 	int err;
 
-	bt_dev_dbg(conn->hcon->hdev, "");
-
 	if (!conn)
 		return -ENOTCONN;
 
+	bt_dev_dbg(conn->hcon->hdev, "");
+
 	chan = conn->smp;
 	if (!chan)
 		return -ENOTCONN;
-- 
2.30.2

