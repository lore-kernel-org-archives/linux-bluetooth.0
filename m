Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AB5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 02:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECB861057
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 02:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhKMCix (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 21:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhKMCiw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 21:38:52 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CCC061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 18:36:01 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b68so9948733pfg.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 18:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRrAXH+ErzMdl3C5zM7lid4/LDebLcY0b1kuEmm5RPs=;
        b=BBllkQ5/egmh586yyRdfrMW0v6o7rqQQddqS4LG850CdbqwekW+LPrPIOx/nuwh7kq
         giQIBI7rs/DVNlIm4fn2YGymR19fijL1w6STE5dptri07PDBjzyLsehZkPFQzh8iNvtQ
         IBPXjWe2QpqDQPVBTbYE8F6zl6GPuuVlX9FhHSrtFEvOO1aFNuGEKumxwZEpRaBgsEbI
         oL3oXYFG6uB2QJcSkzw6tTDlisQKTKaarmg0XHhNTo/NxL6zYlaFF0fVL8POd7mTX2Hm
         ZgsBjDSchty1AX2KOhojs4SZjnNWc0HUtjabmOhLxT+XUHy9OvOdMY21Ef803JMydD6y
         30mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JRrAXH+ErzMdl3C5zM7lid4/LDebLcY0b1kuEmm5RPs=;
        b=VUlaxEASn3qVHsc7FBx6s3nz+OSLfhgG0r9mgNlljLrjzG0NMdPXT0Ip4j86E2aI7T
         l2VyEJRLTgCRhem4iAP9U6PdS4IeCrW6vpSU5ZNEfVUiR6y7dDGLB+jJ+8X4gfN047l1
         Jr74Lpng9rKdz3e8ymuIvQ9rS2wT4kLSgvDHIv961u/FPfaxftOP9PvzPZhNtymPi7W6
         RkNvU41jk+HTUTEUkvmmIWj1WIKSbcVs8hrirPJ6Dqybhoit6Rp8wwT525l30kKZt1n1
         Rsb6CUqPSHQnE9qfCCNZ82+NDmm7w9LJg4Hy/rSwGUd7EJhpt9Bq93pbTIB8weHy84B7
         A/yw==
X-Gm-Message-State: AOAM5324wPURRXxN3k7DR+N/NAiAV1kSBB4gO52TVEDB+CFQ27W2v2Ry
        c4MOUWZbgm2MqisRjdzG+ueMgZ/tgXk=
X-Google-Smtp-Source: ABdhPJyhXwklr9vJWdeDPlw03IZSmvjRZnfHMHajMfoHtcZNgMqmo87Nl8FNKrJUsB04Y3/dZUrwCw==
X-Received: by 2002:a63:2a97:: with SMTP id q145mr13210819pgq.217.1636770960670;
        Fri, 12 Nov 2021 18:36:00 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:5c5a:3570:def6:e3d5])
        by smtp.gmail.com with ESMTPSA id co4sm12006768pjb.2.2021.11.12.18.35.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 18:36:00 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 1/3] emulator: Fix uninitiailzed scalar variable
Date:   Fri, 12 Nov 2021 18:35:57 -0800
Message-Id: <20211113023559.212793-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the uninitiailzed varialble(CWE-457) reported by
the Coverity scan.
---
 emulator/bthost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 61f1cd361..66e337f34 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1570,6 +1570,7 @@ static void rfcomm_sabm_send(struct bthost *bthost, struct btconn *conn,
 {
 	struct rfcomm_cmd cmd;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.address = RFCOMM_ADDR(cr, dlci);
 	cmd.control = RFCOMM_CTRL(RFCOMM_SABM, 1);
 	cmd.length = RFCOMM_LEN8(0);
@@ -2123,6 +2124,7 @@ static void rfcomm_ua_send(struct bthost *bthost, struct btconn *conn,
 {
 	struct rfcomm_cmd cmd;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.address = RFCOMM_ADDR(cr, dlci);
 	cmd.control = RFCOMM_CTRL(RFCOMM_UA, 1);
 	cmd.length = RFCOMM_LEN8(0);
@@ -2136,6 +2138,7 @@ static void rfcomm_dm_send(struct bthost *bthost, struct btconn *conn,
 {
 	struct rfcomm_cmd cmd;
 
+	memset(&cmd, 0, sizeof(cmd));
 	cmd.address = RFCOMM_ADDR(cr, dlci);
 	cmd.control = RFCOMM_CTRL(RFCOMM_DM, 1);
 	cmd.length = RFCOMM_LEN8(0);
-- 
2.25.1

