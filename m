Return-Path: <SRS0=DWZO=YB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF4C4360C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870072070B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Oct 2019 10:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Dw0KIJYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfJHKBn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:01:43 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:34415 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfJHKBm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Oct 2019 06:01:42 -0400
Received: by mail-wm1-f42.google.com with SMTP id y135so1994629wmc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2019 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfabExpNYxiSgZ0gAUihY5IXQSRpa0ndnyt+2X8pJlI=;
        b=Dw0KIJYd2IKVRXN6PHtfk9tNF9usbdYe5y8Qe8fhTGzgeOkhF6VcOIKrLOU7WTWMct
         OK23LN18LoUBtFwotwXipDJ4Hiaig5Rql7y18W9/hKvd4HkYq94S5zJE1vYUPnPTh0Cg
         igNbwFHdDfw/4CWn6fT3ZZDjUHnON7W40BbOVVAsW/0mAwVYavqFpi51EUVMMQA9JlsK
         YZjKrHkI9XzSXD5LHb6Zab2znk2vTenXJs07h34MEMz6omcL8oYCCGzFKL11ruvez17+
         Jb0MLnR0xUka55/p+KB61TuqZ5GA9IV4iQ1EnVs90IL5XVN15jO11eTFFXKpO+NbkRKD
         S6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfabExpNYxiSgZ0gAUihY5IXQSRpa0ndnyt+2X8pJlI=;
        b=Prneo0Lv9ce8ohePJR8dlRwZ69T0qkoV2eJzCGGVXb+bchZ/oPHWzK+5ZOL2yRnP4Z
         KaHUmxGG3az2AL+bs2bqZPnA3l2mAE1/+7thIrsTP+fVuxu104Dp0L1ND9thaR7BgoOz
         jX0CAWPfTexYXco/lfWi4JXHvGDEpoM2CCtAKU9X5ZUyf8Ti49VWEyZqdVodDDodqnLV
         0/8CyhS6iMainUfHdnrQHMlFrXi3W+OqoAUAA3iJB9xAYhvIAP5sRhurtDmMqKE971ph
         MyPITTJPUj74yVmzbQOd9P4iH35GrpsOL2nv9rI7QyLiakjHhTEpPUXN8eOE9gHP3lzW
         gtmg==
X-Gm-Message-State: APjAAAUgVTjMJA2xiZzOKPUnvuvOpW/w2R8VLq4VMXdApLNBnfFj2nN4
        E9bWcGHpmCobcDQKQPS3o/vf65ABxiQ=
X-Google-Smtp-Source: APXvYqzHGeK4owjlJGxMh9Ek64V4acbaKK8SkVIxqoQkNCTiOjAgY+JigxfsxjwHGwj8z0PZ67Rzig==
X-Received: by 2002:a7b:c34e:: with SMTP id l14mr2843719wmj.123.1570528900437;
        Tue, 08 Oct 2019 03:01:40 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
        by smtp.gmail.com with ESMTPSA id s9sm3203927wme.36.2019.10.08.03.01.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 03:01:39 -0700 (PDT)
From:   Ross Burton <ross.burton@intel.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Makefile.am: add missing mkdir in builtin.h generation
Date:   Tue,  8 Oct 2019 11:01:38 +0100
Message-Id: <20191008100138.3737-1-ross.burton@intel.com>
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

