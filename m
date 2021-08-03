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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5060C4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB7F61040
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhHCLow (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbhHCLoW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:44:22 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEBDC061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:44:10 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cb3-20020ad456230000b02903319321d1e3so17109409qvb.14
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=UlRlEB/ZeEifUGAJrRU0GrdEaqZBQw5XCNp2JXUulVV9tgN79e+sY0+i4d6OVKBII+
         dkpxJQoKWKrVALlGi0darIhQwQxkv88N4ISz1KrDFk/ahUA/3MnbRbo4aZ1H2X/UT/Px
         taqAptySZIpI66RX3MyxurljHe7FjlvMJGYMffSSYtKNCCu0X+bAf2ZpL3JaGCmQOLTy
         Mv3qpNuznU76OQkVsAw4vnZTUBknDIBqkMW1SHky7Tq6Hox0+REaHzJMwHaoFK/Di3DJ
         eZxoC19In4SGMoUaBi1V0hmwOmsX06NcBcl0z11u97m8tAfFAg6CMUJjB1qEGvWxZp3E
         fKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GUGK6mf2HhVtnM87+R/s6TG00Oczs2xSvSnRMURkPe8=;
        b=b1twuO5KPYphnPj5/dcz/0lIl1wXxP8ZrsY80ohPoe9Pm8LqIrpEKB3A1apNFopp2n
         bia3B+DXSzxpZSyMlGTEX8+1nlDC3FF4xnSZE7EBISg7NDJjsQlv1guW1Aj+o+rsDJ0W
         erfDgD7uhbketjN6uEXjaWKg34M8n3uOf/TxjuQsDlVy/IQlSsVu2UcB4DVSMdZf7zh2
         z4Eg27876nJGwrOTzyI+9NSczR0FDd+FXPCAmvv5wCeBqTx4MQflFxJCF44Lp3kqgY6+
         CWlBwvZzM4jOi5EgpnnG6/WjXe42odgNEUq/SMaQjKNkZRok4wpDScP91ghuiS0tlMwS
         7OGA==
X-Gm-Message-State: AOAM530ecWpcQ573VW+r0MpyFWkMq9egPuxFJzUBmYjxvXYIic5nMKGu
        tnQ2X+ulEorLazCOPR41tS7hiTzDmJ/lesAizHBkWJat1L43IlvKT/Jn7sdzfUi8xu+tHasJJLb
        bLvYNfOe9stboIlkbKzPGMt9DQYQIPJBM8rbwBYqWhns0/rPaEgLqimSRr74omORpNcsvIu2OHw
        YEWOhB5OlnnhI=
X-Google-Smtp-Source: ABdhPJzrJaZckrzaZQ/YTk2v2ssyprlmn4ndRv3PKDqFd6wNkUwz5/aGCWwAPYrKiX62dK0YuJx2Erc9GYDMh5qhSg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a05:6214:b33:: with SMTP id
 w19mr21298912qvj.50.1627991049202; Tue, 03 Aug 2021 04:44:09 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:16 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.12.I433ab6a7ac1d4f8f8dea496ac14bdbf3597015d3@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 12/13] doc: add description of admin policy
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

