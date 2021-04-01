Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4234C41602
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91746113C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhDAK2L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhDAK1u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:50 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B4C06178C
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:20 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lj2so3359004pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=juhixWLyicFTt7f+uaGnUssgbkazntw8va11il35Aco=;
        b=d+mdMLYXGpUiXb/0heJwjiqdBqBIYR/EzMM88l1RFE+HvpLDBVfGAV0+YK43YSZmD/
         3Lo80wJZC5VoxCqZO/ylthV3MMWPiXJdzLmvUe4a2NRpsceSOGzPSn50LbBBVd4Bo98l
         gdjRHB9Lf450d5fhMvpjVn+AJsVWZaINpbpaAfju3BlJSxeXO5jQtEKD2taf/wa6mcp/
         RfAUA/WGkJstxuspWc7EyDEt+wg44Puaw6PwyQqyXr2InBIHyWq4rSHbnsluA8CDfzKU
         mV2QFEk8WWEuNyxgASfKWZfmays9qE8MihZe3m0IPWBLYzOSHh4EOUfkAc3sWblkhLwN
         Bajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=juhixWLyicFTt7f+uaGnUssgbkazntw8va11il35Aco=;
        b=PNm5Ohqfz39s+CxFPlJTVqMcRhn2qGpS3UiLkOyUU8cvBYg7H6xlYxKS/jN8f1teQv
         x2mBZtrELh7IhfCOyY5WApHufrhBVx5MTq396GbDahodMouKjDmYAP82UWwdmlzFR7hU
         BUGyTs8T5aHo3SPdON1HdFMJMaYeT1NggoCS56OPyZ2Nx/S6LVpiGn/jhE6G7fvAspJi
         SzU5i2UlGxCOIzfdi8J3CpiqdFNZpN6sQxFxjo/gVnUucdbaZgKxLARo3QEXo7IZG9FD
         WgKlL0t7vytnso8kXerz7AWZNIWtKBrRJMrPIkwQhwbYpNRKhNO+sD7yzDZHHI9YCsZW
         hEZA==
X-Gm-Message-State: AOAM530ci80+hGNdx3rW4wBxqvWP+55EBgVSnunSdoURhpPZtF+5dBNh
        LREwnEfJocouvQX+5+ymkLI5g1tjmg4NXUkCixBXSgKMpMPh6U2AT2LOpBkYtCRQeAzNuuE8T1l
        662KKiRUm8yWta+BVpKeXqT7s+WOlKQFw/aKd1sO5cWuD/LiE/9tDcgm8EccZEpPxXJI9yGYOgy
        Az/y5fD1kNSLk=
X-Google-Smtp-Source: ABdhPJzo0ZYKEVOCzxXvIZrrcuL7G04/JHRV4Q21VBDd8gldtomSkgysGgqCgOyxB3qRaJmFOX+ig8gN6EogSpnOqw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:a17:90a:8b97:: with SMTP id
 z23mr309500pjn.1.1617272719582; Thu, 01 Apr 2021 03:25:19 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:40 +0800
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
Message-Id: <20210401182328.Bluez.1.I42e9182418d46012ec4b01562f2e0f18840e90d5@changeid>
Mime-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 1/8] doc: add description of SetServiceAllowList
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds description of SetServiceAllowList.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 doc/admin_policy-api.txt | 34 ++++++++++++++++++++++++++++++++++
 doc/device-api.txt       |  7 +++++++
 2 files changed, 41 insertions(+)
 create mode 100644 doc/admin_policy-api.txt

diff --git a/doc/admin_policy-api.txt b/doc/admin_policy-api.txt
new file mode 100644
index 000000000000..dd957351506a
--- /dev/null
+++ b/doc/admin_policy-api.txt
@@ -0,0 +1,34 @@
+BlueZ D-Bus Adapter API description
+***********************************
+
+
+Adapter hierarchy
+=================
+
+Service		org.bluez
+Interface	org.bluez.AdminPolicy1
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void SetServiceAllowList(array{string} UUIDs) [experimental]
+
+			This method sets the service allowlist by specifying
+			service UUIDs.
+
+			When SetServiceAllowList is called, bluez will first
+			disconnect all the pending/existing connections and
+			block future incoming and outgoing connections to
+			the service in UUIDs for all of the clients once it
+			finished.
+
+			Any subsequent calls to this method will supersede any
+			previously set allowlist values.  Calling this method
+			with an empty array will allow any service UUIDs to be
+			used.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+
+Properties	array{string} ServiceAllowList [readonly, experimental]
+
+			Current value of service allow list.
diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4e824d2dec17..774ee046cc92 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -272,3 +272,10 @@ Properties	string Address [readonly]
 			Example:
 				<Transport Discovery> <Organization Flags...>
 				0x26                   0x01         0x01...
+
+		bool IsBlockedByPolicy [readonly, experimental]
+
+			Indicate whether or not this device is blocked by admin
+			policy. This would be true if any of its auto-connect
+			service does not exist in the ServiceAllowList under
+			org.bluez.AdminPolicy1.
-- 
2.31.0.291.g576ba9dcdaf-goog

