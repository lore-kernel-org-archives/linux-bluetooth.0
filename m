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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBDFC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A08610FA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhHMMVu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbhHMMVt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522D3C0617AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:23 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ay14-20020a056214048eb0290357469934easo6910292qvb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KYlyQQIN3E7Rj0f5GSG7xn2rJTGXll0Q+fAMZgpIuSo=;
        b=mFMuqbqmAiquxpaO3cyqiZvW2l3rzKMhY4wiHsoZ0OHWc8k+ViJIVAs6kIHrh+Iyq7
         bXIDE81tVpyWIj4S4MZZ6cY6xOR8YiVxj1d7ChWVOAbgk5TEex5LgoRnCh8pW3Zfh6h6
         EOzGVKtmc7UgQWGGxBrT+aaCasTovixqTa9ifH7itd5ewjUB6SECgHRU7MIR87GcMgWH
         uJL/Aja2UyXUKlVIwtkrRN1SdKLKfVQzQdWmdJrkj377Yh6JqkSHl50/Cinxvis7HwCn
         8xN2+j0ShGR6Z/rV1C9CdI5vqWPsz7zsNx3q/GAsaCJKHO7z7GXRxzLvgrxcRunfoJMp
         8SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KYlyQQIN3E7Rj0f5GSG7xn2rJTGXll0Q+fAMZgpIuSo=;
        b=GVPaax1Lu7hUxwDC6tEKLb2n0TyWqYd54XFfY3KJcp9iZPEf8f2HasCVdOUrE2T53q
         USLDczUpmQOGdMDKxCxK/rBM9FbnjXx/uyJLr3Zfpl5WpRICxLDgKbR7zt64gjT+IAgr
         Kz+K06jgETmXfLRq4IuUDQTZU3BFwZu1qUea2oCMrmKgkVQ8N2lmRPpg+LHqaWFQtYO8
         a0xV8z+YRLUnMII2vEvWzNTMJ807gDG6lNKjX1wh8e8QoczD6I1+d/xYcszsVfPAKb57
         7nAcQY6ALgKpgsT7ONbzs1Ds5xK7TwVcfL3RDtWs8wM8D0nzOgZrzrIWhoyUNUWchabT
         j3fA==
X-Gm-Message-State: AOAM5311Id4dNBUbOQtsRC9k4HtO+W4gWA7bP/FFAzl9/ABuRB0FfMrf
        RSNxmCxLdjaZ0pdJSAGTCKGkZbN7Vg7KdDtMuPHdAWIcxbgLZp3XedAEq4gZcCXHgr3g5D6v9E9
        G4RnUwWCmJWRByNinFSpdLT2xy7O75t5+fFvtrkULuMQ5dSrENWG4p1iQzL+ripFBdCQPwTGlUg
        do
X-Google-Smtp-Source: ABdhPJxkXTzWyFtjcY8wY1wdJXgzqIVWPVQyKmpOwPXNco19bUU+IYxkcM0LGEWmX6Sg5BTh704aIhBLU/NT
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:21ed:: with SMTP id
 p13mr1834350qvj.49.1628857282384; Fri, 13 Aug 2021 05:21:22 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:14 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.29.I2516e9e453733ffe40e7c0cb090cddb842a36730@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 29/62] tools/bdaddr: Inclusive language changes
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

Use "consolidated file", to follow the usage of "consolidated table"
in BT core spec 5.3.
---

 tools/bdaddr.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bdaddr.rst b/tools/bdaddr.rst
index 1d21e2ca39..a84950bc35 100644
--- a/tools/bdaddr.rst
+++ b/tools/bdaddr.rst
@@ -61,7 +61,7 @@ FILES
 =====
 
 /usr/share/misc/oui.txt
-    IEEE Organizationally Unique Identifier master file.
+    IEEE Organizationally Unique Identifier consolidated file.
     Manually update from: http://standards.ieee.org/regauth/oui/oui.txt
 
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

