Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE63C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16444610E5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245512AbhIBKwZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343591AbhIBKwH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 06:52:07 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48879C0612E7
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 03:50:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r5-20020ac85e85000000b0029bd6ee5179so978749qtx.18
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 03:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RieolaYymu0TqLrGWt8ZqwktYw8m2WgVp44tZhA2mJ0=;
        b=VnrdskhlKE+GpEPuliFGQtuQik4sBStOLJVSkc4l8kL1icxpKpEvgupJd0eGUUVpR6
         EqF8HgrjObuZVZugr9uXG845mBcQ8HcyvpfenHl1Pa5zcGSBV7dl3jAgO3dAzjdvf+uk
         KxPXMl1OvpYYHP+5u8vc3wVHUnZQzZrk1PGEiDRe10JAbzQfYyj87BYSd/p085VL/aDT
         xtaP2SyHEwmM0PsCL4Op3OWo/UxKc0cu+C5+h0GvjjlG/PE0G5I9FTUAuGKmtUjCOsq8
         VeEOI+DHaf4Eo0nfB9EoEEkHiG5gOHfE0+QfadbYbgmi79rJHfynjMrOPd6ynscqo7Bp
         rpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RieolaYymu0TqLrGWt8ZqwktYw8m2WgVp44tZhA2mJ0=;
        b=ZQHwjVW6SS3mMsOr3m2+MQ2lA8dhzs2jMpibmMHgerjghJLhOqqabIAdPEosPfW2ZV
         /NwVeGlgoY/v9Hfm9uE3WLbLsy9rVewwU+/2fX8zgngcMfNCK2sk2L6grftB/38eW0bN
         4vfXTKncOZYEvKFCoybe4eXKA7Dqno/DUk6KB+mNPxebOk2NmomHmj+aRY4y0Ispqnx7
         EL/VVwJ6GVktWpFxWuS0PGVJ1gXWU8DLd13RpXYSCbzxVhmPEFB2DqybW3tFZa2TiKFk
         qb3yqCtrE9z2PIOM7KHKHr4/fvhWjDcRhNkpxtCmGYE944gi4x0BsoOfAx1HjWsP7dSt
         QWdA==
X-Gm-Message-State: AOAM5322B6BJ1XNqCn9/yClOMX6ItDoLd6gMfmiTTZIfxalvgNGEeLp5
        NEqSk9/bIdMqQfOE3uKtSx+J9D/lA5kXK6UZwa7kzSCqNZBiOJLpYZ2uANKCOlGZe+7L6YB66oE
        ZFxe3d3gtSDAedJBi2svv+XQ1W3hw0zQXUWKDbAf4iqEW3P1PZoSftiWqZkcIKvg9TdZCZIBPHt
        Iz
X-Google-Smtp-Source: ABdhPJxi2GSx2BTr7ofveup+AeaTW4gAWr3lkXviQJ5/eB4vCY7W96jrgFR88zic6++7fizdkuX66Q982Zop
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a05:6214:2385:: with SMTP id
 fw5mr2288880qvb.56.1630579837450; Thu, 02 Sep 2021 03:50:37 -0700 (PDT)
Date:   Thu,  2 Sep 2021 18:49:38 +0800
In-Reply-To: <20210902104938.824737-1-apusaka@google.com>
Message-Id: <20210902184744.Bluez.v3.12.I4df08516dd5129d4e9d2cf963121074f500201d9@changeid>
Mime-Version: 1.0
References: <20210902104938.824737-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v3 12/12] doc: Inclusive language update
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Update the docs to reflect the changes for the other inclusive
language updates.
---

(no changes since v2)

Changes in v2:
* Merging several patches from the same directory into one

 doc/mesh-api.txt | 2 +-
 doc/mgmt-api.txt | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index f2c6b9e5c2..ce651c8017 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -585,7 +585,7 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 
 	void SetKeyPhase(uint16 net_index, uint8 phase)
-		This method is used to set the master key update phase of the
+		This method is used to set the flooding key update phase of the
 		given subnet. When finalizing the procedure, it is important
 		to CompleteAppKeyUpdate() on all app keys that have been
 		updated during the procedure prior to setting phase 3.
diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5355fedb00..97d33e30a1 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -855,7 +855,7 @@ Load Long Term Keys Command
 					Address (6 Octets)
 					Address_Type (1 Octet)
 					Key_Type (1 Octet)
-					Master (1 Octet)
+					Central (1 Octet)
 					Encryption_Size (1 Octet)
 					Encryption_Diversifier (2 Octets)
 					Random_Number (8 Octets)
@@ -4019,7 +4019,7 @@ New Long Term Key Event
 					Address (6 Octets)
 					Address_Type (1 Octet)
 					Key_Type (1 Octet)
-					Master (1 Octet)
+					Central (1 Octet)
 					Encryption Size (1 Octet)
 					Enc. Diversifier (2 Octets)
 					Random Number (8 Octets)
@@ -4459,7 +4459,7 @@ New Signature Resolving Key Event
 				}
 
 	This event indicates that a new signature resolving key has been
-	generated for either the master or slave device.
+	generated for either the central or peripheral device.
 
 	The Store_Hint parameter indicates whether the host is expected
 	to store the key persistently or not.
-- 
2.33.0.259.gc128427fd7-goog

