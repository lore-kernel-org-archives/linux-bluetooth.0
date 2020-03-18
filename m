Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F877C43332
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530D42076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 21:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt8SA79V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCRVva (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:51:30 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50426 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgCRVv3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 17:51:29 -0400
Received: by mail-pj1-f65.google.com with SMTP id v13so32083pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IBv8hQNbmpTa0AIoocboT1khiHc/5SGjGyL7viltjm4=;
        b=Zt8SA79VXMfVqmZWlveNoE4Of4buWhfNqcJKJREajFthUEnZlIWiOzPSNs3HnfCl5F
         jslFsIQAiF5T0fiRT6jxNWy3wNs9Q1GncYj4MWIBoZjA0K/+cnvUevj/8MSJggMvPXXV
         RrKU2sT0nWy4c/H3Cn3CItwG4EqbfgeGeIh8E5jmie1Giveo+PAxVSFefDtjNj098aZT
         d3v6TDezKVXkUxOSFc+hdWCY57MrGhKWO1gUnvqsCbaP7G/H92w7YUeWABzRjcjtsJYv
         hVQYili67Kc6+lM7y5D+6xfZCJLtl/RIX9w7B0J9GdtDvJJ480mLjfBuyvkMIvHJBPd+
         J+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBv8hQNbmpTa0AIoocboT1khiHc/5SGjGyL7viltjm4=;
        b=r/ymk1AyyIWem/Nj7eCEf8Knk0iC7+Rz1BWkyjSpqV+GciihhOg4zsOXrClzXBxnSD
         xz7El22mlMHt22ZZSas00VvJagi3GP8K3L7PFqTk/0eN8JwBzUGAp8/NrGnMNTKnu2lO
         gO/sohkPUmGvPD4LedhhuD/uRELsAs0VQzMLO9o1ztYIp/zBLcp2ENLBBrMZZMZUU2co
         zO2gDFK5r5aBh611gGGRUwG5kSCTjjz25daXpFzhvrNLQ2fl4XRM4RpesDCGr1h90y60
         OUBnzYPSs2qGTTr0xcFlwPrTFRhVAmcGL5s22MNWnywRhceKmOq84Jl/eT0saazpSM9C
         j9LQ==
X-Gm-Message-State: ANhLgQ02/QCypSa3pQngBk+gqrMXB4n2s6w4pRLcF/jP1OYjbc5eR+UR
        NtEDzSGo2N6K8yW/UQsp8pg4mSfd
X-Google-Smtp-Source: ADFU+vsgMQ4/V8917NndWUnDqZeR9Ownb/Tn8+ng5m57YPJO9wZG5z2EzFQ7SA/5fJsOSOUwww/FOA==
X-Received: by 2002:a17:90a:37c6:: with SMTP id v64mr313925pjb.20.1584568287933;
        Wed, 18 Mar 2020 14:51:27 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r13sm83709pgf.1.2020.03.18.14.51.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 14:51:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/6] l2test: Add support for BT_MODE_EXT_FLOWCTL
Date:   Wed, 18 Mar 2020 14:51:21 -0700
Message-Id: <20200318215124.21880-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200318215124.21880-1-luiz.dentz@gmail.com>
References: <20200318215124.21880-1-luiz.dentz@gmail.com>
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

