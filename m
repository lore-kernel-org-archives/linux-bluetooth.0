Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF33C4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036220775
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWnuFkkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCTUkn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:40:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35898 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgCTUkn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:40:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id z72so3670015pgz.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IBv8hQNbmpTa0AIoocboT1khiHc/5SGjGyL7viltjm4=;
        b=nWnuFkklLsg2Tli+aftXj4c4QxFJ7m5zwdhvGAFhnk7EpPhsQxBHaW8Uqlj+kK5fiT
         JrPvWL4RW3HjHLgdm6LaaF3c/SZCdMXklhQNJ6+d/6fjApuLdlfItgB4bP9NpeObs5J2
         uargoKaalo8ZB3dciPS4egmbFM3Vi0eENgtht0aLUT984SQsBaPbw4DOL2ImVdYqq780
         w/7cnvOyr1IBE0XEh5DTk3yUCe18NAeoeZUEiYrrDRK778haf3TQnZMaShvEvo2P+9VZ
         fdYxOwDsUgqrzcUJ9o966QckYXfEBMR8rRddH/qqUBocf87WKU5LGXXYaxlQRaORztbm
         AGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBv8hQNbmpTa0AIoocboT1khiHc/5SGjGyL7viltjm4=;
        b=NO4o5jezoXRe0dN1YFMxD8PbKp4wnB/xfpUN9drAf1B/wwGPEysXJzH+aZt28eQA/W
         V+9YGOY1JIClALEvDZsZLHPTvUxGpnigF6b+cVyg0OuTsZoxA8oqKgTToAzoE663m+qt
         UiW35MY/QDukNIDzYDf/LXFRA6I6PNM9MXapJYgaDWs+W+/RiejI4zWyeASBewk4M7ot
         hZ9PiDzRyv0kBt//4Stafy6hUXvLM8HYlqPKmICoyW5u5l8jL82CdfAJu5rLIO/WqXa3
         KfRzj8Z7LVfIPIKZxSIh8xMOdTJG8d/LA8+iYB0hAISz2BpAajLAkNT5+cPr7CdvSaor
         Td2w==
X-Gm-Message-State: ANhLgQ03P6fqrxG65tUjQnHYLDU8xnVJ4758Xso6WEsWP75NXYTpDmAW
        X225txyN852W1A8LZbHU6Ad9+mru
X-Google-Smtp-Source: ADFU+vvMqlU+leHcscU8s7wbh9pvIBzVyy5M/KfW1TXLkjAcAS81zw1icg2IyJXhnaCnsBvFZCb6pA==
X-Received: by 2002:a63:a06e:: with SMTP id u46mr10277458pgn.140.1584736841788;
        Fri, 20 Mar 2020 13:40:41 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d5sm6219522pga.36.2020.03.20.13.40.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:40:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/6] l2test: Add support for BT_MODE_EXT_FLOWCTL
Date:   Fri, 20 Mar 2020 13:40:35 -0700
Message-Id: <20200320204038.11799-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320204038.11799-1-luiz.dentz@gmail.com>
References: <20200320204038.11799-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables using l2test to connect or listen with
BT_MODE_EXT_FLOWCTL.
---
 tools/l2test.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 8c6e08646..0d846ed93 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -143,13 +143,14 @@ struct lookup_table {
 };
 
 static struct lookup_table l2cap_modes[] = {
-	{ "basic",	L2CAP_MODE_BASIC	},
+	{ "basic",	BT_MODE_BASIC		},
 	/* Not implemented
-	{ "flowctl",	L2CAP_MODE_FLOWCTL	},
-	{ "retrans",	L2CAP_MODE_RETRANS	},
+	{ "flowctl",	BT_MODE_FLOWCTL		},
+	{ "retrans",	BT_MODE_RETRANS		},
 	*/
-	{ "ertm",	L2CAP_MODE_ERTM		},
-	{ "streaming",	L2CAP_MODE_STREAMING	},
+	{ "ertm",	BT_MODE_ERTM		},
+	{ "streaming",	BT_MODE_STREAMING	},
+	{ "ext-flowctl",BT_MODE_EXT_FLOWCTL	},
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

