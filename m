Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8AC32771
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 01:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97CB2073D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 01:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UsvFKnIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgAGB3n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:29:43 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44861 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgAGB3n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 20:29:43 -0500
Received: by mail-ua1-f67.google.com with SMTP id c14so16676546uaq.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 17:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fxwCpXshPC80zU3jurlPmcnE1obn0BTvu3Xh4TNXwso=;
        b=UsvFKnIa9D2YrLu0no2thCY1Wa8jrJyJpojAj4y1+W/hQfJpsV+DTSUfU6GrDETxC6
         Fc5r8mcAozgaO7SFCnqTNkY09ILPnffOGTgn19WrapYctSP0hLEVziN2HTVm2swe4R45
         EmDEGzEmTAwWF2+xI8YuiJHX7uXhAUqnYqjiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fxwCpXshPC80zU3jurlPmcnE1obn0BTvu3Xh4TNXwso=;
        b=YW45Gf95RVqlzCayl2nYQXqaccB0zbFQjiczF7j9mzqoUOK69AafeoQwkFIaBPlkX7
         4ejGZIzntSPPWoGvpxNXhp8izAoTaO+cC93K35Gts1qnKgLnOfRfmOUTnPoScBkO/AT4
         K2gEuQ6OI/2SoSI49r1xDLrT5F0vQzOkyzliyKKIkdqRG4vtC8fENfIotrXpogAF9hN8
         FUsXE6YVaYxKodUyokdFZORoyyQX9cb0jsqVnHzk/5nRXpwEpawW4sFltSIzQrd4Oxz9
         3aXEcvrZEslIyRHzbqWTEUfgBo3vsvVMIUfnds5mitEEGyCE5EYcwz/9TfM6AAPW/d97
         Fuqw==
X-Gm-Message-State: APjAAAXYgUreMk4EHERLeJ1gyDD4OxP0YMlAywcqgBXjfyjxEZh2yXmF
        Tayy3s8H6hLywWrkxd2h4fLV7nu5KaI=
X-Google-Smtp-Source: APXvYqwcUy8HljJtuHu9qPjRBp8E0d1MCNwNZmKcuMnL72ggMQtycSjQHhs/D1xAd7kAOKZrqppDVQ==
X-Received: by 2002:ab0:94:: with SMTP id 20mr60199451uaj.71.1578360581873;
        Mon, 06 Jan 2020 17:29:41 -0800 (PST)
Received: from alain.c.googlers.com.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id y7sm18784079vkd.38.2020.01.06.17.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:29:41 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, Alain Michaud <alainm@chromium.org>
Subject: [PATCH v5 2/3] Adding a shared ARRAY_SIZE macro.
Date:   Tue,  7 Jan 2020 01:28:20 +0000
Message-Id: <20200107012820.158721-2-alainm@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200107012820.158721-1-alainm@chromium.org>
References: <20200107012820.158721-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This will allow other implementations within src/ to use a single
definition of the ARRAY_SIZE macro.
---

 src/shared/util.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index 604dc3be4..9193068d1 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -27,6 +27,8 @@
 #include <byteswap.h>
 #include <string.h>
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define le16_to_cpu(val) (val)
 #define le32_to_cpu(val) (val)
-- 
2.24.1.735.g03f4e72817-goog

