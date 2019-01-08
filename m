Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63702C43612
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A91C21019
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 15:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWCNPzhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbfAHPt7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:49:59 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:44367 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPt7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 10:49:59 -0500
Received: by mail-pl1-f180.google.com with SMTP id e11so2070788plt.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jan 2019 07:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=+WtCu0rsyZy4nM8CNOMdSd/tCuGs86sGScNx81ACbjI=;
        b=nWCNPzhInlgFGccL19UiCtcm1aLO7FlJevpG8Dvo9i9fgdz3fTUlpaMBNEMP/kJwT4
         oZp4Xa4KR7cpRn9RsFDrISyxxrFg0541HGfcQqzwqQ3fTrpeOFUxkDSfPN96XBpEww3h
         lRsGNunSx97m4mtOd8PsjIj8dPSKn3eaUqIFt0sVtw70iUCI3AeSX0uF9FIf/afj+jy3
         9X7O03wseSJlOGiffxo8pLLQ8eFKRsge2Yh3jMAK2c+mr3yiLmn10JrE6AjIij0PDDiR
         LuIlP9/1y4grA8EW/Q3jK0W5EJCSZIZcCAfof9rMBV1ZgtI6AFNjQtCHxL1gGENKr05I
         uXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=+WtCu0rsyZy4nM8CNOMdSd/tCuGs86sGScNx81ACbjI=;
        b=gN3X2h73anvBgKGAndp7u7HZAiwirUrIWjOfbDk4ohHWH0kD0LRAtK8/MKyX7GLjRm
         Tk+oSaQQ46n/tUU+DqoOppE0Oj4rst3Sz4kS9BejBGgZwGEHXoKemFY5yF2NFskcDO1H
         r5cN87CEL0mh9K5qB18LMNcv1CyBe2XERSyh1q98YhE0zybxJJa1q2lKSyDaRffUIRa4
         bFzrgWYK3e670JPA4KEzLmu8/e85/tsYPHoUaa0kv5Hrur3USINvO9CPi2kg07KDX08U
         XjXgsF63AlvZn0pDV2DzzM8otGlIHC+uVQoR4qiyMmt6wmyUXRMl5yOZjK/7IrTb8A9Y
         h6Iw==
X-Gm-Message-State: AJcUukfbUm9cDACgesRjoxylqnjQRUfRBTsydswmBELdR2WiqvDVC/Ty
        fyOsDQ0kHba3Zi5LWxnIWIqPy1NyWCc=
X-Google-Smtp-Source: ALg8bN5DoNuaHzXOU8nvEng+FUfJHy+zLgcZR7RCO4PX4IZlgYs/jsE3z15TEkxQmLMnmxNmmEAzZw==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr2296646pla.131.1546962598692;
        Tue, 08 Jan 2019 07:49:58 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2804:14c:8782:823b::1002])
        by smtp.gmail.com with ESMTPSA id 196sm275082811pfc.77.2019.01.08.07.49.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 07:49:58 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] doc/media-api: Add Endpoint property to MediaTransport
Date:   Tue,  8 Jan 2019 12:49:47 -0300
Message-Id: <20190108154950.8534-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190108154950.8534-1-luiz.dentz@gmail.com>
References: <20190108154950.8534-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Adds endpoint object to MediaTransport so application can resolve which
MediaEndpoint is in use.
---
 doc/media-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index af9485342..292e9034c 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -627,3 +627,8 @@ Properties	object Device [readonly]
 			acquired by the sender.
 
 			Possible Values: 0-127
+
+		object Endpoint [readonly, optional, experimental]
+
+			Endpoint object which the transport is associated
+			with.
-- 
2.17.2

