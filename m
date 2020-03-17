Return-Path: <SRS0=BuFd=5C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3BBC0044D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AFA20674
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Mar 2020 02:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oECzbNFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgCQCLs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:11:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37135 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgCQCLs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Mar 2020 22:11:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id 3so3190933pff.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2020 19:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FXwvTnQykoPpkweMgQAgCKJtBtzeHaiXypRA5dAMTdI=;
        b=oECzbNFL2wZjA4/QxQNiiz+IsEY71cRAkDvWEVTJ7grftxAUs/Vsi3w2rWukao7JTi
         cawWI2IlqgYbz/uATG4HfmBm1G+C//dK6+uQTq2/hffrXO32k7R5SIR+7r1xc/8tjBvG
         jxyXVNZ//mL+xDKe7w1uX2mGKTwsiHWSyCe4cyxHRh9i9vyh6GJZuuKCN8f9Bp+2Huug
         sqGCNQCb0HaNIgRYbxZM8Sd+rBh2P0O6Q53sAqyCZQHD+LnI0jGbjwemOGZ2xGdkZwIC
         LJ3DdVIp1LnkkppZbEHDkpBlbLn/mo+wNkLgoT9Y5QtvwWARBWIaGV0JtKjj3pe1fvuo
         oKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXwvTnQykoPpkweMgQAgCKJtBtzeHaiXypRA5dAMTdI=;
        b=ar6K1gCXzTHHt7Mxaf6dcimlTI0CP2mObTGXdBE8KD74zifBA0CCqbum1+UuEU+OJT
         u/d7WEVLCY4h3RWL5TjkzrGCoorJ6O9vFeFWECaSmuJtXNMv/ZZJvEvQewjYDSIeyGLO
         Yt1hqKmglNCA4OTwvxmmO9W4hj54xchxI7XuHQ9fmREyGNcHWO0lvUp88+tyRoUpfLNK
         6cJInIkJhcwdxVBD+cLwfI8Q0G61cpSm46wbTC3hAY4yezVvUXDNDrOD78+QB8Ny8iJ/
         ftvNVvhImHuO7L4C0l52gtenIjZwEl80Hx8cPC1qtnIXikjj9ZuGUd11pX0dvyDzalcb
         QSdA==
X-Gm-Message-State: ANhLgQ0Me90slaDVlbTCd0Xi8esodLg1YTWYoZ/AT3cyl5gkUIvuYsBK
        8JiYagtJcV5vOO9QMNPM+3AE9/6pW5A=
X-Google-Smtp-Source: ADFU+vvlA88umWs1OEdPwlZNx8gPMgoamDKl/13v9booWJGHutTh+O0aQzJ8hTMZpgPc7QNcnb84Jw==
X-Received: by 2002:aa7:87c1:: with SMTP id i1mr2760084pfo.297.1584411105793;
        Mon, 16 Mar 2020 19:11:45 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f19sm700769pgf.33.2020.03.16.19.11.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 19:11:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] l2test: Add support for L2CAP_EXT_FLOWCTL_MODE
Date:   Mon, 16 Mar 2020 19:11:38 -0700
Message-Id: <20200317021141.16398-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317021141.16398-1-luiz.dentz@gmail.com>
References: <20200317021141.16398-1-luiz.dentz@gmail.com>
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

