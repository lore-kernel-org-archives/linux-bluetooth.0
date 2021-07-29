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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D0EC4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF3E6103B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhG2I6K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbhG2I6I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:58:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B8C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:58:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a188-20020a25cac50000b029055d47682463so6199555ybg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=Z3Ss+ye1KTbMpkDYhuFq071uOoDYnQ7eBKaeMyEhkPhJPJnuoi8g0GhfkOxxPJhRST
         btP3Ub5Q4kPG2UOYI7m7fh7SGot+DPKs8diIO8c8naogBkSng5YbNUvzLIobBkDgfNNn
         Ijrzr65Q37ud5xY81rWeRuqwZPcupYiIXOJBKc+zYMQ2KiQRt9g2oI0cct1AITpxPMKc
         ObQB1L6DHGjYvu/VhjpvSC4CLpMmxD0jv25adLMFmv82Q4HPXfcqCi8xfmRfEaOc5xml
         RKO3BrJ3Mfh3/tZoxL5IeW6V2A0diO8FA0zq3r7jf4hhRYljqIxfZhBYaJIvx31e7Cpg
         wVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=D03wStnHhzCn6Q1wHmPO2iLRahJekEkbRonikVoOG6hyB66VLFTu3oiWFiTChIO+TH
         PTLYf5T7fdGtdYhvifaB05kL60pAReH4Hty3KY/BQN27vDKGW19LmNV4WfHeJtbl5Du1
         9QN5RQ4qt0ELhl5KgUlpDJON+mtJbS1fzZht/0Vt/c5RyhhHPMfDOz+6acGYQIKT09EZ
         XAo1dptvWBRcUdkns4Gf/X3poGcfQI4nhR4sVlniBtY7Iwf4QAzKuyv4LA1n/AyntAgT
         BlQrGFMnxg+rFC4OPNWi97cI7Ji2T2TiDVz4SCIgSHIR4PHikUY7Dwv+DvfconrFPHTv
         vQTA==
X-Gm-Message-State: AOAM530IZ+BTzHaCN1wYDPJS5I8N4UsNTXdHnO/5WkDAXp9HYnmF7lQc
        NVAQLhV1kvdoSOgmeuurMS4cn0Gkdx7YsjsRjot5DWVgwc7aYlPLtRkgkYMWEfURon2bJxgKWZ6
        BvOjBSf//45UhuLfDIpvdO7c91zjakAHYANarKeqPsjDiQBYakpPrrXn0beSZThbScQTGusZ8MA
        uEDCBmGmpS99Q=
X-Google-Smtp-Source: ABdhPJwAnu3D9IPkKHCfEUNA4F5opyxViLnEGLEXJU+yUVwjEBGxsB6fIb1FLlfMmxmICGsVxfv4ZYBkIqHD+P0UzQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:cc0c:: with SMTP id
 l12mr5400449ybf.152.1627549084820; Thu, 29 Jul 2021 01:58:04 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:51 +0800
In-Reply-To: <20210729085651.3600926-1-howardchung@google.com>
Message-Id: <20210729165211.Bluez.v5.13.I433ab6a7ac1d4f8f8dea496ac14bdbf3597015d3@changeid>
Mime-Version: 1.0
References: <20210729085651.3600926-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 13/13] doc: add description of admin policy
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

