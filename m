Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1611C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED6B61050
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhHBGNy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhHBGNy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C77C06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:45 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t18-20020a0cd4120000b02902fbda5d4988so12010853qvh.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=pG/tlstIBit6nIvdFvyJu4CGbJRJ2ohw6WaOOJ6yuaE7j50WdXudzSsWTOhHZ7Hoh1
         jPav/bpCOGl+6cEh1k8XaCjCshXSlPZlH0kBr8QKhWEBhDpxlemJKJOjLarnI0/fALLI
         OdQDP6IYf7nrqXHFsHMnFJHED9ythjLvgGyhrf6biyGN/c2vdDCyBL3j9TUBrJ2vM3/m
         fqCWa2ARRROv3HYUbspJlvsTgG1vYiyi1EqKW6yiEaw5+nntu+DF05ajfXIdRbYYOIo+
         WlJb/4hSHNjAYFWQCyt7j7iSKbE63QtfJAKkqwcmg4FBEOsYoFh/MWWQhdMqBeVZJlBx
         KAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=EGZTuxRTUjdjqF8/dcadVKOUPij7BP2iQ9AAVjLdS/vyAsElVo/cho+E/dEfuO7oVL
         CTShxVbajTEY6oRuMrCXaCYKohn/mx9yDa9KjeypFYT2o0C5c1uYMhthlpDR3zl4VC32
         oUonMfi8NForoTYRwbkNEe23smkWFjFyycLJBl9pJPcAA31v58svb/QAY+7r4pF35tdT
         0mfpbFpnc8t2aACAJAxFWg8jZXbIrelSmURMXboTIsAPKS9M4zpK3n0djvmanbzViTSq
         LPJcX8hG9ybHmDM1ybCRcVnEFFoA82fdU1V/WDir6IejcJBbVkYAG1mU+XtHRkp1ML/G
         qiLw==
X-Gm-Message-State: AOAM532yznZEP1kyvreAM8y2fOXMiKIS0HoVKHJP5w3CrzrX+ujNNJAI
        KMC5Z2CZN53e+OnXHn/hSN2nGZsxJ874GGLcG3qP70wzFFouBI6j3Fu1J7XsBnAqcg8+EH3gLDn
        BuwOjGlbdfi6mMS6B0kN5GFS1sTtn35gyIMEJ+EvmSv0qDO71UtQgP22jqRQD+PHVyqN5Th290/
        Fs4Zr8RdsJO5k=
X-Google-Smtp-Source: ABdhPJwo9T3m5xse78Ds24Jl/89n8gQK1jY1fpLBRiRe0ct3f5kTUAd7eP9PdnnGNN6g2+fuGdpBcdDGNH3Nnc3mBw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:a05:6214:14e6:: with SMTP id
 k6mr12325591qvw.53.1627884823801; Sun, 01 Aug 2021 23:13:43 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:50 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.13.I433ab6a7ac1d4f8f8dea496ac14bdbf3597015d3@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 13/13] doc: add description of admin policy
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds admin-policy-api.txt.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 doc/admin-policy-api.txt | 65 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 doc/admin-policy-api.txt

diff --git a/doc/admin-policy-api.txt b/doc/admin-policy-api.txt
new file mode 100644
index 000000000000..3f116901dbd7
--- /dev/null
+++ b/doc/admin-policy-api.txt
@@ -0,0 +1,65 @@
+BlueZ D-Bus Admin Policy API description
+***********************************
+
+This API provides methods to control the behavior of bluez as an administrator.
+
+Interface AdminPolicySet1 provides methods to set policies. Once the policy is
+set successfully, it will affect all clients and stay persistently even after
+restarting Bluetooth Daemon. The only way to clear it is to overwrite the
+policy with the same method.
+
+Interface AdminPolicyStatus1 provides readonly properties to indicate the
+current values of admin policy.
+
+
+Admin Policy Set hierarchy
+=================
+
+Service		org.bluez
+Interface	org.bluez.AdminPolicySet1
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void SetServiceAllowList(array{string} UUIDs)
+
+			This method sets the service allowlist by specifying
+			service UUIDs.
+
+			When SetServiceAllowList is called, bluez will block
+			incoming and outgoing connections to the service not in
+			UUIDs for all of the clients.
+
+			Any subsequent calls to this method will supersede any
+			previously set allowlist values.  Calling this method
+			with an empty array will allow any service UUIDs to be
+			used.
+
+			The default value is an empty array.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+
+Admin Policy Status hierarchy
+=================
+
+Service		org.bluez
+Interface	org.bluez.AdminPolicyStatus1
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Properties	array{string} ServiceAllowList [readonly]
+
+			Current value of service allow list.
+
+
+
+Admin Policy Status hierarchy
+=================
+
+Service		org.bluez
+Interface	org.bluez.AdminPolicyStatus1
+Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
+
+Properties	bool IsAffectedByPolicy [readonly]
+
+			Indicate if there is any auto-connect profile in this
+			device is not allowed by admin policy.
-- 
2.32.0.554.ge1b32706d8-goog

