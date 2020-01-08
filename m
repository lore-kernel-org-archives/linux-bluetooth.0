Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB4C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8F5206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DurjhheM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgAHAd6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38603 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHAd5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so697727pfc.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LZNpc7rBm7qvJQzDH/uuUhS9F/c8VqZuyIaA2JyqPik=;
        b=DurjhheMHP6UppIeEYDVUWmPK1gQ1aNRJSd564SETaXH3OSv4dkjfYttywdETKksPC
         Z3x2mKSYVTYH/NV98DZcO69dlraysulo0yb+1aY0lZC0B3e5DBmpnrPjCB3ND7iTa+DS
         JDAPSmHFthFLDZnP3ZJuCEal9ojWM9Wi7GfdHgp1Hb/NSDaPkqXhatti3Sc/ZO3aF337
         2Tb1UcMQvjPWuI7O7Df7Kbv3fcIUyVkUSh2so6b3ocG1BxngRVcTRpQWGqcvEQzGyMf7
         0FWP37t8Syi3dc/7AXw4qzGsLMWTGZcH6YUJuqVZqgExWEyPX1X+ey5hE1CLoSK6aHvj
         KFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZNpc7rBm7qvJQzDH/uuUhS9F/c8VqZuyIaA2JyqPik=;
        b=lHm2WKO8h4u4uXkQ0T/VAxM6O2L1LQ97wUwq+Pevf1Uj7RkqW9TpfGRrjwwRveGtcA
         pXWNKq7immaQkmlhE8XOo9CeXKyhXqdwV9Eh8TM/lGlOBFXJzh4GkjtInut1B8n0rse8
         vaQb/GG9JHqcwVzSdTR5+ajoE0Ub6DFYAnmWDUbIwyxZ6AbfnQHGF/NjaJNDJmoWthuq
         poB+seWVlqJEOG+WAZSdRZOP2ybeZRylbRrMLLqylYvn2QpYgaxJKggacqq+oUZ/8tyC
         3HrSYbZqK4t61gquX2x/Zgul8zw4XKrRUPG3I4decbRknlHZkGNvRxt5xiVVUhE+AxnF
         UoFw==
X-Gm-Message-State: APjAAAUK/l8OK6gpLrHjBiz7jLJk9rkiBk9eomVbsLNxMgIVDwty4sJM
        YY1lJsam28NNrSC2p++QwHUu+55VF0Y=
X-Google-Smtp-Source: APXvYqz6Ic+KIySuMk0Xf2yLQLYbNdDmJJ/YwBI/Ze96ut90Q3ttNWvZYmbCYc/eob926wn4LL9saw==
X-Received: by 2002:a63:a019:: with SMTP id r25mr2263199pge.400.1578443636924;
        Tue, 07 Jan 2020 16:33:56 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:56 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/22] l2test: Add support for L2CAP_ECRED_MODE
Date:   Tue,  7 Jan 2020 16:33:33 -0800
Message-Id: <20200108003342.15458-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables using l2test to connect or listen with L2CAP_ECRED_MODE.
---
 tools/l2test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index e787c2ce2..317515e68 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -149,6 +149,7 @@ static struct lookup_table l2cap_modes[] = {
 	*/
 	{ "ertm",	L2CAP_MODE_ERTM		},
 	{ "streaming",	L2CAP_MODE_STREAMING	},
+	{ "ecred",	L2CAP_MODE_ECRED	},
 	{ 0 }
 };
 
@@ -282,7 +283,7 @@ static int getopts(int sk, struct l2cap_options *opts, bool connected)
 
 	memset(opts, 0, sizeof(*opts));
 
-	if (bdaddr_type == BDADDR_BREDR) {
+	if (bdaddr_type == BDADDR_BREDR || rfcmode) {
 		optlen = sizeof(*opts);
 		return getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, opts, &optlen);
 	}
@@ -298,7 +299,7 @@ static int getopts(int sk, struct l2cap_options *opts, bool connected)
 
 static int setopts(int sk, struct l2cap_options *opts)
 {
-	if (bdaddr_type == BDADDR_BREDR)
+	if (bdaddr_type == BDADDR_BREDR || rfcmode)
 		return setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, opts,
 								sizeof(*opts));
 
-- 
2.21.0

