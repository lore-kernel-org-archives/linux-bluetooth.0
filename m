Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAAEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E42C61077
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhJRRa5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbhJRRaz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E7C06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n11so11751865plf.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=81EVcq6gCmuUBjFDCUIL/Fcgync/V07YYoweuxYtC3M=;
        b=kwDZFy2q/qzCtyTiwWw3Wuxm6xhtmgma7qLtq8KVxysZV0PPBcEjsIgKk4yw7uwonZ
         H84FEOuSEomf2yy5KCmkPkSv4P46qqV+hWQ0o5F9C0er8XDSnDYzXX+MZDGimdzP3tx0
         LoFCC6ffqE3gxQwrWlMeCprXR8AgbGazhQ7Rxru95aR8qedvzyYbQCdOZcnlt+AAqdo7
         xeCvyvk/j+4WxvCpJvi6hX8zPm/XVJq2CMRXiRgDazCdlHJzv1ig202epYdJBIJ/C12H
         3yfBkZQiqegVjTY9tOejH+/mFdWl0aHDvvIZdhUkJJ9k5Huub5jbfPpwFdu6Kxf4RfZj
         lfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81EVcq6gCmuUBjFDCUIL/Fcgync/V07YYoweuxYtC3M=;
        b=c4eOhtRIiVcdtAPkZ/g7tTnHEfNHbunDJ7Ol31a31DT7Bg0u0WqriQgm+kRviiidxq
         lwIEwldDFwWauHGBgaB+DNslgpyLRAA6g1yHzXi3qAk1W7VXb5CgjBXG21rQfdo5dX7e
         hrMO9xOuEJx/QYu2SZUR3ujAyiOSdtZXcpwcTJf906h6V5ojYuw11c7CHFs6BCtqtAJX
         UPhOXcKFgY0Zcd41HZci/xgSBmEXDeZufzvdnVLg3rbkAHsGLZJpxScawGQHjNlGwLef
         UNdEa8yNIOab8v+2WbuPutWFyORlnVmri75oCAA63/HcvlXuOnUAGCzD+vYLDd2frAX1
         yq1Q==
X-Gm-Message-State: AOAM53073ZE/79uMVkjqUwPX33zobthIFy9Mq/UQFrLqlANApub8FgFA
        ZUmFsvyVHw80qIlYOmVTQKpAjAYc8duG0Q==
X-Google-Smtp-Source: ABdhPJzHPAR59cZWDMZqqopxugmvAZDV1y4hCuTT7AZ5tFXCz+w1K0rHsI0qdvuJAmzhe3MUFFzwhw==
X-Received: by 2002:a17:90b:4a92:: with SMTP id lp18mr227728pjb.47.1634578123651;
        Mon, 18 Oct 2021 10:28:43 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:43 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 6/9] profiles/input: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:30 -0700
Message-Id: <20211018172833.534191-7-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018172833.534191-1-hj.tedd.an@gmail.com>
References: <20211018172833.534191-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the unchecked return value(CWE-252) issues reported by
the Coverity.
---
 profiles/input/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 50ae51855..013899211 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1050,7 +1050,11 @@ static int hidp_add_connection(struct input_device *idev)
 	sprintf(handle, "0x%8.8X", idev->handle);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
 	str = g_key_file_get_string(key_file, "ServiceRecords", handle, NULL);
 	g_key_file_free(key_file);
 
-- 
2.25.1

