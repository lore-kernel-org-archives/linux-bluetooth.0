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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68556C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510E260F02
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhG2M3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbhG2M3M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:29:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDCBC061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:29:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e145-20020a2550970000b029056eb288352cso6587831ybb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=pgxH0xBevsXulso7Jul8p87Lt+1kw6KfbKf1brpLJjsmcRiJm9ZMYYAGduXafHPSqi
         1ALs1azVFDlj/t0VkyDx2AViSGt15aYj2o+f9KwAHKvDtYbuIut4nNUAk6+MJSujNQc4
         UvCQV6YGAWrPsS70diJfE2UnMfS53TScVzusn9t9Lzbw/RA1IIia7Y8mL9pyVyh7PT8s
         cEVeaQtMyDFgB/NCfTwINH/tZecQ/9gbsMZD+N7t31Vg+T+nvcC78A5AavOUwFyKe+36
         mbT5a6KfPckzip5XNq+57KCvYoM9fw+nhQTYyym2Z1H4m9UUSipdwYphxWWYKhNCWqN1
         2BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=RsH4awglx/rhX05b/h+RRvih3j/m/fW7n3dI/zW+nlfErBuqGamVximZeFWXa+UNrA
         yqGZ7zZTClOSH7YHfDKiOMIh73MP2eDw+RTYsPl1sC423Sf4xoMnc1lUZ3n52ToRUfVr
         LDkuljT0wBX2n71bWbQPqL9xO9W1DeKyFDMoUURo3QjcRm8pbaM47Eqw+rid+qkrQnLr
         x6KhR6nxcXQu1Nqtz84Xx8qq+w0cR3WZf7MbTViy8jsJZAhNs7/Iz8izGBRtRCkbzv9V
         dAy1hc/4+pt6smUwjF3UxH3so/L+zZ1vpJQfyUTSEU18xAFtthb5RGR0RFi7wl28TlZl
         A0pg==
X-Gm-Message-State: AOAM530JCnDdgbITiIic4seD2hpCVpVYPIWGOz5CGAuf0vGC6BzKbO8h
        QQSfq0EFisjOFGLXtk9sh0mXfsnAi4II0OZgfaGY1qj0Y+R4h6qU0pX7B5ZZQ1tAWQEua+LpXBR
        l0PDr1O4/z/eMFcNnpkTNiYAAhN7EUXnlTU5A/3yp0Ltsgz1uZAp4ZfRbwzHkyGMQPjEIC9cTF+
        ReMZfhapluRwI=
X-Google-Smtp-Source: ABdhPJzkzAlEjYdZZr80jn+UgRAFkaOlkLaA+RlTlEX0d3S5VxaKBFp8LpTCy1pps0gp6AmfHW6JfWS3WSlWfFOugQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a5b:648:: with SMTP id
 o8mr6543509ybq.260.1627561747391; Thu, 29 Jul 2021 05:29:07 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:51 +0800
In-Reply-To: <20210729122751.3728885-1-howardchung@google.com>
Message-Id: <20210729202648.Bluez.v6.13.I433ab6a7ac1d4f8f8dea496ac14bdbf3597015d3@changeid>
Mime-Version: 1.0
References: <20210729122751.3728885-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 13/13] doc: add description of admin policy
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

