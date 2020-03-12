Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5564BC4CECE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F6E206CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 22:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZBq41fA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgCLWZV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:25:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41980 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCLWZV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 18:25:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id b1so3763898pgm.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2020 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FXwvTnQykoPpkweMgQAgCKJtBtzeHaiXypRA5dAMTdI=;
        b=oZBq41fA/zrwcnpUi3haKsA0TFGctP8QNZT/vfjNSR84/9Do3arIqqF2/20X3av5fJ
         JAq7nQpPw9azjwuLf+Jqx30i1rhAEHXPAmk7AZq9LObIhl93Qr+rMy+n5kwLFO3LFj8P
         IL6m3KKBLmh3pWFhv92Poj1BnLaacxuz8sfUi0GrOAVz64jvJWw74rY/VekLaHLAOwgx
         mposaTB54s5EirTIAvdq7DuJb2IE9TrvdoMRER5T38R+Nhh21nfLHbuOsExcnPXrLscy
         2vNuXzF5NEUYANApcAjzAhlNQsj347tze0KAhIuRsdX+nhx6Vx7TApq2qMMl6aOUqf8+
         AWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXwvTnQykoPpkweMgQAgCKJtBtzeHaiXypRA5dAMTdI=;
        b=QTL6oq1w74r+tlYWpbHZ6gpae25ybDKYI/iy/abISj9dw9u2l3Lt9g/PGE0d83J0oH
         IGriwKaz4MGDFE5o8uPeTc/4hSYq3nbSeY6W0KqdVuAUSJSkCObwHkH2iOJSCwC22Uvw
         5PPJa+sqFzSfr4cmvJm8X3Ak4479fvWK0ccE/0mdBFwgSCBFxbmbGAC/dJSswJBKPvOr
         w6aPB+TrDJNHHEJ9Bh5rtcXA96BT1L1KWSmjTEMqGeDa9SqVE1rxTQJidFViEo4FIG+T
         j3Ct0/NqB7HclbFfLoPI5VERqUhABDS0C5jn8idyjx1/KRMniwe2sMfDYIk4GI6xNvgu
         /xSQ==
X-Gm-Message-State: ANhLgQ2sL72kcAE2fKmNRMYl9lEjKRfNmx1YdyTGvR4RUcKinM4+PaPi
        7pB9/eKQta9KxfxkkQJaH76GcYRdKEU=
X-Google-Smtp-Source: ADFU+vvN3tzLsppfwbf0fMR1iemModEvkw8BSLn4GvJvUbclWG3ddqHJaKwf1qhgM9ymr09q1TMVAQ==
X-Received: by 2002:a62:be04:: with SMTP id l4mr10482810pff.234.1584051920485;
        Thu, 12 Mar 2020 15:25:20 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i13sm4296468pfd.180.2020.03.12.15.25.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 15:25:19 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] l2test: Add support for L2CAP_EXT_FLOWCTL_MODE
Date:   Thu, 12 Mar 2020 15:25:14 -0700
Message-Id: <20200312222516.5179-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312222516.5179-1-luiz.dentz@gmail.com>
References: <20200312222516.5179-1-luiz.dentz@gmail.com>
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

