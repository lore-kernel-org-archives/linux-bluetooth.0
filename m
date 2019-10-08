Return-Path: <SRS0=DWZO=YB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9028BC4360C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C1E2070B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="QtVQ5kYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfJHKCB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:02:01 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36337 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbfJHKCB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Oct 2019 06:02:01 -0400
Received: by mail-wr1-f43.google.com with SMTP id y19so18675210wrd.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2019 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfabExpNYxiSgZ0gAUihY5IXQSRpa0ndnyt+2X8pJlI=;
        b=QtVQ5kYaJZhKjB1G/ypllTrJpAQDL6wmYIBQXpkaypIykZTfErX9wnuNK2S17DR/Gd
         iM0JUpOAqrGAUvbJ6NSk78jkhRXchn9j9ANyNOi+h/AElgzXUmHNgqeoVdw1aQWOwl6e
         fon4qeuHqVk6KGQ43SMFnQxG1OHaMTqS4oC6V79sh9RNTdOZ2JCGMEgYH4RrgNilbpav
         OWkbsfdoy+IE7l2dGIrRuNcxmSVrSr4MV2x2bgm+Ootf9djuV1QwqqA6e5OetO/qUkwp
         Q4Kj5whb9yruxYPIr5T89wFbNwihn1pilGj0ggsnZD1tlz9DGagTPB6OGRKuUTL4E0dZ
         /wLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfabExpNYxiSgZ0gAUihY5IXQSRpa0ndnyt+2X8pJlI=;
        b=NQ/jVfh0p5rc4n/eiTNAGfZ5CzyQ2pfYdv+lhYcd9xswfRX0DIDov99IRC21aoh5v/
         ygOoqQQHAFuYmCuwyN400IDr78hooyxGFT2awSOhqFWHEMERAUidV3QN9SxVyFQmGYuT
         og8mDDr6qk0h9ZQsuzryow5yi8qohkCmqnB1W7U5kKfmUMk8oPEI1orbzang9wkiQWoR
         kiazsn0helSc6Csxlbs5gQ+f4+x101JcJM1fN24PwU2RME6vfF9VuQdzOFejhYu/xtMV
         qlaKk4/SgoBqkYifeLG5eG7KD/J9z7dD5EThEcA+rWw4gM0b+MmcedsVrrTmWoc/UxYJ
         JJxA==
X-Gm-Message-State: APjAAAXZcxaplGaN6NXKBRY49Tmv7G+c0t7jQHGx/vrV+Zx5uIgRPBSH
        5kXONmsjc0Bt/ZxQMXNJceNKrbgzzSM=
X-Google-Smtp-Source: APXvYqxWtW6j9j5NGV73FKfEjNes1nKnRSPqcBXvz0r9+hFE05cwYk6atGnZjra79z/LgqlIV7fP6A==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr19937141wrs.7.1570528918419;
        Tue, 08 Oct 2019 03:01:58 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
        by smtp.gmail.com with ESMTPSA id f3sm20680040wrq.53.2019.10.08.03.01.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 03:01:57 -0700 (PDT)
From:   Ross Burton <ross.burton@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] Makefile.am: add missing mkdir in rules generation
Date:   Tue,  8 Oct 2019 11:01:56 +0100
Message-Id: <20191008100156.3813-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In parallel out-of-tree builds it's possible that tools/*.rules are
generated before the target directory has been implicitly created. Solve this by
creating the directory before writing into it.
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 2ac28b23d..e7bcd2366 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -589,6 +589,7 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
 tools/%.rules:
+	$(AM_V_at)$(MKDIR_P) tools
 	$(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
 
 $(lib_libbluetooth_la_OBJECTS): $(local_headers)
-- 
2.20.1

