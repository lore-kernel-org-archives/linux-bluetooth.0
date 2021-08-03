Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE71BC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F0560F48
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhHCIX6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhHCIX6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:23:58 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2372C0613D5
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:23:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so16785418qvt.20
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=Pcq7c9gQYM5QQWeDId5jgTfElN0Ed7byzvEnjewy0Pn5oMFYdBHj+eRynVdr7lkRX7
         9I6Qq6TvhlnkBc77su79v/FAuQvZvXRweXCMPT4RoJ4CjVLeeaFvHAytiMsUWW0ZXkYm
         cXLn4WmQ/bHqnvyehEUPRCiQJX5iLkC2V5or+EcDryLo592h8FujefrGjz7otN7D9yC7
         51bDrQZML1GW70+c3lGBhFvbrp9/xkkdnga4ye09DVH4TIo6ePiHayUC/ZeD+e9f6cXr
         TVME01IUjiYeRHbreomwYsyOWZygdu3qVM/NPcnbHXLlSqpSiDXVy6jLvpN/jzWoyxes
         9z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=hw+O8GaBrKjv/sXnTD5PkIqxGm/f1FNRKPO5aEwtzhP1Ppy6cRhpAHBBaluiPq28lO
         ADp5XTXm8VL9qfmdQkCifG4gCuQt1oqam0M2Udzs2SejupyZOcS+ANYgUFxVE6vSSIUy
         6VErLCJKYRInbYWB8xRYOM97sptF41xnE33SVa6Bw/4ECVWDYg6FkEhnkYwFv7ImDn5c
         zUhMamroyqTzDx4etP0Zv3r6S7IZnToa8es/+Pr4QGQxd+6x94mX4EaYkSkaFAxG1xNu
         5TNfmqrqBoQTLejhDyAxY3eGPFkYmZyTm+0nPreYgNM5KXrxhRHnPm82ObOmHsuvoBTO
         HsJw==
X-Gm-Message-State: AOAM5312K351qCUjIuXwaCY4zhSFNnNrZcsgB29nA0Ds/1mv/+RbWbIp
        SKgwG9Hmmz0pID60jDLYEtyMvqXmoWs0S0480m3YVmno6uXy11Da3gRQmRVKVR4vnIAh1d31y2o
        x+Wwr+lj80CFcuqP50ysSsOLI8xmtR0HIHp2N1oz05o/txs6dhYKma6V957qcRd1+oycUvbD4I3
        2US6IAUJCu62g=
X-Google-Smtp-Source: ABdhPJxO8gHjUohPfA1AlvKFeD7dTS6ZwAj2xbOaxmaXFEbwXmG+JY0yyCCuT5eKbHWcpTRBzRE+XXTD/5c/gqDzyw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1021:: with SMTP id
 k1mr20497623qvr.4.1627979026751; Tue, 03 Aug 2021 01:23:46 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:22:36 +0800
In-Reply-To: <20210803082237.723766-1-howardchung@google.com>
Message-Id: <20210803161319.Bluez.v8.12.I433ab6a7ac1d4f8f8dea496ac14bdbf3597015d3@changeid>
Mime-Version: 1.0
References: <20210803082237.723766-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v8 12/13] doc: add description of admin policy
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

