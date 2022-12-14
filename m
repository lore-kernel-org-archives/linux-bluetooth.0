Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF17C10F1B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Dec 2022 00:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiLNAVj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbiLNAVf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Dec 2022 19:21:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587151E4
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 16:21:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 17so1715869pll.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 16:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o3WT2+ThZfqSmR0Bfv3Cox6kat1chtligemGMpSVCiw=;
        b=MLHelXSNvvprqnZ8RvkxzA0OkAc/WwDIaTKAK3LspsGra8oNH4Dpn5P+0UbvZS4HSs
         akc7EnkqHVDobnZVTHJiJgsl/yVZUdSyONt1q3kOFrwFA+pjkNTAwWKdKdf+jE1X0p54
         kXh2iiWH3XMZBVA3RFjI9goN/EoXvZvLWWzEDBAFn9/GgsMON9a1BlsBOWT/aIalyAB8
         o9YEUYW66pHPjVP+nBr0A9sKfkqrQTnZ/J7taZ92hsSu/Vr8AXiqMIZVeDrAC7B29vMS
         lN8FzLLKWOMlZxtMUkuPykaL5LzYB1YI67tz0RJFBO+W+gn/nxayhquSvWrtxqHvgv0j
         Ka5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3WT2+ThZfqSmR0Bfv3Cox6kat1chtligemGMpSVCiw=;
        b=ypTuLfWVeiEiK0T6m/Tr9D73h80BCSNzafkC/lY8DuhpZzM0uB956GKhRZ7AYsYfuP
         aArwg3YReflmGL8EqNp5yyyq2rZaqTHaP/tImYiFARe3XSinFoWo245uCUgz9/xZCk6P
         q0vJ08UDM5v4R+UKeWmuUcu3eYbhl8nY3eQCjZQm7DIT+2OLETML5+YVjDY4nv5PHPFM
         zvjUFlYhjUMiNjpkfwwJm1xHK562K6ChmfDkZx5KYtmUWBdtZWhpQdTtBHHS2k+iDVHi
         MULM5NpD32UwKRXLM9vFbKm0Evy6An9tKo8nQ1wm+j+mssZMn584LjDJaGYaUn398XgE
         7OrA==
X-Gm-Message-State: ANoB5plFJe5a9mgIcrrC9ee0Ak84afLuJRpgBroflTVL2OiLAQU27gPd
        xJGBiAbaksrUUlGr19aYnL+Ou7Wx1KGatsDW
X-Google-Smtp-Source: AA0mqf6baCW2zN7PjbYBkqPuC6PB+sk3mwEcEZXsVKZnSNSqWxLu65Ts0NGjYu0cQ0etCrYzXTXrmA==
X-Received: by 2002:a17:902:e212:b0:189:80e4:6920 with SMTP id u18-20020a170902e21200b0018980e46920mr17982095plb.42.1670977293052;
        Tue, 13 Dec 2022 16:21:33 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b001895d871c95sm482446plb.70.2022.12.13.16.21.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 16:21:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/shell: Add bt_shell_echo
Date:   Tue, 13 Dec 2022 16:21:28 -0800
Message-Id: <20221214002129.2105777-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221214002129.2105777-1-luiz.dentz@gmail.com>
References: <20221214002129.2105777-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_shell_echo which can be used to print messages on the echo
area.
---
 src/shared/shell.c | 15 +++++++++++++++
 src/shared/shell.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 0639c786d983..0045ac80ca6b 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -576,6 +576,21 @@ void bt_shell_printf(const char *fmt, ...)
 	}
 }
 
+void bt_shell_echo(const char *fmt, ...)
+{
+	va_list args;
+	char *str;
+
+	va_start(args, fmt);
+	vasprintf(&str, fmt, args);
+	asprintf(&str, COLOR_HIGHLIGHT "%s" COLOR_OFF, str);
+	va_end(args);
+
+	rl_save_prompt();
+	bt_shell_set_prompt(str);
+	rl_restore_prompt();
+}
+
 static void print_string(const char *str, void *user_data)
 {
 	bt_shell_printf("%s\n", str);
diff --git a/src/shared/shell.h b/src/shared/shell.h
index 8baa2854a250..87fb5c415f20 100644
--- a/src/shared/shell.h
+++ b/src/shared/shell.h
@@ -70,6 +70,8 @@ void bt_shell_set_prompt(const char *string);
 
 void bt_shell_printf(const char *fmt,
 				...) __attribute__((format(printf, 1, 2)));
+void bt_shell_echo(const char *fmt,
+				...) __attribute__((format(printf, 1, 2)));
 void bt_shell_hexdump(const unsigned char *buf, size_t len);
 void bt_shell_usage(void);
 
-- 
2.37.3

