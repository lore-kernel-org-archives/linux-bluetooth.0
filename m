Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D33C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 18:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955A060FEB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Jun 2021 18:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhFXSNL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:13:11 -0400
Received: from vern.gendns.com ([98.142.107.122]:40536 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhFXSNK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Jun 2021 14:13:10 -0400
X-Greylist: delayed 1567 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2021 14:13:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IR47SNYHakzv32LA5oS9u/LB8Qu1MH5I/N1xky/09Ok=; b=FFaZrG4fKa8673WstwLOOzzTJi
        2XSutVqaVtIWwWiKYVP6/XDNZmeiAqbW2QyXfJSog8xuvz+inJkn+iA24eYFDsZ6h9f/6DMpNgpcd
        PBLNAkZoB1vFIUb4QC4zsx2T31gYQGtSCJXsscPrjwvp/KD3J5yC/hU8oX5AkGJ6atWnGEOcWJxEJ
        wefHuq9ZhfSaefT4wQGtiMu/kcvzNgKGwq+1XTtdCH2iqcGtE6jTk9XwEUOHlAicW3cUcuZVmWzLh
        rf81bbEEbjcDw6uHDq0IFXkyyjp+h6I9lEzjAq3ryBZ0qiZ60u2BuuWuQWaCQa35cOxOPFztu7ouQ
        Mgtxdm5w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:37642 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1lwTOx-0005Tl-8r; Thu, 24 Jun 2021 13:44:42 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Manish Mandlik <mmandlik@google.com>
Subject: [RESEND PATCH BlueZ] doc/advmon-api: Clarify Patterns property
Date:   Thu, 24 Jun 2021 12:44:01 -0500
Message-Id: <20210624174401.1881338-1-david@lechnology.com>
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

