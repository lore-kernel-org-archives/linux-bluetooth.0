Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308AEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiBONhM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Feb 2022 08:37:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbiBONhL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Feb 2022 08:37:11 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC277AAD
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:37:02 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c10so9313407pfv.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Feb 2022 05:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LHYny5oShxCf5SLl5OM+fcMEb9asaSj1Cnlyvhc+Bs=;
        b=YR+Qeadq5XzW24WNzAcvNJSt7bwHd1c0BaJj1nds56CSoWd1u3OkKvYVIrS0CEQ09a
         rXD5SlD6v5QJsEHBmR/g7KWJO0r9SHNqJuRQW35n7l+fKSEkKXS+F5yrliar3mdBrnkH
         JTqYGO7l/jxhPSUe6wL35GFmDFNRculrFK9AI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LHYny5oShxCf5SLl5OM+fcMEb9asaSj1Cnlyvhc+Bs=;
        b=loFtIplAOMUzH190LEJX+pPZbOmfr1wxoNG6LkpLGYsaIbuO1cv1kjgj5vxMDaEmIq
         untP6p86l+cRdB+/iywfQ2ti5XzktgcJ86s3Fov/9gGjdn3hs1hkYYPmpKSjw2nyhaUz
         sagzCEG6dZBbM17Hrv9eNuObZfU+psO/n5lMwFmD0MAm67A23cUBRAsBCV41h2rtgDgP
         /bAKVHq68TCabBRE5GynwIPM6zhllraP8sBb+jtUuBv2/eKII6XM+QhVXx67agLq1iUk
         Pr/SfG0DEIpbhtBL8icctcqQuCPc2gEoq/bbi96OsAlqzc2eP+6mhS5TGsVe8BjzlauT
         QUzQ==
X-Gm-Message-State: AOAM5321QkB0as7kDIfZkw6i77IadWzxlkDm4YYcT82Tm8OBRTJArsRa
        Ng9bgJgM6uTQaXNQlPIhzvGYBjr96x6ygw==
X-Google-Smtp-Source: ABdhPJwwwhYpcHdiDsfVKWT6xEuQfhF0aTYje0VN5W/BBi30/0gOR4EUgtGg8/IJM/rq1BK1ihIoQw==
X-Received: by 2002:a63:8449:: with SMTP id k70mr3531633pgd.188.1644932221277;
        Tue, 15 Feb 2022 05:37:01 -0800 (PST)
Received: from localhost (208.158.221.35.bc.googleusercontent.com. [35.221.158.208])
        by smtp.gmail.com with UTF8SMTPSA id g63sm7498580pfb.65.2022.02.15.05.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 05:37:00 -0800 (PST)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>
Subject: [BlueZ PATCH v4 8/8] monitor: packet: add missing decodings of MGMT commands to todo
Date:   Tue, 15 Feb 2022 21:36:36 +0800
Message-Id: <20220215133636.2827039-6-josephsih@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220215133636.2827039-1-josephsih@chromium.org>
References: <20220215133636.2827039-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the missing decodings of MGMT commands to
btmon --todo.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

Changes in v4:
- This is a new patch that adds the missing decodings of MGMT commands.

 monitor/packet.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 5f2085b4e..33e0cf7f6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -14696,4 +14696,13 @@ void packet_todo(void)
 
 		printf("\t%s\n", le_meta_event_table[i].str);
 	}
+
+	printf("MGMT commands with missing decodings:\n");
+
+	for (i = 0; mgmt_command_table[i].str; i++) {
+		if (mgmt_command_table[i].func)
+			continue;
+
+		printf("\t%s\n", mgmt_command_table[i].str);
+	}
 }
-- 
2.35.1.265.g69c8d7142f-goog

