Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C70C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0C66140F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 18:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhI2SDm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 14:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhI2SDl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 14:03:41 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782E6C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:02:00 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f130so3189003qke.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IL/gqf8CeRZCv+nMrMB9yoL87PzoWz5Qh1vHHDaSi6g=;
        b=gbUqVWGToBDqWP8rcz3Y9IG81j/Zpb1id4b6WoQjDkXvCDONfVokxYwYcdcBKOV9Bm
         fsEDlViYgcylgpzO4BSt5D25YB8DN7KIkiS/CWfIT9psuJP4ffei7lfhfek/lIotqDlQ
         FcVIrJfH7zCR3iILX/4TP/7AMFQhKGRp1CUM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IL/gqf8CeRZCv+nMrMB9yoL87PzoWz5Qh1vHHDaSi6g=;
        b=a7E3C9mPK1JsZQYHH+iIlJ81ckdjxFP0CShAuWkrcfL/yk+0FxpHxdL6bbhGkjdwms
         IZQ+dEd6YklKt6TUCIhQdyAARtCUagXPAEBMgoH4hYETXjPxsHeYxKnXUKvaSYjhkc9j
         uRPdUjQu3wF13EC4Y8x8jWHJSLqMA6TjgR9nTM7O/UIuqUbz+2ckc7Hz09RIQOB/jIna
         5lBuvB75XVSds83RikNiwmTyUHYYQmFyROIOPtu14QaN90XDast15FRa8sG5buMh9all
         00A1Lavb/aSI8+opbGHvxVRkdbFHqoNRuDwlXveFQmYTtXv0OpCC58rDzAxA+v5kOmuI
         /H5A==
X-Gm-Message-State: AOAM53092ASAI9lsErjGu5Y6pugiuBWgIBdhzfpLckFIsb3My3Jjq1jE
        1S/+AoAX6sz887W4k9X8C0bZ+4T9O/cA2u+3
X-Google-Smtp-Source: ABdhPJzcw0KiaKcv7ckHFEXfNyP+bP44Rmo24bsOEdMAW7lzzjXcPhVd1WSy5VW8h+o+NGrAR0aKOg==
X-Received: by 2002:a37:9f12:: with SMTP id i18mr1051563qke.460.1632938519503;
        Wed, 29 Sep 2021 11:01:59 -0700 (PDT)
Received: from MrComputer.nevonetnext (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id 14sm367355qtx.33.2021.09.29.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:01:59 -0700 (PDT)
From:   Dagan Martinez <dmartinez@starry.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <dmartinez@starry.com>
Subject: [PATCH BlueZ v2 2/2] doc/gatt-api: Add 'X-asynchronous` permissions
Date:   Wed, 29 Sep 2021 14:00:31 -0400
Message-Id: <20210929180031.417090-3-dmartinez@starry.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929180031.417090-1-dmartinez@starry.com>
References: <20210929180031.417090-1-dmartinez@starry.com>
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

