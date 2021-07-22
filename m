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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE6DC6379B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566216120C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhGVGoA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhGVGny (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:43:54 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8CC0617A0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:24:06 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y5-20020a37af050000b02903a9c3f8b89fso3532882qke.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NwhbRd6Nda2nJmrC1VjdWIQ0w2RnDxD9VGxxWica+fA=;
        b=tW0sibNufkvI6BamDgrPIBrtPLeDsXTICTcA5r8dLpuIBjINjYNEQDK6Ksvg55pUQw
         MKM4+9c4NR3p5iXL4AMb2zKmq9vKzRXGIoe3y1zsKfbRO0eIIfKGWLproFwfV5gaM4k7
         36docd2sbCrb6YIGGgVLL+k7bP+4eNux5TNgLDUJHzER8FtWbPI7vP07a/rfSkdTXZCr
         2+ZVazXrqpJ15AWfbp2sUxriQi1GKClPO4R0z4dvuduGrJP71KB+gYaKaqjtCdcdbK9u
         MZxKudABBKFDv1sW+2ckqhnMhniN81Pozdf+QL3Difq0p7FdOfIhJe0K3xLyGI+UpRDj
         AGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NwhbRd6Nda2nJmrC1VjdWIQ0w2RnDxD9VGxxWica+fA=;
        b=uhIAGwaBundzaD6Cu2qkfnyFLGD9DH99NNZuBWiBhEOBaSTFaMXo5BNZQU8+Ox6gxq
         mlF9BpzWxM79KePWBslVi09Ax8uhoHOWYp6Xn9VYTz9XTrrffWx2xFzHNa1GaEKP7nex
         vAmI8oxjrDRDhlJ2xNaOx/S8PDVdiEh+EWoJYk5SyWJNu4Wq6ACJVK5//abEP6BAIxRA
         nQh+h62nFmFkeFy9H8tZrEdD9XfptrX/d2kOrTv4Z5rFDJpSUU0SS78UAWo3jnrkVZ2W
         PZUwuuxSu5qmLStxcTpc06DWlrR/d3S9i7DnG78lw+aV/bkuu8RllbuMaZw+l/jBgoCd
         OivA==
X-Gm-Message-State: AOAM531mHPwNUkYNkEPLpFxfFO4d6s24mjPolbw8xZZTAjR3XOLlPcx4
        ReJl4S0oeUjXaGfbkSXHG53Yq2rtQ30OFgcakS24GIf50yMpYem7aPp8HnjBAPZI01alAHN06DY
        XktQZYMSFJ2i2rFNqcsglDvJusaKoF0xpzHdkAmEHZxGjnoNL8/NgaaT7+Zy7LG1Uu6sm0JX1Fv
        DPnXNY3OSyTsQ=
X-Google-Smtp-Source: ABdhPJzmSvxaH++Chu+mvdDv/eEMk44UnLEwaXz48FKYP2dS7r24twbza6YhQpqYTnHKyDflSwxpqBHss/OlTb0CUg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a0c:ec02:: with SMTP id
 y2mr39785420qvo.61.1626938645644; Thu, 22 Jul 2021 00:24:05 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:21 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.11.I433ab6a7ac1d4f8f8dea496ac14bdbf3597015d3@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 11/11] doc: add description of admin policy
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds admin-pocliy-api.txt.

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
2.32.0.402.g57bb445576-goog

