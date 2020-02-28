Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E0DC3F2CD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F1246B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqnxoDJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgB1XrI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37928 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgB1XrH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so2499080pfc.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FXwvTnQykoPpkweMgQAgCKJtBtzeHaiXypRA5dAMTdI=;
        b=aqnxoDJjH15ML2P2FXmR6AliXPmUtllDOyfQEq9aIkvm0Wi69baU+MPXeMPguA3wYV
         OrZ8WJvb3bAsJ0GH4NKDx29yskNQqEY8gIia85rFeXX2VMJLtopwHL1PUnfuq7jQMVdm
         QoIb6MIvptd2gaXxc6PRE6pHD9mEwBmJnbJNUuR2Ssw499GPr/lde7WMO5qQqnhawPWi
         1lRknvP3hYWRh/WgCPFwTukIqDr+k7C7CqsBtRy1FKBZgxbIlzMaSPGwzWF8X0BATMlT
         PFSq2UMtLmD53B1iT0ZKzGQo+s2GQjtnTVPRp/pAq4ajc2V5NkhvNEjZ/NTpoIPum3qd
         D1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXwvTnQykoPpkweMgQAgCKJtBtzeHaiXypRA5dAMTdI=;
        b=MyDWxzRvRMT9RNxpTjmQKxXpf8NAvPEG/DV90QQOxOhJ5ibcG7zo3NE32dneeTbkZU
         nI/onh1yOZFEiaATYvrXatQ/ZPOJN/iOfxyTy7eFaQE86mNLiX3BKCQKBtpaY2IHtHLF
         t8d482pO7Ervn1jOgnxs+qFUDywsbYFTe/L7ZAuPuMQkfFTpjHbg3OFcOBVZI5Gl72zK
         RuSk2RolVi1o/n8FVpwGCexrtN6T6kTVgRr/l4yr1y78a9EeymkSeWuSVq//4RNPTehA
         KZJ0b/KNJ5jaGlrJCJ3Vd5458gw9Jm19bG5WO5yVEshgV8+g1LsOsdiyTbGJktNK6NW3
         qdBg==
X-Gm-Message-State: APjAAAULGE6SUHWOm98iKBNCSVwv6CDye0ZjYSqT15SwVIsMLakQzo6k
        mkiQU6+BtU5eyq9Rhg9AVsa3F4w+VoA=
X-Google-Smtp-Source: APXvYqwAi+0VqygDjpA6CCRD2qsD6Kjlf7e1k1VikdoaIRHDd3O00D+C2iahrxmGG5A8v4vEzg/d4g==
X-Received: by 2002:a62:b604:: with SMTP id j4mr6735453pff.93.1582933626463;
        Fri, 28 Feb 2020 15:47:06 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/12] l2test: Add support for L2CAP_EXT_FLOWCTL_MODE
Date:   Fri, 28 Feb 2020 15:46:52 -0800
Message-Id: <20200228234701.14614-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228234701.14614-1-luiz.dentz@gmail.com>
References: <20200228234701.14614-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables using l2test to connect or listen with
L2CAP_EXT_FLOWCTL_MODE.
---
 tools/l2test.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 8c6e08646..ee3637699 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -150,6 +150,7 @@ static struct lookup_table l2cap_modes[] = {
 	*/
 	{ "ertm",	L2CAP_MODE_ERTM		},
 	{ "streaming",	L2CAP_MODE_STREAMING	},
+	{ "ext-flowctl",L2CAP_MODE_EXT_FLOWCTL	},
 	{ 0 }
 };
 
@@ -283,7 +284,7 @@ static int getopts(int sk, struct l2cap_options *opts, bool connected)
 
 	memset(opts, 0, sizeof(*opts));
 
-	if (bdaddr_type == BDADDR_BREDR) {
+	if (bdaddr_type == BDADDR_BREDR || rfcmode) {
 		optlen = sizeof(*opts);
 		return getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, opts, &optlen);
 	}
@@ -303,6 +304,13 @@ static int setopts(int sk, struct l2cap_options *opts)
 		return setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, opts,
 								sizeof(*opts));
 
+	if (opts->mode) {
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_MODE, &opts->mode,
+						sizeof(opts->mode)) < 0) {
+			return -errno;
+		}
+	}
+
 	return setsockopt(sk, SOL_BLUETOOTH, BT_RCVMTU, &opts->imtu,
 							sizeof(opts->imtu));
 }
-- 
2.21.1

