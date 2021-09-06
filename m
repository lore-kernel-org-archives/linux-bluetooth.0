Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2604AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0739661004
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbhIFIGs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbhIFIGr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:06:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E77C061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:05:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n202-20020a25d6d3000000b005991fd2f912so7526600ybg.20
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LO4Wyzb9FWHJEEm3PB9geKIDMH3dl1EIUhsAEsYDJDo=;
        b=a4pcGmcmJuQwZSMiTGL3wYoWjuAbfkZh67L/z+fdy5AQ/hx7Ujq76X25P3ckO/VAjw
         tYJ8OA6/8G3gN2ZKR2g3ypB+/yFGLus2YVaFpMEtvTWz8B8Ql0N2jKMGoF2KoFr75w7P
         pm/2qhC/UwFuLkUmdpifY6rs+51SzZNl7dpl9OFfWt+qE1dPhGKQcm76D3/5PJhKq57h
         y8QYUiGJ0c8B4JJ8wi0JSW39TNvESakQLEjiQNTrUPQTyRPOnSF4wWW+YgAG3BEvhJ68
         j22WKnTiScSsAmMpy/4TFNZE9LTrq6okzWJDSr9t37POHosBGUi2m7qHJKzvMdxIPp88
         RmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LO4Wyzb9FWHJEEm3PB9geKIDMH3dl1EIUhsAEsYDJDo=;
        b=sOg5PJJ1DmzOEw7gXwo28wy0x+ezNTKBqfAaegk37jSrcwLPOmJAcXUvxRR4fygHFy
         RXVl4w30d1fXfBP7CdAdcADPaZK2qswNkiJYwHrbpk6dBEBua8BGOFlCom3R+UP9qyAT
         DEqte071ssFCV+LUFe4Wny+TADJ3QAQKSFai3twLqBRnUMoiWjz7y8q1PRE2TMvKF7Rj
         j4+oc85lcCZSKuLAQZT4U3td7umgNISPgTlvZJnwH4wj9rdQmAxtVmzkrYae5FfrODQk
         Dnpl/GpLeuCadHi742uCL5iI+ekvBJFsenK4A6cXE/PvQsTpQyIHq+F+WmNjuZBuNj4y
         jz1g==
X-Gm-Message-State: AOAM531d1tyqxIedprMIHa80p7lrrIk+UHnruYF//TVQ0s4/eMa0zCLS
        5pSSqNSNiTOSuUNdiG/pOWq329jtg9MkVhi6REo+vPGy7ZHIrt4domKTwq3Orx5caqergYm4ZXa
        CExS5KcXEuV/RNnOKKmyQGjUpKbeGG01aQbGiZ2Kj79ItF/j7EpHRd9ho+vRhfUwiV4zy/eHmJc
        +r
X-Google-Smtp-Source: ABdhPJzNvh3UAL5Qb0mYlrtS17FXXWOZn+lTNejhFHS5Aj35/8mQeXz2m8FS7ejrIs86zdeNSEgAB3ZptBtQ
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3b13:95ba:12e5:7134])
 (user=apusaka job=sendgmr) by 2002:a25:520a:: with SMTP id
 g10mr15077626ybb.117.1630915542318; Mon, 06 Sep 2021 01:05:42 -0700 (PDT)
Date:   Mon,  6 Sep 2021 16:04:50 +0800
In-Reply-To: <20210906080450.1771211-1-apusaka@google.com>
Message-Id: <20210906160340.Bluez.v4.12.I4df08516dd5129d4e9d2cf963121074f500201d9@changeid>
Mime-Version: 1.0
References: <20210906080450.1771211-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v4 12/12] doc: Inclusive language update
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
2.33.0.153.gba50c8fa24-goog

