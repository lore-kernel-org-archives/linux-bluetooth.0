Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA26C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 May 2023 20:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjEPU7a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 May 2023 16:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEPU73 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 May 2023 16:59:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D934559E0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52c6f81193cso10228853a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 May 2023 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684270767; x=1686862767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnB5yv9oZNhLgZuBAf3kZHHnyPDEbPfDsi/R/yytOW0=;
        b=APvcuB4pZo2fjFEYaS1tPeo1cGzYn4+rx8CUc+cfsmWjOsy/V8lxX1KHrzVqeVUhjw
         3fSI+Twt8fyDU0g0DvQ0vfmP2bLSMBOXJtLmHOjWMH58bTLlZnEDZcgX/88W036O4DU4
         4xNI687LfK5YxZAHPUkr7wfBwdUhxvWJ8qXs4nMvRVo16FShykYxe29bA027T9aNEb6B
         HoAjq+olF+gH8F0YoPw1PrP/wvNBrJCVb8okqUUPUXvKMquUAOWYchb+OSq5AP5xnnsH
         ewFKURSg1BekfdlVHOf15TYBHFyOnTjFyAYaLaQgdJcAJmJjCspVID5vMMBAvTUxuvh5
         mixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270767; x=1686862767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnB5yv9oZNhLgZuBAf3kZHHnyPDEbPfDsi/R/yytOW0=;
        b=d4ivic6Nn7ivWvKGbTyJTYZFhhrJhsfk4CuXi8waOEKBMaUKSQqUS+QL72gr4CMP/F
         zyEOootjv33zgIIpG3F8T6AiB0/ect1T+tlO3eTuld7OWs11EzPNNtkNYU7tsPBdMZ2V
         o/LAfl0Kyn5qols9z8wt85wihL5gdRlnpgs5/XS1TLqtxkzMHj69rPewCd+8kUv4X5wx
         DqRauG2cN+7Vwv0En40rWRZjKKmuEaQn9yxxn15kg77G5tKi4lP7DHyQuSzB2LmuOgHs
         EqynmIs7++Bj1vrnRV0Y2Fitp+MQqz1/K0YGfAq85wi3WWW6/4qYH0Y+Z6vxQv0FPTGy
         eriA==
X-Gm-Message-State: AC+VfDzL++jNsCX48pI+45tb/5q81j1NImDNiQKlCVK8v9Y0KAQ8X24K
        K0tS7TfNvoCtBI+J7vYEeEfzYvYY4g0=
X-Google-Smtp-Source: ACHHUZ5cmJvPUTHFRgC5FrF2iq5vVNSIMhpctMHlxUM8gYmrWf15HJITBmrQOLY/qd9bYhLp+PLLXw==
X-Received: by 2002:a17:902:8c98:b0:1ad:be4d:5dfe with SMTP id t24-20020a1709028c9800b001adbe4d5dfemr21260402plo.27.1684270767402;
        Tue, 16 May 2023 13:59:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id t16-20020a1709028c9000b001acad024c8asm14272237plo.40.2023.05.16.13.59.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:59:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/10] profile: Add support for experimental flag
Date:   Tue, 16 May 2023 13:59:15 -0700
Message-Id: <20230516205924.1040506-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds experimental field to btd_profile so the plugin can indicate
drivers that depends on experimental to be enabled.
---
 src/profile.c | 6 ++++++
 src/profile.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index e1bebf1ee19c..ea188f36b6dd 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -775,6 +775,12 @@ static struct btd_profile *btd_profile_find_uuid(const char *uuid)
 
 int btd_profile_register(struct btd_profile *profile)
 {
+	if (profile->experimental && !(g_dbus_get_flags() &
+					G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
+		DBG("D-Bus experimental not enabled");
+		return -ENOTSUP;
+	}
+
 	profiles = g_slist_append(profiles, profile);
 	return 0;
 }
diff --git a/src/profile.h b/src/profile.h
index 6827f848148c..6871f2f0d7d8 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -28,6 +28,11 @@ struct btd_profile {
 	 */
 	bool external;
 
+	/* Indicates the profile is experimental and shall only be registered
+	 * when experimental has been enabled (see: main.conf:Experimental).
+	 */
+	bool experimental;
+
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
-- 
2.40.1

