Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66645C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 13:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E60C205CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="M8QpGIYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgHSN2O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:28:14 -0400
Received: from ns.omicron.at ([212.183.10.25]:45256 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbgHSN2N (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 09:28:13 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 09:28:06 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 07JDMiP3020967
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:45 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 07JDMiP3020967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1597843365;
        bh=1c0JuGsAJgb85k4gKftWDbw/FxvuY81Tku6bJzjflCo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=M8QpGIYaM44x0QlQD13301tw1Q2Svo2alyoZOUH7zAHkwJxvKk50JV6wNhDu5cK23
         ptd8SJFsMko9aBvxR/mV+whgyKrOVxY42tnwdHi/i7Du9G0/oA4JzyTG1nuZMLKQsU
         Lx8YLfgU9lw9RKRhq/tcy8QpaDNDsonYplKoaocw=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id C3A5BA0062
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:43 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id C1BF0A0053
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:43 +0200 (CEST)
Received: from EXC04-ATKLA.omicron.at ([172.22.100.189])
        by MGW01-ATKLA.omicron.at  with ESMTP id 07JDMiY2021525-07JDMiY5021525
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:44 +0200
Received: from marmar13.omicron.at (172.22.32.104) by EXC04-ATKLA.omicron.at
 (172.22.100.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:22:41 +0200
From:   Mark Marshall <mark.marshall@omicronenergy.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Mark Marshall <mark.marshall@omicronenergy.com>
Subject: [PATCH BlueZ 2/2] l2test: Correct the endian handling
Date:   Wed, 19 Aug 2020 15:22:31 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819132231.22673-1-mark.marshall@omicronenergy.com>
References: <20200819132231.22673-1-mark.marshall@omicronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.32.104]
X-ClientProxiedBy: EXC04-ATKLA.omicron.at (172.22.100.189) To
 EXC04-ATKLA.omicron.at (172.22.100.189)
Message-ID: <411f2f20-c199-44ef-a974-8c2230e07e51@EXC04-ATKLA.omicron.at>
X-FE-Policy-ID: 1:1:1:SYSTEM
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The code that deals with endian issues was not always correct, use
bt_get_leN in all cases.
---
 tools/l2test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 0d846ed93..a62eacb4e 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -1155,8 +1155,8 @@ static void info_request(char *svr)
 
 	switch (btohs(rsp->result)) {
 	case 0x0000:
-		memcpy(&mtu, rsp->data, sizeof(mtu));
-		printf("Connectionless MTU size is %d\n", btohs(mtu));
+		mtu = bt_get_le16(rsp->data);
+		printf("Connectionless MTU size is %d\n", mtu);
 		break;
 	case 0x0001:
 		printf("Connectionless MTU is not supported\n");
@@ -1182,8 +1182,8 @@ static void info_request(char *svr)
 
 	switch (btohs(rsp->result)) {
 	case 0x0000:
-		memcpy(&mask, rsp->data, sizeof(mask));
-		printf("Extended feature mask is 0x%04x\n", btohl(mask));
+		mask = bt_get_le32(rsp->data);
+		printf("Extended feature mask is 0x%04x\n", mask);
 		if (mask & L2CAP_FEAT_FLOWCTL)
 			printf("  Flow control mode\n");
 		if (mask & L2CAP_FEAT_RETRANS)
@@ -1210,7 +1210,7 @@ static void info_request(char *svr)
 		break;
 	}
 
-	if (!(mask & 0x80))
+	if (!(mask & L2CAP_FEAT_FIXED_CHAN))
 		goto failed;
 
 	memset(buf, 0, sizeof(buf));
@@ -1232,8 +1232,8 @@ static void info_request(char *svr)
 
 	switch (btohs(rsp->result)) {
 	case 0x0000:
-		memcpy(&channels, rsp->data, sizeof(channels));
-		printf("Fixed channels list is 0x%04x\n", btohl(channels));
+		channels = bt_get_le32(rsp->data);
+		printf("Fixed channels list is 0x%04x\n", channels);
 		break;
 	case 0x0001:
 		printf("Fixed channels list is not supported\n");
-- 
2.17.1

