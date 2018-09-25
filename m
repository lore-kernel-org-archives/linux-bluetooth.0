Return-Path: <SRS0=tqgc=MH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CEBC43382
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 18:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F2A2086B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 18:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hy5rG6Fa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F2A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIZBC4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:02:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46979 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeIZBCy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Sep 2018 21:02:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id d8-v6so4887270pfo.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Sep 2018 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59Ctqn6p9LkduqETHrhIZzTWaR9rJMivRNGJp75lx4w=;
        b=hy5rG6FaSLgDHPGHundPwvtpEZSkvcH40foeCjOutQUrAETCEePSkzzL+Jt+QZdrfm
         DzLcTsDtP+OfNCs1VWhoYwPT+88SAGi2JnLIpB4x6qfpLB8FMpdZlQqYlUpDzsSXB24N
         JjcJ0QkckYk8G1Wnz3NoxtXULgECcfVdHQfBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59Ctqn6p9LkduqETHrhIZzTWaR9rJMivRNGJp75lx4w=;
        b=I87Ztm0PfZIfVQdxCkXQZwjHcPGn0ZW4M61F5/XneF4o9wfw4qysvQQBMI01GI//Ot
         FWvtn3nWyQiItxM33GNvzRZiuUFkzE+bD1E+jtDsYJVF6Vgt9Mao1HcKipZqSP4SGBUK
         3tSH1lN/6R54/42frRisOI3AW43/v9JzZb86uKGeAeNf1A1c+5Te4/U+8QV4xDLInqn4
         5na4wIq0dWrmCMk3UfNe2/0U8PdqxTFLk8NLe2inAiiEOKk0bnIsP9wYqCLYnSHLQCtz
         8xKzXx4OyfWj8IoV88sMKQ/ODvfa9dDzTllqLHXhCxBgdaPHb6KdS62JxXa2UzMIAamV
         UoCQ==
X-Gm-Message-State: ABuFfoiH+QmIS40HFUoS5DcnSS6HpTzvA0uFcs/BQWbse1pW1odtT+vm
        uKLJ1beOZZYCBE+pxVOJj3wUog==
X-Google-Smtp-Source: ACcGV62E8YNgm+iIH+HReKKf01VwD5vVFG4DQ4RqyfR/qXYuBMrll+6qZ8HKgRexsqFiI37y/w5CIg==
X-Received: by 2002:a63:a80c:: with SMTP id o12-v6mr2198405pgf.271.1537901638959;
        Tue, 25 Sep 2018 11:53:58 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p7-v6sm5208971pfb.101.2018.09.25.11.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:53:58 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: [PATCH v3 1/2] Compiler Attributes: naked can be shared
Date:   Tue, 25 Sep 2018 11:53:38 -0700
Message-Id: <20180925185339.80701-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180925185339.80701-1-mka@chromium.org>
References: <20180925185339.80701-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

The naked attribute is supported by at least gcc >= 4.6 (for ARM,
which is the only current user), gcc >= 8 (for x86), clang >= 3.1
and icc >= 13. See https://godbolt.org/z/350Dyc

Therefore, move it out of compiler-gcc.h so that the definition
is shared by all compilers.

This also fixes Clang support for ARM32 --- 815f0ddb346c
("include/linux/compiler*.h: make compiler-*.h mutually exclusive").

Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/compiler-gcc.h   | 8 --------
 include/linux/compiler_types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 25d3dd6b2702..4d36b27214fd 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -79,14 +79,6 @@
 #define __noretpoline __attribute__((indirect_branch("keep")))
 #endif
 
-/*
- * it doesn't make sense on ARM (currently the only user of __naked)
- * to trace naked functions because then mcount is called without
- * stack and frame pointer being set up and there is no chance to
- * restore the lr register to the value before mcount was called.
- */
-#define __naked		__attribute__((naked)) notrace
-
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
 #define __optimize(level)	__attribute__((__optimize__(level)))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3525c179698c..db192becfec4 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -226,6 +226,14 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((no_instrument_function))
 #endif
 
+/*
+ * it doesn't make sense on ARM (currently the only user of __naked)
+ * to trace naked functions because then mcount is called without
+ * stack and frame pointer being set up and there is no chance to
+ * restore the lr register to the value before mcount was called.
+ */
+#define __naked			__attribute__((naked)) notrace
+
 #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
 
 /*
-- 
2.19.0.605.g01d371f741-goog

