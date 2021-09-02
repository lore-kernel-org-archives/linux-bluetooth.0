Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E51C4320E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D85610CD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhIBEJ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242235AbhIBEJV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:09:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5841BC061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:08:23 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y1-20020a17090a154100b00196156bbc18so368263pja.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wQW5sRYp/dvG+wXe86fcE1hrtE67nnkl7q2mYx1x44c=;
        b=FK71F/GgFtxrxniBXkbEfROuWokzdKpC+Wap3U733iBGMkEhlErvi2MBnaMuNA8YVw
         ErvlIR5qBwwy/6vj717b8iuPmksq/iIfIIMOK/vhE+bWJgBG9/2I9HSZb30WGMtMf0D1
         yUKVD3CZ8gFzlnGx5HKhWNr0v0l2OeHsbt3cWy3hOKNBLF3P9j6c1dcsvt0lfmWofSXh
         0bN3M68IBYmM9jyoTNhGh2KHvxWK6f55JL/0nvScusXzDpuOkLkYUinKf5I1B0z5O9/n
         FbgnSUheDc4PFi2/KY0YONtrKwAlW83/alyASnIlEkuIJxdjkY0bJylHO2N0VPoiqYn/
         IgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wQW5sRYp/dvG+wXe86fcE1hrtE67nnkl7q2mYx1x44c=;
        b=hnHZQWNuBdnVfyl9BLbqMJsO5VRDtp+q97IptWmdNKIBPjj1GtbJC67AXzXizT0cZr
         j1d6aHRPIAqADflXxVEhD0mCyAtaJD/BEZF/qEpCIHiBkifT8CPYhBGTl8rxXaBLlJku
         bbvNxh9wksufVXVFejCIU+mPO8atYfnRvWzx18lGm9eurNULjuPbZCdAhctXBuInkb1v
         ne4qSd4PwnN9eIdTBN8M5JvDzxHiskb0nMgoSMKsDnHHq1+yVskOh5KtfDzDr8TyHj7K
         jsa3TSFtlFndjwgQaWAr+gqpdu3OkwR6y1zrd6xnpatU574tGZHXBb6GiDl76jYMEtpu
         y6hQ==
X-Gm-Message-State: AOAM5331Rq5kMdl/R69w7OpaA5pWEMErDt2v7qY3h4+cMkP4Z6Ph5RV4
        2il9ZQkFfCl3X/K/Zdr+lF+Qd2pR+tD1g/qDyfZGOqs/kqnXMM1ogb9lydMa8lK4Y1MIM/h17SA
        TZdr/vr6XExd0+XYoLOBOrKQMEnIAT01DfV+37bGhBdPyGra7ItUMWEfk5mdJgbqysuVGGxAhI0
        WC
X-Google-Smtp-Source: ABdhPJz7o70cRN7NP5rWGpFnrqBSz2Xiiyw6j9Ds7FhGhzGfs311ZGjOInxm013Vxq9KLlDhABSuvAllQvBs
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a17:902:ff02:b0:138:b944:e0f0 with SMTP id
 f2-20020a170902ff0200b00138b944e0f0mr1077314plj.34.1630555702780; Wed, 01 Sep
 2021 21:08:22 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:10 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.12.I4df08516dd5129d4e9d2cf963121074f500201d9@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 12/13] doc: Inclusive language update
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

