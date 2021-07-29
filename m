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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149DDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2CE60F9B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbhG2DOh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbhG2DOg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:14:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6919C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:14:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p71-20020a25424a0000b029056092741626so5311370yba.19
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=X3UG3iU6RtNApsoMwy5ufHfLvu+I9+sEw0wPZ3XLM9lViqCdHBcY+uB6Iq5KBjuIbf
         lSKbXR6YM9af6YtL9Z3tul+CB3+sT/QQGUyL5MIZtL053sseRic3lxcJTuKGGvC4KKBs
         shKQuFELfT71BxP2pVGhPcn4hKlmD8WSWht7IpA7dUZX+mTEXWGvnsCe49yltTBKu6Zc
         mYzHqQkXVewa63VMZfDR5weqI2N5AzwbgkLPer7vKU2vEddhF8RpvMOvrIBL/nxHcSPp
         t5t3qsvjL8Ha2DJXwDGgCtB9PLmdr3j4lVNq9T4O024YZlKOyhWRM0qICquxsXvB2jax
         Pp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=Cgt61HVWftjErcsMFfx/PYtM8Fncj33WAlFF2/faeyiWGabLPg7ImXvjxWLydFGmS4
         bRFHwNRzb4vN6NSdrqymVJDpuhMD0hm49rFVGivg7qGCfGonaqPaaV0W+G+idFIeoADj
         /3W6CDSiSxSwwKh/9eQFZ9rE6uMBXhuhksfI74nkwXbBImHtfQL6zSRm0IcXLO/pRqD2
         t02Lx3eUHGvxKSm7JyubgvzumFUvajIFxLIrFjJvu2wEr4VzvhFBRczyqn6Zyj+WbRUH
         FgRePEliCLKj5U1f276Gba0wmlwHWpQWSx+0Yjc3KGP0mNODgUR+SYIUGYgCB3JslmTA
         SsfA==
X-Gm-Message-State: AOAM530v2qzX/SwGyddtOKAcdhaR6Maaa7gxi5lY/im4PicPZB/VnRzw
        i7gFfVa+hRVj4w57GXXYHXO72bBrpQYIrlkgE34s57wNCsIREq0dXSLfrSTjXvvJzBFfPR/E1i/
        8SNE/LvvWdyNyZRLsseC83X5kCMPUro7rjaLDXwbYmKi81DAbjXjULHu5oD02C6hmik90jurExC
        ExIWnNE4yZoZk=
X-Google-Smtp-Source: ABdhPJzh1PoOtE2jIskWttRFQt1q95Wb3blDeFrs/6an9iIW3ZuAYRimc14xS2Egk1MqJBlekfCS7Z4VXI7hLwzMjA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:b787:: with SMTP id
 n7mr3849777ybh.468.1627528472023; Wed, 28 Jul 2021 20:14:32 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:59 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.13.I433ab6a7ac1d4f8f8dea496ac14bdbf3597015d3@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 13/13] doc: add description of admin policy
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

