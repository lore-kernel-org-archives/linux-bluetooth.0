Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB3FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Nov 2021 21:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhKWViB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Nov 2021 16:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhKWViA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Nov 2021 16:38:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C0BC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 13:34:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id x7so620761pjn.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Nov 2021 13:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+u3JusoKBNium7ZrBf77ToKNjAXgQWgfFTp4Jc6mIE=;
        b=oOGBZ9FtOXAuW5hZ4nTIL8I6oyl1HDbmlJQbR1yOgqB5PSZV3zFCqtpN3tZZfxaelQ
         y8V3jfAhDUzrT6bFK8FZpWw/3+PYAFj84kLFsutWNHEcf/2m+oGzGlnFU+at6/yEAtm7
         knxwtjlLWE6d0OiIkQ62iD65njwQbrZkCY2JLRMs8GTDYSoLReCuQUSniq7lqRWDJNoU
         IEgj4brxFZpy6VG9wyHua7N0NrBKOwQ6bxO7nnXvXg+kbUbHeU6nmR0me8ZVRYylhf26
         HblXOMDMmcAGR8gea6TdCnrrrz+iDG9yRI6BEzcMBZ7zDF/lX+xdM44kgxrdSHtrfhtU
         8VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1+u3JusoKBNium7ZrBf77ToKNjAXgQWgfFTp4Jc6mIE=;
        b=zWBbzZpCmFHViAFaILsdPTgxznuMg0pNYjwX0DdrpB5sxLZaxaEOv7cL9YQyxCCbJl
         KGaL8oEgxVufaiAPUJ1q6yoKCvXir/2shwYcvLy9M9/fslSZM3r2k60tYo7foZFtIB0E
         Yub5untLPqXNEzJD2vUonHLP13L/uTWDYOZHECDD9jBJGYnjhzeoqji3/Kw+nvnwGE4w
         BegdykivT7y01uX9/FZytnfryDOhfWoPfDuehiiJ8tf/h4jBKZoRPvkzkhrEdI83OxIS
         PqVJD/r/Mw3U9KS8LVyU6SFnBhHQmOQLLExUvksiiwc9hr/rare2+cv8SihOtMAP2rxn
         fhNg==
X-Gm-Message-State: AOAM530Uy6tK6N00yAtfj0Uv668LU7LNNHbh6jfpnBqP8FCnpMTn52UK
        xM7a1pIz4fdZFRck53AsQELJ0oWHuU4=
X-Google-Smtp-Source: ABdhPJwuso+kwr9++zFIKJ9T4A9mO76FE1JvAoKMouzc8VcERj/VXGB1o8MAgk6VHjk2FRuEUbRCSA==
X-Received: by 2002:a17:902:7284:b0:142:728b:46a6 with SMTP id d4-20020a170902728400b00142728b46a6mr11035277pll.45.1637703291519;
        Tue, 23 Nov 2021 13:34:51 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z3sm14060709pfh.79.2021.11.23.13.34.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 13:34:51 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Check for linux/uinput.h and linux/uhid.h
Date:   Tue, 23 Nov 2021 13:34:50 -0800
Message-Id: <20211123213450.2595964-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes configure to check the presence of linux/uinput.h and
linux/uhid.h kernel uapi headers since the code no longer contain copies
of them and otherwise the code cannot be build without them:

checking linux/uinput.h usability... yes
checking linux/uinput.h presence... yes
checking for linux/uinput.h... yes
checking linux/uhid.h usability... yes
checking linux/uhid.h presence... yes
checking for linux/uhid.h... yes
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 0329095ee..2674e30d3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -63,7 +63,7 @@ AC_CHECK_LIB(pthread, pthread_create, dummy=yes,
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 
-AC_CHECK_HEADERS(linux/types.h linux/if_alg.h)
+AC_CHECK_HEADERS(linux/types.h linux/if_alg.h linux/uinput.h linux/uhid.h)
 
 PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
 				AC_MSG_ERROR(GLib >= 2.28 is required))
-- 
2.33.1

