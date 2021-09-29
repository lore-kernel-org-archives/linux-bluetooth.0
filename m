Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3069BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0983861353
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 16:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbhI2QSu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbhI2QSt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 12:18:49 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C848C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 09:17:08 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q81so2867940qke.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IL/gqf8CeRZCv+nMrMB9yoL87PzoWz5Qh1vHHDaSi6g=;
        b=QNe4hYyaCOY0yZ3suMRFY1+vRcxr5s2U533fBjQ/JzOgS3bxzoMSaTdgHK/mLxeoCs
         9tWBpXc5GMhi086r6NRCKeuVzOQRBk6X2QSv0zMvglN6FP+2nbaqh6A7o4tqTisTjnup
         ZbDAV1wvnQl0GWP6vHWs81ygwmXSW6PwQ6WM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IL/gqf8CeRZCv+nMrMB9yoL87PzoWz5Qh1vHHDaSi6g=;
        b=Q89R/GVtSFJX4Y/m4V+6o6TE6FVjbFNG5nummT+hO1PlRSp2imN7H1EyJkVTxkLTSu
         DokFbpAcCw1Yk8Ne2y/9Y6+bdz4Vf373s1cMEFY2h8YNU70sMTPzlvjn+9LJKTqUF1bq
         Iw0zPksZamajXImE8QwdXky06DmhclyJUBh9YH1kTwzd9yIHSh6YimPLy+MN4M0aHElG
         Ww0uHwSg2M55jsI+Aj4r0dfDdgjPUt11ITZj7WIyVchc8hZ5nfhE3liO8lO7rTEgy2wn
         QmvRMK8DnwhHL6nl8DhHs8RdyFOmqKGVMzLHFkqPZ1gM0ZVgtixYfDJwawxfzaFVGuga
         f60g==
X-Gm-Message-State: AOAM530OBnF39AAcnt9A7eDS8W7lQuUWvixtPu+kcoLjVTglW12kyJ8C
        eMAhvrzE22rrVmUjGOTWfiC/iyO6aFVGhg==
X-Google-Smtp-Source: ABdhPJzpxnkiBTAXczv0ckSCa5p+FAAZuNYeMFYQxXKnLgO6AMNE2abyNuqJzWIRnPOC2cOVRxvvhQ==
X-Received: by 2002:a37:507:: with SMTP id 7mr609288qkf.96.1632932227626;
        Wed, 29 Sep 2021 09:17:07 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id 205sm165863qkf.19.2021.09.29.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 09:17:07 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ 2/2] doc/gatt-api: Add 'X-asynchronous` permissions
Date:   Wed, 29 Sep 2021 12:16:56 -0400
Message-Id: <20210929161656.413300-3-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929161656.413300-1-dmartinez@starry.com>
References: <20210929161656.413300-1-dmartinez@starry.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update docs to reflect the addition of `X-asynchronous` permissions,
which allow a GATT server to restrict CCC write permissions via
permissions set on its associated characteristic.
---
 doc/gatt-api.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 04789c6d3..2550510ba 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -253,7 +253,13 @@ Properties	string UUID [read-only]
 			Defines how the characteristic value can be used. See
 			Core spec "Table 3.5: Characteristic Properties bit
 			field", and "Table 3.8: Characteristic Extended
-			Properties bit field". Allowed values:
+			Properties bit field".
+
+			The "x-asynchronous" flags allow a characteristic to impose write
+			restrictions on its client characteristic configuration descriptor,
+			if applicable, restricting access to notifications and indications.
+
+			Allowed values:
 
 				"broadcast"
 				"read"
@@ -267,10 +273,13 @@ Properties	string UUID [read-only]
 				"writable-auxiliaries"
 				"encrypt-read"
 				"encrypt-write"
+				"encrypt-asynchronous" (Server only)
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
+				"encrypt-authenticated-asynchronous" (Server only)
 				"secure-read" (Server only)
 				"secure-write" (Server only)
+				"secure-asynchronous" (Server only)
 				"authorize"
 
 		uint16 Handle [read-write, optional] (Server Only)
-- 
2.31.1

