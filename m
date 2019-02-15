Return-Path: <SRS0=5uBP=QW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2109C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE622192D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 14:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlTCawej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfBOOXH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:23:07 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33023 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBOOXG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Feb 2019 09:23:06 -0500
Received: by mail-ed1-f49.google.com with SMTP id a2so8126487edi.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Feb 2019 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=DcNEAldhCbiMeI9f+tLEklL9Dp/OIOvGX3zeVAw4vAs=;
        b=SlTCawejaFKeIQnXxUYBM+lLze2PHRmfW8xLBJ6g8LsTAwfmSFCh7iHOQwbWRWNnNI
         syO97V6k0wx50Exbwf3EiTzoR4D869w4p++XgI0lLvWL5Hdprgh0/qrL8IbL1HAMe1iC
         i4hdJBbYT1yOSN5bU9IaC21hZkLuIlv/XrxyVz3mRRJRI4Xckh6NNSG6FvAqHCz4NATL
         a8p56hPj2n56U6cM7MxmILNLEAPFNASysVHk2Fi6GMNNVid7QCrsQsJUASIb7REbWCMx
         ikXe9c9OZ0t8DL3Pfk7+g1BO56vddKdv0TSgOxmLJvdro2vDcv8nHavTPIga70u4FGUl
         k1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=DcNEAldhCbiMeI9f+tLEklL9Dp/OIOvGX3zeVAw4vAs=;
        b=o5Wwlu7NJwgIzWA+UzPU2cAos2ArK+VHe0kusk9+GuySITA5RC8m1zSnMWgZyi5FJK
         wrp3NnnHf1+GvUqFXi86WHSVtMrgQ8z+HIe0n92Um7hhJ3qs3iKoOTzKWwSKc00Ic3WC
         A3FQmL5yVVzkJsi3fpUKFaG5+OeFX1QuQGo6jVXfDhh2SvYrV6abCofH+u8TM3XAqiCz
         LEZKgsYn4GeyxeCeQFBb+7PDkvr37XR+41IBAzs8qeP8cTsNTgc3DBVLIH/z6hnlX3h8
         0QDfx3GXFKhMe0c3ofFOTr89o3s0RsyaxhfddIcmcG843H6ytDpWWOLGHgMT4kJggT7j
         oHNQ==
X-Gm-Message-State: AHQUAuZe3+HMrlntStmEpSRNyWw7rIdnXrWqLChu0oxYdnOPw64DSK9U
        lESxsSdQiKvbkFpBY2+rXsTNqHLM
X-Google-Smtp-Source: AHgI3IZ8Kwg8Lh1c+odCZzjhsh13iQgY5htWCkswzG+S0SZ9rjEcWtARJEcJ2yL0RPoMPURpkWtFtQ==
X-Received: by 2002:a17:906:3749:: with SMTP id e9mr7029019ejc.194.1550240584171;
        Fri, 15 Feb 2019 06:23:04 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id v11sm1501333edy.49.2019.02.15.06.23.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 06:23:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] doc/advertising-api: Add support for setting Secondary Channel
Date:   Fri, 15 Feb 2019 16:22:58 +0200
Message-Id: <20190215142301.30909-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables reading and setting the Secondary Channel/PHY supported
by the controller.
---
 doc/advertising-api.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index cfce0f9a3..b0565eab2 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -129,6 +129,15 @@ Properties	string Type
 			Timeout of the advertisement in seconds. This defines
 			the lifetime of the advertisement.
 
+		string SecondaryChannel [Experimental]
+
+			Secondary channel to be used. Primary channel is
+			always set to "1M" except when "Coded" is set.
+
+			Possible value: "1M" (default)
+					"2M"
+					"Coded"
+
 LE Advertising Manager hierarchy
 ================================
 
@@ -190,3 +199,13 @@ Properties	byte ActiveInstances
 			Possible values: "tx-power"
 					 "appearance"
 					 "local-name"
+
+		array{string} SupportedSecondaryChannels [Experimental]
+
+			List of supported Secondary channels. Secondary
+			channels can be used to advertise with the
+			corresponding PHY.
+
+			Possible values: "1M"
+					 "2M"
+					 "Coded"
-- 
2.17.2

