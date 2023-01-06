Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B2C4708E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 01:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjAFBba (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 20:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjAFBbP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 20:31:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4A3227A
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 17:31:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id c4so195878plc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 17:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nes1oSOLfK+ntfaQB+T+bjU3oDqawffQKlo+JIhefg=;
        b=b0jJ8BnJDcNM4oiOvMXGR9C+ltqTnuFyGSIpIB2tHODhkLAC4atlP0fkf4uLsS5Hzw
         lY6iXxkvZC13sJ9KTlYYG5vhyrDdMoUEpMffIACRnCNbNvPLCcQY3RZDVJrFoV8LbtRD
         APgLP4W3Vr1yutP8+JEP7sQUYsDje7lbLNchOyRf8zly6UDIN+yRc++V7l7zSg7Whczl
         lwlxjnBY2G/i1DSZimF+DUfLLgWSErpF61FnlRiw3g7EmZd5bbQFTQvkmPIDtVZ8pLq7
         ynAAeK1ZBiYc7RBHPtiyc+rnXS0rOPs8lKFtdG8WGdDUy7Q9lRIg1mQln88Zwv6TcQK7
         G3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nes1oSOLfK+ntfaQB+T+bjU3oDqawffQKlo+JIhefg=;
        b=76ZendtICNMqgZ658DNuS52QSLzM1TErCOXRl/S7Zfy0mRzNiJRpG3p3iDuGQmEnZk
         ap3kIXLbe5X78zZwvalSg+ugWzhdH4CRvnevcGJXi6Tiqw3xXEN/fEcEAhnrOZIMXV5w
         1YDDR79/mzIWzPzKE1t++JfTqIfouK2TLAE0Z4aQTg/pNnZvOd9h80GJyAEWrBQ8NJEb
         iKo+kxG+r1eRZQwKpw4QPnYZyxuKFVHbJyS0uWZr78kVBMCwQPgVkK0XG0n697V3lJsH
         j2BNmFv2aB0nVoPnXk8yJHcffzxtqZVB+VBOvt0cxH3bef22QbqWGWi8YQjBQIo5P85M
         nuzg==
X-Gm-Message-State: AFqh2ko5tu2R+4lh21WQ2HeQ7s8VYU5RTOf2ehe/C8WIeaoYSdathitD
        tvmjuaaIPJA1KDnzhjfG1CLasSW05iE=
X-Google-Smtp-Source: AMrXdXtjd5c9x2/9fF9ujpLyQdf3vSqH9imqn0hoz8uz521Ael2smVE0P4am7LOOdndbgWWBqM6fmQ==
X-Received: by 2002:a05:6a20:d685:b0:ac:83e:a9dc with SMTP id it5-20020a056a20d68500b000ac083ea9dcmr65455451pzb.13.1672968674176;
        Thu, 05 Jan 2023 17:31:14 -0800 (PST)
Received: from EDP-LAB-JQIAN2.PD.CalAmpCorp.com ([69.110.165.186])
        by smtp.gmail.com with ESMTPSA id z16-20020a170902d55000b00189db296776sm17421946plf.17.2023.01.05.17.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 17:31:13 -0800 (PST)
From:   Jing Qian <jingq77@gmail.com>
X-Google-Original-From: Jing Qian <jqian@calamp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jing Qian <jqian@calamp.com>
Subject: [PATCH BlueZ 1/1] hcidump:fix array boundary issue le_meta_ev_dump()
Date:   Thu,  5 Jan 2023 19:31:01 -0600
Message-Id: <20230106013101.35016-2-jqian@calamp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106013101.35016-1-jqian@calamp.com>
References: <20230106013101.35016-1-jqian@calamp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

le_meta_ev_dump() print array content without checking index boundary.
hcidump would crash if the event index is out-of-boundary
---
 tools/parser/hci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index db7d32c011b9..b434b879a292 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -3657,7 +3657,12 @@ static inline void le_meta_ev_dump(int level, struct frame *frm)
 	frm->len -= EVT_LE_META_EVENT_SIZE;
 
 	p_indent(level, frm);
-	printf("%s\n", ev_le_meta_str[subevent]);
+
+	if (subevent >= 0 && subevent <= LE_EV_NUM) {
+		printf("%s\n", ev_le_meta_str[subevent]);
+	} else {
+		printf("Undefined--> %d\n", subevent);
+	}
 
 	switch (mevt->subevent) {
 	case EVT_LE_CONN_COMPLETE:
-- 
2.25.1

