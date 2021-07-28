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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBCDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8433361019
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhG1NQt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbhG1NQs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:48 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BCC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:47 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w19-20020a170902d113b029012c1505a89fso1957172plw.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NokkcDvovb9Lu8+jkbGkT+S9xqf5OeaAMMgso8G3IEE=;
        b=f8KOfVGu/IebllCksFxsfOIAhfTgY/TA/KIHbrUh07XrfGps6ZTbbNalYbBrJp+IQX
         K38t//ywPn+RFVsyG1gRHLRLXOHcgp2+rg5zExtGiHLx/S6IuDuq0Npwhd9sZSxoV3h8
         lgt42Q5xLhcuKo4J1Y3LrQnZUlPuadEV5rt8nnHaSbZvJciX++b4bSSy8PaHdwb/L0W9
         dFw+8ToAHfKoJGFO+371l+0CacrgIwFYiilD6Ertth4R973cRJDGhRjKLWNv1JsFmDWQ
         6QRLhFBuAXA84RoAnFqLAXzkIU63Z2BPHx3QcoIfqwpxy1XEjlpGh/X2shqJnWsqOdYI
         /Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NokkcDvovb9Lu8+jkbGkT+S9xqf5OeaAMMgso8G3IEE=;
        b=UfFUe60u2uW2dR7hXG6IBfVjzkLNVTFRWJsKB6pTos7Aw/Jp6PIK1UT/sUQcBRBz+R
         Pb8NALB/GYV+dvodpVLL7dBObqQUul3h0pmcx4qlyvHG92I+Lt3MFyIiBYL+VqwgJeMk
         sqHBCjeiv+wJ2CKoQBOlyMNXsLuDzySXcs4jZg69C3TcXSXJ2xOE09UnvHaJWuu1Fnfq
         73RFNN30YKJAyQhYpEYFiUDsa4QQVL5QhUk8hS/aoQTi0S4MRr4oHoNPmUqGoQVOGSZZ
         RztbQ/5w4tASr5O4SQK2McJ4MkARadPpSZKDWTmLuyGfzvd5Y8rH1APofoNwW7F0hfB8
         FFSA==
X-Gm-Message-State: AOAM532jtRf12/sNpPJ9SOjBwws8YIVqK0zP4vHbLr6U7jeWS4VEDpNr
        7djT4PPxI6zSBuJDS4sySRJlysTGIEizhW8sHdGPaSF3+ncxaQ3+h/AWBwq2K0QjjrTXtcTKzor
        F8MHjEwU/KLXCF/OcqeXB2AZYho9UbvD/JqEWMhaBaNvyDwLtlAzvSIreEmiL6+ctEoceLRyYzT
        noyJmD0ReEhLI=
X-Google-Smtp-Source: ABdhPJzYeMsPcVkyPJmIS1rex449Jy0KmUcbyxlSvmlxIlwMeSu2LeS0+Ki0axWezkH5TYuf9yjCBRsdyQdWAGZmug==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:aa7:85da:0:b029:329:aacc:333e with
 SMTP id z26-20020aa785da0000b0290329aacc333emr28163383pfn.60.1627478206780;
 Wed, 28 Jul 2021 06:16:46 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:29 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.13.I433ab6a7ac1d4f8f8dea496ac14bdbf3597015d3@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 13/13] doc: add description of admin policy
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
index 000000000..3f116901d
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
2.32.0.432.gabb21c7263-goog

