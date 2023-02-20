Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722B4C05027
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Feb 2023 18:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjBTSMf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Feb 2023 13:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjBTSM1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Feb 2023 13:12:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F248206B2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 10:12:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id oe18-20020a17090b395200b00236a0d55d3aso2692020pjb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Feb 2023 10:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELxzqMJZX2R/rAh5yssUawc/s1J8f63xM5+g2a2DKA8=;
        b=ANGXg/0ksir3p/SuXWpoGHXVe9BRVGUsDNiGFncfZqijqp8oUBKZODqSiEBAXaOncb
         nglGFS/dkT3o4cZx0I1qkuNqrMRPDw9oFJ+93owDIGww4lDx2QdiqTz5T8457yaX+/Vb
         vBtJtLnA+wJWKEnT0cp3rzBBdsNq7UDbe3SuatMCGwIu3gPDiSXyKPp4ftxSHJO76eSO
         VqykiYYV5ducUXw225cbS92BJjRUlQ9EuBmgAi+rxvlzRd7BUleRmFmsdWiFQX8iULfz
         UbOXT/yrWJIL1Gpz+GOhEBMP4DhZT46ps5tA93mOiJiQaS76qWHCnNgqC8qlBTYbSIpv
         VcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELxzqMJZX2R/rAh5yssUawc/s1J8f63xM5+g2a2DKA8=;
        b=WpjGuHI6s8WMTzvZDyx+nyERHbpO4dgc1taTQtEKrydBJeB3zv6RlUt9Hlo7D2GfI6
         F11N7i5ndccUxhXEPfKLc+Ym5oGZcaHJncXPqWeTbhElDvOxaroG0yvCWpk1Y77hDDnj
         MSfkYEsXiFi8cpJOq4z193zdIAUs0/IQYAYlgj5VpYO4RVh85HH0ZiGx5Oz2TUwY/Tq6
         UADG2qL2QUeGxlGt8oK78yCnDQBsz+CJHeTm0yjWawg/YBZlFwkszctXXIcRJX+kPrXz
         7PU+1ivdXqulA8IXvSlquGsF67fEMGZR/UE6HFMIN72c1bpwAjbG9ET3z9z2yQyjKAjL
         jRVw==
X-Gm-Message-State: AO0yUKWZjy3oyOU9rWE8YQNYtOglBna8O4b5VpM1DEKHWNwZ5Rxe5I3Z
        TNPp5sHa4HbPDkIyaIkfpwOxi5UE8xA=
X-Google-Smtp-Source: AK7set8YFD+i1m4yYu5L95iD/eLqhuIaFzyk191IKT10gLK+spl5Zs2zDKphzl5kELGoifyKUkxYtA==
X-Received: by 2002:a05:6a20:6915:b0:be:f8c3:2032 with SMTP id q21-20020a056a20691500b000bef8c32032mr10216285pzj.48.1676916726722;
        Mon, 20 Feb 2023 10:12:06 -0800 (PST)
Received: from fedora.hsd1.or.comcast.net ([2601:1c0:5e81:6f50::cb12])
        by smtp.gmail.com with ESMTPSA id f16-20020aa782d0000000b005a852875590sm7973308pfn.113.2023.02.20.10.12.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 10:12:06 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2] configure: Check ell path
Date:   Mon, 20 Feb 2023 10:12:05 -0800
Message-Id: <20230220181205.1577283-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

If the 'enable-external-ell' is not specified in the configure parameter,
the build system assumes that the ELL source is located same level where
the bluez source is cloned. But the configure doens't check the folder
and user will get the build error while building the source.

This patch checks if the ELL source path if the 'enable-external-ell'
flag is not set and throws an error if the ELL doesn't exist.
---
 configure.ac | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configure.ac b/configure.ac
index f9f0faf57..515cdf146 100644
--- a/configure.ac
+++ b/configure.ac
@@ -289,6 +289,11 @@ if (test "${enable_external_ell}" = "yes"); then
 	AC_SUBST(ELL_CFLAGS)
 	AC_SUBST(ELL_LIBS)
 fi
+if (test "${enable_external_ell}" != "yes"); then
+	AC_CHECK_FILE(${srcdir}/ell/ell.h, dummy=yes,
+			AC_CHECK_FILE(${srcdir}/../ell/ell/ell.h, dummy=yes,
+				AC_MSG_ERROR(ELL source is required or use --enable-external-ell)))
+fi
 AM_CONDITIONAL(EXTERNAL_ELL, test "${enable_external_ell}" = "yes" ||
 				(test "${enable_btpclient}" != "yes" &&
 						test "${enable_mesh}" != "yes"))
-- 
2.39.2

