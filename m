Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DFDC4743C
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Jun 2021 00:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5426121D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Jun 2021 00:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFEAEG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Jun 2021 20:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFEAEF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Jun 2021 20:04:05 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D43FC061766
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jun 2021 17:02:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d5-20020a17090ab305b02901675357c371so7991839pjr.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Jun 2021 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/XhIDy736F/MgXA+fkXd9PPWaYekCXW/pnskPaBXHs=;
        b=vZOgNURsu66Ps8ly5BPkCO8uhfnR1C+Sl2RmEL8riDRuWOTMHSo63PgC3SWLzOcTd9
         0rfELwV4obrHGXOdnqEbXomf73SbImQyD1yYpF6vsmpxmffKPH35tdFDcp+81u13zcQ6
         DMXMIRYfC/hTHYNUbKWqkLbROt1/008ixteeF7JzgbsHOGuUIkZMbjSl9JjvteCl541L
         j1aY2DPeQ6isgflQh2UvM6c+/qx26BdJ7XY5gsxalJ/2lqcMMPjBgYMjk2yRYSpCOPwY
         Z68TVcBULGeoqX44oxsju7HXcw6gEnyfMs0v84hxm5egMSe1YFhSA/P0LOk4EkTTdDo7
         l90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/XhIDy736F/MgXA+fkXd9PPWaYekCXW/pnskPaBXHs=;
        b=NXuCgk5Z0X5bD/+Cyst603t2MszRrgNDM6dbFOl6mgE0E6hCuQe0a+zjlffmCB5Oan
         P+KP9QCvyXtmFaRWx6JyErC8CgEMlgMvuarUdn9ySLtnCB1ALg15VsJF6pHwTNPW/J3f
         2i26SYUPI3uWGFsrYogzVcDhqf8hsMP3UKGgYVmlf2yD/ZNdTENpQOlUduQ0/OY3zFQ6
         t0GNnWnZlVq3MDLfmylT1/HYVeBKOCQ2301uwCFSYp1SB3LLoZNTGSRwv7ONr9e8Qtyt
         txPQr0o4jh65kK93E3QG7I0WHaL28wQAR64opk9GZZEH3VnmV+R1qsuzIechaOzev/wi
         58Zw==
X-Gm-Message-State: AOAM533KnhxG9RUarrLs8e8vQOXIw6shffe6mxE+Hbvki4VVobP7WNyq
        ztI2RT7IeC9R2WvudSgmoLCLmA+c9Us=
X-Google-Smtp-Source: ABdhPJz59c5OsIa9h2o7/x0mFCY73HDxhjScjZG7ZTJKSW8AbmsR9bef9tbcUKtGIfpWW6JnoUt5xw==
X-Received: by 2002:a17:902:8ec9:b029:ef:5a88:e7cf with SMTP id x9-20020a1709028ec9b02900ef5a88e7cfmr6769929plo.48.1622851323719;
        Fri, 04 Jun 2021 17:02:03 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g22sm2481163pfv.123.2021.06.04.17.02.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 17:02:03 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH V2] shared/mgmt: Fix not processing request queue
Date:   Fri,  4 Jun 2021 17:02:00 -0700
Message-Id: <20210605000200.1938853-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the kernel returns an invalid opcode like below the request won't
be processed making it unusable:

@ MGMT Command: Read Advertising Features (0x003d) plen 0
{0x0001} [hci0] 14:25:11.096370
@ MGMT Event: Command Status (0x0002) plen 3
{0x0001} [hci0] 14:25:11.096373
      Set Advertising (0x0029)
              Status: Not Supported (0x0c)

In order to fix this attempts to remove the first request pending on the
given index:

= bluetoothd: src/advertising.c:read_adv_features_callback() Failed to
read advertising features: Not Supported (0x0c)
---
 src/shared/mgmt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 3e9b9ee26..b869fa6ef 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -248,6 +248,17 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,
 
 	request = queue_remove_if(mgmt->pending_list,
 					match_request_opcode_index, &match);
+	if (!request) {
+		util_debug(mgmt->debug_callback, mgmt->debug_data,
+				"Unable to find request for opcode 0x%04x",
+				opcode);
+
+		/* Attempt to remove with no opcode */
+		request = queue_remove_if(mgmt->pending_list,
+						match_request_index,
+						UINT_TO_PTR(index));
+	}
+
 	if (request) {
 		if (request->callback)
 			request->callback(status, length, param,
-- 
2.31.1

