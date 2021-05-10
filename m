Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D522C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 20:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D891261466
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 May 2021 20:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhEJUJ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 May 2021 16:09:57 -0400
Received: from vern.gendns.com ([98.142.107.122]:40574 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJUJ5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 May 2021 16:09:57 -0400
X-Greylist: delayed 1265 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 16:09:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dvgKLP22m5dpQc/XaEo1kCfYFrQgZ0058//D3GBR13Y=; b=VC1kZ5nOKvBFGHsVgk7G3GcyjA
        aWVwexgYmOjftneo+mom4qg7MYeP3vivYtiKIxwohfa5TjJY+6HOI7SGMaSWp15+WryzHxD7MsAIv
        SJE5CiKTBYZU4OiIBhedRzDYQ+gHnGRjg3r4PT1SNyLMIZQwRrQBfyjZIiozxbWkP7hfDBlILrjUZ
        NiBoNWfj2hU18Imz3aErEikIE+MOBvZwN5AjaKCdfgJlbBd+2l1UR3DL7mCGeecTdqnHK8OKdEaQJ
        sKIGM69gOo8Fj0iSS9zhTFr41asB0266PL3aDnOJYPbVa1k5Z55+oqy6c2YgucVjdU1+jMILr7be5
        5qEssZKA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:35776 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1lgBsT-0007G2-F8; Mon, 10 May 2021 15:47:44 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@google.com>
Subject: [PATCH BlueZ] doc/advmon-api: Clarify Patterns property
Date:   Mon, 10 May 2021 14:47:07 -0500
Message-Id: <20210510194707.300130-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The Patterns property description was not as clear as it could be. This
expands the text a bit, replaces the C enum value 0x01 with the D-Bus
property string value "or_patterns" and improves the grammar in a few
places.
---

Related question: How can we create an advertisement monitor with no filter?
Currently, "or_patterns" is the only Type and therefore a pattern is required.


 doc/advertisement-monitor-api.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
index 8100717c0..9189f2cce 100644
--- a/doc/advertisement-monitor-api.txt
+++ b/doc/advertisement-monitor-api.txt
@@ -105,10 +105,11 @@ Properties	string Type [read-only]
 
 		array{(uint8, uint8, array{byte})} Patterns [read-only, optional]
 
-			If Type is set to 0x01, this must exist and has at least
-			one entry in the array.
+			If the Type property is set to "or_patterns", then this
+			property must exist and have at least one entry in the
+			array.
 
-			The structure of a pattern contains the following.
+			The structure of a pattern contains the following:
 			uint8 start_position
 				The index in an AD data field where the search
 				should start. The beginning of an AD data field
-- 
2.25.1

