Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E91361179
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhIOIfB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhIOIfA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:35:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8E1C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so2687366yba.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yaMz213rWflLG4vbOwbcu514tRd55dCVj4xqS6IobEg=;
        b=pYOZHwa9SwXmxdJvn16YYOGhLKWM3D3hqXeldP5kntNhk7GY3bHabQBShZPDAMaFyZ
         vd0kgOci3huXk2K/MZBB0U8ihIp8eJvB7fyfzgiA55PYTYJO7Wof0+2fk9+C0RlkAA2J
         F8lEKOdS7PZOxZuxK0ecD/1V63g/vAcfXvkXQDBqjDeO2Rjf4K8+EPnVDFLsEeGKvrRc
         sLhoMxwp4Fe1WnMmb+zmeOvFkddlmrJZBjUNUbPxY56atZCigemlqLCzH4tOjUFWHxfv
         P3kUqBOEYYA2zQFQzwqnVsqsNvsoP7nFpdPMb93iD3CXc5KPDKa0AQyUts+WQLJXnu9L
         7Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yaMz213rWflLG4vbOwbcu514tRd55dCVj4xqS6IobEg=;
        b=PaBcMttE1dqhfeKS07cosn8uFx1OBk88gBSDKjzzHESYMITorbYEXjwK8pwrLNtG/P
         whNwV7zVQHXC0RvLsS2vo7I02rD722SQUDB8rzu0+Rhr+SbXOrtFGXqi/kvhmwPGKtBw
         5/dKDqavPNY3O4oINrE2G4zL6FS7UpPNuaHUfNNrPa22Ob4ZpgtvNFLNAklWeQ0hfb3E
         fXhUzkioJy+Td8q9kQ8sP1WTzFr9n1mbpXR87lxQiefyKLOpmoFjtRQeIWKWy3cmTMI+
         EgGmrGHAeey+BqTACflqEVZUaZLvagf4Jrt9D3+kgwp8PCZqXTKSRXwPqLEtuL0rvjFw
         XZFg==
X-Gm-Message-State: AOAM5331cPAQ2480PmcXrO3UGKVkSXZ5oPYAAQKlrihrFw2/s7ELZt+s
        4q3ov5ry9/k7JzoqDV0xeOBP4cESyu0qs5v3AC/PZqj1/f1/6AM3AhM2hjcX5iToFvejqbSv41/
        rDj4gx4uZlkhRfFoO/v0qsaUcPIgRCLBkcOd1OoyUGTbSG7VZGw5M0CC0RL3LPe6dfh1m9lgGAz
        0Y
X-Google-Smtp-Source: ABdhPJwIJiTjHbzGgM+cYybL9wjZV+jJjHrMSyGWpzWzRNfTLV5qYVHw6eNQ2HaRCcAdE2IJP4pCIDLgknJT
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:a25:ef03:: with SMTP id
 g3mr7261ybd.369.1631694821239; Wed, 15 Sep 2021 01:33:41 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:32:09 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.13.I4df08516dd5129d4e9d2cf963121074f500201d9@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 13/13] doc: Inclusive language update
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
2.33.0.464.g1972c5931b-goog

