Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9DDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 13:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CDA205CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=omicronenergy.com header.i=@omicronenergy.com header.b="ZXrC8VAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgHSN2K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:28:10 -0400
Received: from ns.omicron.at ([212.183.10.25]:45256 "EHLO ns.omicron.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgHSN2J (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 09:28:09 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Aug 2020 09:28:06 EDT
Received: from MGW02-ATKLA.omicron.at ([172.25.62.35])
        by ns.omicron.at (8.15.2/8.15.2) with ESMTPS id 07JDMiVg020963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:44 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 ns.omicron.at 07JDMiVg020963
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omicronenergy.com;
        s=default; t=1597843364;
        bh=SL+ccKKYMqjN6lbW3mI+FOY5RPCosCqUgpc/bMPHIDc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZXrC8VADEjdrUB5jYD2f8aBWhFM7dAOx7U1oStFr/RIqY7nuZakmBbzvPSBRPvEvg
         ud08Trfyfah9NdPEd4xlGttnaVL4JQPzmhc4rbOUafiavUAnHAQvR+jCcYn70iXEkg
         NaE16Udz5W8Eu+q1ri8YvvuM45kMQljHyyEdviIk=
Received: from MGW02-ATKLA.omicron.at (localhost [127.0.0.1])
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTP id B5FC2A0054
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:43 +0200 (CEST)
Received: from MGW01-ATKLA.omicron.at (unknown [172.25.62.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by MGW02-ATKLA.omicron.at (Postfix) with ESMTPS id B40CEA0053
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:43 +0200 (CEST)
Received: from EXC04-ATKLA.omicron.at ([172.22.100.189])
        by MGW01-ATKLA.omicron.at  with ESMTP id 07JDMiY2021525-07JDMiY4021525
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=CAFAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 15:22:44 +0200
Received: from marmar13.omicron.at (172.22.32.104) by EXC04-ATKLA.omicron.at
 (172.22.100.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:22:40 +0200
From:   Mark Marshall <mark.marshall@omicronenergy.com>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Mark Marshall <mark.marshall@omicronenergy.com>
Subject: [PATCH BlueZ 1/2] btiotest: Correct setting of addr_type for big-endian platforms
Date:   Wed, 19 Aug 2020 15:22:30 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819132231.22673-1-mark.marshall@omicronenergy.com>
References: <20200819132231.22673-1-mark.marshall@omicronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.32.104]
X-ClientProxiedBy: EXC04-ATKLA.omicron.at (172.22.100.189) To
 EXC04-ATKLA.omicron.at (172.22.100.189)
Message-ID: <418845b9-28e1-4356-9ce2-b422720bf948@EXC04-ATKLA.omicron.at>
X-FE-Policy-ID: 1:1:1:SYSTEM
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The glibc option parser expects the option values pointed to by
G_OPTION_ARG_INT to be an int, so a guint8 is wrong in all cases,
but on a big-endian platform you can't even change the addr_type.
(On little endian, it would appear to work).
---
 tools/btiotest.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 6c778e3c5..d56bb4fda 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -556,7 +556,7 @@ static int opt_sec = 0;
 static gboolean opt_master = FALSE;
 static int opt_priority = 0;
 static int opt_cid = 0;
-static guint8 opt_addr_type = 0;
+static int opt_addr_type = 0;
 
 static GMainLoop *main_loop;
 
@@ -616,8 +616,9 @@ int main(int argc, char *argv[])
 	g_option_context_free(context);
 
 	printf("accept=%d reject=%d discon=%d defer=%d sec=%d update_sec=%d"
-		" prio=%d voice=0x%04x\n", opt_accept, opt_reject, opt_disconn,
-		opt_defer, opt_sec, opt_update_sec, opt_priority, opt_voice);
+		" prio=%d voice=0x%04x addr_type=%u\n", opt_accept, opt_reject, opt_disconn,
+		opt_defer, opt_sec, opt_update_sec, opt_priority, opt_voice,
+		opt_addr_type);
 
 	if (opt_psm || opt_cid) {
 		if (argc > 1)
-- 
2.17.1

